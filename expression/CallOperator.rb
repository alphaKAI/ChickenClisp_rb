class CallOperator
  def initialize(operator, args)
    @operator = operator
    @args     = args
  end

  def eval(engine)
    closure = engine.eval(@operator)

    closure.eval(@args)
  end
end
