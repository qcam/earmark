defmodule Earmark.Helpers.YeccHelpers do

  import Earmark.Helpers.LeexHelpers, only: [lex: 2]

  @spec parse!( String.t, Keyword.t(atom) ) :: tuple
  def parse!( text, lexer: lexer, parser: parser ) do
    case parse(text, lexer: lexer, parser: parser) do
        {:ok, ast}  ->  ast
        {:error, _} -> nil
    end
  end

  @spec parse(  String.t, Keyword.t(atom) ) :: {:ok, tuple} | {:error, any}
  def parse( text, lexer: lexer, parser: parser ) do
    with tokens <- lex(text, with: lexer) do
      parser.parse(tokens)
    end
  end
end

# SPDX-License-Identifier: Apache-2.0
