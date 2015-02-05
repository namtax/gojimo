class Subject
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def id
    input[:id]
  end

  def title
    input[:title]
  end

  def link
    input[:link]
  end

  def colour
    input[:colour]
  end
end
