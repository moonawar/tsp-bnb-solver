# Reader.rb
# read graph from file or user input
require_relative 'AdjacencyGraph.rb'

class InputReader
    def input_graph
        # read input from user and return a graph
        
        # get number of rows and columns
        puts "\n--- Enter the graph data ^-^ ---\n\n"

        print "Number of nodes: "
        nodes_num = gets.chomp.to_i

        # create a graph
        graph = AdjacencyGraph.new(nodes_num)

        # ask for the graph
        puts "\nThe graph is adjacency graph (weighted and directed), so enter the weight of node source (row) to node destination (column)
Enter ~ if there is no edge between two nodes
Seperate column with space, row with new line
Must be a complete graph

Example:
~ 7 16 9
10 ~ 4 14
12 0 ~ 20
3 15 18 ~
"

        puts "\nEnter the graph\n"
        # get the graph
        for i in 0...nodes_num
            input_line = gets.chomp.split(" ")
            for j in 0...nodes_num
                if input_line[j] == "~"
                    graph.set_edge_inf(i, j)
                else
                    graph.add_edge(i, j, input_line[j].to_i)
                end
            end
        end

        return graph
    end
end

class FileReader
    def input_graph
        # read input from file and return a graph
        # get file name
        puts "\nFile is picked from ../test/"
        print "Enter file name ^-^ (e.g. example1.txt): "
        file_name = gets.chomp
        file_path = "../test/" + file_name

        puts "\nReading file..."

        # open file
        file = File.open(file_path, "r")

        # get number of rows and columns
        line = file.readline
        nodes_num = line.split(" ").length

        # create a graph
        graph = AdjacencyGraph.new(nodes_num)

        # read file
        for i in 0...nodes_num
            file_line = line.split(" ")

            for j in 0...nodes_num
                if file_line[j] == "~"
                    graph.set_edge_inf(i, j)
                else
                    graph.add_edge(i, j, file_line[j].to_i)
                end
            end
            line = file.readline if i != nodes_num-1
        end

        puts "Reading file done!\n"

        return graph
    end
end