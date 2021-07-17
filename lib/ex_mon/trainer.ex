defmodule ExMon.Trainer do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, Ecto.UUID, autogenerate: true}

  @required [
    :name,
    :password
  ]


  schema "trainers" do
    field :name, :string
    field :password_hash
    field :password, :string, virtual: true

    timestamps()
  end



  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_length(:password, min: 6)
    |> put_pass_hash()
  end

   def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
