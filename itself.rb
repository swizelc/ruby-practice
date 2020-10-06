
f = File.open(File.basename(__FILE__), "r") do |f|
  puts f.readlines
end
