defmodule HelloVersionWeb.Router do
  use HelloVersionWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HelloVersionWeb, as: :api do
    pipe_through :api

    resources "/quotations", QuotationController, except: [:new, :edit, :delete]

    scope "/t", Api.T, as: :t do
      resources "/quotations", QuotationController, except: [:new, :edit]
    end
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:hello_version, :dev_routes) do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
