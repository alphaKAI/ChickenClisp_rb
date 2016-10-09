require "./Engine"
require "./operator/IOperator"

class AddOperator < Operator
  def call(engine, args)
    ret = 0

    args.each do |arg|
      v = engine.eval arg
      ret += v
    end

    return ret
  end
end
