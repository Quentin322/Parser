require 'logger'

class InputReader

    def initialize()
        @logger = Logger.new(STDOUT)
    end

    def read(welcome_message, process, validator, error_message)
        @logger.info(welcome_message)

        while 1
            input = gets.chomp

            if validator.call input
                return process.call input
            else
                @logger.error(error_message)
            end
        end
    end
end
