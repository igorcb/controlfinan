class CurrentAccount < ActiveRecord::Base
  validates :cash_account_id, presence: true
  validates :cost_id, presence: true
  validates :date_ocurrence, presence: true
  validates :price, presence: true
  validates :type_launche, presence: true

  scope :month_current, lambda { |date| ( where ["date_ocurrence >= ? and date_ocurrence <= ?", DateTime.parse(date).beginning_of_month, DateTime.parse(date).end_of_month])}
  scope :ordered, -> { order(date_ocurrence: :desc, id: :desc) }
  scope :balance_day, -> date {where(date_ocurrence: date).order(date_ocurrence: :desc, id: :desc) }

  def name_account
    case self.cash_account_id
      when 0 then "Conta Dinheiro"
      when 1 then "Itau"
      when 2 then "Santander"
      when 3 then "CEF Poupança"
      when 4 then "Pag Seguro"
      when 5 then "Uber"
      when 5 then "Platinum Itau"
    else "Nao Definido"
    end
  end 

  def name_cost
    case self.cost_id
      when 0 then "Combustivel"
      when 1 then "Central"
      when 2 then "Aluguel Carro"
      when 3 then "Almoço"
      when 4 then "Lanche"
      when 5 then "Diversos"
      when 6 then "Corridas"
      when 7 then "Telefone"
      when 8 then "Lavagem"
      when 9 then "Transferencia"
      when 10 then "Depositos"
    else "Nao Definido"
    end
  end

  def credito_debito
  	case self.type_launche
  		when -1 then "Débito"
  		when  1	then "Crédito"
  		else ""
  	end
  end

  def self.saldo(date=nil)
    date.nil? ? CurrentAccount.sum('price*type_launche') : CurrentAccount.where(date_ocurrence: date).sum('price*type_launche')
  end

end
