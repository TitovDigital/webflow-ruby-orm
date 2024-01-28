# Webflow-Ruby-Orm

`webflow-ruby-orm` gem implements object-oriented way to access
data in Webflow using v2 Webflow API.

See also [OmniAuth Webflow strategy](https://github.com/TitovDigital/omniauth-webflow).

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG

## Usage

Implementation follows the ActiveRecord pattern with minor differences.

```ruby
> Webflow::Base.set_token('abcd....')
> sites = Webflow::Site.all
[#<Webflow::Site:0x00007f44bb435d30
  @attributes=
   {"id"=>"603...",
    "workspaceId"=>"62a2...",
    "displayName"=>"Able CDP",
    #...
   }
]
> sites.first.display_name
"Able CDP"
> sites.first.time_zone
"Europe/London"
> sites.collections
[#<Webflow::Collection:0x00007efce6d0dfb0
  @attributes=
   {"id"=>"...",
    "displayName"=>"Blog Posts",
    "singularName"=>"Blog Post",
    "slug"=>"blog",
    "createdOn"=>"2021-03-12T02:22:28.146Z",
    "lastUpdated"=>"2021-03-12T02:25:42.901Z"},
  @parent=
   #<Webflow::Site:0x00007efce7c7bab0
]
```

## Architecture

Webflow model classes are generated dynamically on load:
* [webflow.rb](lib/webflow.rb) defines models and associations to create
* [webflow/base.rb](lib/webflow/base.rb) is a common model implementation

### ToDo
* Pagination
* Saving changes to existing records

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TitovDigital/webflow-ruby-orm.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
