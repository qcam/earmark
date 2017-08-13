defmodule Acceptance.ParagraphsTest do
  use ExUnit.Case

  describe "Paragraphs" do
    test "simple line" do
      markdown = "line1"
      # html = "<p>line1</p>\n"
      ast = [{"p", [], ["line1"]}]
      messages = []

      assert Earmark.as_ast(markdown) == {:ok, ast, messages}
    end

    test "a para" do
      markdown = "aaa\n\nbbb\n"
      # html     = "<p>aaa</p>\n<p>bbb</p>\n"
      ast = [{"p", [], ["aaa"]}, {"p", [], ["bbb"]}]
      messages = []

      assert Earmark.as_ast(markdown) == {:ok, ast, messages}
    end

    test "and another one" do
      markdown = "aaa\n\n\nbbb\n"
      # html     = "<p>aaa</p>\n<p>bbb</p>\n"
      ast = [{"p", [], ["aaa"]}, {"p", [], ["bbb"]}]
      messages = []

      assert Earmark.as_ast(markdown) == {:ok, ast, messages}
    end

  end
end
