Rails.application.routes.draw do
  resources :webhooks, only: %i(create), path: 'webhooks/:token'
  match 'webhooks/:token' => 'webhooks#show', via: :head
  root 'welcome#index'
end
