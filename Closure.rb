class Closure
  def initialize(engine, operator)
    @engine   = engine
    @operator = operator
  end

  def eval(args)
    @operator.call(@engine, args)
  end
end
