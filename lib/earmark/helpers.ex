defmodule Earmark.Helpers do

  @doc """
  Expand tabs to multiples of 4 columns
  """
  @spec expand_tabs( String.t ) :: String.t
  def expand_tabs(line) do
    Regex.replace(~r{(.*?)\t}, line, &expander/2)
  end

  @spec expander( any, String.t ) :: String.t
  defp expander(_, leader) do
    extra = 4 - rem(String.length(leader), 4)
    leader <> pad(extra)
  end

  @doc """
  Remove newlines at end of line
  """
  @spec remove_line_ending( String.t ) :: String.t
  def remove_line_ending(line) do
    line |> String.trim_trailing("\n") |> String.trim_trailing("\r")
  end

  @spec pad( pos_integer ) :: String.t
  defp pad(1), do: " "
  defp pad(2), do: "  "
  defp pad(3), do: "   "
  defp pad(4), do: "    "

  @doc """
  `Regex.replace` with the arguments in the correct order
  """

  @spec replace( String.t, Regex.t, String.t, Keyword.t ) :: String.t
  def replace(text, regex, replacement, options \\ []) do
    Regex.replace(regex, text, replacement, options)
  end

  @doc """
  Encode URIs to be included in the `<a>` elements.

  Percent-escapes a URI, and after that escapes any
  `&`, `<`, `>`, `"`, `'`.
  """
  @spec encode( String.t ) :: String.t
  def encode(html) do
    URI.encode(html) |> escape(true)
  end

  @doc """
  Replace <, >, and quotes with the corresponding entities. If
  `encode` is true, convert ampersands, too, otherwise only
   convert non-entity ampersands.
  """

  @spec escape( String.t, boolean ) :: String.t
  def escape(html, encode \\ false)

  def escape(html, false), do: _escape(Regex.replace(~r{&(?!#?\w+;)}, html, "&amp;"))
  def escape(html, _), do: _escape(String.replace(html, "&", "&amp;"))

  defp _escape(html) do
    html
    |> String.replace("<",  "&lt;")
    |> String.replace(">",  "&gt;")
    |> String.replace("\"", "&quot;")
    |> String.replace("'",  "&#39;")
  end


end

# SPDX-License-Identifier: Apache-2.0
