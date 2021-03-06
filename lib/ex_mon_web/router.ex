defmodule ExMonWeb.Router do
  use ExMonWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExMonWeb do
    pipe_through :api
  end


  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ExMonWeb.Telemetry
    end
  end

  scope "/", ExMonWeb do
    pipe_through :api

    get "/", WelcomeController, :index
    resources "/trainers", TrainersController, only: [:create, :show, :delete, :update]
  end
end
