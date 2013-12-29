require "huffman"
require "method_profiler"
require 'benchmark'

namespace :benchmark do

  #file_name = "data/miserables.txt"
  #file_name = "data/education.txt" 
  #file_name = "data/ddhc.txt"  
  #file_name = "data/preambule_ddhc.txt" 
  #file_name = "data/ex1.txt" 


  desc "encode_file benchmark"
  task :encode_file do
      

          #benchmark_encode_file("data/ex1.txt") 
        #benchmark_encode_file("data/preambule_ddhc.txt")
        #benchmark_encode_file("data/ddhc.txt")  
        #benchmark_encode_file("data/miserables.txt")
            #benchmark_encode_file("data/education.txt") 
        #benchmark_encode_file("data/125-symbols.txt" )
        #benchmark_encode_file("data/175-symbols.txt" )
        #benchmark_encode_file("data/210-symbols.txt" )
        benchmark_encode_file("data/255-symbols.txt" )

    

  end

######################################################################################
  

  desc "decode_file benchmark"
  task :decode_file do
    puts "Benchmark decode_file"
    profiler = MethodProfiler.observe(Huffman)
    profiler_binary_stream = MethodProfiler.observe(Huffman::BinaryStream)
    #profiler_letter_frequency = MethodProfiler.observe(Huffman::LetterFrequency)
    #profiler_tree = MethodProfiler.observe(Huffman::Tree)
    #profiler_node = MethodProfiler.observe(Huffman::Node)

    Benchmark.bm do |x|
      x.report("decode_file") { Huffman.decode_file(file_name+".huffman-encoded",file_name+".huffman-dictionnary")}
    end
    puts profiler.report.sort_by(:average_time).order(:ascending)
    puts profiler_binary_stream.report.sort_by(:average_time).order(:ascending)
    #puts profiler_letter_frequency.report.sort_by(:total_time).order(:ascending)
    #puts profiler_tree.report.sort_by(:total_time).order(:ascending)
    #puts profiler_node.report.sort_by(:total_time).order(:ascending)

  end

private

  def benchmark_encode_file(file_name)
    puts "Benchmark encode_file #{file_name}"
    puts "Taille : #{File.size(file_name)}"
    puts "Nombre de symboles #{Huffman::LetterFrequency.get_frequencies(File.read(file_name)).count}"

    profiler_huffman = MethodProfiler.observe(Huffman)
    profiler_pq = MethodProfiler.observe(PriorityQueue)
    profiler_letter_frequency = MethodProfiler.observe(Huffman::LetterFrequency)
    profiler_tree = MethodProfiler.observe(Huffman::Tree)
    profiler_node = MethodProfiler.observe(Huffman::Node)
    profiler_binary_stream = MethodProfiler.observe(Huffman::BinaryStream)


    Huffman.encode_file(file_name) 

    
    puts profiler_huffman.report.sort_by(:average_time).order(:ascending)
    puts profiler_pq.report.sort_by(:average_time).order(:ascending)
    puts profiler_letter_frequency.report.sort_by(:average_time).order(:ascending)
    puts profiler_binary_stream.report.sort_by(:average_time).order(:ascending)
    puts profiler_tree.report.sort_by(:average_time).order(:ascending)
    puts profiler_node.report.sort_by(:average_time).order(:ascending)
  end 


end