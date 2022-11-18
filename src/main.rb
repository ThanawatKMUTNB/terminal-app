#---------------------------------------------------------------------------------------------------------------------
#                            PURR SEASONS CAT HOTEL
#                                  Terminal App
#
#                    Creatively and Lovingly Hand Crafted by
#                      Carlie Hamilton and Natalie Sargent
#                 for our Coder Academy - Ruby Terminal Assignment
#                   
#  Version 1.3
#  24 April 2019
#---------------------------------------------------------------------------------------------------------------------

require 'tty-prompt'
require_relative './classes/hotel'
require_relative './classes/room'
require_relative './classes/cat'
require_relative './classes/booking'
require_relative './methods/headers'

# Create a hotel and rooms
hotel = Manage_Hotel.new.add_room(Deluxe.new).add_room(Luxury.new).add_room(Grey.new)
hotel_in = Hotel_Info.new

# Welcome message
clear
welcome(hotel_in)

# Enter Cat guest details
puts "\n    Hello Human! \n\n"
puts "Please enter your cat's name right meow: \n\n"

# Creating a cat - loop to make sure the user types in something. This exits out of the loop if the user does not type anything in after 3 tries. 
# In the future we could use some regex to make sure the user formats a cat name to some standard, such as starting with a letter. 
cat_name_count = 0
while cat_name_count < 3
    cat_name = gets.chomp.capitalize

    # exits the loop if the user types in a name
    if cat_name != "" 
        clear
        break

    # continues the loop until the user types in a name, or until the cat_name_count is greater than three. 
    else
        cat_name_count += 1
        if cat_name_count == 3
            clear
            puts "\n\n You must have a shy cat..."
            cat_name = "The Cat Without A Name"
        else
            puts "Ooops, please enter your cat's name:"
        end
    end
end

# Creates a new cat object, and reaffirms to the user their input with a greeting. 
cat = Cat.new(cat_name)
puts "\n\n Meow #{cat.name}!"

# Main Application Loop - menu options
while true
    
    # Display hotel menu options using TTY-Prompt gem
    welcome(hotel_in)
    selection = TTY::Prompt.new.select("How may we assist you today? Please select from the following options:",  cycle: true, marker: '>', echo: false) do |menu|
        menu.choice('Make a new booking', 1)
        menu.choice('View an existing booking', 2)
        menu.choice('View hotel rooms', 3)
        menu.choice('View hotel information', 4)
        menu.choice('Exit', 5)

        case selection

        # 1. Make a new booking
        when 1

            # A booking has already been created
            if cat.booking
                clear
                welcome(hotel_in)
                puts "\n\n\n You already have a booking! \n\n\n"

            # If there is no booking, creates a booking
            else
                # Display list of room types and select a room
                new_booking_header
                room = hotel.select_room
                
                # Displays the room details, including availability
                # The user selects the days they want for the booking
                new_booking_header
                room.display_room
                room.display_features
                booking_days = room.select_days

                # checks if user has selected days
                while booking_days.length == 0
                    new_booking_header
                    puts "\n\n Ooops, no days were selected. \n\n\n"
                    booking_days = room.select_days
                end

                # creates the booking
                cat.booking = Booking.new(room, booking_days)

                # loading screen
                loading_screen("Loading your booking right meow......")


                # Displays the booking for user including price
                clear
                puts "Thank you for your booking!"
                cat.booking.display_booking(cat, hotel_in)
                back_main_menu
            end

        # View an existing booking
        when 2
            
            if cat.booking
                # View an existing booking
                clear
                cat.booking.display_booking(cat, hotel_in)
                back_main_menu
            else
                # Or, if there is no booking, displays an error message
                clear
                welcome(hotel_in)
                puts "\n\n  Ooops, sorry, you don't have a booking yet! \n\n\n"
            end

        # View hotel room types
        when 3
            # user selects a room type to view
            view_rooms_header
            room = hotel.select_room
            
            # Display details of room selected
            room_name_header(room.type)
            room.display_room
            room.display_features
            room.display_availability
            back_main_menu

        # View about the hotel and contact information
        when 4
            clear
            hotel.hotel_info #
            back_main_menu

        # Quit
        when 5
            # Goodbye message if the user has created a booking
            if cat.booking
                clear
                puts "Thank you #{cat_name}!"
                puts "We look forward to welcoming you at the Purr Seasons on #{cat.booking.days[0]}." 
                puts "Have a purr-fect day!"
                return
            
            # Goodbye message if a booking hasn't been created
            else 
                clear
                puts "Thank you #{cat_name}"
                puts "We hope you will visit us soon!"
                puts "Have a purr-fect day"
                return
            end
        end
    end
end