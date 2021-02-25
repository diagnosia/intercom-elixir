defmodule Intercom.Contacts do
  @moduledoc """
  Provides functionality for managing contacts.

  See https://developers.intercom.com/intercom-api-reference/reference#contacts-model
  """

  @doc """
  Retrieves one contact identified by the intercom id.

  Arguments:
  - `contact_id`: The id generated by intercom for the contact.

  Returns `{:ok, data, metadata}` or `{:error, error_code, metadata}`.
  """
  @spec get(String.t()) :: Intercom.API.response()
  def get(contact_id) do
    Intercom.API.call_endpoint(:get, "contacts/#{contact_id}")
  end

  @doc """
  Retrieves a list of contacts with `field` equal to `value`.

  Arguments:
  - `field`: The intercom field, see https://developers.intercom.com/intercom-api-reference/reference#search-for-contacts.
  - `value`: The value the intercom field must have to match.

  Returns `{:ok, data, metadata}` or `{:error, error_code, metadata}`.
  """
  @spec find_equal(String.t(), String.t()) :: Intercom.API.response()
  def find_equal(field, value) do
    Intercom.API.call_endpoint(:post, "contacts/search", %{
      query: %{field: field, operator: "=", value: value}
    })
  end

  @doc """
  Create a new contact.

  Arguments:
  - `params`: A map containing the fields of the user to be created. See https://developers.intercom.com/intercom-api-reference/reference#create-contact for parameters accepted by the intercom API.

  Returns `{:ok, data, metadata}` or `{:error, error_code, metadata}`.
  """
  @spec create(map()) :: Intercom.API.response()
  def create(params) do
    Intercom.API.call_endpoint(:post, "contacts", params)
  end

  @doc """
  Updates one contact identified by the intercom id.

  Arguments:
  - `contact_id`: The id generated by intercom for the contact.
  - `params`: A map containing the fields to update. See https://developers.intercom.com/intercom-api-reference/reference#update-contact for parameters accepted by the intercom API.

  Returns `{:ok, data, metadata}` or `{:error, error_code, metadata}`.
  """
  @spec update(String.t(), map()) :: Intercom.API.response()
  def update(contact_id, params) do
    Intercom.API.call_endpoint(:put, "contacts/#{contact_id}", params)
  end

  @doc """
  Archive one contact identified by the intercom id.

  Arguments:
  - `contact_id`: The id generated by intercom for the contact.

  Returns `{:ok, data, metadata}` or `{:error, error_code, metadata}`.
  """
  @spec archive(String.t()) :: Intercom.API.response()
  def archive(contact_id) do
    Intercom.API.call_endpoint(:post, "contacts/#{contact_id}/archive", nil)
  end

  @doc """
  Adds a specific tag to a specific contact.

  Arguments:
  - `contact_id`: The id generated by intercom for the contact.
  - `tag_id`: The id generated by intercom for the tag.

  Returns `{:ok, data, metadata}` or `{:error, error_code, metadata}`.
  """
  @spec add_tag(String.t(), String.t()) :: Intercom.API.response()
  def add_tag(contact_id, tag_id) do
    Intercom.API.call_endpoint(:post, "contacts/#{contact_id}/tags", %{
      id: tag_id
    })
  end
end
