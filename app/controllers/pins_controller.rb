class PinsController < ApplicationController
before_filter :authenticate_user!, except: [:index]

  # GET /pins
  # GET /pins.json
  def index
    @query = sanitize(params[:query]) if params[:query]

    if user_signed_in?
      @presenter = PinPresenter.new(
      :query => @query,
      :user => current_user,
      :page => params[:page],
      :safe_mode => current_user.safe_mode
      )
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pins }
    end
  end

  # GET /pins/1
  # GET /pins/1.json
  def show
    @pin = Pin.find(params[:id])
    @comments = @pin.comment_threads.order('created_at desc')
    @new_comment = Comment.build_from(@pin, current_user, "")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pin }
    end
  end

  def admin
    @pins = Pin.where(state: 'pending').order("created_at desc").paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pins }
    end
  end

  # GET /pins/new
  # GET /pins/new.json
  def new
    @pin = current_user.pins.new
    4.times {@pin.pin_images.build}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pin }
    end
  end

  # GET /pins/1/edit
  def edit
    @pin = Pin.find(params[:id])
    l = @pin.pin_images.length
    (4-l).times {@pin.pin_images.build}
  end

  # POST /pins
  # POST /pins.json
  #submit button triggers
  def create
    @pin = current_user.pins.new(params[:pin])

    respond_to do |format|
      if @pin.save
        format.html { redirect_to @pin, notice: 'Pin was successfully created.' }
        format.json { render json: @pin, status: :created, location: @pin }
      else
        format.html { render action: "new" }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pins/1
  # PUT /pins/1.json
  def update
    @pin = Pin.find(params[:id])

    respond_to do |format|
      if @pin.update_attributes(params[:pin])
        format.html { redirect_to @pin, notice: 'Pin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pins/1
  # DELETE /pins/1.json
  def destroy
    @pin = Pin.find(params[:id])
    @pin.destroy

    respond_to do |format|
      format.html { redirect_to pins_url }
      format.json { head :no_content }
    end
  end

  private

  def sanitize(query)
    query.gsub!(/(dr.|Dr.|dr|Dr)/, '')
    query.gsub!(/[\W]/, ' ')
    return Riddle.escape(query)
  end
end
