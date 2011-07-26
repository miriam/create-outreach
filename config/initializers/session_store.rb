# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_create-outreach_session',
  :secret      => 'f4b2935618bd20ac59263d4b8ce1e4215ef8fd97da685f773aca35352dc15ae81e019cdf296bb12fa7766babdabc60681b7d137e5f5631b1a74598b2eed7eddd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
