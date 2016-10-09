require "./Engine"
require "./operator/IOperator"

class WhileOperator < Operator
  def call(engine, args)
    ret = nil

    while engine.eval(args[0])
      ret = engine.eval args[1]
    end

    ret
  end
end
