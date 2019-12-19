Stardust::GraphQL.define_mutation :stardust_hooks_create do

  description "Creates a hook"


  argument :attributes, :hook_create_attributes, required: true

  field :hook, :hook, null: true
  field :error, :string, null: true

  null false


  def resolve(attributes:)
    attrs = attributes.to_h.merge!(events: [])
    hook = Stardust::Hooks::Hook.create(attrs)

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
