Rails.application.routes.draw do

  get '/', to: 'application#index'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get "/shelters/:id/pets", to: 'shelter_pets#index'
  get '/shelters/:id/pets/new', to: 'shelter_pets#new'
  post '/shelters/:id/pets', to: 'shelter_pets#create'

  patch '/pets/:id/adoptable', to: 'pets#update_pending_status'
  patch '/pets/:id/pending', to: 'pets#update_adopt_status'

  get '/shelter_reviews/:id/new', to: 'shelter_reviews#new'
  post '/shelters/:id/reviews', to: 'shelter_reviews#create'
  delete '/shelters/:shelter_id/:review_id', to: 'shelter_reviews#delete'

end
