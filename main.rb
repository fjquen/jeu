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
        base_game(NUM_BLOCK,WALL,VOID,LOOP,PLAYER,ENNEMY,GOAL)
        @direction
    end
    

    

    def update
        if @bool_move
        @camera_y = @player.y_player * BLOCK_Y - @adjacentMatrice.flatten.count(WALL)-NUM_BLOCK
        @camera_x = @player.x_player * BLOCK_X - @adjacentMatrice.flatten.count(WALL)-NUM_BLOCK
        
        for n in 0..5
            @test[n].move(@player.x_player,@player.y_player,WALL,ENNEMY,VOID,GOAL)
        end
       
            if Gosu.button_down? Gosu::KB_RIGHT
                @direction = "r"
                @player.move(@direction,WALL,VOID,PLAYER)
                next_level_maze(WALL,VOID,LOOP,NUM_BLOCK,PLAYER,GOAL,ENNEMY,@player.y_player,@player.x_player+1)
            end
            
            if Gosu.button_down? Gosu::KB_LEFT
                @direction = "l"
                @player.move(@direction,WALL,VOID,PLAYER)
                next_level_maze(WALL,VOID,LOOP,NUM_BLOCK,PLAYER,GOAL,ENNEMY,@player.y_player,@player.x_player-1)
            end
            
            
            if Gosu.button_down? Gosu::KB_UP
                @direction = "u"
                @player.move(@direction,WALL,VOID,PLAYER)
                next_level_maze(WALL,VOID,LOOP,NUM_BLOCK,PLAYER,GOAL,ENNEMY,@player.y_player-1,@player.x_player)
            end
            
            if Gosu.button_down? Gosu::KB_DOWN
                @direction = "d"
                @player.move(@direction,WALL,VOID,PLAYER)
                next_level_maze(WALL,VOID,LOOP,NUM_BLOCK,PLAYER,GOAL,ENNEMY,@player.y_player+1,@player.x_player)
            end
        end

        def button_down(id)
            case id
            when Gosu::KB_ESCAPE
                close
            when Gosu::KB_R
                if @lose
                 base_game(NUM_BLOCK,WALL,VOID,LOOP,PLAYER,ENNEMY,GOAL)
                end
            when Gosu::KB_SPACE
                case @direction
                    when "r"
                        @adjacentMatrice[@player.y_player][@player.x_player+1]["o"] = WALL
                    when "l"
                        @adjacentMatrice[@player.y_player][@player.x_player-1]["o"] = WALL
                    when "u"
                        @adjacentMatrice[@player.y_player-1][@player.x_player]["o"] = WALL
                    when "d"
                        @adjacentMatrice[@player.y_player+1][@player.x_player]["o"] = WALL
                end
            end
        end
        for n in 0..5
            if @test[n].y_ennemy == @player.y_player and  @test[n].x_ennemy+1 == @player.x_player
                @lose = true
            elsif @test[n].y_ennemy == @player.y_player and @test[n].x_ennemy-1 == @player.x_player
                @lose = true
            elsif @test[n].y_ennemy+1 == @player.y_player and @test[n].x_ennemy == @player.x_player
                @lose = true
            elsif @test[n].y_ennemy-1 == @player.y_player and  @test[n].x_ennemy == @player.x_player
                @lose = true
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
        if @lose
            draw_font_lose()
        end
    end


    def draw_font_lose
          @bool_move = false
          Gosu.draw_rect(100, 190, 400, 50, Gosu::Color::WHITE)
          @font.draw_text("t'es mort bitch", 130, 205, 0, 1, 1, Gosu::Color::BLACK)
          @adjacentMatrice.clear
    end
end

Main.new.show
