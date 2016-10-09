require "./Engine"
require "./operator/IOperator"

class SetOperator < Operator
  def call(engine, args)
    engine.setVariable(args[0], engine.eval(args[1]));
  end
end
