Rails.application.routes.draw do
	root 'words#index'
	get "/words/retry" => 'words#retry'
	get '/about' => 'static#about'
	get '/contact' => 'static#contact'
	resources :words
	resources :results
end

#      Prefix Verb   URI Pattern                 Controller#Action
#        root GET    /                           words#index
# words_retry GET    /words/retry(.:format)      words#retry
#       about GET    /about(.:format)            static#about
#     contact GET    /contact(.:format)          static#contact
#       words GET    /words(.:format)            words#index
#             POST   /words(.:format)            words#create
#    new_word GET    /words/new(.:format)        words#new
#   edit_word GET    /words/:id/edit(.:format)   words#edit
#        word GET    /words/:id(.:format)        words#show
#             PATCH  /words/:id(.:format)        words#update
#             PUT    /words/:id(.:format)        words#update
#             DELETE /words/:id(.:format)        words#destroy
#     results GET    /results(.:format)          results#index
#             POST   /results(.:format)          results#create
#  new_result GET    /results/new(.:format)      results#new
# edit_result GET    /results/:id/edit(.:format) results#edit
#      result GET    /results/:id(.:format)      results#show
#             PATCH  /results/:id(.:format)      results#update
#             PUT    /results/:id(.:format)      results#update
#             DELETE /results/:id(.:format)      results#destroy