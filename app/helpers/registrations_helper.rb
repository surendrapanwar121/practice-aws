module RegistrationsHelper
  def country_options
    ISO3166::Country.countries.map do |country|
      ["#{country.emoji_flag} #{country.iso_short_name}", country.iso_short_name]
    end
  end
end
