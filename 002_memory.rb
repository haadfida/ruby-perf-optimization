#!/usr/bin/ruby

require 'benchmark'
require 'csv'
require 'pry'

num_rows = 100_000
num_cols = 10

data = Array.new(num_rows) do
  Array.new(num_cols) { 'x' * 1000 }
end

mem_before = "%d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)
data_to_insert = nil
time = Benchmark.realtime do
  CSV.open('003_10mb.csv', 'w') do |csv|
    num_rows.times do |i|
      num_cols.times do |j|
        data_to_insert = data[i][j]
        data_to_insert << ',' unless j == num_cols - 1
        csv << [data_to_insert]
      end
      
      data_to_insert << "\n" unless i == num_rows - 1
      csv << [data_to_insert]

    end
  end
end

mem_after = "%d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)

puts "Time: #{time}"
puts "MEM: #{mem_before} -> #{mem_after}"

