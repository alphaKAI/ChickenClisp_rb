require "./Engine"
require "./operator/IOperator"
require "./expression/ImmediateValue"

class AsIVOperator < Operator
  def call(engine, args)
    ImmediateValue.new engine.eval(args[0])
  end
end
