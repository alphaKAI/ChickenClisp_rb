require "./Engine"
require "./operator/IOperator"

class CdrOperator < Operator
  def call(engine, args)
    obj = engine.eval args[0]

    if obj.instance_of? Array
      if obj.length == 1
        return [];
      elsif obj.length > 1
        return obj[1..-1]
      else
        raise "pair required, but got ()"
      end
    end
  end
end
