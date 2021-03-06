Rails.application.routes.draw do
  get 'home/index' 

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  root 'home#index'

  get 'home/' => 'home#index'

  get '/alunos/:id/aprovar' => 'alunos#aprovar', :as => 'aluno_aprova'

  get '/home/login' => 'home#login', :as => 'login'

  get '/home/logout' => 'home#logout', :as => 'logout'

  post '/home/log' => 'home#log', :as => 'log'

  get '/alunos/:id/nova_senha' => 'alunos#nova_senha', :as => 'nova_senha'

  patch '/alunos/:id/troca_senha' => 'alunos#troca_senha', :as => 'troca_senha'

  get '/alunos/turma/:turma' => 'alunos#alunos_turma', :as => 'alunos_turma'

  get '/professores/login' => 'professores#login', :as => 'logar'

  post '/professores/log' => 'professores#log', :as => 'loga'

  get '/professores/logout' => 'professores#logout', :as => 'logoutt'

  post '/arquivos/create' => 'arquivos#create', :as => 'create'

  get '/posts/videos' => 'posts#videos', :as => 'videos'

  get '/posts/listas' => 'posts#listas', :as => 'listas'

  get '/posts/resolucoes' => 'posts#resolucoes', :as => 'resolucoes'

  get '/notas/usuario' => 'notas#usuario', :as => 'usuario'

  get '/turma/:turma' => 'presencas#turma_alunos', :as => 'turma_alunos'

  resources :alunos

  resources :disciplinas

  resources :professores

  resources :posts

  resources :turmas

  resources :atendimentos

  resources :notas

  resources :presencas

  resources :comentarios

  resources :avaliacoes

  resources :arquivos

end