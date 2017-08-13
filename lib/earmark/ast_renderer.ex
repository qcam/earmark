defmodule Earmark.AstRenderer do

  use Earmark.Types

  alias Earmark.Block
  alias Earmark.Context
  alias Earmark.Message

  import Earmark.Message, only: [sort_messages: 1]

  @type parsed :: { Block.ts, Context.t }

  @type att_name  :: String.t
  @type att_value :: String.t
  @type att_list  :: list({att_name, att_value})

  @type element :: String.t

  @type content :: list(triples | String.t)

  @type triple  :: { element, att_list, content }
  @type triples :: list(triple)

  @type result :: { triples, messages }
  @type ast    :: { status, triples, messages }

  @empty_ast { [], [] }

  @spec render_ast( parsed ) :: ast
  @doc """
  Renders an AST representing an HTML oriented triple tree.
  TODO: Add doctest examples
  """
  def render_ast({_, %Context{}} = parsed) do
    case _render_ast( parsed, @empty_ast ) do
      { triples, [] }     -> {:ok, Enum.reverse(triples), []}
      { triples, errors } -> {:error, Enum.reverse(triples), errors}
    end
  end

  @spec _render_ast( parsed, result ) :: result
  defp _render_ast({[], _}, result), do: result
  defp _render_ast({[block | rest], context}, result) do
    result1 = _render_block(block)
    _render_ast({rest, context}, add_to_result(result, result1) )
  end

  @spec _render_block( Block.t ) :: result
  defp _render_block(block) 
  defp _render_block(%Block.Para{}=para) do 
    {{"p", [], para.lines}, []}
  end

  defp add_to_result({triples, errors}, {triples1, errors1}) do
    {
      [triples1 | triples],
      Enum.reduce(errors1, errors, &([&1 | &2]))
    }
  end
end
