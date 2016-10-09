require "./Engine"
require "./Transpiler"
require "./operator/IOperator"

class LoadOperator < Operator
  def call(engine, args)
    loaded = []
    eargs0 = engine.eval args[0]

    if eargs0.instance_of? Array
      args = eargs0
    end

    fpaths = args.map { |arg| engine.eval(arg) + ".ore" }

    fpaths.each do |fpath|
      unless File.exists?(fpath)
        raise "No such file - " + fpath
      else
        engine.eval(Transpiler.transpile File.read(fpath))
        loaded << fpath
      end
    end

    loaded
  end
end
