require "./Engine"
require "./operator/IOperator"

class AliasOperator < Operator
  def call(engine, args)
    _new = args[0];
    base = args[1];

    v = engine.variables[base]

    if v != nil
      engine.variables[_new] = v;
    end

    v
  end
end
