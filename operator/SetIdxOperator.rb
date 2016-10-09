require "./Engine"
require "./operator/IOperator"
require "./expression/ImmediateValue"

class SetIdxOperator < Operator
  def call(engine, args)
    if (!(args[0].instance_of? ImmediateValue) && !(args[0].value.instance_of? Array))
      raise "set-idx requires array"
    end

    arr   = args[0].value
    idx   = args[1]
    value = args[2]

    if (0 < idx && idx < arr.length)
      arr[idx] = value

      return ImmediateValue.new arr
    else
      raise "Invalid"
    end
  end
end
