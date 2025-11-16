# frozen_string_literal: true

# This file is the main entry point for the RubyJS library.
# It requires all the necessary components of the compiler pipeline.

# Require third-party dependencies first to avoid namespace collisions.
require 'parser/current'
require 'parser/ast/processor'

require_relative "ruby_js/error"
require_relative "ruby_js/internal_ast"
require_relative "ruby_js/ir"
require_relative "ruby_js/ast_transformer"
require_relative "ruby_js/compiler"
require_relative "ruby_js/code_generator"
require_relative "ruby_js/driver"
