require 'pry'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0
  result = nil
  while i < collection.length do 
    if name == collection[i][:item] 
      result = collection[i]
    end
    i += 1
  end
  result
end


def consolidate_cart(cart)
  organized_cart = []
  i = 0 
  while i < cart.length do 
    cart_item = find_item_by_name_in_collection(cart[i][:item], organized_cart)
    if cart_item 
      cart_item[:count] += 1
    else 
      cart_item = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1}
      organized_cart << cart_item
    end
    i += 1 
  end
  organized_cart
end 


def apply_coupons(cart, coupons)
  i = 0
  while i < coupons.length do 
    #look for item in the coupon in the cart, else will be nil 
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    #lookup the couponed item in the cart to see if it exists already, else it will be nil
    cart_item_with_coupon = find_item_by_name_in_collection("#{coupons[i][:item]} W/COUPON", cart)
    #if the coupon item exists in the cart and they have enough to use the coupon
    if cart_item && cart_item[:count] >= coupons[i][:num]
      #if the couponed item already exists (numerous coupons) then + to the couponed amount, and - from retail amount
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[i][:num]
        cart_item[:count] -= coupons[i][:num]
      #else if the couponed item doesnt exist yet, create it, and - the couponed amount from the retail amount
      else
        cart_item_with_coupon = {
          :item => "#{coupons[i][:item]} W/COUPON",
          :price => coupons[i][:cost] / coupons[i][:num],
          :clearance => cart_item[:clearance],
          :count => coupons[i][:num]}
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[i][:num]
      end
    end
    i += 1  
  end
  cart
end

def apply_clearance(cart)
 i = 0
 while i < cart.length do
   if cart[i][:clearance]
    cart[i][:price] = (cart[i][:price] * 0.8).round(2)
   end
   i += 1
 end
 cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0 
  i = 0
  while i < final_cart.length
    total += final_cart[i][:price] * final_cart[i][:count]
    i += 1
  end
  if total > 100
    total = (total*0.9)
  end
  total
end