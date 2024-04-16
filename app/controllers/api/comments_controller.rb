module Api
    class CommentsController < ApplicationController
        before_action :parse_request, only: [:create]

        def index
            feature_id = params[:feature_id]

            puts feature_id

            comments = Comment.where(feature_id: feature_id)

            puts comments

            render :json => { :data => comments }, :status => :ok
        end

        # POST /api/features/:feature_id/comments
        def create
            # @comment = @feature.comment.build(comment_params) 
            json_params = @request_payload
            feature_id = json_params['feature_id']
            comment = json_params['comment']

            @comment = Comment.new(
                :feature_id => feature_id,
                :description => comment.strip
            )

            if @comment.save && @comment[:description].length > 0
                render :json => { :data => @comment }, :status => :created
            else 
                render :json => @comment.errors, :status => :unprocessable_entity
            end

        end

        def parse_request
            @request_payload = JSON.parse(request.body.read)
        end
    end
end
