Rails.application.routes.draw do
  # API定义
  namespace :api, defaults: {format: :json} do
    namespace :v1 do

    end
  end
end
