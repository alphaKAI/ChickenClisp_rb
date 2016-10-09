require "./Engine"
require "./operator/IOperator"

class MulOperator < Operator
  def call(engine, args)
    ret = 1

    args.each do |arg|
      v = engine.eval(arg)
      ret *= v
    end

    return ret;
  end
end
