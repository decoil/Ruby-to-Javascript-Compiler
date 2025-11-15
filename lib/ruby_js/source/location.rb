# frozen_string_literal: true

module RubyJS
  module Source
    # Represents a location in the source code.
    #
    # @!attribute [r] line
    #   @return [Integer] The line number.
    # @!attribute [r] column
    #   @return [Integer] The column number.
    # @!attribute [r] offset
    #   @return [Integer] The byte offset.
    Location = Data.define(:line, :column, :offset)
  end
end
