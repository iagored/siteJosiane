# encoding: UTF-8

class PresencasController < ApplicationController

	def index
		@p = Presenca.all
	end

	def new
		if session[:prof]
			@p = Presenca.new
			professor = Professor.find_by(siape: session[:prof])
			@turmas = Turma.where("professor_id=#{professor.id}")
			if session[:turma]
				if session[:turma]!="0"
					@turma = Turma.find_by_codigo(session[:turma])
					@alunos = Aluno.where(turma_id: @turma.id).order('nome')
				else
					@alunos = Aluno.all
				end
			else
				@alunos = Aluno.all
			end
		else
			redirect_to :logar
	  	end
	end

	def turma_alunos

		session[:turma] = params[:turma]
		redirect_to '/presencas/new'
		
	end

	def create
		
		if session[:prof]

			aluno = "1"
			turma = "1"

			@p = Presenca.new

			if params[:presente] == "p"
				@p.presente = true
			else
				@p.presente = false
			end

			if params[:justificado] == "j"
				@p.justificado = true
			else
				@p.justificado = false
			end

			@p.turma = turma
			@p.aluno = aluno
			
			if @p.save
				redirect_to '/presencas/new'
			else		
				message = "Falha na inserção: "
				@p.errors.full_messages.each do |m|
					message += m
				end

				flash.now[:alert] = message
	    		render 'new'
  			end

  		else
			redirect_to :logar
	   	end
 
	end

end