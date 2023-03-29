# TSPSolver.rb
# Traveling salesman problem solver using branch and bound algorithm
require_relative 'AdjacencyGraph.rb'
require_relative 'external/PriorityQueue.rb'

class TSPSolver
    # solve traveling salesman problem with branch and bound algorithm
    def initialize(graph)
        @graph = graph
        @nodes_num = graph.nodes_num
    end

    def solve
        # init
        @queue = PriorityQueue.new()

        # first graph reduction
        r = @graph.reduce
        
        # initialize root node
        root_node_i = -1
        while root_node_i < 0 || root_node_i >= @nodes_num
            print "\nSelect root node (1..#{@nodes_num}): "
            root_node_i = gets.chomp.to_i - 1
        end
        
        root_node = SearchNodeState.new(root_node_i + 1, @graph, [root_node_i + 1], r)
        @queue.push(root_node, root_node.cost)

        while !@queue.empty?
            node = @queue.pop
            
            if node.is_goal
                if (node.path.length == @nodes_num + 1) # check if tsp is complete
                    return node.path, node.cost
                end
            end
            
            generate_child_nodes(node)
        end
        
    end

    def generate_child_nodes(parent)
        # generate child nodes
        for col_i in 0...@graph.nodes_num
            if !parent.graph.is_edge_inf(parent.id - 1, col_i)
                # clone parent graph
                child_graph = parent.graph.clone

                cost_to_child = child_graph.nodes[parent.id-1][col_i]

                # set both parent row and child column to infinity
                # prevent going back to the same node
                child_graph.set_row_inf(parent.id-1)
                child_graph.set_col_inf(col_i)
                child_graph.set_edge_inf(col_i, parent.id-1)

                # reduce child graph
                r = child_graph.reduce

                # create a new node
                new_node = SearchNodeState.new(col_i + 1, child_graph, parent.path + [col_i + 1], parent.cost + r + cost_to_child)
                @queue.push(new_node, new_node.cost)
            end
        end
    end
end

class SearchNodeState
    # search node state
    attr_reader :id, :graph, :path, :cost

    def initialize(id, graph, path, cost)
        @id = id
        @graph = graph
        @path = path
        @cost = cost
    end

    def is_goal
        # check if the current node is goal
        for i in 0...@graph.nodes_num
            for j in 0...@graph.nodes_num
                if @graph.nodes[i][j] != Float::INFINITY
                    return false
                end
            end
        end
        return true
    end
end