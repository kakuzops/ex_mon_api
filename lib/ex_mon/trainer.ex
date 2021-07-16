defmodule ExMon.Trainer do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, Ecto.UUID, autogenerate: true}

  @required [
    :name,
    :password_hash
  ]


  schema "trainers" do
    field :name, :string
    field :password_hash, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required)
    |> validate_required(@required)
  end
end
