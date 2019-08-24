module API
  class Base < Grape::API
    mount Welcome
  end
end
