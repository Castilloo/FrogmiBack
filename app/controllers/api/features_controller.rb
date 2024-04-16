module Api
    class FeaturesController < ApplicationController
        def index
            features = Feature.order('created_at')
                .paginate(:page => params[:page], :per_page => params[:per_page])

            # puts "Página: #{features.current_page}"
            
            data = format(features)

            render :json => {
                :pagination => {
                    :current_page => features.current_page,
                    :total => features.total_entries,
                    :per_page => features.per_page
                },
                :data => data,
            }, :status => :ok
        end

        def show_by_mag_type
            mag_type = params[:magType]

            filtered_data = Feature.where('mag_type ILIKE ?', "%#{mag_type}%")
                .paginate(:page => params[:page], :per_page => params[:per_page])

            data = format(filtered_data)

            render json: {
                status: 'EXITOSO',
                message: 'Features data successfully',
                data: data
            }, status: :ok

        end

        private 
        def format(data)
            result = []

            data.each do |eq|
                dict = {
                    'id' => eq.id,
                    'type' => eq.feature_type,
                    'attributes' => {
                        'external_id' => eq.external_id,
                        'magnitude' => eq.magnitude,
                        'place' => eq.place,
                        'time' => eq.time,
                        'tsunami' => eq.tsunami,
                        'mag_type' => eq.mag_type,
                        'title' => eq.title,
                        'coordinates' => {
                            'longitude' => eq.longitude,
                            'latitude' => eq.latitude
                        }
                    },
                    'links': {
                        'external_url' => eq.external_url
                    }
                }

                result << dict
            end

            return result
        end
    end
end