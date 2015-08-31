require "open-uri"

url = "http://ruby.bastardsbook.com/files/fundamentals/hamlet.txt"
file = "hamlet.txt"

File.open(file, "w") {|thefile| thefile.write(open(url).read)}

File.open(file, "r").readlines.each.with_index do |theline, theindex|
  if theindex%42 == 0
    puts theline
  end
end

trip = false
File.open(file, "r").readlines.each do |theline|
  if theline =~ /^\s\sHam\./
    trip = true
  elsif theline =~ /^\s\s[A-z]{3,4}\./
    trip = false
  end

  if trip
    puts theline
  end  
end

Dir.glob("./testdir/*").sort_by {|thefilename| File.size(thefilename)}.reverse[0..9].each do |thefilename|
  puts "#{thefilename} #{File.size(thefilename)}"
end

thehash = {}
Dir.glob("./testdir/*").each do |thefilename|
  thehash[thefilename.match(/\.[A-z]+$/).to_s.to_sym] ||= {}
  thehash[thefilename.match(/\.[A-z]+$/).to_s.to_sym][:count] ||= 0
  thehash[thefilename.match(/\.[A-z]+$/).to_s.to_sym][:count] +=1

  thehash[thefilename.match(/\.[A-z]+$/).to_s.to_sym][:size] ||= 0
  thehash[thefilename.match(/\.[A-z]+$/).to_s.to_sym][:size] += File.size(thefilename)
end

afile = File.open("filedeets.txt", "w")
afile.write("Filetype\tCount\tSize\n")

thehash.each do |k,v|
  afile.write("#{k}\t#{v[:count]}\t#{v[:size]}\n")
end
afile.close
