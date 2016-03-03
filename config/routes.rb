Rails.application.routes.draw do
  resources :webhooks, only: %i(create), path: 'webhooks/:token'
  root 'welcome#index'
end
