require "./Engine"
require "./operator/IOperator"

class CondOperator < Operator
  def call(engine, args)
    args.each do |state|
      pred = state[0]
      expr = state[1]

      if (engine.eval(pred) || pred == "else")
        return engine.eval expr
      end
    end

    nil
  end
end
