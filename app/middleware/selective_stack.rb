class SelectiveStack
  def initialize(app)
    @app = app
  end

  def call(env)
    if env["PATH_INFO"].start_with?("/admin")
      middleware_stack.build(@app).call(env)
    else
      @app.call(env)
    end
  end

private
  def middleware_stack
    @middleware_stack ||= begin
      ActionDispatch::MiddlewareStack.new.tap do |middleware|
        middleware.use Rack::MethodOverride
        middleware.use ActionDispatch::Flash
        middleware.use ActionDispatch::Cookies
        middleware.use ActionDispatch::Session::CookieStore
      end
    end
  end
end