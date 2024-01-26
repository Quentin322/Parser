require_relative 'MyApplicationSkorokhod.rb'

module ItemContainer
    include MyApplicationSkorokhod
    
    module ClassMethods
    end
    
    module InstanceMethods
    end

    self.included(class_instance)
    
end
