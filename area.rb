module Area
    def area_test(wall,void,looper,num_block)
		n=0
        @array_indice = []
        @array_fusion = []
        @adjacentMatrice.each_index do |y|
            @adjacentMatrice[y].each_index do |x|
                if x<@adjacentMatrice.length
                    n+=1
                    @array_indice.push(n)
                    @adjacentMatrice[y][x] = {"i"=>n,"o"=>wall}
                end
            end
        end
        @n=0
        while @n<looper
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
            @n+=1
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
            elsif @adjacentMatrice[array_f[i]["y"]+1][array_f[i]["x"]]["o"] == wall and @adjacentMatrice[array_f[i]["y"]+2][array_f[i]["x"]]["o"] == void
                @adjacentMatrice[array_f[i]["y"]+1][array_f[i]["x"]]["o"]= void
            end
        end
    end



    def test(wall,void,num_block)
        random = rand(1)
       for n in 0..@array_fusion.length-1
        if random == 0
            dig_x(@array_fusion, n,wall,void,num_block)
        elsif random == 1
            dig_y(@array_fusion, n,wall,void,num_block)
        end
       end
    end
end