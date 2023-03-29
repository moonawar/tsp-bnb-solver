# AdjacencyGraph.rb
# Data structure for graph representation using adjacency matrix

class AdjacencyGraph
    attr_reader :nodes_num, :nodes

    def initialize(nodes_num)
        # initialize graph
        @nodes_num = nodes_num
        @nodes = Array.new(nodes_num) { Array.new(nodes_num) }
    end

    def clone
        # clone graph
        clone_graph = AdjacencyGraph.new(@nodes_num)
        for i in 0...@nodes_num
            for j in 0...@nodes_num
                clone_graph.nodes[i][j] = @nodes[i][j]
            end
        end
        return clone_graph
    end

    def add_edge(row, col, weight)
        # set edge weight between two nodes
        @nodes[row][col] = weight
    end

    def set_edge_inf(row, col)
        # set edge weight between two nodes to infinity
        @nodes[row][col] = Float::INFINITY
    end

    def is_edge_inf(row, col)
        # check if edge weight between two nodes is infinity
        return @nodes[row][col] == Float::INFINITY
    end
        
    def reduce
        # reduction cost
        r = 0

        # reduce rows
        for i in 0...@nodes_num
            min = Float::INFINITY
            # find minimum
            for j in 0...@nodes_num
                if @nodes[i][j] < min
                    min = @nodes[i][j]
                end
            end

            if (min == Float::INFINITY)
                next
            end

            r += min
            # reduce
            for j in 0...@nodes_num
                @nodes[i][j] -= min
            end
        end

        # reduce columns
        for i in 0...@nodes_num
            min = Float::INFINITY
            # find minimum
            for j in 0...@nodes_num
                if @nodes[j][i] < min
                    min = @nodes[j][i]
                end
            end

            if (min == Float::INFINITY)
                next
            end

            r += min
            # reduce
            for j in 0...@nodes_num
                @nodes[j][i] -= min
            end
        end

        # return reduction cost
        return r
    end

    def set_row_inf(row)
        # set row to infinity
        for i in 0...@nodes_num
            @nodes[row][i] = Float::INFINITY
        end
    end

    def set_col_inf(col)
        # set column to infinity
        for i in 0...@nodes_num
            @nodes[i][col] = Float::INFINITY
        end
    end

    def print_graph
        for i in 0...@nodes_num
            for j in 0...@nodes_num
                print @nodes[i][j] == Float::INFINITY ? "~ " : @nodes[i][j].to_s + " "
            end
            puts
        end
    end
end