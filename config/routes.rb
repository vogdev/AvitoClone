Rails.application.routes.draw do

  devise_for :users
    resources :annonces do
    	 collection do
    	  get 'search'
    	  get 'myannonces'
    end
   end

    root to: "annonces#index"
end
