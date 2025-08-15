defmodule StopsApiTest do
  use ExUnit.Case
  doctest StopsApi

  test "greets the world" do
    assert StopsApi.hello() == :world
  end
end
