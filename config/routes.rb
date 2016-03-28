Rails.application.routes.draw do
 root 'words#index'
 resources :words
end

#    Prefix Verb   URI Pattern               Controller#Action
#      root GET    /                         words#index
#     words GET    /words(.:format)          words#index
#           POST   /words(.:format)          words#create
#  new_word GET    /words/new(.:format)      words#new
# edit_word GET    /words/:id/edit(.:format) words#edit
#      word GET    /words/:id(.:format)      words#show
#           PATCH  /words/:id(.:format)      words#update
#           PUT    /words/:id(.:format)      words#update
#           DELETE /words/:id(.:format)      words#destroy