require "./Engine"
require "./operator/IOperator"

class EqualOperator < Operator
  def call(engine, args)
    engine.eval(args[0]) == engine.eval(args[1])
  end
end

class NotEqualOperator < Operator
  def call(engine, args)
    engine.eval(args[0]) != engine.eval(args[1])
  end
end

class LessOperator < Operator
  def call(engine, args)
    engine.eval(args[0]) < engine.eval(args[1])
  end
end

class GreatOperator < Operator
  def call(engine, args)
    engine.eval(args[0]) > engine.eval(args[1])
  end
end

class LEqOperator < Operator
  def call(engine, args)
    engine.eval(args[0]) <= engine.eval(args[1])
  end
end

class GEqOperator < Operator
  def call(engine, args)
    engine.eval(args[0]) >= engine.eval(args[1])
  end
end
