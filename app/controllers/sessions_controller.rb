class SessionsController < Devise::SessionsController

  def create
    super
    flash[:notice] = "Hi, #{current_user.full_name}!"
  end

end
