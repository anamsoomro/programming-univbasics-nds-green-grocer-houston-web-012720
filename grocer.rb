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
<<<<<<< HEAD
  organized_cart = []
  i = 0 
  while i < cart.length do 
    cart_item = find_item_by_name_in_collection(cart[i][:item], organized_cart)
    if cart_item 
      cart_item[:count] += 1
    else 
      cart_item = {
=======
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  new_cart = []
  i = 0 
  while i < cart.length do 
    new_cart_item = find_item_by_name_in_collection (cart[i][:item], new_cart)
    if new_cart_item != nil
      new_cart_item[:count] += 1
    else 
      new_cart_item = {
>>>>>>> c1445c3c4aae9a379de2508f4e273682906163dd
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1}
<<<<<<< HEAD
      organized_cart << cart_item
    end
    i += 1 
  end
  organized_cart
=======
      new_cart << new_cart_item
    end
    i += 1 
  end
  new_cart
>>>>>>> c1445c3c4aae9a379de2508f4e273682906163dd
end 


def apply_coupons(cart, coupons)
  i = 0
  while i < coupons.length do 
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    couponed_item_name = "#{coupons[i][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[i][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[i][:num]
        cart_item[:count] -= coupons[i][:num]
      else
        cart_item_with_coupon = {
          :item => couponed_item_name,
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
  binding.pry
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
  
  
  
  