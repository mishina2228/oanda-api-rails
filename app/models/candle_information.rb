class CandleInformation
  include ActiveModel::Model

  attr_accessor :usd_jpy_m1_count, :eur_jpy_m1_count, :gbp_jpy_m1_count
  attr_accessor :usd_jpy_m1_latest, :eur_jpy_m1_latest, :gbp_jpy_m1_latest

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value) if respond_to?("#{key}=")
    end
  end
end
