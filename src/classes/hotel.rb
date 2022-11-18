#equire 'tty-prompt'
require_relative './prompt.rb'
require_relative '../methods/headers'

class Hotel_Info
    attr_reader :name

    # We have initialized the hotel with all this data - so that the data is in one location if it needs to be modified.
    # If in the future we were to expand to different locations, we could create Hotel subclasses, and hard-code the information in there. 
    def initialize
        @name = "Purr Seasons"
        @address = "32 Cat St, Tabby Town"
        @phone = "1800 MEOW MEOW"
        @email = "say_meow@purrseasons.com"
        @about = "~ An Experience Your Cat Won\'t Forget ~ \n The Purr Seasons is a luxury cat hotel. \n It's so good you'll wish you could stay too! \n\n All our rooms are heated to the purr-fect temperature,\n are fitted with cosy furnishings,\n include lots of cuddle time (if your cat likes that!),\n and are designed to make your cat feel at home. "
    
    end

    # Displays the contact information for the hotel
    def hotel_info
        puts HEADER_LINE
        puts "#{@name.upcase}".center(HEADER_LENGTH)
        puts HEADER_LINE
        puts
        contact_info
        puts
        puts HEADER_LINE
        puts
        puts "   #{@about}"
        puts
        puts HEADER_LINE
    end

    # Contact information is seperated from hotel information so that we can use this contact information in different locations if we need it
    def contact_info
        puts " Address: #{@address}"
        puts " Phone No: #{@phone}"
        puts " Email: #{@email}"
    end

    # adds a room to the hotel - pushes the room to the rooms array
    # def add_room(room)
    #     @rooms << room
    #     return self
    # end

    # # menu to choose a room in the hotel
    # def select_room

    #     # These two lines create an array for the menu to display the room names
    #     menu = []
    #     @rooms.each { |room| menu.push(room.type)} 

    #     # this displays the menu using the TTY-Prompt gem. It returns the selected room
    #     selection = Prompt.instance.select("Choose a room type:", menu, cycle: true, marker: '>', echo: false)
    #         @rooms.each { |room| return room if room.type == selection }
    # end
end

class Manage_Hotel
    attr_reader :rooms

    def initialize
        @rooms = []          # Array of room objects - one advantage of having this array is that when new rooms are added to the Hotel class, the rest of the code does not have to be changed, and it will display in the main application. 
    end

    def add_room(room)
        @rooms << room
        return self
    end

    # menu to choose a room in the hotel
    def select_room

        # These two lines create an array for the menu to display the room names
        menu = []
        @rooms.each { |room| menu.push(room.type)} 

        # this displays the menu using the TTY-Prompt gem. It returns the selected room
        selection = Prompt.instance.select("Choose a room type:", menu, cycle: true, marker: '>', echo: false)
            @rooms.each { |room| return room if room.type == selection }
    end
end