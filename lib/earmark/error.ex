defmodule Earmark.Error do

  @moduledoc false

  defexception [:message]

  @typep t :: %__MODULE__{__exception__: true}

  @doc false
  @spec exception( String.t ) :: t
  def exception(msg), do: %__MODULE__{message: msg}

end

# SPDX-License-Identifier: Apache-2.0
