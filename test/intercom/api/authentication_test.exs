defmodule Intercom.API.AuthenticationTest do
  use ExUnit.Case, async: false

  @module Intercom.API.Authentication

  setup do
    access_token = Application.get_env(:intercom, :access_token)

    on_exit(fn ->
      Application.put_env(:intercom, :access_token, access_token)
    end)
  end

  describe "get_access_token/0" do
    test "makes request when access token is valid" do
      Application.put_env(:intercom, :access_token, "abcde")
      assert {:ok, "abcde"} == @module.get_access_token()
    end

    test "returns correct error message when access token isn't set" do
      Application.delete_env(:intercom, :access_token)
      assert {:error, :no_access_token} == @module.get_access_token()
    end

    test "returns correct error message when access token is invalid" do
      Application.put_env(:intercom, :access_token, 12345)
      assert {:error, :invalid_access_token} == @module.get_access_token()
    end
  end
end
