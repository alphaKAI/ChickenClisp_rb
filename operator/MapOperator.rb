require "./Engine"
require "./operator/IOperator"
require "./expression/ImmediateValue"
require "./Closure"

class MapOperator < Operator
  def call(engine, args)
    func   = args[0]
    eargs1 = engine.eval args[1]

    if eargs1.instance_of? Array
      array = eargs1
      ret   = []
      efunc = engine.eval func

      if efunc.instance_of? Closure
        array.each do |elem| ret << efunc.eval([elem]) end
      else
        array.each do |elem| ret << efunc.call(engine, [elem]) end
      end

      ret
    else
      if (!(eargs1.instance_of? ImmediateValue) && !(eargs1.value.instance_of? Array))
        raise "Map requires array and function as a Operator"
      end

      array = eargs1.value
      ret   = []
      efunc = engine.eval func

      if (efunc.instance_of? Closure)
        array.each do |elem| ret << efunc.eval([elem]) end
      else
        array.each do |elem| ret << efunc.call(engine, [elem]) end
      end

      ret
    end
  end
end
