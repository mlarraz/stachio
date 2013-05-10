Rails.application.routes.draw do
  mount Stachio::Engine => "/"
  root :to => 'stachio#index'
end
