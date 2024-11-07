defmodule Hourai.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    # TODO: add email validation
    field :email, :string
    # field :priv, :boolean
    field :country, :string, default: "??"
    field :clan_id, :integer, default: 0
    field :main_ruleset, :integer, default: 0

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:id, :name, :email])
    |> validate_required([:id, :name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:name)
  end
end
