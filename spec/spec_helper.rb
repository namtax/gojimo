require './app.rb'
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
    Configuration.instance_eval do
      def dir_name
        'tmp'
      end
    end
    Dir['tmp/*'].each { |f| FileUtils.rm_f(f) }
  end
end

Capybara.app = Gojimo
