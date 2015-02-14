require 'test_helper'

class RecordsControllerTest < ActionController::TestCase
  setup do
    @record = records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:records)
  end

  test "should create record" do
    assert_difference('Record.count') do
      post :create, record: { amount: @record.amount, category_id: @record.category_id }
    end

    assert_response 201
  end

  test "should show record" do
    get :show, id: @record
    assert_response :success
  end

  test "should update record" do
    put :update, id: @record, record: { amount: @record.amount, category_id: @record.category_id }
    assert_response 204
  end

  test "should destroy record" do
    assert_difference('Record.count', -1) do
      delete :destroy, id: @record
    end

    assert_response 204
  end
end
