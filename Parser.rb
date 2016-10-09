require "./expression/ImmediateValue"

class Parser
  def self.nextBracket(code)
    i = 0
    leftCount  = 1
    rightCount = 0

    while (leftCount != rightCount)
      if (code[i] == "(")
        leftCount += 1
      end
      if (code[i] == ")")
        rightCount += 1
      end
      i += 1
    end

    return i
  end

  def self.parse(code)
    out = []
    i   = 0

    while (i < code.length)
      ch = code[i]

      if (ch == ' ')
        i += 1
        next
      else
        if (ch == "(")
          j = Parser::nextBracket(code[i+1..-1])

          out << Parser::parse(code[i+1..i + j])

          i += j
        elsif (ch == ")")
          return out
        else
          if (ch =~ /[0-9]/)
            tmp = ""
            j = i

            begin
              tmp += code[j]
              j += 1
            end while ((code[j] != " " && code[j] =~ /[0-9]/) || (code[j] == "." && code[j + 1] != nil && code[j + 1] =~ /[0-9]/))

            if (tmp.include? ".")
              out << tmp.to_f
            else
              out << tmp.to_i
            end

            i = j-1
          elsif (ch == "\"" || ch == "\'")
            if (ch == '\'' && code[i + 1] && code[i + 1] == "(")
              j = Parser.nextBracket(code[i + 2..-1]) + 1

              out << ImmediateValue.new(Parser::parse(code[i+2..j+i]))

              i += j
            else
              tmp = ""
              j = i+1

              while (code[j] != ch && code[j] )
                if (j < code.length)
                  tmp += code[j]
                else
                  raise ("Syntax Error")
                end
                j += 1
              end

              out << tmp
              i = j
            end
          else
            tmp = ""
            j = i

            while (code[j] && code[j] != "\"" && code[j] != "\'" && code[j] != "(" && code[j] != ")" && code[j] != " ") do
              tmp += code[j]
              j += 1
            end

            if tmp == "true"
              out << true
            elsif tmp == "false"
              out << false
            elsif tmp == "null"
              out << "null"
            else
              out << tmp
            end

            i = j
          end
        end
      end

      i += 1
    end

    return out
  end
end

# print ("parsed -> ")
# p (Parser.parse('(foo 12345 "abcdef" (abc hij) \'(1 2 3 4 5 6 789))'))
