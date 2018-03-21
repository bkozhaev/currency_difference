class Currency
  attr_reader :name, :value

  def self.from_node(node)
    name = node.elements['Name'].text
    value = node.elements['Value'].text

    new(name, value)
  end

  def initialize(name, value)
    @name = name
    @value = value
  end

  def to_s
    "#{name}: #{value} руб."
  end
end