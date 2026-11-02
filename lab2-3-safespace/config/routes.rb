Rails.application.routes.draw do
  root "pages#home"

  get  "/what-is",      to: "pages#what_is",      as: :what_is
  get  "/law",          to: "pages#law",          as: :law
  get  "/enforcer",     to: "pages#enforcer",     as: :enforcer
  get  "/hotline",      to: "pages#hotline",      as: :hotline
  get  "/contact",      to: "pages#contact",      as: :contact
  get  "/safety-check", to: "pages#safety_check", as: :safety_check
  post "/contact",      to: "pages#send_message"
end
