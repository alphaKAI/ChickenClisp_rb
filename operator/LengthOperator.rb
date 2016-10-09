require "./Engine"
require "./operator/IOperator"

class LengthOperator < Operator
  def call(engine, args)
    obj = engine.eval args[0]

    if obj.instance_of? Array
      return obj.length
    else
      raise "Given object is not an Array or List"
    end
  end
end
