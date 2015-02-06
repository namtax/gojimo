class Qualification
  attr_reader :input

  def self.all
    @all ||= ApiClient
      .new
      .response
      .map(&method(:new))
  end

  def self.find(name)
    all.detect{ |q| q.name == name }
  end

  def initialize(input)
    @input = input
  end

  def id
    input[:id]
  end

  def name
    input[:name]
  end

  def subjects
    input[:subjects].map(&Subject.method(:new))
  end
end
