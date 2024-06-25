require "gosu"
require './constant.rb'
require './area.rb'
require './player.rb'


class Main < Gosu::Window
	include Constant
	include Area
    
    def initialize
        super WIDTH, HEIGTH, false,100
        self.caption = "Game"
        @adjacentMatrice = Array.new(40){Array.new(40,{"i"=>0,"o"=>WALL})}
        area_test(WALL,VOID)
        test(WALL,VOID)
        @player = Player.new(@adjacentMatrice)
        @player.position_player(VOID,PLAYER)
    end
    

    

    def update
       
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
                    Gosu.draw_rect(col*BLOCK_X, row*BLOCK_Y, BLOCK_X, BLOCK_Y,Gosu::Color::BLUE)
                elsif @adjacentMatrice[row][col]["o"] == VOID
                    Gosu.draw_rect(col*BLOCK_X, row*BLOCK_Y, BLOCK_X, BLOCK_Y,Gosu::Color::BLACK)
                elsif @adjacentMatrice[row][col]["o"] == PLAYER
                    Gosu.draw_rect(col*BLOCK_X, row*BLOCK_Y, BLOCK_X, BLOCK_Y,Gosu::Color::RED)
                end
            end
        end
    end
end

Main.new.show
