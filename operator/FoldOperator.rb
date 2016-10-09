require "./Engine"
require "./operator/IOperator"
require "./expression/ImmediateValue"
require "./Closure"

class FoldOperator < Operator
  def call(engine, args)
    func  = args[0]
    tmp   = args[1]
    eargs = engine.eval args[2]

    if eargs.instance_of? Array
      array = eargs
      efunc = engine.eval func

      if efunc.instance_of? Closure
        array.each do |elem|
          tmp = efunc.eval [tmp, elem]
        end
      elsif efunc.class.superclass == Operator
        array.each do |elem|
          tmp = efunc.call(engine, [tmp, elem])
        end
      end

      return tmp
    else
      if (!(eargs.instance_of? ImmediateValue) && !(eargs.value.instance_of? Array))
        raise "Map requires array and function as a Operator"
      end

      array = eargs.value
      efunc = engine.eval func

      if efunc.instance_of? Closure
        array.each do |elem|
          tmp = efunc.eval [tmp, elem]
        end
      else
        array.each do |elem|
          tmp = efunc.call(engine, [tmp, elem])
        end
      end

      return tmp
    end
  end
end
