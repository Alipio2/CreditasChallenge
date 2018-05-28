class Nome
	attr_reader :primeiroNome, :ultimoNome
	def initialize(primeiro, ultimo)		
		@primeiroNome = primeiro
    	@ultimoNome = ultimo
	end
end

class Email
	attr_reader :email
	def initialize(email)		
		@email = email    
	end

	def enviarEmail(texto)
		puts "#{texto}. --> Isto é um Email!!"
	end
end	

class Endereco
	attr_reader :logradouro, :numero, :bairro, :cep, :cidade, :estado
	def initialize(logradouro, numero, bairro, cep, cidade, estado)
		@logradouro = logradouro
		@numero = numero
		@bairro = bairro
		@cep = cep 
		@cidade = cidade 
		@estado = estado 
	end
end	

class Cliente
	attr_reader :nome, :email, :enderecoCobranca, :enderecoEntrega 
	def initialize(nome, email, enderecoCobranca, enderecoEntrega)
		@nome = nome
		@email = email
		@enderecoCobranca = enderecoCobranca
		@enderecoEntrega = enderecoEntrega 
	end	
end	

class Etiqueta

	def gerarEtiqueta()
		
	end	
end

class Produto < Etiqueta
	attr_reader :nome, :preco, :quantidade, :etiqueta
  	def initialize(nome, preco, quantidade)
    	@nome = nome
    	@preco = aplicarDesconto(preco)
    	@quantidade = quantidade
    	@etiqueta = ""
    end

  	def gerarEtiqueta()
  		super
 		@etiqueta= "Este é um item físico, Produto Frágil! --> Isto é uma Etiqueta!!"
 		puts etiqueta
  	end 	

  	def aplicarDesconto(preco)

  		preco.to_f
  	end

  	def enviarEmail()
  	end
end

class Livro < Produto
	attr_reader :isbn
  	def initialize(nome, preco, quantidade, isbn)
    	@nome= nome
    	@preco = aplicarDesconto(preco)
    	@quantidade =quantidade
    	@isbn = isbn    	
  	end

  	def gerarEtiqueta()  		
  		@etiqueta= "Este produto é um livro e conforme a Constituição Art. 150, VI, ele é isento de impostos. --> Isto é uma Etiqueta!!"
  		puts etiqueta
  	end

  	def aplicarDesconto(preco)  		
  		preco.to_f
  	end

  	def enviarEmail()
  	end
end 

class Assinatura < Produto
	attr_reader :descricao,:dataInicio, :validoAte, :estatus, :email 
	def initialize(descricao, preco, validade, email)
    	@descricao= descricao
    	@preco =  aplicarDesconto(preco)
    	@validoAte =validade
    	@estatus = "Ativo"    	
    	@email = email
    	#email.enviarEmail("Parabens sua Assinatura foi Criada!\n\n\n\n")    	
  	end

  	def gerarEtiqueta()
  		#@etiqueta= "Este produto é uma Assunatura. --> Isto é uma Etiqueta!!"
 		#puts etiqueta
  	end 

  	def aplicarDesconto(preco)
  		preco.to_f
  	end

  	def enviarEmail()
  		ativar()
  		email.enviarEmail("Sua Assinatura foi Ativada.")
  	end

  	def encerrar()
		@estatus = "Inativa"
		email.enviarEmail("Sua Assinatura foi Desativada.")
  	end  	

  	def ativar()

		@estatus = "Ativa"		
  	end  

  	def exibirEstatus()

		puts "#{estatus}"
  	end
end  	

class MidiaDigital < Produto
	attr_reader  :anoLancamento, :email, :descricao
	def initialize(nome, preco, anoLancamento, email)
    	@nome= nome
    	@preco= aplicarDesconto(preco)
    	@anoLancamento = anoLancamento    	
    	@descricao = "Parabens voce acaba de comprar uma Midia Digital #{nome}!"
    	@email = email    	
  	end

  	def gerarEtiqueta()
  		#@etiqueta= "Este produto é uma Midia Digital. --> Isto é uma Etiqueta!!"
		#puts etiqueta
  	end

  	def aplicarDesconto(preco)

  		preco.to_f - 10.00
  	end

  	def enviarEmail() 

  		email.enviarEmail(descricao)
  	end
end

class ItemPedido
	attr_reader :produto, :quantidade
	def initialize(produto, quantidade)
		@produto = produto
		@quantidade = quantidade
		@preco = produto.preco.to_f
	end

	def alterarQuantidade(quantidade)

		@quantidade = quantidade
	end	
end

class Pedido
	attr_reader :status, :itemPedido, :cliente, :dataAbretura
	def initialize(cliente)
		@status="abreto"
		@dataAbretura = Time.now
		@itemPedido = []
		@cliente= cliente
	end

	def adicionarItem(itemPedido)
		if(status == "abreto")
			@itemPedido << itemPedido
		end  	 		
	end	

	def removerItem(itemPedido)
		if(status == "abreto")
			itemPedido.delete(itemPedido)
    	end	 
	end	

	def exibirItens()
		for item in @itemPedido
			puts item.produto.etiqueta
		end
	end

	def fechar()

		@status="fechado"				
	end 
end	

class Pagamento
	attr_reader :pedido, :status, :dataPagamento, :fatura
	def initialize(pedido)
			@pedido= pedido
			@status = "Pendete"		
	end

	def pagar()
		@dataPagamento =Time.now
		@status ="Fechado"			
		@fatura = Fatura.new(pedido.cliente.enderecoCobranca, pedido.cliente.enderecoEntrega, pedido)

		for item in pedido.itemPedido
			item.produto.gerarEtiqueta()
			item.produto.enviarEmail()
		end		
	end
end

class Fatura
	attr_reader :enderecoEntrega, :enderecoCobranca, :pedido
	def initialize(enderecoCobranca, enderecoEntrega, pedido)
		@enderecoEntrega = enderecoEntrega
		@enderecoCobranca = enderecoCobranca
		@pedido = pedido
	end
end	

nome = Nome.new("alipio", "Ferro")
email = Email.new("alipioDesafio@cerditas.com")
enderecoCobranca = Endereco.new("Avenida Paulista", 1300, "Bela Vista", "013113-00", "São Paulo", "SP")
enderecoEntrega = Endereco.new("Avenida Paulista", 1300, "Bela Vista", "013113-00", "São Paulo", "SP")
cliente = Cliente.new(nome,email,enderecoCobranca, enderecoEntrega)
produto =Produto.new("Escumadeira de alumino", 250.10, 10)
livro = Livro.new("Ruby para Iniciantes", 150, 10, "978-0-470-37495-5")
assinatura = Assinatura.new("Assinatura Revista Veja", 150.55, 365, email)
midia = MidiaDigital.new("Video da Campanha Outono Amarelo", 158.99, 2017, email)
lista = []

lista << ItemPedido.new(midia, 157)
lista << ItemPedido.new(produto, 200)
lista << ItemPedido.new(livro, 10)
lista << ItemPedido.new(assinatura, 52)

pedido = Pedido.new(cliente)

for item in lista
	pedido.adicionarItem(item)
end

pedido.fechar()

pagamento = Pagamento.new(pedido)
pagamento.pagar()