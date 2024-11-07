defmodule Hourai.Repo.Migrations.CreateUsers do
  use Ecto.Migration
  import Ecto.Changeset

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :priv, :boolean
      add :country, :string, [size: 2, default: "xx"]

      timestamps(type: :utc_datetime)
    end
  end
end
