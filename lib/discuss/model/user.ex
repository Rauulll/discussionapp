defmodule Discuss.Model.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:name]}

  schema "users" do
    field :name, :string
    field :token, :string
    field :provider, :string
    field :email, :string

    has_many :topics, Discuss.Model.Topic
    has_many :comments, Discuss.Model.Comments

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :email, :provider, :token])
    |> validate_required([:name, :email, :provider, :token])
  end
end
