module Api
  module V0
    class ReadingCollectionsController < ApiController
      def create
        reading_collection = current_user.reading_collections.create(collection_params)
        articles = reading_collection.get_articles
        reading_collection.articles << articles
      end

      private

      def collection_params
        params.permit(:name, tag_list: [])
      end
    end
  end
end
