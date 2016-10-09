require "./Engine"
require "./operator/IOperator"

class GetfunOperator < Operator
  def call(engine, args)
    engine.variables[engine.eval(args[0])]
  end
end
