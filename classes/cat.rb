class Cat
    attr_writer :booking

    def initialize(name)
        @name = name
        # @age = age
        @booking = nil
    end
end

# Testing

# cat = Cat.new("Smokey", 4)
# p cat