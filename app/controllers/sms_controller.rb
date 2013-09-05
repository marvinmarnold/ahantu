class SmsController < ApplicationController
  before_action :set_sm, only: [:show, :edit, :update, :destroy]

  # GET /sms
  # GET /sms.json
  def index
    @sms = Sm.all
  end

  # GET /sms/1
  # GET /sms/1.json
  def show
  end

  # GET /sms/new
  def new
    @sm = Sm.new
  end

  # GET /sms/1/edit
  def edit
  end

  # POST /sms
  # POST /sms.json
  def create
    @sm = Sm.new(sm_params)

    respond_to do |format|
      if @sm.save
        format.html { redirect_to @sm, notice: 'Sm was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sm }
      else
        format.html { render action: 'new' }
        format.json { render json: @sm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sms/1
  # PATCH/PUT /sms/1.json
  def update
    respond_to do |format|
      if @sm.update(sm_params)
        format.html { redirect_to @sm, notice: 'Sm was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms/1
  # DELETE /sms/1.json
  def destroy
    @sm.destroy
    respond_to do |format|
      format.html { redirect_to sms_url }
      format.json { head :no_content }
    end
  end

  def entry_point
    Sm.create!(
      phone_id: Phone.find_or_create_by_number(from: params[:sender]).id,
      #to: params[:receiver]
      # See http://po-ru.com/diary/fixing-invalid-utf-8-in-ruby-revisited/
      # http://stackoverflow.com/questions/7870636/equivalent-of-iconv-convutf-8-ignore-in-ruby-1-9-x/7870859#7870859
      message: (params[:message] + ' ')[0..-2].encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "").force_encoding('UTF-8'),
      sent_at: Time.zone.now,
      incoming: true,
    )

    render status: 200,
      nothing: true,
      content_type: 'text/html'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sm
      @sm = Sm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sm_params
      params.require(:sm).permit(:cart_id, :message, :phone_id, :incoming, :sent_at)
    end
end
