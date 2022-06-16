Rails.application.routes.draw do
  get "/lines/:index", to: "lines#index"
end
