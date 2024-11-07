defmodule Hourai.Schema.Clans do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clans" do
    field :name, :string
    field :tag, :string
    field :owner, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(achievement, attrs) do
    achievement
    |> cast(attrs, [:id, :name, :tag, :owner])
    |> validate_required([:id, :name, :tag, :owner])
    |> unique_constraint(:name)
  end
end
