# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :resource_bulletin, only: %i[archive edit show to_moderate update]

  def index
    @query = Bulletin.published_bulletins.order_by_desc.ransack(params[:query])

    @bulletins = @query.result.page(params[:page]).per(10)
  end

  def show
    authorize @bulletin
  end

  def new
    @bulletin = Bulletin.new

    authorize @bulletin
  end

  def edit
    authorize @bulletin
  end

  def create
    @bulletin = Bulletin.new(bulletin_params.merge(user_id: current_user&.id))

    authorize @bulletin

    if @bulletin.save
      flash[:primary] = t('bulletins.create.success')
      redirect_to @bulletin
    else
      flash[:danger] = @bulletin.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @bulletin

    if @bulletin.update(bulletin_params)
      flash[:primary] = t('bulletins.update.success')
      redirect_to profile_path
    else
      flash[:danger] = @bulletin.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def to_moderate
    authorize @bulletin

    unless @bulletin.may_to_moderate?
      flash[:danger] = t('aasm.failure.to_moderate')
      redirect_back(fallback_location: profile_path)
    end and return

    @bulletin.to_moderate!

    if @bulletin.save
      flash[:primary] = t('aasm.success.to_moderate')
      redirect_to profile_path
    else
      flash[:danger] = @bulletin.errors.full_messages.to_sentence
      redirect_back(fallback_location: profile_path)
    end
  end

  def archive
    authorize @bulletin

    unless @bulletin.may_archive?
      flash[:danger] = t('aasm.failure.archive')
      redirect_back(fallback_location: profile_path)
    end and return

    @bulletin.archive!

    if @bulletin.save
      flash[:primary] = t('aasm.success.archive')
      redirect_to profile_path
    else
      flash[:danger] = @bulletin.errors.full_messages.to_sentence
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
