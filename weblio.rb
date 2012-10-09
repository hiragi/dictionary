#-*- coding: utf-8 -*-
require 'rubygems'
require 'hpricot'
require 'open-uri'

class WeblioSearch

	attr_reader :word, :url, :result

	def initialize(word)
		@word = word
		@url = "http://ejje.weblio.jp/content/" + word
	end

	def search
		html = Hpricot(open(@url))

		# 検索結果によってタグが違う
		tags = [(html/'p.lvlB'), (html/'div.level0'), (html/"div.Jstkg"), (html/"div.Stwdj"), (html/"div.nwnejS"), (html/"div.Crlcj"), (html/"p.wehgjT"), (html/"div.Wejty"), (html/"div.wejhsLvl0")]
		if not tags[0].empty?
			# タグがp.class="lvlB"のとき
			mean_tag = tags[0]
		elsif !tags[1].empty?
			# タグがdiv.level0のとき
			mean_tag = tags[1]
		elsif !tags[2].empty?
			# タグがdiv.Jstkgのとき
			mean_tag = tags[2]
		elsif !tags[3].empty?
			mean_tag = tags[3]
		elsif !tags[4].empty?
			mean_tag = tags[4]
		elsif !tags[5].empty?
			mean_tag = tags[5]
    elsif !tags[6].empty?
			mean_tag = tags[6]
		elsif !tags[7].empty?
			mean_tag = tags[7]
		elsif !tags[8].empty?
			mean_tag = tags[8]
		else
			$stderr.puts("No Word")
		end
		@result = mean_tag.inner_html.gsub(".", "\n\n").gsub(/<("[^"]*"|'[^']*'|[^'">])*>/, "")
	end

	def writefile(word)
		line = "\n---------------------------------------------------------------------------------------------------------\n\n"
		open("/home/hiragi/hiragi/study/dictionary/bin/log.txt", "a"){|f|
			f.write(word+"\n\n")
			f.write(@result)
			f.write(line)
		}
	end

end

read_expr = proc { print "word? > " ; gets }
while expr = read_expr.call do
  system("clear")
	weblio = WeblioSearch.new(expr.gsub(" ", "+"))
	begin
		puts weblio.search
	rescue
		next
	end
	weblio.writefile(expr)

end
