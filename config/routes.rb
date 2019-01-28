Rails.application.routes.draw do
  # get 'people/index'
  root "people#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post 'get_new_phone_number' => 'people#get_new_phone_number'
    end
  end
end
