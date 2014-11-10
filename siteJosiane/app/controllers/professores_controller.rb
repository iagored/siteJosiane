# encoding: UTF-8

class ProfessoresController < ApplicationController

	def index

		if not session[:prof]
			redirect_to action: 'login'
		else
			@professor = Professor.all
		end
		
	end

	def login

		if not session[:prof]
			@professor = Professor.new
		else
			redirect_to professores_path
		end

		
	end

	def log
		
		if not session[:prof]

			@professor = Professor.find_by_siape_and_senha(params[:siape],Digest::MD5.hexdigest(params[:senha]))	
			
			if !@professor.nil?
				session[:prof] = @professor.siape
				redirect_to professores_path
			else
				@professor = Professor.new
				flash.now[:alert] = 'Siape ou senha incorretas'
	        	render :login
			end

		else
			redirect_to professores_path
		end

	end

	def logout

		if session[:prof]
		    reset_session
		    redirect_to :logar
		else
			redirect_to professores_path
		end

  	end

	def new

		if not session[:prof]
			@professor = Professor.new
		else
			redirect_to professores_path
		end
		
	end

	def create
		
		if not session[:prof]
			
			@professor = Professor.new params.require(:professor).permit(:nome, :siape, :senha, :email)
			senha2 = params[:senha2]

			puts params.inspect

			if @professor.senha.eql? senha2

				@professor.senha = Digest::MD5.hexdigest(@professor.senha)
				
		  		if @professor.save
		  			redirect_to professores_path
		  		else
		  			message = "Falha no cadastro: "
					@professor.errors.full_messages.each do |m|
						message += m
					end
					flash.now[:alert] = message
	       			render 'new'
	       		end

	       	else

	  			flash.now[:alert] = "Senhas não verificam"
	        	render 'new'

	  		end

	  	else

			redirect_to :index

		end

	end

	def nova_senha

		@professor = Professor.find(params[:id])
		if not session[:prof] && @professor.siape==session[:prof]
			redirect_to :index
		end

	end

	def troca_senha

		@professor = Professor.find(params[:id])
		if session[:prof] && @professor.siape==session[:prof]
			old_senha = Digest::MD5.hexdigest(params[:senha_antiga])

			if @professor.senha.eql? old_senha
		  		
				new_senha = Digest::MD5.hexdigest(params[:senha])

		  		if @professor.update(senha: new_senha)
		  			redirect_to @professor, notice: "Troca de senha efetuada com sucesso"
		  		else
		  			flash.now[:alert] = "Falha na troca de senha"
		  			render :nova_senha
		  		end

	  		else
	  			
	  			flash.now[:alert] = "Senha antiga incorreta"
	  			render :nova_senha

	  		end

	  	else
			redirect_to root_path
	    end

	end

end