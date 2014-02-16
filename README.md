Undo
==========
[![Build Status](https://travis-ci.org/AlexParamonov/undo.png?branch=master)](https://travis-ci.org/AlexParamonov/undo)
[![Gemnasium Build Status](https://gemnasium.com/AlexParamonov/undo.png)](http://gemnasium.com/AlexParamonov/undo)
[![Coverage Status](https://coveralls.io/repos/AlexParamonov/undo/badge.png?branch=master)](https://coveralls.io/r/AlexParamonov/undo?branch=master)
[![Gem Version](https://badge.fury.io/rb/undo.png)](http://badge.fury.io/rb/undo)

Undo last operation on object.  
Undo gem allows to use custom adapters for storage (Redis,
ActiveRecord, etc). And custom serializers when need (ActiveRecord, Virtus, etc)

Contents
---------
1. Installation
1. Requirements
1. Usage
    1. Undo operation
    1. Configuration options
    1. In place configuration
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
1. gem virtus ~> 1.0

Usage
-----

### Undo operation

Wrap object in Undo decorator:

``` ruby
Undo.wrap object
```

And use it as usual afterwards. Undo gem will store object state on each hit to `mutator methods`.  
By default mutator_methods are `update`, `delete`, `destroy`.  
To append custom mutator_methods use  

``` ruby
Undo.configure do |config|
  config.mutator_methods += [:put, :push, :pop]
end
```

To restore previous version

```
Undo.restore uuid
```

`uuid` is provided by wrapped object:

```
Undo.wrap(object).uuid
```

By default it is using `SecureRandom.uuid`.  
To define custom uuid generator use `uuid_generator` option:

``` ruby
Undo.configure do |config|
  config.uuid_generator = ->(object) { "#{object.class.name}_#{object.id}" }
end
```

### Configuration options
`storage` option responsible for putting and fetching object state to or from some storage.  
Implement `put(uuid, object)` and `fetch(uuid)` methods.  
Currently available serializers:
* `Undo::Storage::Memory` simple runtime storage (Hash)
* `gem "undo-storage-redis"` designed to be used with `gem "redis"` from v0.1

See also [documentation](http://github.com/AlexParamonov/undo)
on project repository for full list of currently available storage adapters.  
To convert objects to data that can be processed by storage adapters and backward, use `serializers`:

``` ruby
Undo.configure do |config|
  config.serializer = CustomSerializer.new
end
```

Currently available serializers:
* `Undo::Serializer::Null` pass though serializer. It do nothing and returns whatever passed to it.

Check [documentation](http://github.com/AlexParamonov/undo) on project
repository for currently available serializers.

`uuid_generator` option allows to setup custom uuid generator.

By default it is using `SecureRandom.uuid`.  
To define custom uuid generator use `uuid_generator` option:

``` ruby
Undo.configure do |config|
  config.uuid_generator = ->(object) { "#{object.class.name}_#{object.id}" }
end
```

`mutator methods` option defines a list of methods that will trigger storage#put
By default mutator_methods are `update`, `delete`, `destroy`.  
To set custom mutator_methods use  

``` ruby
Undo.configure do |config|
  config.mutator_methods = [:put, :push, :pop]
end
```

### In place configuration
Any configuration option from previous chapter can be applied in
place for given operation. To restore object from another storage use
`storage` option:

``` ruby
Undo.restore uuid, storage: AnotherStorage.new
```

To wrap an object using custom mutator_methods use `mutator_methods` option:

``` ruby
Undo.wrap object, mutator_methods: [:save]
```

To use custom serializer or deserializer use `serializer` option:

``` ruby
Undo.wrap post, serializer: PostSerializer.new(post)
post.destroy
Undo.restore uuid, serializer: PostDeserializer.new(options)
```


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

1. Fork repository ( http://github.com/AlexParamonov/undo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Copyright
---------
Copyright © 2014 Alexander Paramonov.
Released under the MIT License. See the LICENSE file for further details.
