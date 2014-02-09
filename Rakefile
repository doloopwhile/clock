# -*- coding: utf-8 -*-
require 'rake'
# require 'rake/clean'

task :default => [:serve]

task :generate do
  sh 'python3 generate.py'
end

task :serve => [:generate] do
  cd 'output'
  sh 'python3 -m http.server 8000'
end
