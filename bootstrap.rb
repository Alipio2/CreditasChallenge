class Name
  attr_reader :firstName, :lastName
  def initialize(firstName, lastName)    
    @firstName = firstName
      @lastName = lastName
  end
end

class Email
  attr_reader :email
  def initialize(email)   
    @email = email    
  end

  def sedEmail(words)
    puts "#{words}. --> This is Email!"
  end
end

class Address
  attr_reader :zipcode, :street, :number, :neighborhood, :city, :country

  def initialize(zipcode, street, number, neighborhood, city, country)
    @zipcode = zipcode
    @street = street
    @number = number
    @neighborhood = neighborhood
    @city = city
    @country = country
  end
end 

class Customer
 attr_reader :name, :email, :billing_address, :shipping_address
  def initialize(name, email, billing_address, shipping_address)
    @name = name
    @email = email
    @billing_addressa = billing_address
    @shipping_address = shipping_address 
  end 
end

class Label
  def printLabel(words)
    puts "#{words}. --> This is sticker!"
  end
end  

class Product 
  attr_reader :name, :price, :quantity, :label 

  def initialize(name, price, quantity)
    @name   = name
    @quantity = quantity
    @label = Label.new
    @price = toDiscount(price)
  end  

  def printLabel()

    label.printLabel("This is a Physical Item, Fragile Product!")      
  end  

  def sedEmail()

   end

  def toDiscount(valeu)

      @price = valeu.to_f
  end

end

class Book < Product
    attr_reader :isbn, :label 
    def initialize(name, price, quantity, isbn)
      @name= name
      @price = toDiscount(price)
      @quantity = quantity
      @isbn = isbn
      @label = Label.new     
    end 

    def printLabel() 
     label.printLabel("This product is a book and according to the Constitution Art. 150, VI, it is exempt from taxes.")         
    end  

    def sedEmail()    
    end

    def toDiscount(valeu)
       @price = valeu.to_f
    end
end

class Digital < Product
  attr_reader :description, :shelflife, :status, :email 
    def initialize(description, price, shelflife, email)
        @description= description
        @price =  toDiscount(price)
        @shelflife = shelflife
        @status = "Created"      
        @email = email       
    end

  def printLabel()         
  end 

  def toDiscount(valeu)
    @price = valeu.to_f
  end

  def toActivate()
    @status = "Active"
    email.sedEmail("Your Digital Product has been Enabled.")
  end

  def toDisable()
    @status = "Inactive"
    email.sedEmail("Your Digital Product has been Inactive.") 
  end 

  def printStatus()
    puts "#{status}"
  end
end

class Membership < Product
  attr_reader :launchYear, :email, :description
  def initialize(nome, price, launchYear, email)
      @name= nome
      @price= toDiscount(price)
      @launchYear = launchYear      
      @description = "Congratulations, you just bought a Digital Media.. #{nome}!"
      @email = email      
  end

  def printLabel()         
  end  

  def sedEmail()
    email.sedEmail(description)    
  end

  def toDiscount(valeu)
    @price = valeu.to_f - 10.00.to_f
  end
end

class Order
  attr_reader :customer, :orderItem, :payment, :closed_at, :status, :amount

  def initialize(customer)
    @customer = customer
    @status="Open"
    @orderItem = []     
  end

  def addProduct(orderItem)
   if(status == "Open")
      @orderItem << orderItem
    end
  end

  def removeProduct(orderItem)
    if(status == "Open")
      orderItem.delete(orderItem)
    end  
  end 
  
  def close()   
      @closed_at = Time.now
      @status="Close"
      getAmount()      
  end

  def printProduct()
    for item in @orderItem
      puts item.product.label.to_s      
    end
  end

  def getAmount()
    @amount = 0
    for item in @orderItem
      @amount = @amount.to_f + item.product.price.to_f      
    end
  end
end

class OrderItem
  attr_reader :order, :product, :quantity

  def initialize(order, product, quantity)
    @order = order
    @product = product
    @quantity =quantity
  end

  def toChange(quantity)
    @quantity = quantity
  end
end

class Payment
  attr_reader :order, :authorization_number, :payment_method, :invoice, :paid_at, :status

  def initialize(order, payment_method)
    @order = order
    @authorization_number = Time.now.to_i
    @payment_method = payment_method
    @status = "Pending"   
  end

  def pay()
    @invoice = Invoice.new(order.customer.billing_address, order.customer.shipping_address, order)
    @paid_at = Time.now

    for item in order.orderItem
      item.product.printLabel()
      item.product.sedEmail()
    end

    puts "O Total da sua Compra é: R$#{order.amount}"    
    end
end

class Invoice
  attr_reader :billing_address, :shipping_address, :order

  def initialize(billing_address, shipping_address, order)
    @billing_address = billing_address
    @shipping_address = shipping_address
    @order = order
  end
end

class CreditCard
  def self.fetch_by_hashed(code)
    CreditCard.new
  end
end

##########################################

nome = Name.new("alipio", "Ferro")
email = Email.new("alipioDesafio@cerditas.com")
address01 = Address.new("Avenida Paulista", 1300, "Bela Vista", "013113-00", "São Paulo", "SP")
address02 = Address.new("Avenida Paulista", 1300, "Bela Vista", "013113-00", "São Paulo", "SP")
customer = Customer.new(nome, email, address01, address02)

product = Product.new("Escumadeira de alumino", 250.10, 10)
book = Book.new("Ruby para Iniciantes", 150, 10, "978-0-470-37495-5")
digital = Digital.new("Assinatura Revista Veja", 150.55, 365, email)
membership = Membership.new("Video da Campanha Outono Amarelo", 158.99, 2017, email)

order = Order.new(customer)

list = []
list << OrderItem.new(order, digital, 157)
list << OrderItem.new(order, product, 200)
list << OrderItem.new(order, book, 10)
list << OrderItem.new(order, membership, 52)

for item in list
  order.addProduct(item)
end

order.close()

payment = Payment.new(order, CreditCard.new)
payment.pay()