Rails.application.routes.draw do
  namespace 'api' do
      resources :features, only: [:index] do
        get 'show_by_mag_type', on: :collection
        resources :comments, only: [:create, :index]
    end
  end
end
