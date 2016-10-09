require "./Engine"
require "./operator/IOperator"

class DynamicOperator < Operator
  def initialize(funcArgs, funcBody)
    @funcArgs = funcArgs
    @funcBody = funcBody
  end

  def call(engine, args)
    i = 0
    _engine = engine.clone

    @funcArgs.each do |arg|
      _engine.defineVariable(arg, engine.eval(args[i]))
      i += 1
    end

    _engine.eval @funcBody
  end
end
