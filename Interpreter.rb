require "./Engine"
require "./Transpiler"

class Interpreter
  public
  def initialize
    @engine     = Engine.new()
    @bracketState = 0;
  end

  def checkBracket(code)
    code.each_char do |ch|
      if ch == "("
        @bracketState += 1
      end
      if ch == ")"
        @bracketState -= 1
      end

      if (@bracketState == 0)
        return true
      else
        return false
      end
    end
  end

  def interpreter
    @buf = []

    print "=> "

    loop do
      STDIN.gets.chomp.each_char do |val|
        def e(val)
          if (self.checkBracket(val) && (@buf.length != 0))
            puts (@engine.eval(Transpiler.transpile(@buf.join())));
            @buf = []
          end
        end

        if ('\n' == val || '\r\n' == val)
          e(val)
        else
          @buf << val
          e(val)
        end

      end

      (@bracketState + 1).times do |i|
        print "="
      end

      print "> "
    end
  end
end
