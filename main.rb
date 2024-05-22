require "gosu"

class Main < Gosu::Window
    def initialize
        super 640, 480
        self.caption = "Game"
         @mazeCreate = Array.new(20){Array.new(20,"#")}
        rand_position = rand(@mazeCreate.length-1)
       
        @x,@y=rand_position,rand_position
        @mazeCreate[@x][@y] = ' '
		@tab_move_seed = ["r","l","d","u"]
		
		1000.times { |i| 
		case @tab_move_seed .sample
			when "r"
			 x=@x+1
			 if @mazeCreate[@y][x] == '#' and x<@mazeCreate.length-1 and !@mazeCreate[@y][x].nil?
				@x=x
				@mazeCreate[@y][@x] = ' '
			 end
			 
			when "l"
			 x=@x-1
			 if @mazeCreate[@y][x] == '#' and x>0 and !@mazeCreate[@y][x].nil?
				@x=x
				@mazeCreate[@y][@x] = ' '
			 end
			 
			when "d"
			y=@y+1
			if @mazeCreate[y][@x] == '#' and y<@mazeCreate.length-1 and !@mazeCreate[y][@x].nil?
				@y=y
				@mazeCreate[@y][@x] = ' '
			end
			
			when "u"
			 y=@y-1
			 if @mazeCreate[y][@x] == '#' and y>0 and !@mazeCreate[y][@x].nil?
				@y=y
				@mazeCreate[@y][@x] = ' '
			 end
			 
		   end 
	   }
    end

    def update
       
    end
    

    
    def draw
        @mazeCreate.each_index do |row|
            @mazeCreate[row].each_index do |col|
                if @mazeCreate[row][col] == "#"
                    Gosu.draw_rect(col*20, row*20, 20, 20,Gosu::Color::BLUE)
                elsif @mazeCreate[row][col] == " "
                    Gosu.draw_rect(col*20, row*20, 20, 20,Gosu::Color::BLACK)
                end
            end
        end
    end
   
end

Main.new.show
