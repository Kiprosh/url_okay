require "url_okay/version"

module UrlOkay
	  ## URL patterns
	# Pinterest: http://www.pinterest.com/pin/322218548312284034/
	# Realtor: http://www.realtor.com/realestateandhomes-detail/54-Ada-Dr_Staten-Island_NY_10314_M36593-07012
	# Trulia: http://www.trulia.com/property/3064326987-127-Dixieland-Dr-New-Market-AL-35761
	# Zillow: http://www.zillow.com/homes/for_sale/IA/list/19_rid/44.272738,-89.653931,39.550648,-97.124634_rect/

	class ProperUrlValidator < ActiveModel::EachValidator
	  REG_URL         = /^(https?:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/i
	  SPECIFIC_DOMAIN = [:pinterest_link, :realtor_link, :trulia_link, :zillow_link, :youtube_link]
	  SPECIFIC_URL    = /^(https?:\/\/)?((w{3}\.)?)(pinterest|realtor|trulia|youtube|zillow)\.com(\/[A-Za-z0-9\-_%&\?\/\.=,+]*)?$/i

	  def validate_each(record, attribute, value)
	    error = I18n.t("activerecord.errors.models.#{record.class.name.downcase}.attributes.#{attribute.to_s}.invalid",
	      attribute: attribute.to_s.humanize.downcase)

	    record.errors.add(attribute, error) unless (value =~ regex(attribute))
	  end

	  private
	    def regex(col)
	      SPECIFIC_DOMAIN.include?(col) ? SPECIFIC_URL : REG_URL
	    end
	end
end
