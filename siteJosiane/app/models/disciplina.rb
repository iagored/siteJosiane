# encoding: UTF-8

class Disciplina < ActiveRecord::Base

	has_many :avaliacoes
	has_many :presencas
	belongs_to :professor

	validates_associated :professor

	validates :professor_id, presence: {message: "Não é possível existir uma disiciplina sem um professor responsável"}
	validates :nome, presence: {message: "Nome não pode ficar em branco"}
	validates :chs, presence: {message: "CHS não pode ficar em branco"},
		numericality:{message: "CHS inválida"}
	validates :cht, presence: {message: "CHT não pode ficar em branco"},
		numericality:{message: "CHT máxima inválida"}

	validate :positivo?

  	private
  	def positivo?
  		
  		if chs < 0
  			errors.add(:chs, "Carga horárias devem ser positivas e maiores que zero") 
  		end 

  		if cht < 0
  			errors.add(:cht, "Carga horárias devem ser positivas e maiores que zero") 
  		end
  		
  	end

end