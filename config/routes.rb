Rails.application.routes.draw do
  root to: 'questions#index'

  resources :questions do
    put 'hide', on: :member
    get 'search', on: :collection
  end
  resource :session, only: %i[new create destroy]
  resources :users, except: %i[index], param: :nickname
end
