require "./Engine"
require "./operator/IOperator"

class NotOperator < Operator
  def call(engine, args)
    !engine.eval(args[0])
  end
end

class AndOperator < Operator
  def call(engine, args)
    engine.eval(args[0]) && engine.eval(args[1])
  end
end

class OrOperator < Operator
  def call(engine, args)
    engine.eval(args[0]) || engine.eval(args[1])
  end
end
