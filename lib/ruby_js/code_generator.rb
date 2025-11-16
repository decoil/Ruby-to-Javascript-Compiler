# frozen_string_literal: true

require_relative 'ir'

module RubyJS
  # The CodeGenerator is the back-end of our pipeline. It consumes the linear
  # Intermediate Representation (IR) and produces the final, target-specific
  # output string (in this case, JavaScript).
  class CodeGenerator
    # Generates a JavaScript code string from an IR program.
    # This implementation functions as a simple, stack-based virtual machine.
    #
    # @param ir_program [IR::Program] The IR program to generate code from.
    # @return [String] The resulting JavaScript code.
    def generate(ir_program)
      js_code = ""
      stack = []

      ir_program.instructions.each do |instr|
        case instr
        in IR::PushLiteral(value:)
          stack.push(value.inspect) # Use inspect for correct JS string/number formatting
        in IR::Add
          right = stack.pop
          left = stack.pop
          stack.push("(#{left} + #{right})")
        in IR::Subtract
          right = stack.pop
          left = stack.pop
          stack.push("(#{left} - #{right})")
        in IR::Multiply
          right = stack.pop
          left = stack.pop
          stack.push("(#{left} * #{right})")
        in IR::Divide
          right = stack.pop
          left = stack.pop
          stack.push("(#{left} / #{right})")
        end
      end

      # For now, we assume the last expression's result is the program's output.
      js_code = stack.join(";\n")
      js_code
    end
  end
end
