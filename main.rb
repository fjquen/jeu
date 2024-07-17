require "gosu"
require './constant.rb'
require './area.rb'
require './player.rb'
require './exit.rb'


class Main < Gosu::Window
	include Constant
	include Area
    
    def initialize
        super WIDTH, HEIGTH, false,100
        self.caption = "Game"
        @array_dig = []
        @adjacentMatrice = Array.new(NUM_BLOCK){Array.new(NUM_BLOCK,{"i"=>0,"o"=>WALL})}
        generate_maze(WALL,VOID,LOOP,NUM_BLOCK)
        maze_fusion(WALL,VOID,NUM_BLOCK)
        @player = Player.new(@adjacentMatrice)
        @player.position_player(VOID,PLAYER)
        maze_connection(WALL,VOID)
    end
    

    

    def update
        @camera_y = @player.y_player * BLOCK_Y - @adjacentMatrice.flatten.count(WALL)-NUM_BLOCK
        @camera_x = @player.x_player * BLOCK_X - @adjacentMatrice.flatten.count(WALL)-NUM_BLOCK
        
        if Gosu.button_down? Gosu::KB_RIGHT
            @player.move("r",WALL,VOID,PLAYER)
        end
        
		if Gosu.button_down? Gosu::KB_LEFT
            @player.move("l",WALL,VOID,PLAYER)
        end
        
        
        if Gosu.button_down? Gosu::KB_UP
            @player.move("u",WALL,VOID,PLAYER)
        end
        
        if Gosu.button_down? Gosu::KB_DOWN
            @player.move("d",WALL,VOID,PLAYER)
        end
    end
    

    
    def draw
        
        @adjacentMatrice.each_index do |row|
            @adjacentMatrice[row].each_index do |col|
                if @adjacentMatrice[row][col]["o"] == WALL
                    Gosu.draw_rect(col*BLOCK_X-@camera_x+NUM_BLOCK, row*BLOCK_Y-@camera_y+NUM_BLOCK, BLOCK_X, BLOCK_Y,Gosu::Color::BLUE)
                elsif @adjacentMatrice[row][col]["o"] == VOID
                    Gosu.draw_rect(col*BLOCK_X-@camera_x+NUM_BLOCK, row*BLOCK_Y-@camera_y+NUM_BLOCK, BLOCK_X, BLOCK_Y,Gosu::Color::BLACK)
                elsif @adjacentMatrice[row][col]["o"] == PLAYER
                    Gosu.draw_rect(col*BLOCK_X-@camera_x+NUM_BLOCK, row*BLOCK_Y-@camera_y+NUM_BLOCK, BLOCK_X, BLOCK_Y,Gosu::Color::RED)
                elsif @adjacentMatrice[row][col]["o"] == TEST
                    Gosu.draw_rect(col*BLOCK_X-@camera_x+NUM_BLOCK, row*BLOCK_Y-@camera_y+NUM_BLOCK, BLOCK_X, BLOCK_Y,Gosu::Color::WHITE)
                end
            end
        end
    end
end

Main.new.show
