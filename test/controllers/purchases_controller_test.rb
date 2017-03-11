require 'test_helper'

class PurchasesControllerTest < ActionDispatch::IntegrationTest
  # setup do
  #   @purchase = purchases(:one)
  # end
  #
  # test "should get index" do
  #   get purchases_url
  #   assert_response :success
  # end
  #
  # test "should get new" do
  #   get new_purchase_url
  #   assert_response :success
  # end
  #
  # test "should create purchase" do
  #   assert_difference('Purchase.count') do
  #     post purchases_url, params: { purchase: { amount_bought: @purchase.amount_bought, amount_spent: @purchase.amount_spent, exch_rate: @purchase.exch_rate, from_currency: @purchase.from_currency, time_of_purchase: @purchase.time_of_purchase, to_currency: @purchase.to_currency, user_id: @purchase.user_id } }
  #   end
  #
  #   assert_redirected_to purchase_url(Purchase.last)
  # end
  #
  # test "should show purchase" do
  #   get purchase_url(@purchase)
  #   assert_response :success
  # end
  #
  # test "should update purchase" do
  #   patch purchase_url(@purchase), params: { purchase: { amount_bought: @purchase.amount_bought, amount_spent: @purchase.amount_spent, exch_rate: @purchase.exch_rate, from_currency: @purchase.from_currency, time_of_purchase: @purchase.time_of_purchase, to_currency: @purchase.to_currency, user_id: @purchase.user_id } }
  #   assert_redirected_to purchase_url(@purchase)
  # end
  #
  # test "should destroy purchase" do
  #   assert_difference('Purchase.count', -1) do
  #     delete purchase_url(@purchase)
  #   end
  #
  #   assert_redirected_to purchases_url
  # end
end
