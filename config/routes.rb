IndigenousLiteracyFoundation::Application.routes.draw do

  root :to => "dashboard#index"

  get 'dashboard' => 'dashboard#index'
  
  resources :excitement_pages do
    resources :testimonials
    resources :community_sections
    member do
      get 'email_list'
      post 'send_email'
      get 'show_image'
    end
    resources :books    
  end

  resources :communities
  resources :photos do
      member do
      get 'show_image'
    end
  end

  get 'community_profiles/load_communities' => 'community_profiles#load_communities'
  resources :community_profiles
end
