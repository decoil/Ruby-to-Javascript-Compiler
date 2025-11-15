# frozen_string_literal: true

module RubyJS
  module InternalAST
    # Represents an integer literal, e.g., `123`.
    # @!attribute [r] value
    #   @return [Integer] The integer value.
    IntegerLiteral = Data.define(:value) do
      include Node
    end

    # Represents a float literal, e.g., `3.14`.
    # @!attribute [r] value
    #   @return [Float] The float value.
    FloatLiteral = Data.define(:value) do
      include Node
    end

    # Represents an identifier, e.g., `my_variable`.
    # @!attribute [r] name
    #   @return [String] The name of the identifier.
    Identifier = Data.define(:name) do
      include Node
    end
  end
end
