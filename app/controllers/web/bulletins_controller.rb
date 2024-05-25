# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  def index
    @query = Bulletin.published_bulletins.order_by_desc.ransack(params[:query])

    @bulletins = @query.result.page(params[:page]).per(10)
  end

  def show
    resource_bulletin
  end

  def new
    @bulletin = Bulletin.new
    authorize @bulletin
  end

  def edit
    authorize resource_bulletin
  end

  def create
    @bulletin = Bulletin.new(bulletin_params.merge(user_id: current_user&.id))
    authorize @bulletin

    if @bulletin.save
      flash[:primary] = t('bulletins.create.success')
      redirect_to @bulletin
    else
      redirect_back(fallback_location: new_bulletin_path)
      flash[:danger] = @bulletin.errors.full_messages.to_sentence
    end
  end

  def update
    authorize resource_bulletin

    if resource_bulletin.update(bulletin_params)
      flash[:primary] = t('bulletins.update.success')
      redirect_to profile_path
    else
      flash[:danger] = resource_bulletin.errors.full_messages.to_sentence
      redirect_back(fallback_location: edit_bulletin_path(resource_bulletin))
    end
  end

  def to_moderate
    authorize resource_bulletin

    unless resource_bulletin.may_to_moderate?
      flash[:danger] = t('aasm.failure.to_moderate')
      redirect_back(fallback_location: profile_path)
    end and return

    resource_bulletin.to_moderate!

    if resource_bulletin.save
      flash[:primary] = t('aasm.success.to_moderate')
      redirect_to profile_path
    else
      flash[:danger] = resource_bulletin.errors.full_messages.to_sentence
      redirect_back(fallback_location: profile_path)
    end
  end

  def archive
    authorize resource_bulletin

    unless resource_bulletin.may_archive?
      flash[:danger] = t('aasm.failure.archive')
      redirect_back(fallback_location: profile_path)
    end and return

    resource_bulletin.archive!

    if resource_bulletin.save
      flash[:primary] = t('aasm.success.archive')
      redirect_to profile_path
    else
      flash[:danger] = resource_bulletin.errors.full_messages.to_sentence
      redirect_back(fallback_location: profile_path)
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title,
                                     :description,
                                     :category_id,
                                     :image,
                                     :user_id,
                                     :state)
  end
end
