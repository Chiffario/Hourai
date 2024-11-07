defmodule Hourai.Schema.Achievement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "achievements" do
    field :name, :string
    # TODO: add email validation
    field :file, :string
    field :description, :string
    field :condition, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(achievement, attrs) do
    achievement
    |> cast(attrs, [:id, :name, :file, :description, :condition])
    |> validate_required([:id, :name, :file, :description, :condition])
    |> unique_constraint(:name)
  end
end
