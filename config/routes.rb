# frozen_string_literal: true

Rails.application.routes.draw do
  resources :boards, only: [:index, :show, :new, :create]

  root 'boards#new'

  resources :recent_boards, only: [:index]
end
