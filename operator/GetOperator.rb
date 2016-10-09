require "./Engine"
require "./operator/IOperator"

class GetOperator < Operator
  def call(engine, args)
    engine.getVariable args[0]
  end
end
