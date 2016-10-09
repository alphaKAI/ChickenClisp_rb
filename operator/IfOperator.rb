require "./Engine"
require "./operator/IOperator"

class IfOperator < Operator
  def call(engine, args)
    engine.eval args[engine.eval args[0] ? 1 : 2]
  end
end
