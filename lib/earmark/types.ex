defmodule Earmark.Types do

  defmacro __using__(_options \\ []) do
    quote do
      @type token  :: {atom, String.t}
      @type tokens :: list(token)
      @type numbered_line :: %{required(:line) => String.t, required(:lnb) => number, optional(:inside_code) => String.t}
      @type message_type :: :warning | :error
      @type message :: {message_type, number, String.t}
      @type maybe(t) :: t | nil
      @type inline_code_continuation :: {maybe(String.t), number}

      @type triplet(t) :: {t, t, t}
    end
  end

end

# SPDX-License-Identifier: Apache-2.0
