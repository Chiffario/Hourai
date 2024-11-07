defmodule Hourai.Schema.Channel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "channels" do
    field :name, :string
    # TODO: add email validation
    field :description, :string, default: ""
    field :autojoin, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(achievement, attrs) do
    achievement
    |> cast(attrs, [:id, :name, :description, :autojoin])
    |> validate_required([:id, :name, :description, :autojoin])
    |> unique_constraint(:id)
  end
end
