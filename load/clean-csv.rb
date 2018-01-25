require 'csv'

File.open('csv/check.csv', 'w') {|file| file.truncate(0) }