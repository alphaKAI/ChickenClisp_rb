require "./Engine"
require "./operator/IOperator"

class PrintOperator < Operator
  def call(engine, args)
    args.each do |arg|
      print engine.eval arg
    end

    puts ""

    0
  end
end
