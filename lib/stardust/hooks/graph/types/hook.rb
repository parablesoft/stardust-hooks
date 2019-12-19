Stardust::GraphQL.define_types do

  object :hook do
    description "Hook details"
    field :id, :id, null: false
    field :name, :string, null: false
    field :referenceable, :hook_reference, null: true
    field :configuration, :string, null: true
    field :events, [:string], null: true
  end

  input_object :hook_create_attributes do
    argument :name, :string, required: true
  end

  input_object :hook_update_attributes do
    argument :name, :string, required: true
    argument :configuration, :string, required: false
    argument :events, [:string], required: false
    argument :referenceable_id, :id, required: false
    argument :referenceable_type, :string, required: false
  end
end
