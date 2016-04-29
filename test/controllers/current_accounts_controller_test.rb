require 'test_helper'

class CurrentAccountsControllerTest < ActionController::TestCase
  setup do
    @current_account = current_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:current_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create current_account" do
    assert_difference('CurrentAccount.count') do
      post :create, current_account: { cash_account_id: @current_account.cash_account_id, cost_id: @current_account.cost_id, date_ocurrence: @current_account.date_ocurrence, historic: @current_account.historic, type_launche: @current_account.type_launche }
    end

    assert_redirected_to current_account_path(assigns(:current_account))
  end

  test "should show current_account" do
    get :show, id: @current_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @current_account
    assert_response :success
  end

  test "should update current_account" do
    patch :update, id: @current_account, current_account: { cash_account_id: @current_account.cash_account_id, cost_id: @current_account.cost_id, date_ocurrence: @current_account.date_ocurrence, historic: @current_account.historic, type_launche: @current_account.type_launche }
    assert_redirected_to current_account_path(assigns(:current_account))
  end

  test "should destroy current_account" do
    assert_difference('CurrentAccount.count', -1) do
      delete :destroy, id: @current_account
    end

    assert_redirected_to current_accounts_path
  end
end
