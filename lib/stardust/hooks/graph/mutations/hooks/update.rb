Stardust::GraphQL.define_mutation :stardust_hooks_update do

  description "Updates a hook"

  argument :id, 
    :id, 
    required: true,
    loads: Stardust::Hooks::Hook,
    as: :hook

  argument :attributes, :details, required: true

  argument :referenceable_id, 
    :id, 
    required: false

  argument :referenceable_type, 
    :string, 
    required: false

  field :hook, :hook, null: true
  field :error, :string, null: true

  null false


  def resolve(hook:, attributes:, referenceable_id:, referenceable_type:)
    @attributes = attributes
    @referenceable_id = referenceable_id
    @referenceable_type = referenceable_type
    hook.update_attributes(attributes_for_update)

    {
      hook: hook,
      error: nil
    }


  end



  private

  attr_reader :attributes,
    :referenceable_id,
    :referenceable_type

  def attributes_for_update
    output = attributes.to_unsafe_h
    output.merge!(
      {
        referenceable_id: referenceable_id,
        referenceable_type: referenceable_type
      }
    )
    output
  end


  def self.authorized?(_, ctx)
    current_user = ctx[:current_user]
    current_user.present? && permitted_roles.include?(current_user.role)
  end

  def self.permitted_roles
    ["admin"]
  end


end
