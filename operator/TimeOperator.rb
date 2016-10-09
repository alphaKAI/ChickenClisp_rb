require "benchmark"
require "./Engine"
require "./operator/IOperator"

class TimeOperator < Operator
  def call(engine, args)
    result = Benchmark.realtime do
      engine.eval args[0]
    end

    puts "Time: #{result}"

    result
  end
end
