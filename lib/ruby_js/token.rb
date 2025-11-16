# frozen_string_literal: true

module RubyJS
  # Represents a token in the source code.
  #
  # @!attribute [r] type
  #   @return [Symbol] The type of the token.
  # @!attribute [r] value
  #   @return [String] The literal value of the token.
  # @!attribute [r] location
  #   @return [Source::Location] The location of the token in the source code.
  Token = Data.define(:type, :value, :location)
end
