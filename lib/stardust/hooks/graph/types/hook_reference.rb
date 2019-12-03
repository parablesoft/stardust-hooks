Stardust::GraphQL.define_types do

  object :hook_reference do
    description "Hook Reference details"
    field :id, :id, null: false
    field :name, :string, null: false
  end
end
