require "./Engine"
require "./operator/IOperator"

class ModOperator < Operator
  def call(engine, args)
    ret = engine.eval args[0]

    args[1..-1].each do |arg|
      v = engine.eval arg
      ret %= v
    end

    ret
  end
end
