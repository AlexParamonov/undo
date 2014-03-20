Undo
==========
[![Build Status](https://travis-ci.org/AlexParamonov/undo.png?branch=master)](https://travis-ci.org/AlexParamonov/undo)
[![Coverage Status](https://coveralls.io/repos/AlexParamonov/undo/badge.png?branch=master)](https://coveralls.io/r/AlexParamonov/undo?branch=master)
[![Code Climate](https://codeclimate.com/github/AlexParamonov/undo.png)](https://codeclimate.com/github/AlexParamonov/undo)
[![Gemnasium Build Status](https://gemnasium.com/AlexParamonov/undo.png)](http://gemnasium.com/AlexParamonov/undo)
[![Gem Version](https://badge.fury.io/rb/undo.png)](http://badge.fury.io/rb/undo)

The Undo restores previous object state.  
It stores the object state before the mutation and allows to
restore this state later.

Lightweight, modular and very flexible library that works as with
Rails, as with plain Ruby. No specific persistence required: store
data as it suites you.

The Undo uses plugable adapters for storage such as Redis,
RailsCache. And serializers such as ActiveModel for example. Simple
interface makes it easy to implement new adapters or tweak existing.

Most of adapters and serializers have no external dependencies and can
be used with similary quaking objects.

Contents
---------
1. Installation
1. Requirements
1. Usage
    1. Undo operation
    1. Configuration options
    1. In place configuration
    1. Pass through options
1. Contacts
1. Compatibility
1. Contributing
1. Copyright


Installation
------------

Add this line to your application's Gemfile:

    gem 'undo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install undo


Requirements
------------
1. Ruby 1.9 or above
1. gem [virtus](https://github.com/solnic/virtus) ~> 1.0


Usage
-----

### Undo operation

    uuid = Undo.store object

    # ... 
    # do something destructive
    # ...

    Undo.restore uuid

That is basically it :)

Additionally it is possible to wrap object in decorator:

    decorated_object = Undo.wrap object
    decorated_object.destroy
    Undo.restore decorated_object.uuid

decorated_object is a pure decorator, so it quacks like original
object. The Undo will store object state on each hit to `mutation
methods` such as `update`, `delete`, `destroy`. Those methods can be
changed either in place or using global configuration (see below).

To use something more advanced than plain memory storage and
pass through serializer, configure the Undo:

    Undo.configure do |config|
      config.storage = Undo::Storage::RailsCache.new
      config.serializer = Undo::Serializer::ActiveModel.new
    end

It allows to serialize and deserialize ActiveRecord models (and
POROs after implementing the #attributes method) and store it to Rails
cache. See those gems documentation for more details:

* [gem `undo-storage-rails_cache`](https://github.com/AlexParamonov/undo-storage-rails_cache)
* [gem `undo-serializer-active_model`](https://github.com/AlexParamonov/undo-serializer-active_model) 

There are more adapters. Read about them in configuration chapter below.

When storage does not garbage collect old records, call 

    Undo.delete uuid

to manually delete related data in storage. It accepts the same options as store/restore.

### UUID

UUID is a uniq key used by the Undo to store and retrieve data. It is
generated automatically, but it is possible to either provide custom
uuid or custom uuid generator.

    # use generated uuid
    uuid = Undo.store object
    Undo.restore uuid

    # manually specify uuid
    uuid = "uniq identifier"
    Undo.store object, uuid: uuid
    Undo.restore uuid

    # specify uuid generator in place
    uuid = Undo.store object, uuid_generator: ->(object) { "#{object.class.name}_#{object.id}" }
    Undo.restore uuid

By default uuids are generated by `SecureRandom.uuid`. The generator
set by `uuid_generator` option which may be set in place as shown
above or in global configuration (see below).

### Configuration options

#### Storage

The `storage` option is responsible of defining a storage adapter that
can store, fetch and delete object state from storage.

Adapter must implement `store(uuid, object, options)`, `fetch(uuid, options)` and
optionally `delete(uuid, options)` methods. Naming follows ruby `Hash`
interface.

Currently available storage adapters:

* [`Undo::Storage::Memory`](https://github.com/AlexParamonov/undo/blob/master/lib/undo/storage/memory.rb) is a simple runtime storage (ruby Hash object).
* [`gem "undo-storage-rails_cache"`](https://github.com/AlexParamonov/undo-storage-rails_cache) designed for Rails cache, but can be used with any similarly quaking cache store. Rails constant may not even be defined.
* [`gem "undo-storage-redis"`](https://github.com/AlexParamonov/undo-storage-redis) designed to be used with `gem "redis"` from v0.1 to current.

Check the [documentation on Github](http://github.com/AlexParamonov/undo/README.md)
for current list of available storage adapters.

#### Serializer

To convert objects to hashes that can be processed by storage adapters
and backward, `serializer` is used:

    Undo.configure do |config|
      config.serializer = CustomSerializer.new
    end

Serializer must implement `serialize(object, options)` and
`deserialize(object, options)` methods.

Currently available serializers:

* [`Undo::Serializer::Null`](https://github.com/AlexParamonov/undo/blob/master/lib/undo/serializer/null.rb) passes through object without any convertions. It do nothing and returns whatever passed to it.
* [`gem undo-serializer-active_model`](https://github.com/AlexParamonov/undo-serializer-active_model) allows to serialize the ActiveRecord models as well as POROs (with implemented #attributes method).

Check the [documentation on Github](http://github.com/AlexParamonov/undo/README.md)
for current list of available serializers.

Serializer could return any type of object, Hash is not forced. But in
this case compatible storage adapter should be used.

#### UUID generator

`uuid_generator` option allows to setup custom uuid generator:

    Undo.configure do |config|
      config.uuid_generator = ->(object) { "#{object.class.name}_#{object.id}" }
    end

By default it is using `SecureRandom.uuid`.

#### Mutation methods

Option is used by `Undo.wrap` only.

`mutation_methods` defines a list of methods which may mutate object state.
For each hit to such methods `Undo.store` will be called.

By default `mutation_methods` are `update`, `delete`, `destroy`. To
append custom `mutation_methods` use:

    Undo.configure do |config|
      config.mutation_methods += [:put, :push, :pop]
    end

### In place configuration

Any configuration option from previous chapter can be applied in place
for a given operation. 

For example to restore object from another storage, the `storage`
option may be used in place:

    Undo.restore uuid, storage: AnotherStorage.new

To wrap an object using custom mutation_methods:

    Undo.wrap object, mutation_methods: :save
    Undo.wrap another_object, mutation_methods: [:push, :pull]

To use custom serializer or deserializer use `serializer` option:

    Undo.wrap post, serializer: PostSerializer.new(post)
    post.destroy
    Undo.restore uuid, serializer: PostDeserializer.new(options)

and so on.

### Pass through options

Any option, that is not recognized by the Undo as configuration
option, will be bypass to the serializer and storage adapter:

    Undo.store post, include: :comments, expires_in: 1.hour

Same applies for `#restore`, `#wrap` and `#delete` methods.


Contacts
-------------
Have questions or recommendations? Contact me via `alexander.n.paramonov@gmail.com`
Found a bug or have enhancement request? You are welcome at [Github bugtracker](https://github.com/AlexParamonov/undo/issues)


Compatibility
-------------
tested with Ruby

* 2.1
* 2.0
* 1.9.3
* ruby-head
* rbx
* jruby-19mode
* jruby-head

See [build history](http://travis-ci.org/#!/AlexParamonov/undo/builds)


## Contributing

1. [Fork repository](http://github.com/AlexParamonov/undo/fork)
2. Create feature branch (`git checkout -b my-new-feature`)
3. Commit changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request on Github

Copyright
---------
Copyright © 2014 Alexander Paramonov.
Released under the MIT License. See the LICENSE file for further details.
