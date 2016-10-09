class ImmediateValue
  attr_accessor :value

  public
  def initialize(value)
    @value = value
  end

  def eval(engine)
    @value
  end
end
