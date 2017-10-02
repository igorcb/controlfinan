module CurrentAccountsHelper
  def full_title(page_title)
    base_title = "ControlFinan"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end	

	def select_cash_account
		[["CONTA DINHEIRO", "0"], ["ITAU","1"], ["SANTANDER", "2"], ["CEF POUPANÇA", "3"], ["PAG SEGURO", "4"], ["UBER", "5"], ["PLATINUM ITAU", "6"], ["BANCO DO BRASIL", "7"]]
	end

	def select_cost
		[["COMBUSTIVEL", "0"], ["CENTRAL", "1"], ["ALUGUEL CARRO", "2"], ["ALMOÇO", "3"], ["LANCHE", "4"], ["DIVERSOS", "5"], ["CORRIDAS", "6"], ["TELEFONE", "7"], ["LAVAGEM", "8"], ["TRANSFERENCIA", "9"], ["DEPOSITOS", "10"], ["ESTACIONAMENTO", "11"], ["IMPOSTOS", "12"], ["MULTAS", "13"], ["MANUTENCAO", "14"], ["VIAGENS UBER", "15"]]
	end

	def select_credito_debito
    ([['Débito', -1], ['Crédito', 1]])

  end

  def date_br(date)
    date.nil? ? "" : I18n.l(date, format: '%d/%m/%Y')
  end

  def current_month(date=nil)
    month = date.nil? ? Date.current : date
    #I18n.l(month, format: "%B")
    #I18n.t("date.abbr_month_names")[Date.today.month]
    I18n.t("date.abbr_month_names")[date]
  end
end
