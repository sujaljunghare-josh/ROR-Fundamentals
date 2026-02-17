Rails.application.routes.draw do
  # RESTful routes for Blogs and nested Comments
  resources :blogs do
    resources :comments, only: [:create, :destroy] # Shallow nesting often preferred
    
    # API to publish a blog (Member route adds /blogs/:id/publish)
    member do
      patch :publish
    end
  end
end