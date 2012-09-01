
#initialize these variables before all others.
S3_CREDENTIALS = Rails.root.join("config/s3.yml")

#already have this in Settings.config.facebook, but it might not load in time: check later.
FACEBOOK_CONFIG = YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]
