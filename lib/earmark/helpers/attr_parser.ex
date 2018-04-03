defmodule Earmark.Helpers.AttrParser do

  import Earmark.Helpers.StringHelpers, only: [ behead: 2 ]
  import Earmark.Message, only: [add_message: 2]

  alias Earmark.Options

  @typep errorlist :: list(String.t)

  @spec parse_attrs(Options.t, String.t, non_neg_integer) :: {Options.t, map()}
  def parse_attrs(context, attrs, lnb) do
    { attrs, errors } = _parse_attrs(%{}, attrs, [], lnb)
    { add_errors(context, errors, lnb), attrs }
  end

  @spec _parse_attrs( map(), String.t, errorlist, number() ) :: {Options.t, errorlist}
  defp _parse_attrs(dict, attrs, errors, lnb) do
    cond do
      Regex.match?(~r{^\s*$}, attrs) -> {dict, errors}

      match = Regex.run(~r{^\.(\S+)\s*}, attrs) ->
        [ leader, class ] = match
          Map.update(dict, "class", [ class ], &[ class | &1])
          |> _parse_attrs(behead(attrs, leader), errors, lnb)

      match = Regex.run(~r{^\#(\S+)\s*}, attrs) ->
        [ leader, id ] = match
          Map.update(dict, "id", [ id ], &[ id | &1])
          |> _parse_attrs(behead(attrs, leader), errors, lnb)

      # Might we being running into escape issues here too?
      match = Regex.run(~r{^(\S+)=\'([^\']*)'\s*}, attrs) -> #'
      [ leader, name, value ] = match
        Map.update(dict, name, [ value ], &[ value | &1])
        |> _parse_attrs(behead(attrs, leader), errors, lnb)

      # Might we being running into escape issues here too?
      match = Regex.run(~r{^(\S+)=\"([^\"]*)"\s*}, attrs) -> #"
      [ leader, name, value ] = match
        Map.update(dict, name, [ value ], &[ value | &1])
        |> _parse_attrs(behead(attrs, leader), errors, lnb)

      match = Regex.run(~r{^(\S+)=(\S+)\s*}, attrs) ->
        [ leader, name, value ] = match
          Map.update(dict, name, [ value ], &[ value | &1])
          |> _parse_attrs(behead(attrs, leader), errors, lnb)

      match = Regex.run(~r{^(\S+)\s*(.*)}, attrs) ->
        [ _, incorrect, rest  ] = match
        _parse_attrs(dict, rest, [ incorrect | errors ], lnb)

      :otherwise ->
        {dict, [attrs | errors ]}
    end
  end

  @spec add_errors( Options.t, errorlist, non_neg_integer ) :: Options.t
  defp add_errors(context, [], _lnb), do: context
  defp add_errors(context, errors, lnb), do: add_message(context, {:warning, lnb, "Illegal attributes #{inspect errors} ignored in IAL"})

end

# SPDX-License-Identifier: Apache-2.0
