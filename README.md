# DealervaultApi

Simple Ruby API wrapper to acces DealerVault API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dealervault_api'
```

And then execute:

```shell
$ bundle install
```

Or install it yourself as:

```shell
$ gem install dealervault_api
```

## Usage

Initialize client
    
```ruby
client = DealervaultApi::Client.new('USER_EMAIL_HERE', 'API_KEY_HERE') # the token will be retrieved
```

Create a delivery request and retrieve id
```ruby
data = @client.delivery.create('PROGRAM_ID_DVV12345', 'ROOFTOP_ID_DVD12345', 'FILE_TYPE', 'TYPE')
data['requestId']
```

Check the data set

```ruby 
data = @client.delivery.data_set('REQUEST_ID', 500)
```



## Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jippylong12/dealervault_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/jippylong12/dealervault_api/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DealervaultApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jippylong12/dealervault_api/blob/master/CODE_OF_CONDUCT.md).
