class UsersAPI < Grape::API
  before do
    authenticate!
  end

  resource :users do
    desc 'Index'
    get do
      User.select(:email, :id, :username).limit(20)
    end

    desc 'Show'
    params do
      requires :id, type: Integer, desc: 'User id'
    end
    route_param :id do
      get do
        User.select(:email, :id, :username).find(params[:id])
      end
    end
  end
end
