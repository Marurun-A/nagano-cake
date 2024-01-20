module ApplicationHelper


  def payment_method_label(payment_method)
  case payment_method
  when "credit_card"
    "クレジットカード"
  when "transfer"
    "銀行振込"
  else
    "未定義の支払い方法"
  end
  end
end
