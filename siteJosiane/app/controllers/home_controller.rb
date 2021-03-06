# encoding: UTF-8

class HomeController < ApplicationController

	def index

		if session[:usuario]
			aluno = Aluno.find_by(matricula: session[:usuario])
			turma = Turma.find(aluno.turma_id)
			@professor = Professor.find(turma.professor_id)
			@posts = Post.where("professor_id=#{@professor.id}").limit(5).order('created_at DESC')
			@arquivos = Arquivo.joins('JOIN posts ON posts.id = arquivos.post_id').where("tipo = 'Video'").order('nome')
		else
			redirect_to action:'login'
		end

	end

  	def login

  		if not session[:usuario]
			@aluno = Aluno.new
		else
			redirect_to root_path
		end

	end

	def log
		
		if not session[:usuario]

			if session[:prof]
				reset_session
			end

		@aluno = Aluno.find_by_matricula_and_senha(params[:matricula],Digest::MD5.hexdigest(params[:senha]))
		
			if !@aluno.nil?
				if @aluno.confirmado
					session[:usuario] = @aluno.matricula
					redirect_to :home
			  	else
			  		flash.now[:alert] = "Ainda em espera de aprovação de cadastro"
	        		render :login
			  	end
			else
				@aluno = Aluno.new
				flash.now[:alert] = 'Matrícula ou senha incorretas'
	        	render :login
			end

		else

			redirect_to root_path

		end

	end

	def logout

		if session[:usuario]
		    reset_session
		    redirect_to root_path
		else
			redirect_to action: 'login'
		end

  	end

end
