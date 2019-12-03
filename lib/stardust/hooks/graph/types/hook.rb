Stardust::GraphQL.define_types do

  object :hook do
    description "Hook details"
    field :id, :id, null: false
    field :name, :string, null: false
    field :referenceable, :hook_reference, null: true
    field :configuration, :string, null: true
    field :events, [:string], null: true
  end
end
