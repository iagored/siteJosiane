# encoding: UTF-8

class Arquivo < ActiveRecord::Base

	belongs_to :post

	validates_associated :post

	validates :post_id, presence: {message: "Não é possível existir um arquivo sem um post associado"}
	validates :nome, presence: {message: "Conteúdo não pode ficar em branco"},
		uniqueness:{message: "Conteúdo já postado"}
	validates :extensao, presence: {message: "Extensão não pode ficar em branco"}

end
