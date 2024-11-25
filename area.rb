module Area

    def generate_area_block(wall)
        n=0
        @adjacentMatrice.each_index do |y|
            @adjacentMatrice[y].each_index do |x|
                if x<@adjacentMatrice.length
                    n+=1
                    @array_indice.push(n)
                    @adjacentMatrice[y][x] = {"i"=>n,"o"=>wall}
                end
            end
        end
    end

    def generate_maze(wall,void,looper,num_block)
        n=0
        while n<looper
            y_adj = 0
            x_adj = 0
            fusion = @array_indice.sample
            @adjacentMatrice.each_index do |y|
                @adjacentMatrice[y].each_index do |x|
                    if @adjacentMatrice[y][x]["i"] == fusion and x>1 and y>1 and x<num_block-2 and y<num_block-2
                        y_adj = y
                        x_adj = x
                        @adjacentMatrice[y][x]["o"] =void
                        @array_fusion<<{"x"=>x_adj,"y"=>y_adj}
                        @array_dig.push({"y"=>y,"x"=>x})
                    end
                end
            end

        tab_direction = [{"x"=>0,"y"=>1},{"x"=>0,"y"=>-1},{"x"=>1,"y"=>0},{"x"=>-1,"y"=>0}]
        direction = tab_direction.sample
            if y_adj < num_block-2 and x_adj < num_block-2 and y_adj > 1 and x_adj > 1
                if @adjacentMatrice[y_adj+direction["y"]][x_adj+direction["x"]]["o"] == wall  and @adjacentMatrice[y_adj+direction["y"]][x_adj+direction["x"]]["i"] != fusion
                    @adjacentMatrice[y_adj+direction["y"]][x_adj+direction["x"]]["i"] = fusion
                    @adjacentMatrice[y_adj+direction["y"]][x_adj+direction["x"]]["o"] = void
                end
            end
            n+=1
        end
	end

    def dig_x(array_f, i,wall,void,num_block)
        if array_f[i]["x"]+1 < num_block-2 and array_f[i]["x"]+2 < num_block-2
            if @adjacentMatrice[array_f[i]["y"]][array_f[i]["x"]+1]["o"] == wall and @adjacentMatrice[array_f[i]["y"]][array_f[i]["x"]+2]["o"] == void
                @adjacentMatrice[array_f[i]["y"]][array_f[i]["x"]+1]["o"]= void
            elsif @adjacentMatrice[array_f[i]["y"]][array_f[i]["x"]-1]["o"] == wall and @adjacentMatrice[array_f[i]["y"]][array_f[i]["x"]-2]["o"] == void
                @adjacentMatrice[array_f[i]["y"]][array_f[i]["x"]-1]["o"]= void
            end
        end
    end

    def dig_y(array_f, i,wall,void,num_block)
        if array_f[i]["y"]+1 < num_block-2 and array_f[i]["y"]+2< num_block-2
            if @adjacentMatrice[array_f[i]["y"]-1][array_f[i]["x"]]["o"] == wall and @adjacentMatrice[array_f[i]["y"]-2][array_f[i]["x"]]["o"] == void
                @adjacentMatrice[array_f[i]["y"]-1][array_f[i]["x"]]["o"]= void
                @array_dig.push({"y"=>array_f[i]["y"]-1,"x"=>array_f[i]["x"]})
            elsif @adjacentMatrice[array_f[i]["y"]+1][array_f[i]["x"]]["o"] == wall and @adjacentMatrice[array_f[i]["y"]+2][array_f[i]["x"]]["o"] == void
                @adjacentMatrice[array_f[i]["y"]+1][array_f[i]["x"]]["o"]= void
                @array_dig.push({"y"=>array_f[i]["y"]+1,"x"=>array_f[i]["x"]})
            end
        end
    end



    def maze_fusion(wall,void,num_block)
        random = rand(2)
       for n in 0..@array_fusion.length-1
        if random == 0
            dig_x(@array_fusion, n,wall,void,num_block)
        elsif random == 1
            dig_y(@array_fusion, n,wall,void,num_block)
        end
       end
    end

    def maze_connection(wall,void)
        @array_dig.each do |n|
            if @adjacentMatrice[n["y"]-1][n["x"]]["o"] == wall and @adjacentMatrice[n["y"]-2][n["x"]]["o"] == void
                @adjacentMatrice[n["y"]-1][n["x"]]["o"]= void
            elsif @adjacentMatrice[n["y"]+1][n["x"]]["o"] == wall and @adjacentMatrice[n["y"]+2][n["x"]]["o"] == void
                @adjacentMatrice[n["y"]+1][n["x"]]["o"]= void
            elsif @adjacentMatrice[n["y"]][n["x"]+1]["o"] == wall and @adjacentMatrice[n["y"]][n["x"]+2]["o"] == void
                @adjacentMatrice[n["y"]][n["x"]+1]["o"]= void
            elsif @adjacentMatrice[n["y"]][n["x"]-1]["o"] == wall and @adjacentMatrice[n["y"]][n["x"]-2]["o"] == void
                @adjacentMatrice[n["y"]][n["x"]-1]["o"]= void
            end
        end
    end

    def next_level_maze(wall,void,nloop,num_block,player,goal,ennemy,y_dist_player,x_dist_player)
        if @adjacentMatrice[y_dist_player][x_dist_player]["o"] == goal
            @array_dig = []
            @array_indice = []
            @array_fusion = []
            generate_area_block(wall)
            generate_maze(wall,void,nloop,num_block)
            maze_fusion(wall,void,num_block)
            maze_connection(wall,void)
            @player.position_player(void,player)
            @goal.position_exit(void,goal)
            for n in 0..5
                @test[n].position_ennemy(void,ennemy,player)
            end
        end
    end


    def base_game(num_block,wall,void,looper,player,ennemy,goal)
        @array_dig = []
        @array_indice = []
        @array_fusion = []
        @adjacentMatrice = Array.new(num_block){Array.new(num_block,{"i"=>0,"o"=>wall})}
        generate_area_block(wall)
        generate_maze(wall,void,looper,num_block)
        maze_fusion(wall,void,num_block)
        maze_connection(wall,void)
        @player = Player.new(@adjacentMatrice)
        @goal = Exit.new(@adjacentMatrice)
        
        @player.position_player(void,player)
        @goal.position_exit(void,goal)
        @font = Gosu::Font.new(20)
        @bool_move = true
        @lose = false

        @test = []

        for n in 0..5
            @test.push(Ennemy.new(@adjacentMatrice))
        end

        for n in 0..5
            @test[n].position_ennemy(void,ennemy,player)
        end
    end
end