# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_default-twitter-auth-app_session',
  :secret      => '1b006d88b95a4e8b3a19a475162ff197282c431c9b986c5439765d230de711b1e5dc6d7685feb4c6bf1386222006a393562cb5a4128fcddba781a4e060fdb325'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
