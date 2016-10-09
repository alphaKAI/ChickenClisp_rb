require "./Engine"
require "./operator/IOperator"

class UntilOperator < Operator
  def call(engine, args)
    ret = nil

    while !engine.eval(args[0])
      ret = engine.eval args[1]
    end

    return ret
  end
end
