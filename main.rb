require "gosu"
require "./player.rb"

class Main < Gosu::Window
    def initialize
        
    end

    def update
       
    end
    

    
    def draw
        @player.draw
    end
   
end

Main.new.show
