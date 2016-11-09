# Instant 2FA for Devise

## Configuration

### Initial Setup

In a Rails environment, require the gem in your Gemfile:

    gem 'devise_instant2fa'

Once that's done, run:

    bundle install

Note that Ruby 2.1 or greater is required.

### Installation

#### Configuration

In order to use Instant 2FA, you'll need to configure your `access_key` and `access_secret` in the `config/initializers/devise.rb` file:

```ruby
config.instant2fa_access_key = 'YOUR_ACCESS_KEY'
config.instant2fa_access_secret = 'YOUR_ACCESS_SECRET'
```

After you've updated your configuration settings, you'll need to add the `:instant2fa_authenticatable` strategy to your user (likely in your `user.rb` file):

```ruby
devise :instant2fa_authenticatable, :database_authenticatable, :registerable, :recoverable, :rememberable,
       :trackable, :validatable
```

With those changes enabled, users who enable Instant 2FA will be prompted for verification on login.

### Customisation and Usage

#### Adding the user settings page

Instant 2FA automatically provides a hosted user settings page. This library provies view helpers to embed that page in your user experience. To use the helpers, you'll need to include the `DeviseInstant2fa::Views::Helpers` module in your `ApplicationHelpers` (or in a more specific module):

```ruby
module ApplicationHelper
  include DeviseInstant2fa::Views::Helpers
end
```

Once this is included, you'll have access to the `instant2fa_settings_view(user)` method, which you can use in any view:

```html
<div class="two-factor-settings">
  <%= instant2fa_settings_view(resource) %>
</div>
````

#### Overriding the verification view

The default view that shows the form can be overridden by adding a file named `show.html.erb` (or `show.html.haml` if you prefer HAML) inside `app/views/devise/instant2fa/` and customizing it. The important element to display is the `instant2fa_verification_form` helper.

Below is an example using ERB:

```html
<p><%= flash[:notice] %></p>

<%= instant2fa_verification_form(resource_name, @hosted_page_url)%>
```
