Rails.application.routes.draw do
  get "/lines/:id", to: "lines#index"
end
