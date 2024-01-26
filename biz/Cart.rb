require 'open-uri'
require 'byebug'
require 'nokogiri'
require 'csv'
require 'json'
require 'logger'

require_relative 'Item.rb'
require_relative 'MyApplicationSkorokhod.rb'

class Cart
  include MyApplicationSkorokhod

  @@cart_list = []

  def initialize
    @logger = Logger.new(STDOUT)
  end

  def save_to_csv
    path_csv = MyApplicationSkorokhod::AppSingleton.singleton_class.class_variable_get(:@@file_name) + '.csv'
    items = Cart.get_cart_list

    begin  
      File.new(path_csv, "w").close

      CSV.open(path_csv, "w", headers: ['Id', 'Name', 'Price', 'Amount', 'Weight', 'Description'], write_headers: true) do |csv|
        items.each do |item|
          csv << item.to_s
        end
      end

      @logger.info('Successfully written in the csv file')
    rescue StandardError => e
      @logger.error(e.message)
      @logger.error('Cannot open the csv file for writing')
    end
  end

  def save_to_json
    path_json = MyApplicationSkorokhod::AppSingleton.singleton_class.class_variable_get(:@@file_name) + '.json'
    items = Cart.get_cart_list

    begin 
      File.new(path_json, "w").close

      File.open(path_json, "w") do |json|
        items.each do |item|
          json.write(JSON.pretty_generate(item.to_h))
        end
      end

      @logger.info('Successfully written in the json file')
    rescue StandardError => e
      @logger.error(e.message)
      @logger.error('Cannot open the json file for writing')
    end
  end

  def self.add_to_cart(item)
    @@cart_list.push(item)
  end

  def self.get_cart_list
    @@cart_list
  end
end
