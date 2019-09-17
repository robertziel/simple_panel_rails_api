class UsersAPI < Grape::API
  before do
    authenticate!
  end

  resource :users do
    include Grape::Kaminari

    desc 'Index' do
      headers ApiDescHelper.with_common_headers
    end
    paginate
    get do
      paginate(User.select(:email, :id, :username))
    end

    desc 'Show' do
      headers ApiDescHelper.with_common_headers
    end
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
