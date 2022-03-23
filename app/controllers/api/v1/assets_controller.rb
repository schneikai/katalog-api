module Api
  module V1
    class AssetsController < ActionController::API
      before_action :authenticate_user!

      # GET /api/v1/assets
      def index
        @assets = Asset.where(user: current_user)
      end
    end
  end
end
