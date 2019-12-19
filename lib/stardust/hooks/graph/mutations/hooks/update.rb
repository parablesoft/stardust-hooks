Stardust::GraphQL.define_mutation :stardust_hooks_update do

  description "Updates a hook"

  argument :id, 
    :id, 
    required: true,
    loads: Stardust::Hooks::Hook,
    as: :hook

  argument :attributes, :hook_update_attributes, required: true

  field :hook, :hook, null: true
  field :error, :string, null: true

  null false


  def resolve(hook:, attributes:)
    hook.update_attributes(attributes.to_h)

    {
      hook: hook,
      error: nil
    }
  end

  private

  def self.authorized?(_, ctx)
    current_user = ctx[:current_user]
    current_user.present? && permitted_roles.include?(current_user.role)
  end

  def self.permitted_roles
    ["admin"]
  end


end
