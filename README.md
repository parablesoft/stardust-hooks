# Stardust::Hooks
The `Stardust::Hooks` gem allows you to easily add subscribers to models, which correspond with configurations created with the Hooks DSL. 

TODO: Need to describe this better


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'stardust-hooks', 
  git: "https://github.com/parablesoft/stardust-hooks.git",
  branch: "master"

```

And then execute:
```bash
$ bundle
$ rake db:migrate
```

Create an initializer with the following:
```ruby
Stardust::Hooks::SubscriptionManager.create_subscriptions
```

Create load files for the graph

1) Create `/app/graph/mutations/stardust_hooks.rb`

```ruby
load 'stardust/hooks/graph/mutations.rb'
```

2) Create `/app/graph/queries/stardust_hooks.rb`

```ruby
load 'stardust/hooks/graph/queries.rb'
```

3) Create `/app/graph/types/stardust_hooks.rb`

```ruby
load 'stardust/hooks/graph/types.rb'
```




## Usage

### Include in your models

By including the publishable module in your model, any time an instance of a model is created, updated or deleted, it will publish those events. Subscribers are configured to listen for these events.

```ruby
include Stardust::Hooks::Hook::Publishable
```


### Hook Scopes
You must also specify how the model is associated to the referencable association set on the hook, by implementing the private hook scope method. References can be set on hooks so they are only run when they are associated with that reference. Hook scope gives a way back to that reference.

**Examples**

```ruby
def hook_scope
	nil
end
```

```ruby
def hook_scope
  self.dealer
end
```

```ruby
def hook_scope
  self.dealer.order
end
```


### Publishable Attributes

By default all attributes of a model will be watched. If you provide a `publishable_attributes` method definition, the hook will only fire if changes have happened on at least one of those attributes. This is only applicable on the update event. Publishable attributes should return an array of symbols. 

**Examples**

You can whitelist attributes by providing an array of fields
```ruby
def publishable_attributes
  [:first_name,:last_name]
end
```
If you call super from your implementation, you'll get access to all of the model's attributes, which allows you to blacklist attributes as shown in the example below.
```ruby
def publishable_attributes
  super - [:updated_at]
end
```



## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
