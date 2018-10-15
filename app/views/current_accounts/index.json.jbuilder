json.array!(@current_accounts) do |current_account|
  json.extract! current_account, :id, :cash_account_id, :cost_id, :date_ocurrence, :type_launche, :price, :historic, :user_id
  json.url current_account_url(current_account, format: :json)
end
