require "./Engine"
require "./Transpiler"
require "./Interpreter"

if (ARGV.length == 1)
  fpath = ARGV[0];

  if (!File.exists?(fpath))
    puts "No such file - " + fpath
  else
    engine = Engine.new

    engine.eval(Transpiler.transpile(File.read(fpath)))
  end
elsif (ARGV.length == 0)
  itpr = Interpreter.new

  itpr.interpreter
else
  puts "error"
end
