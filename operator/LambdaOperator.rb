require "./Engine"
require "./operator/IOperator"
require "./operator/DynamicOperator"

class LambdaOperator < Operator
  def call(engine, args)
    funcArgs = args[0]
    funcBody = args[1]

    DynamicOperator.new(funcArgs, funcBody)
  end
end
