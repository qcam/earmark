defmodule Earmark.Types do

  defmacro __using__(_options \\ []) do
    quote do
      #
      # General Types
      # -------------
      @type maybe(t) :: t | nil

      @type bin_fn_t(t, u) :: (t -> u)
      @type map_fn_t(t, u) :: ((list(t), bin_fn_t(t, u)) -> list(u))

      @type pair(t)    :: {t, t}
      @type triplet(t) :: {t, t, t}

      #
      # Specific Types
      # --------------
      @type token  :: {atom, String.t}
      @type tokens :: list(token)

      @type numbered_line :: %{required(:line) => String.t, required(:lnb) => number, optional(:inside_code) => String.t}
      @type numbered_line_tuple  :: {String.t, non_neg_integer()}
      @type numbered_line_tuples :: list(numbered_line_tuple)

      @type message_type :: :warning | :error
      @type message :: {message_type, number, String.t}

      @type inline_code_continuation :: {maybe(String.t), number}

    end
  end

end

# SPDX-License-Identifier: Apache-2.0
