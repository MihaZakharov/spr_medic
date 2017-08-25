Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get 'pharmacies/all(:id)',   to: 'pharmacies#all'
  resources :pharmacies
  resources :regions
  resources :pharmacy_webs

  get 'percentages/new_w_pharm/(:id)', to: 'percentages#newex', as: 'create_new_for_pharm'
  resources :percentages

 # resources :groups
 root "getinvoice#index"
devise_scope :user do
  get 'users/show', to: 'users/registrations#show'
end
  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations' }
 # devise_for :users
#  resources :products
  post 'reg_json', to: 'regions#showalljson'
  get 'products/all', to: 'products#index'
  post 'products/searching', to: 'products#searching'
  post 'products/detailproduct', to: 'products#dtlprod'
  post 'products',      to: 'products#showproductsfromgroup'
  resources :products
  get 'groups/all',   to: 'groups#all'
  get 'groups/alln',   to: 'groups#alln'
  get 'groups/:id',        to: 'groups#showgrp'

#  get 'pharmacies/all(:id)',   to: 'pharmacies#all'

  get 'prod_exp/all',   to: 'special_offer#getSpecialOffer'
  post 'offers',to: 'special_offer#getOffersFromApt'

#  post 'makeinv/:invoice',   to: 'makeinv#all'
  post 'makeinv',   to: 'makeinv#all'
  post 'getinvoice',        to: 'getinvoice#showinv'
  post 'getinvoice/detail',        to: 'getinvoice#showdetailinvoice'
  #site
   get  'getinvoice/(:fltr)/showall', to: 'getinvoice#index' , as: :invoice
   get  'getinvoice/:id/edit', to: 'getinvoice#edit', as: :edit_invoice
   post  'getinvoice/change/:id', to: 'getinvoice#change'
  #resources :getinvoice

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
