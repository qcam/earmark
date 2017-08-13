defmodule Test.Ast.EmptyAstTest do
  use ExUnit.Case

  test "empty input" do 
      markdown = ""
      # html = "<ul>\n<li>Foo\n</li>\n</ul>\n<hr class=\"thick\"/>\n<ul>\n<li>Bar\n</li>\n</ul>\n"
      ast = []
      messages = []
      assert Earmark.as_ast(markdown) == {:ok, ast, messages}
  end
  
end
