defmodule PgNotifierTest do
  use ExUnit.Case
  doctest PgNotifier

  test "greets the world" do
    assert PgNotifier.hello() == :world
  end
end
