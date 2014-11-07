Rails.application.routes.draw do
  root 'slump#index'

  get 'slump/:id/(:title)', to: 'slump#show', as: 'show_slump'

  get 'fetch', to: 'slump#fetch'
end
