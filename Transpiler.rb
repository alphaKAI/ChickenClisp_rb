require "./Parser"

class Transpiler
  def self.transpile(code)
    return Parser.parse(code.gsub(/;.*$/, "").gsub(/\n/, ""))[0];
  end
end

#p Transpiler.transpile("(def foo (x) (* x x))")
