Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :plots, only: [:index]

  resources :plots, only: [:index] do
    delete '/plants/:id', to: 'plot_plants#destroy', as: 'plant'
  end
end
