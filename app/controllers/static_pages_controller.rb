class StaticPagesController < ApplicationController
  include CurrentAccountsHelper
  before_action :authenticate_user!  

  def dashboard
    puts ">>>>>>>>>>>>>>> User: #{current_user.id}: #{current_user.email}"
  	accounts = CurrentAccount.where(user_id: current_user).month_current(date_br(DateTime.now.to_date)).select([:date_ocurrence]).group(:date_ocurrence).sum('price*type_launche')
  	credits = CurrentAccount.where(user_id: current_user).month_credit(date_br(DateTime.now.to_date)).select([:date_ocurrence]).group(:date_ocurrence).sum('price*type_launche')
  	@total_accounts = CurrentAccount.where(user_id: current_user).month_current(date_br(DateTime.now.to_date)).sum('price*type_launche')
  	@total_credits  = CurrentAccount.where(user_id: current_user).month_credit(date_br(DateTime.now.to_date)).sum('price*type_launche')
    
    # total de creditos
    @current_accounts = accounts.sort { |x, y| y[0] <=> x[0] }
    @current_account_credits = credits.sort { |x, y| y[0] <=> x[0] }

    @cash_accounts = CurrentAccount.where(user_id: current_user).cash_accounts

    @running = CurrentAccount.where(user_id: current_user).running(date_br(DateTime.now.to_date))
    @fuel = CurrentAccount.where(user_id: current_user).fuel(date_br(DateTime.now.to_date))
    @wash = CurrentAccount.where(user_id: current_user).wash(date_br(DateTime.now.to_date))
    @fone = CurrentAccount.where(user_id: current_user).fone(date_br(DateTime.now.to_date))

    @summary = @running - @fuel - @wash - @fone

  end

  def moviment
    
  end
end
