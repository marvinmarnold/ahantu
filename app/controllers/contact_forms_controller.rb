class ContactFormsController < ApplicationController
  before_action :set_contact_form, only: [:show, :edit, :update, :destroy]

  authorize_resource

  # GET /contact_forms
  # GET /contact_forms.json
  def index
    @contact_forms = ContactForm.all
  end

  # GET /contact_forms/1
  # GET /contact_forms/1.json
  def show
  end

  # GET /contact_forms/new
  def new
    redirect_to contact_path
  end

  # GET /contact_forms/1/edit
  def edit
  end

  # POST /contact_forms
  # POST /contact_forms.json
  def create
    @contact_form = current_user.contact_forms.build(contact_form_params)

    respond_to do |format|
      if @contact_form.save
        format.html { redirect_to root_path, notice: t("contact_form.new.success") }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /contact_forms/1
  # PATCH/PUT /contact_forms/1.json
  def update
    respond_to do |format|
      if @contact_form.update(contact_form_params)
        format.html { redirect_to @contact_form, notice: 'Contact form was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /contact_forms/1
  # DELETE /contact_forms/1.json
  def destroy
    @contact_form.destroy
    respond_to do |format|
      format.html { redirect_to contact_forms_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_form
      @contact_form = current_user.contact_forms.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_form_params
      params.require(:contact_form).permit(:subject, :from, :body)
    end
end
