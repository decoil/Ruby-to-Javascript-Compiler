# frozen_string_literal: true

require_relative 'internal_ast'
require_relative 'ir'

module RubyJS
  # The Compiler is the middle-end of our pipeline. It performs the crucial
  # transformation from the hierarchical Abstract Syntax Tree (AST) into a
  # linear, instruction-based Intermediate Representation (IR).
  class Compiler
    def initialize
      @instructions = []
    end

    # Compiles an AST node into a sequence of IR instructions.
    #
    # @param node [InternalAST::Node, Array<InternalAST::Node>] The root of the AST to compile.
    # @return [IR::Program] The resulting IR program.
    def compile(node)
      visit(node)
      IR::Program.new(instructions: @instructions)
    end

    private

    # Traverses the AST using the Visitor pattern, emitting IR instructions.
    # This is the core of the semantic analysis and IR generation phase.
    #
    # @param node [InternalAST::Node, Array<InternalAST::Node>] The current AST node to visit.
    def visit(node)
      if node.is_a?(Array)
        return node.each { |n| visit(n) }
      end

      case node
      in InternalAST::Program(statements:)
        statements.each { |stmt| visit(stmt) }
      in InternalAST::ExpressionStatement(expression:)
        visit(expression)
      in InternalAST::InfixOperation(left:, operator:, right:)
        visit(left)
        visit(right)
        case operator
        when :+ then emit(IR::Add.new)
        when :- then emit(IR::Subtract.new)
        when :* then emit(IR::Multiply.new)
        when :/ then emit(IR::Divide.new)
        end
      in InternalAST::IntegerLiteral(value:)
        emit(IR::PushLiteral.new(value: value))
      in InternalAST::FloatLiteral(value:)
        emit(IR::PushLiteral.new(value: value))
      in InternalAST::MethodDefinition(name:, args:, body:)
        # For now, just compile the body.
        body.each { |stmt| visit(stmt) }
      end
    end

    # Appends a new instruction to the program's instruction sequence.
    #
    # @param instruction [IR::Instruction] The instruction to emit.
    def emit(instruction)
      @instructions << instruction
    end
  end
end
