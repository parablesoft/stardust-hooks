Stardust::GraphQL.define_query :stardust_hooks do


  description "Fetches all the hooks in the system"
  type [:hook]
  null false


  def resolve()
    Stardust::Hooks::Hook.all
  end


  private
  def self.authorized?(_, ctx)
    current_user = ctx[:current_user]
    return false unless current_user
    current_user && permitted_roles.include?(current_user.role)
  end

  def self.permitted_roles
    ["admin"].freeze
  end

end
