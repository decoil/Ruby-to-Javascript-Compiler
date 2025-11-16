# frozen_string_literal: true

module RubyJS
  module InternalAST
    # Represents an infix operation, e.g., `left + right`.
    # @!attribute [r] left
    #   @return [Node] The left-hand side of the operation.
    # @!attribute [r] operator
    #   @return [Symbol] The name of the operator method (e.g., `:+`).
    # @!attribute [r] right
    #   @return [Node] The right-hand side of the operation.
    InfixOperation = Data.define(:left, :operator, :right) do
      include Node
    end
  end
end
