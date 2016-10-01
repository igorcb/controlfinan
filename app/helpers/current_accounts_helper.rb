module CurrentAccountsHelper
	def select_cash_account
		[["CONTA DINHEIRO", "0"], ["ITAU","1"], ["SANTANDER", "2"], ["CEF POUPANÇA", "3"], ["PAG SEGURO", "4"], ["UBER", "5"], ["PLATINUM ITAU", "6"]]
	end

	def select_cost
		[["COMBUSTIVEL", "0"], ["CENTRAL", "1"], ["ALUGUEL CARRO", "2"], ["ALMOÇO", "3"], ["LANCHE", "4"], ["DIVERSOS", "5"], ["CORRIDAS", "6"], ["TELEFONE", "7"], ["LAVAGEM", "8"], ["TRANSFERENCIA", "9"], ["DEPOSITOS", "10"]]
	end

	def select_credito_debito
    ([['Débito', -1], ['Crédito', 1]])

  end

  def date_br(date)
    date.nil? ? "" : I18n.l(date, format: '%d/%m/%Y')
  end  
end
