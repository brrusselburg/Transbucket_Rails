Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :letter_opener

  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.serve_static_files = true #false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.log_level = :debug

  config.action_mailer.default_url_options = {
    :host => "transbucket.com"
  }

  Paperclip.options[:command_path] = '/usr/local/bin/identify'

  # if you need to test s3, uncomment this
  #config.paperclip_defaults = {
    #:storage => :s3,
		#:s3_region => "us-east-1",
    #:s3_credentials => {
      #:bucket => ENV['S3_BUCKET'],
      #:access_key_id => ENV['S3_KEY'],
      #:secret_access_key => ENV['S3_SECRET']
    #}
  #}

  config.after_initialize do
    Bullet.enable = true
    Bullet.bullet_logger = true
    #Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
    #                :password => 'bullets_password_for_jabber',
    #                :receiver => 'your_account@jabber.org',
    #                :show_online_status => true }
    Bullet.rails_logger = true
  end
end
