# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :authenticate_user!, only: %i[new edit create update to_moderate archive]

  def index
    @query = Bulletin.published.order_by_desc.ransack(params[:query])

    @bulletins = @query.result.page(params[:page]).per(10)
  end

  def show
    @bulletin = set_bulletin

    authorize @bulletin
  end

  def new
    @bulletin = current_user.bulletins.build
  end

  def edit
    @bulletin = set_bulletin

    authorize @bulletin
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      flash[:primary] = t('bulletins.create.success')
      redirect_to @bulletin
    else
      flash[:danger] = @bulletin.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @bulletin = set_bulletin

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
    @bulletin = set_bulletin

    authorize @bulletin

    if @bulletin.may_to_moderate?
      @bulletin.to_moderate!

      flash[:primary] = t('aasm.success.to_moderate')
      redirect_to profile_path
    else
      flash[:danger] = t('aasm.failure.to_moderate')
      redirect_back(fallback_location: profile_path)
    end
  end

  def archive
    @bulletin = set_bulletin

    authorize @bulletin

    if @bulletin.may_archive?
      @bulletin.archive!

      flash[:primary] = t('aasm.success.archive')
      redirect_to profile_path
    else
      flash[:danger] = t('aasm.failure.archive')
      redirect_back(fallback_location: profile_path)
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
