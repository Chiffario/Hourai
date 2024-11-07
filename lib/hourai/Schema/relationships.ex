defmodule Hourai.Schema.Relationship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "relationships" do
    belongs_to :user_lhs, Hourai.Schema.User
    belongs_to :user_rhs, Hourai.Schema.User
    field :relationship_type, Ecto.Enum, values: [:friend, :blocked, :mutual]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(achievement, attrs) do
    achievement
    |> cast(attrs, [:user_lhs, :user_rhs, :relationship_type])
    |> validate_required([:user_lhs, :user_rhs, :relationship_type])
  end
end
