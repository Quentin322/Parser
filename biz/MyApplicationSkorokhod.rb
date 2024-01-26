module MyApplicationSkorokhod

    class AppSingleton
        class << self
            @@web_addresses = [
                'https://chernivtsi.sushi-master.ua/menu/aktsii',
                'https://chernivtsi.sushi-master.ua/menu/rolls',
                'https://chernivtsi.sushi-master.ua/menu/californii'
            ]

            @@file_name = 'outputs/list_of_products'
    
            @@validator = -> (pages) { pages >= 5 && pages <= 100 }
    
            @@file_ext = ['rb']
    
            @@parse_item = /<div class="products-list-el">(.*)<\/div>/
        end
    end
    
    module ClassMethods
    end
    
    module InstanceMethods
    end
end
