Stardust::GraphQL.define_query :stardust_hook do


  description "Fetchs a single hook"
  type :hook
  null false

  argument :id,
    :id,
    required: true,
    loads: Stardust::Hooks::Hook,
    as: :hook

  def resolve(hook:)
    hook
  end


  private

  def self.authorized?(_, ctx)
    current_user = ctx[:current_user]
    return false unless current_user
    current_user && permitted_roles.include?(current_user.role)
  end

  def self.permitted_roles
    Stardust::Hooks.configuration.manager_roles
  end
end
