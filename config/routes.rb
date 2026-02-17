Rails.application.routes.draw do
  resources :blogs do
    collection do
      get :drafts
    end

    resources :comments, only: [:create, :destroy]
    
    member do
      patch :publish
    end
  end
  
  # Optional: Set a root path so localhost:3000 actually goes somewhere!
  root "blogs#index"
end 