# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @query = Bulletin.order_by_desc.ransack(params[:query])
    @bulletins = @query.result.page(params[:page]).per(5)

    params[:active_link] = 'bulletins'
  end

  def publish
    @bulletin = set_bulletin

    if @bulletin.may_publish?
      @bulletin.publish!

      flash[:primary] = t('aasm.success.publish')
      redirect_to admin_root_path
    else
      flash[:danger] = t('aasm.failure.publish')
      redirect_back(fallback_location: admin_root_path)
    end
  end

  def reject
    @bulletin = set_bulletin

    if @bulletin.may_reject?
      @bulletin.reject!

      flash[:primary] = t('aasm.success.reject')
      redirect_to admin_root_path
    else
      flash[:danger] = t('aasm.failure.reject')
      redirect_back(fallback_location: admin_root_path)
    end
  end

  def archive
    @bulletin = set_bulletin

    if @bulletin.may_archive?
      @bulletin.archive!

      flash[:primary] = t('aasm.success.archive')
      redirect_to admin_root_path
    else
      flash[:danger] = t('aasm.failure.archive')
      redirect_back(fallback_location: admin_root_path)
    end
  end
end
