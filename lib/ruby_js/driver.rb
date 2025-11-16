# frozen_string_literal: true

require_relative 'ast_transformer'
require_relative 'compiler'
require_relative 'code_generator'

module RubyJS
  # The Driver encapsulates the entire compilation pipeline, providing a single
  # entry point to compile Ruby source code into JavaScript.
  class Driver
    def self.compile(source)
      # 1. Parsing (External AST)
      buffer = Parser::Source::Buffer.new('(string)')
      buffer.source = source
      parser = Parser::CurrentRuby.new
      external_ast = parser.parse(buffer)

      # 2. Transformation (Adapter)
      transformer = ASTTransformer.new
      internal_ast = transformer.process(external_ast)

      # 3. Compilation (IR Generation)
      compiler = Compiler.new
      ir_program = compiler.compile(internal_ast)

      # 4. Code Generation (JavaScript Output)
      generator = CodeGenerator.new
      generator.generate(ir_program)
    end
  end
end
