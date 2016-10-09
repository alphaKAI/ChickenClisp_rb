require "./Engine"
require "./Transpiler"

engine = Engine.new

engine.eval(
  ["step",
    ["set", "i", 10],
    ["set", "sum", 0],
    ["until", ["=", ["get", "i"], 0], [
      "step",
      ["set", "sum", ["+", ["get", "sum"], ["get", "i"]]],
      ["set", "i", ["+", ["get", "i"], -1]]
    ]],
    ["get", "sum"]
  ]
);

# loop 10 times and square 10
code1 = "
(step
  (def square (x)
    (step
      (set y (* x x))
      (set z (* x x))
      (* y z)))
  (set x 1)
  (while (< x 11)
    (step
      (print x)
      (set x (+ x 1))))
  (print (square 10)))
";

# sum 1 to 10
code2 = "
(step
  (set sum 0)
  (set i 1)
  (while (<= i 10)
    (step
      (set sum (+ sum i))
      (set i (+ i 1))))
  (print sum))
";

code3 = "
(step
  (def fun (x) (* x 40))
  (set f fun)
  (print (f (fun 10))))
";

code4 = "
(step
  (set x (lambda (y) (* y y)))
  (print (x 500))
  (print ((lambda (z) (* z 40)) 10)))
";

code5 = "
(step
  (print '(1 2 3 4 5 6 789))
  (print (map (lambda (x) (* x x )) '(1 2 3 4 5))))
";

code6 = "
(step
  (set arr (set-idx '(1 2 3 4 5) 2 100))
  (print (map (lambda (x) (* x 10)) arr)))
";

code7 = "
(step
  (set x 10)
  (print x))
";

factor = "
(step
  (def factor (x)
    (if (<= x 1)
      1
      (* x (factor (- x 1)))))
  (print (factor 4))
  (print (factor 5)))
"
fib = "
(step
  (def fib (n) (step
    (if (= n 0) 0
      (if (= n 1) 1
        (+ (fib (- n 1)) (fib (- n 2)))))))
  (def i 0)
  (while (< i 10) (step
    (print (fib i))
    (set i (+ i 1)))))
";

fold = "(print (fold + 0 (map (lambda (x) (* x x)) (seq 10))))";

codes = [
  code1,
  code2,
  code3,
  code4,
  code5,
  code6,
  code7,
  factor,
  fib,
  fold
];


idx = 1;

codes.each do |code|
  puts "Sample code #{idx} :"
  puts "CODE----------------------------------------"
  puts code
  puts "OUTPUTS--------------------------------------"

  engine.eval(Transpiler.transpile(code))

  puts "\n";
  idx += 1
end
