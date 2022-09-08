require 'csv'
require "benchmark"

puts Benchmark.measure {
  data = CSV.open('003_10mb.csv')
  output = data.readlines.map do |line|
    line.map do |col|
      col.downcase.gsub(/\b('?[a-z])/) { $1.capitalize }
    end
  end

  File.open('003_10mb_output.csv', 'w+') do |file|
    file.write output.join('\n')
  end
}

