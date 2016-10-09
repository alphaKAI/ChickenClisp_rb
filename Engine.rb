require "./operator/IOperator"
require "./expression/CallOperator"
require "./expression/ImmediateValue"
require "./Closure"

require "./operator/AddOperator"
require "./operator/SubOperator"
require "./operator/MulOperator"
require "./operator/DivOperator"
require "./operator/ModOperator"
require "./operator/EqualOperator"
require "./operator/GetOperator"
require "./operator/SetOperator"
require "./operator/StepOperator"
require "./operator/UntilOperator"
require "./operator/IfOperator"
require "./operator/LogicOperator"
require "./operator/PrintOperator"
require  "./operator/DeffunOperator"
require "./operator/WhileOperator"
require "./operator/GetfunOperator"
require "./operator/DynamicOperator"
require "./operator/LambdaOperator"
require "./operator/MapOperator"
require "./operator/SetIdxOperator"
require "./operator/AsIVOperator"
require "./operator/DefvarOperator"
require "./operator/SeqOperator"
require "./operator/FoldOperator"
require "./operator/LengthOperator"
require "./operator/CarOperator"
require "./operator/CdrOperator"
require "./operator/LoadOperator"
require "./operator/CondOperator"
require "./operator/AliasOperator"
require "./operator/TimeOperator"


class Engine
  attr_accessor :variables, :_super

  def initialize
    @variables = {}

    @variables["+"] = AddOperator.new
    @variables["-"] = SubOperator.new
    @variables["*"] = MulOperator.new
    @variables["/"] = DivOperator.new
    @variables["%"] = ModOperator.new
    @variables["="] = EqualOperator.new
    @variables["<"] = LessOperator.new
    @variables[">"] = GreatOperator.new
    @variables["<="]  = LEqOperator.new
    @variables[">="]  = GEqOperator.new
    @variables["set"] = SetOperator.new
    @variables["get"] = GetOperator.new
    @variables["until"] = UntilOperator.new
    @variables["step"]  = StepOperator.new
    @variables["if"] = IfOperator.new
    @variables["!"]  = NotOperator.new
    @variables["&&"] = AndOperator.new
    @variables["||"] = OrOperator.new
    @variables["print"] = PrintOperator.new
    @variables["def"]   = DeffunOperator.new
    @variables["while"] = WhileOperator.new
    @variables["get-fun"] = GetfunOperator.new
    @variables["lambda"]  = LambdaOperator.new
    @variables["map"]     = MapOperator.new
    @variables["set-idx"] = SetIdxOperator.new
    @variables["as-iv"]   = AsIVOperator.new
    @variables["def-var"] = DefvarOperator.new
    @variables["seq"]     = SeqOperator.new
    @variables["fold"]    = FoldOperator.new
    @variables["length"]  = LengthOperator.new
    @variables["car"]     = CarOperator.new
    @variables["cdr"]     = CdrOperator.new
    @variables["load"]    = LoadOperator.new
    @variables["cond"]    = CondOperator.new
    @variables["alias"]   = AliasOperator.new
    @variables["time"]    = TimeOperator.new
  end

  @_super = nil

  def clone
   _newEngine = Engine.new

   _newEngine._super = self

    @variables.each do |key, value|
     _newEngine.variables[key] = value
    end

   _newEngine
  end

  def defineVariable(name, value)
    @variables[name] = value

    value
  end

  def setVariable(name, value)
    engine = self

    while (true) do
      if (engine.variables[name] != nil)
        engine.variables[name] = value

        return value
      elsif (engine._super != nil)
        engine = engine._super
      else
        engine.defineVariable(name, value)
      end
    end
  end

  def getVariable(name)
    engine = self

    while (true)
      if (engine.variables[name] != nil)
        return engine.variables[name]
      elsif (engine._super != nil)
        engine = engine._super
      else
        return nil
      end
    end
  end

  def eval(script)
    ret = self.getExpression(script)

    if (ret.class.superclass == Operator)
      return ret
    end

    ret = ret.eval(self)

    if (ret.class.superclass == Operator)
      return Closure.new(self, ret)
    else
      return ret
    end
  end

  def getExpression(script)
    if (script.instance_of? ImmediateValue)
      return script
    end

    if (script.instance_of? Array)
      if (script[0].instance_of? Array)
        ret = CallOperator.new(@variables[script[0][0]], script[0][1..-1])
        tmp = ret.eval(self)

        if (tmp.instance_of? Closure)
          return ImmediateValue.new(tmp.eval(script[1..-1]))
        elsif (tmp.class.superclass == Operator)
          return ImmediateValue.new(tmp.call(self, script[1..-1]))
        end
      end
      return CallOperator.new(@variables[script[0]], script[1..-1])
    else
      tmp = self.getVariable(script)

      if (tmp != nil)
        if (tmp.class.superclass == Operator)
          return tmp
        else
          return ImmediateValue.new(tmp)
        end
      end

      return ImmediateValue.new(script)
    end
  end
end
