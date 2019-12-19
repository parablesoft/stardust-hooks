Stardust::GraphQL.define_mutation :stardust_hooks_destroy do

  description "Destroys a hook"

  argument :id, :id, 
    required: true,
    loads: Stardust::Hooks::Hook,
    as: :hook


  field :message, :string, null: true
  field :error, :string, null: true

  null false


  def resolve(hook:)
    hook.destroy
    {
      message: "success",
      error: nil
    }


  end



  private

  def self.authorized?(_, ctx)
    current_user = ctx[:current_user]
    current_user.present? && permitted_roles.include?(current_user.role)
  end

  def self.permitted_roles
    Stardust::Hooks.configuration.manager_roles
  end


end
