#!/usr/bin/env rake
# encoding: utf-8
require 'rubygems'
require 'rake'
require 'rdoc/task'

require 'bundler'
require "bundler/gem_tasks"

require 'rspec'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

desc 'Test the awesome grid plugin.'
RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
end

