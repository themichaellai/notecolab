class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    aces_link_courses_path
  end
end
