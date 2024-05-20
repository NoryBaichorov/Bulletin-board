# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    auth = request.env['omniauth.auth']

    user = User.find_or_initialize_by(email: auth.dig(:info, :email))
    user.name = auth.dig(:info, :name)

    if user.save
      sign_in(user)
      flash[:primary] = t('success_login')
    else
      flash[:danger] = user.errors.full_messages.join.to_sentence
    end

    redirect_to root_path
  end

  def logout
    sign_out
    redirect_to root_path
    flash[:primary] = t('success_logout')
  end
end
