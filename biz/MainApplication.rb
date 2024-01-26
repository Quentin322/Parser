require_relative 'MyApplicationSkorokhod.rb'
require_relative '../helpers/InputReader.rb'
require_relative '../engine/Engine.rb'

class MainApplication
    include MyApplicationSkorokhod

    class Application

        def run
            input_reader = InputReader.new

            catalogue_links = MyApplicationSkorokhod::AppSingleton.singleton_class.class_variable_get(:@@web_addresses)

            engine = Engine.new

            engine.perform_parsing(catalogue_links)
        end
    end
end
