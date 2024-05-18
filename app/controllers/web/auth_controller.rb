# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  skip_before_action :verify_authenticity_token, only: :callback

  def callback
    auth = request.env['omniauth.auth']
    Rails.logger.debug { "auth => #{auth.inspect}" }

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
  end
end
