# -*- coding: utf-8 -*-
require 'rubygems'
require 'action_mailer'

File.open("/home/hiragi/hiragi/study/dictionary/bin/log.txt", "r").read.split("---------------------------------------------------------------------------------------------------------").each do |aaa|
  array << aaa
end

puts array[0]
