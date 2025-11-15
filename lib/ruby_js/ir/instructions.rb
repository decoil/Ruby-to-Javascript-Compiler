# frozen_string_literal: true

module RubyJS
  # The IR module provides a formal, linear Intermediate Representation
  # that decouples the AST from the final code generation.
  module IR
    # A container for a sequence of IR instructions, representing a complete program or block.
    # @!attribute [r] instructions
    #   @return [Array<Instruction>] The list of instructions.
    Program = Data.define(:instructions)

    # A marker module for all IR instruction classes.
    module Instruction; end

    # An instruction to push a literal value (e.g., an integer, float) onto the
    # virtual machine's stack.
    # @!attribute [r] value
    #   @return [Integer, Float, String] The literal value to push.
    PushLiteral = Data.define(:value) do
      include Instruction
    end

    # An instruction to pop two values from the stack, add them, and push the result.
    Add = Data.define do
      include Instruction
    end

    # An instruction to pop two values from the stack, subtract the top from the second,
    # and push the result.
    Subtract = Data.define do
      include Instruction
    end

    # An instruction to pop two values from the stack, multiply them, and push the result.
    Multiply = Data.define do
      include Instruction
    end

    # An instruction to pop two values from the stack, divide the second by the top,
    # and push the result.
    Divide = Data.define do
      include Instruction
    end
  end
end
