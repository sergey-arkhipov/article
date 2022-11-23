# elasticsearch.rb
ELASTIC_PASSWORD = Rails.application.credentials[:elastic_password]
CERT_FINGERPRINT = Rails.application.credentials[:cert_fingerprint]
config = {
  host: "https://elastic:#{ELASTIC_PASSWORD}@localhost:9200",
  transport_options: {
    ssl: { verify: false },
    request: { timeout: 5 }
  },
  ca_fingerprint: CERT_FINGERPRINT
}

if File.exist?('config/elasticsearch.yml')
  config.merge!(YAML.load_file('config/elasticsearch.yml')[Rails.env].deep_symbolize_keys)
end

Elasticsearch::Model.client = Elasticsearch::Client.new(config)
