require 'open-uri'
require 'byebug'
require 'nokogiri'
require 'logger'

require_relative '../biz/Item.rb'
require_relative '../biz/Cart.rb'
require_relative '../biz/MyApplicationSkorokhod.rb'

class Parser
    include MyApplicationSkorokhod

    def initialize(url)
        @url = url
        @logger = Logger.new(STDOUT)
    end

    def parse()
        begin
            html = URI.open(@url) { |result| result.read}
            doc = Nokogiri::HTML(html)
            i = 0
            doc.css('.products-list-el').each do |element|
                item = Item.new()
                item.name = element.css(".bottom-block").css(".title-block").text
                item.description = element.css(".bottom-block").css(".description").text
                item.price = element.css(".bottom-block").css(".add-to-card-block").css('.prices').css('.current-price').text.split(" ")[0]
                item.weight = element.css(".bottom-block").css(".under-title").text.split(" ")[1]
                item.amount = element.css(".bottom-block").css(".under-title").text.split(" ")[0].to_i
                item.id = i+1
                i= i+1
                Cart.add_to_cart(item)
            end

            @logger.info('Successfully parsed the provided page - ' + @url)
        rescue OpenURI::HTTPError => e
            @logger.error(e.message)
            @logger.error('Error on parsing page - ' + @url)
        end
    end
    
end

