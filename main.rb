require "gosu"
require './constant.rb'
require './area.rb'
require './player.rb'
require './exit.rb'
require './ennemy.rb'


class Main < Gosu::Window
	include Constant
	include Area
    
    def initialize
        super WIDTH, HEIGTH, false,100
        self.caption = "Game"
        @array_dig = []
        @array_indice = []
        @array_fusion = []
        @adjacentMatrice = Array.new(NUM_BLOCK){Array.new(NUM_BLOCK,{"i"=>0,"o"=>WALL})}
        generate_area_block(WALL)
        generate_maze(WALL,VOID,LOOP,NUM_BLOCK)
        maze_fusion(WALL,VOID,NUM_BLOCK)
        maze_connection(WALL,VOID)
        @player = Player.new(@adjacentMatrice)
        @goal = Exit.new(@adjacentMatrice)
        @ennemy = Ennemy.new(@adjacentMatrice)
        @player.position_player(VOID,PLAYER)
        @goal.position_exit(VOID,GOAL)
        @ennemy.position_ennemy(VOID,ENNEMY)
        @font = Gosu::Font.new(20)
        @bool_move = true
    end
    

    

    def update
        @camera_y = @player.y_player * BLOCK_Y - @adjacentMatrice.flatten.count(WALL)-NUM_BLOCK
        @camera_x = @player.x_player * BLOCK_X - @adjacentMatrice.flatten.count(WALL)-NUM_BLOCK
        #@ennemy.move(@player.x_player,@player.y_player,WALL,ENNEMY,VOID,GOAL)
        
        if @bool_move
            if Gosu.button_down? Gosu::KB_RIGHT
                @player.move("r",WALL,VOID,PLAYER)
                next_level_maze(WALL,VOID,LOOP,NUM_BLOCK,PLAYER,GOAL,ENNEMY)
            end
            
            if Gosu.button_down? Gosu::KB_LEFT
                @player.move("l",WALL,VOID,PLAYER)
                next_level_maze(WALL,VOID,LOOP,NUM_BLOCK,PLAYER,GOAL,ENNEMY)
            end
            
            
            if Gosu.button_down? Gosu::KB_UP
                @player.move("u",WALL,VOID,PLAYER)
                next_level_maze(WALL,VOID,LOOP,NUM_BLOCK,PLAYER,GOAL,ENNEMY)
            end
            
            if Gosu.button_down? Gosu::KB_DOWN
                @player.move("d",WALL,VOID,PLAYER)
                next_level_maze(WALL,VOID,LOOP,NUM_BLOCK,PLAYER,GOAL,ENNEMY)
            end
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
                elsif @adjacentMatrice[row][col]["o"] == GOAL
                    Gosu.draw_rect(col*BLOCK_X-@camera_x+NUM_BLOCK, row*BLOCK_Y-@camera_y+NUM_BLOCK, BLOCK_X, BLOCK_Y,Gosu::Color::WHITE)
                elsif @adjacentMatrice[row][col]["o"] == ENNEMY
                    Gosu.draw_rect(col*BLOCK_X-@camera_x+NUM_BLOCK, row*BLOCK_Y-@camera_y+NUM_BLOCK, BLOCK_X, BLOCK_Y,Gosu::Color::YELLOW)
                end
            end
        end

        draw_font_lose()
    end


    def draw_font_lose
        if @player.x_player == @ennemy.x_ennemy and @player.y_player == @ennemy.y_ennemy
          @bool_move = false
          Gosu.draw_rect(100, 190, 400, 50, Gosu::Color::WHITE)
          @font.draw_text("t'es mort bitch", 130, 205, 0, 1, 1, Gosu::Color::BLACK)
          @adjacentMatrice.clear
        end
    end
end

Main.new.show
