# frozen_string_literal: true

module RubyJS
  module InternalAST
    # Represents the root of a program's AST.
    # @!attribute [r] statements
    #   @return [Array<Node>] A list of statement nodes.
    Program = Data.define(:statements) do
      include Node
    end

    # Represents a statement that consists of a single expression.
    # e.g., `1 + 2` on its own line.
    # @!attribute [r] expression
    #   @return [Node] The expression node.
    ExpressionStatement = Data.define(:expression) do
      include Node
    end

    # Represents a method definition (`def ... end`).
    # @!attribute [r] name
    #   @return [String] The name of the method.
    # @!attribute [r] args
    #   @return [Array] A list of argument identifiers (TODO: formalize).
    # @!attribute [r] body
    #   @return [Array<Node>] A list of statements that form the method's body.
    MethodDefinition = Data.define(:name, :args, :body) do
      include Node
    end
  end
end
