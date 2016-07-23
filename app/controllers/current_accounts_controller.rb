class CurrentAccountsController < ApplicationController
  before_action :set_current_account, only: [:show, :edit, :update, :destroy]

  # GET /current_accounts
  # GET /current_accounts.json
  def index
    #@current_accounts = CurrentAccount.ordered
    @current_accounts = CurrentAccount.ordered.paginate(page: params[:page])
  end

  # GET /current_accounts/1
  # GET /current_accounts/1.json
  def show
  end

  # GET /current_accounts/new
  def new
    @current_account = CurrentAccount.new
  end

  # GET /current_accounts/1/edit
  def edit
  end

  # POST /current_accounts
  # POST /current_accounts.json
  def create
    @current_account = CurrentAccount.new(current_account_params)

    respond_to do |format|
      if @current_account.save
        format.html { redirect_to @current_account, flash: { success: "AccountPayable was successfully created." } }
        format.json { render :show, status: :created, location: @current_account }
      else
        format.html { render :new }
        format.json { render json: @current_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /current_accounts/1
  # PATCH/PUT /current_accounts/1.json
  def update
    respond_to do |format|
      if @current_account.update(current_account_params)
        format.html { redirect_to @current_account, flash: { success: "AccountPayable was successfully updated." } }
        format.json { render :show, status: :ok, location: @current_account }
      else
        format.html { render :edit }
        format.json { render json: @current_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /current_accounts/1
  # DELETE /current_accounts/1.json
  def destroy
    @current_account.destroy
    respond_to do |format|
      format.html { redirect_to current_accounts_url, notice: 'Current account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @current_accounts = CurrentAccount.where(date_ocurrence: params[:date_calendar_now])
    @saldo = CurrentAccount.saldo(params[:date_calendar_now])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_account
      @current_account = CurrentAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def current_account_params
      params.require(:current_account).permit(:cash_account_id, :cost_id, :date_ocurrence, :type_launche, :price, :historic)
    end
end
