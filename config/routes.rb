Rails.application.routes.draw do
 root 'words#index'
 get "/words/test" => 'words#test'
 get "/words/retry" => 'words#retry'
 resources :words do
 	resources :results
 end
 resources :results
end

#           Prefix Verb   URI Pattern                                Controller#Action
#             root GET    /                                          words#index
#       words_test GET    /words/test(.:format)                      words#test
#      words_retry GET    /words/retry(.:format)                     words#retry
#     word_results GET    /words/:word_id/results(.:format)          results#index
#                  POST   /words/:word_id/results(.:format)          results#create
#  new_word_result GET    /words/:word_id/results/new(.:format)      results#new
# edit_word_result GET    /words/:word_id/results/:id/edit(.:format) results#edit
#      word_result GET    /words/:word_id/results/:id(.:format)      results#show
#                  PATCH  /words/:word_id/results/:id(.:format)      results#update
#                  PUT    /words/:word_id/results/:id(.:format)      results#update
#                  DELETE /words/:word_id/results/:id(.:format)      results#destroy
#            words GET    /words(.:format)                           words#index
#                  POST   /words(.:format)                           words#create
#         new_word GET    /words/new(.:format)                       words#new
#        edit_word GET    /words/:id/edit(.:format)                  words#edit
#             word GET    /words/:id(.:format)                       words#show
#                  PATCH  /words/:id(.:format)                       words#update
#                  PUT    /words/:id(.:format)                       words#update
#                  DELETE /words/:id(.:format)                       words#destroy
#          results GET    /results(.:format)                         results#index
#                  POST   /results(.:format)                         results#create
#       new_result GET    /results/new(.:format)                     results#new
#      edit_result GET    /results/:id/edit(.:format)                results#edit
#           result GET    /results/:id(.:format)                     results#show
#                  PATCH  /results/:id(.:format)                     results#update
#                  PUT    /results/:id(.:format)                     results#update
#                  DELETE /results/:id(.:format)                     results#destroy