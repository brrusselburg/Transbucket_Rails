class PinPresenter
  attr_accessor :query, :page, :filter, :pins
  attr_accessor :user, :procedures, :surgeons, :general

  def initialize(opts = {})
    @page = opts.delete(:page)
    @query = opts.delete(:query)
    @user = opts.delete(:user)
    @current_user = opts.delete(:current_user)
    @filter = opts

    @pins = if @query.present?
              # FIXME: with all includes get some unused eager, without get N+1
              Pin.search(@query, page: @page, per_page: 20, sql: { include: [:user, :pin_images, :procedure, :surgeon] })
            elsif @user.present?
              Pin.includes(:user, :pin_images, :procedure, :surgeon).by_user(@user).paginate(:page => @page)
            elsif has_keywords?
              # includes are handled inside Query object
              PinFilterQuery.new(filter).filtered.paginate(:page => @page)
            else
              Pin.includes(:user, :pin_images, :procedure, :surgeon).recent.paginate(:page => @page)
            end
  end

  private
  def has_keywords?
    filter.values.reject(&:nil?).count > 0
  end
end
