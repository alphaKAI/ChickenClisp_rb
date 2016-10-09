require "./Engine"
require "./operator/IOperator"

class SeqOperator < Operator
  def call(engine, args)
    n   = args[0]
    arr = Array.new n

    n.times do |i| arr[i] = i end

    arr
  end
end
