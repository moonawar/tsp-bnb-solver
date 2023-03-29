# Main.rb
# run the program with "ruby Main.rb"

require_relative 'AdjacencyGraph.rb'
require_relative 'Reader.rb'
require_relative 'TSPSolver.rb'

puts "\n--- Traveling salesman problem solver ---\nby Addin Munawwar @moonawar - Informatics Engineering ITB\n\n"

puts "1. Input graph from file"
puts "2. Input graph from user"

input_type = 0
while input_type < 1 || input_type > 2
    print "\nSelect input type (1 or 2): "
    input_type = gets.chomp.to_i
end

reader = nil
if input_type == 1
    reader = FileReader.new
else
    reader = InputReader.new
end

graph = reader.input_graph

solver = TSPSolver.new(graph)
path, cost = solver.solve

puts "\nTraveling salesman problem is solved with.."
puts "Path: #{path}"
puts "Cost: #{cost}"