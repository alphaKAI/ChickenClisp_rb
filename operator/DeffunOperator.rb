require "./Engine"
require "./operator/IOperator"
require "./operator/DynamicOperator"

class DeffunOperator < Operator
  def call(engine, args)
    funcName = engine.eval args[0]
    funcArgs = args[1]
    funcBody = args[2]

    engine.defineVariable(funcName, DynamicOperator.new(funcArgs, funcBody));
  end
end
