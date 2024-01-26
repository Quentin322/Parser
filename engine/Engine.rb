require 'logger'

require_relative '../helpers/Parser.rb'
require_relative '../biz/Cart.rb'

class Engine

    def initialize()
        @logger = Logger.new(STDOUT)
    end 

    def perform_parsing(urls)
        parser1 = Parser.new(urls[0])
        parser2 = Parser.new(urls[1])
        parser3 = Parser.new(urls[2])

        cart = Cart.new()
        @logger.info('New Cart is created')

        thread1 = Thread.new{parser1.parse}
        @logger.info('New thread1 is created')
        thread2 = Thread.new{parser2.parse}
        @logger.info('New thread2 is created')
        thread3 = Thread.new{parser3.parse}
        @logger.info('New thread3 is created')

        thread1.join
        thread2.join
        thread3.join
        
        @logger.info('Website is parsed')

        cart.save_to_csv()
        cart.save_to_json()

    end

end
