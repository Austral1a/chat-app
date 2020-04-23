Rails.application.routes.draw do
  get 'login', to: 'session#new'
end
