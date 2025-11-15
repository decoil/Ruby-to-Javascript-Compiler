# frozen_string_literal: true

require_relative 'internal_ast'

module RubyJS
  # The ASTTransformer is an adapter that converts the AST produced by the
  # 'parser' gem into our own internal, well-defined RubyJS::InternalAST format.
  class ASTTransformer < Parser::AST::Processor
    #
    # Expression Handlers
    #

    def on_int(node)
      InternalAST::IntegerLiteral.new(value: node.children.first)
    end

    def on_float(node)
      InternalAST::FloatLiteral.new(value: node.children.first)
    end

    def on_send(node)
      receiver, method_name, *args = node.children

      InternalAST::InfixOperation.new(
        left: process(receiver),
        operator: method_name,
        right: process(args.first)
      )
    end

    #
    # Statement Handlers
    #

    def on_def(node)
      name, args, body = node.children

      processed_body = if body.nil?
                         []
                       elsif body.type == :begin
                         process_all(body.children)
                       else
                         [process(body)]
                       end

      InternalAST::MethodDefinition.new(
        name: name.to_s,
        args: [], # TODO: Process args node
        body: processed_body
      )
    end

    def on_begin(node)
      # 'begin' nodes represent a sequence of expressions.
      # We need to wrap them in ExpressionStatement nodes to be valid in our AST.
      processed_children = process_all(node.children)

      program = InternalAST::Program.new(statements: [])
      processed_children.each do |child|
        program.statements << InternalAST::ExpressionStatement.new(expression: child)
      end
      program
    end
  end
end
