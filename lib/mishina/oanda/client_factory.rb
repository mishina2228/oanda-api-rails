class Mishina::Oanda::ClientFactory
  def self.client(token_path: nil, domain: :practice)
    token_path ||= Constants::Mishina::OANDA_TOKEN_PATH
    token_yml = YAML.load_file(token_path)
    token = token_yml['oanda']['api_key']
    OandaAPI::Client::TokenClient.new(domain, token)
  end
end
