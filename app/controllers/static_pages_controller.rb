class StaticPagesController < ApplicationController
  include CurrentAccountsHelper
  
  def dashboard
  	accounts = CurrentAccount.month_current(date_br(DateTime.now.to_date)).select([:date_ocurrence]).group(:date_ocurrence).sum('price*type_launche')
  	credits = CurrentAccount.month_credit(date_br(DateTime.now.to_date)).select([:date_ocurrence]).group(:date_ocurrence).sum('price*type_launche')
  	@total_accounts = CurrentAccount.month_current(date_br(DateTime.now.to_date)).sum('price*type_launche')
  	@total_credits  = CurrentAccount.month_credit(date_br(DateTime.now.to_date)).sum('price*type_launche')
    
    # total de creditos
    @current_accounts = accounts.sort { |x, y| y[0] <=> x[0] }
    @current_account_credits = credits.sort { |x, y| y[0] <=> x[0] }


  end
end
