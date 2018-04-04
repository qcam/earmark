defmodule Earmark.Helpers.LeexHelpers do
  @doc """
    Allows to lex an Elixir string with a leex lexer and returns
    the tokens as needed for a yecc parser.
  """
  @spec lex( String.t, Keyword.t(atom) ) :: Keyword.t(list)
  def lex text, with: lexer do
    case text
      |> String.to_charlist()
      |> lexer.string() do
        {:ok, tokens, _} -> tokens
      end
  end

  @spec tokenize( String.t, Keyword.t(atom) ) :: Keyword.t(String.t)
  def tokenize line, with: lexer do
    {:ok, tokens, _} =
    line
    |> to_charlist()
    |> lexer.string()
    elixirize_tokens(tokens,[])
    |> Enum.reverse()
  end

  @spec elixirize_tokens( Keyword.t(list), Keyword.t(String.t) ) :: Keyword.t(String.t)
  defp elixirize_tokens(tokens, rest)
  defp elixirize_tokens([], result), do: result
  defp elixirize_tokens([{token, _, text}|rest], result), do: elixirize_tokens(rest, [{token,to_string(text)}|result])

end

# SPDX-License-Identifier: Apache-2.0
