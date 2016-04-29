class StaticPagesController < ApplicationController
  include CurrentAccountsHelper
  
  def dashboard
  	accounts = CurrentAccount.month_current(date_br(DateTime.now.to_date)).select([:date_ocurrence]).group(:date_ocurrence).sum('price*type_launche')
    #@current_accounts = accounts.sort! { |x, y| x[0] <=> y[0] }
    @current_accounts = accounts.sort { |x, y| y[0] <=> x[0] }
  end
end
