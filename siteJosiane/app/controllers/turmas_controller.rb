# encoding: UTF-8

class TurmasController < ApplicationController

	def new
		if session[:prof]
			@turma = Turma.new
		else
			redirect_to :logar
		end
	end

	def create
			
		if session[:prof] 

			professor = Professor.find_by(siape: session[:prof])

			@turma = Turma.new params.require(:turma).permit(:codigo)
			@turma.professor_id = professor.id
				
			if @turma.save
				redirect_to professores_path, notice: "Turma inserida!"
			else		
				message = "Falha na inserção: "
				@turma.errors.full_messages.each do |m|
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