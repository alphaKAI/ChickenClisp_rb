require "./Engine"
require "./operator/IOperator"

class DefvarOperator < Operator
  def call(engine, args)
    engine.defineVariable(args[0], engine.eval(args[1]))
  end
end
