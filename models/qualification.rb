class Qualification
  attr_reader :input

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
