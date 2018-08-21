Rails.application.routes.draw do

  devise_for :users, skip: [ :registrations ]

  root 'organizations#index'

  resources :registrations, only: [ :new, :create ] do
    collection do 
      get 'by_invite'
      post 'register_from_invite'
    end
  end

  resources :organizations do
    resources :settings
    resources :subscriptions, only: [ :new, :create ] do
      collection do
        delete 'cancel'
        get 'edit'
        post 'update'
      end
    end
    member do
      get 'experiences'
      get 'shadowers'
      get 'persons'
      get 'places'
      get 'place_groups'
      get 'person_groups'
      delete 'remove_shadower/:user_id', to: 'organizations#remove_shadower', as: 'remove_shadower'
    end
  end

  resources :experiences do
    member do
      post 'clone'
    end
    resources :shadowers
    resources :reports
    resources :segments do 
      member do
        get 'persons'
        get 'places'
        get 'shadowers'
      end
    end
  end
  
  resources :segments, only: [] do
    member do 
      post 'create_reference'
      patch 'clone'
      post 'bulk_add_existing_references'
      delete 'remove_reference/:reference_id', to: 'segments#remove_reference', as: 'remove_reference'
    end
    resources :notes do 
      collection do 
        post 'create_person_place'
      end
    end
  end

  resources :invites
  resources :persons
  resources :places
  resources :admin, only: [:index]
  resources :person_groups, only: [:update]
  resources :place_groups, only: [:update]
  resources :email_reports, only: [:create]
  resources :groups, only: [:create, :destroy] do
    member do
      delete 'remove_reference/:reference_id', to: 'groups#remove_reference', as: 'remove_reference'
    end
    collection do
      post 'add_references'
    end
  end
  resources :users, only: [:edit, :update] do 
    collection do 
      get 'edit_password'
      post 'update_password'
    end
  end

  # Searches
  get 'searches/experiences/:organization_id', to: 'searches#experiences', as: 'search_experiences'
  get 'searches/shadowers/:organization_id', to: 'searches#shadowers', as: 'search_shadowers'
  get 'searches/places/:organization_id', to: 'searches#places', as: 'search_places'
  get 'searches/persons/:organization_id', to: 'searches#persons', as: 'search_persons'
  get 'searches/organizations', to: 'searches#organizations', as: 'search_organizations'

  # Download Reports
  get 'reports/:report_id/open_report/', to: 'reports#open_report', as: 'open_report'

  # Update Note Status
  patch 'notes/:note_id/update_status/', to: 'notes#update_status'

  # Delete shadowers
  delete 'segment/:segment_id/shadowers/:user_id', to: 'segments#remove_shadower', as: 'remove_segment_shadower'
  delete 'experience/:experience_id/shadowers/:user_id', to: 'experiences#remove_shadower', as: 'remove_experience_shadower'
  delete 'organization/:organization_id/shadowers/:user_id', to: 'organizations#remove_shadower', as: 'remove_organization_shadower'

  # Update Segment Order
  patch 'update_segment_order/', to: 'segments#update_segment_order'

  # Update Segment Order
  patch 'transfer_coordinator/:organization_id', to: 'settings#transfer_coordinator'

  namespace :api do
    namespace :v1 do
      namespace :authentication do
        post 'login'
        post 'signup'
        post 'reset_password'
        get 'signed_in_user'
      end
      resources :segments, only: [:create, :update, :destroy]
      resources :notes, only: [:create, :update, :destroy]
      resources :experiences, only: [ :index, :create, :update, :destroy ]
      resources :references, only: [:index, :create]
      resources :organizations, only: [:index] do
        member do
          get  'experiences'
        end
      end
    end
  end
 
end