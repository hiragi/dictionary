#!/usr/local/bin/ruby

require 'rubygems'
require 'mechanize'

agent = Mechanize.new
agent.get("http://dictionary.goo.ne.jp/ej/")

agent.page.form_with(:name => "dict"){|form|
  form.field_with(:name => "MT").value = ARGV[0]
  form.submit
}

word = agent.page.at("dl.allList")

only_word = (word/:dt)
meaning = (word/:dd)

=begin
for i in 0..only_word.length-1
  puts (only_word/:a)[i].inner_html, "\n"
  puts meaning[i].inner_html, "\n\n"
  puts "------------------------------------------------"
end
=end

word = ((only_word/:a)[0].inner_html + "\n\n")
mean = (meaning[0].inner_html + "\n\n")
line = "---------------------------------------------------------------------------------------------------------\n\n"

File.open("/home/hiragi/hiragi/study/dictionary/bin/log.txt", "a"){|f|
  puts word, "\n"
  f.write(word)
  puts mean, "\n"
  f.write(mean)
  f.write(line)
}

