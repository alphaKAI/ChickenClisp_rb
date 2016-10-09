require "./Engine"
require "./operator/IOperator"

class StepOperator < Operator
  def call(engine, args)
    ret = nil;

    args.each do |arg| ret = engine.eval(arg) end

    ret
  end
end
