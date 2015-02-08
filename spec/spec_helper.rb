$:.unshift(File.expand_path('../lib', '__FILE__'))
$:.unshift(File.expand_path('../models', '__FILE__'))

require './app.rb'
require 'api_client'
require 'qualification'
require 'subject'
require 'data_store'
require 'capybara/rspec'
require 'pry'

module FixAll
  def all(expected)
    RSpec::Matchers::BuiltIn::All.new(expected)
  end
end

RSpec.configure do |c|
  c.include Capybara::DSL
  c.include FixAll
  c.before(:each) do
    FileUtils.rm_f(File.expand_path('data/response.json'))
  end
end

Capybara.app = Gojimo
