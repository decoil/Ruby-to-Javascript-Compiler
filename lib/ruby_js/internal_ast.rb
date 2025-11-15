# frozen_string_literal: true

module RubyJS
  # The InternalAST module provides the hierarchical, object-oriented representation of the
  # source code. The Parser produces this tree, and the Compiler consumes it.
  module InternalAST
    # A marker module for all AST node classes.
    module Node; end
  end
end

require_relative 'internal_ast/literal_nodes'
require_relative 'internal_ast/expression_nodes'
require_relative 'internal_ast/statement_nodes'
