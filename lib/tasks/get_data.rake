require "httparty"
require "json"

namespace :feature do
    desc 'Obtener datos sismológicos de la página earthquake.usgs.gov'

    task get_data: :environment do
        url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson"
        response = HTTParty.get(url)

        difference_minutes = 0.0

        if Feature.count != 0
            latest_created_at = Feature.order(created_at: :desc).first.created_at
            today = Time.now

            diference_seconds = today - latest_created_at
            difference_minutes = (diference_seconds / 60).to_i
        end

        if response.success? && difference_minutes > 60 || 
            response.success? && Feature.count == 0

            data_response = JSON.parse(response.body)
            features = data_response['features']

            # data = []

            features_filtered = features.select do |feature|
                feature['type'] == 'Feature' &&
                feature['properties']['place'] != nil &&
                feature['properties']['url'] != nil &&
                feature['properties']['magType'] != nil &&
                feature['properties']['title'] != nil &&
                feature['geometry']['coordinates'] != nil &&
                feature['properties']['mag'] >= -1.0 &&
                feature['properties']['mag'] <= 10.0 &&
                feature['geometry']['coordinates'].length > 0 &&
                feature['geometry']['coordinates'][0] >= -90.0 &&
                feature['geometry']['coordinates'][0] <= 90.0 &&
                feature['geometry']['coordinates'][1] >= -180.0 &&
                feature['geometry']['coordinates'][1] <= 180.0
            end

            features_filtered.each do |data|

                Feature.create(
                    feature_type: data['type'],
                    external_id: data['id'],
                    magnitude: data['properties']['mag'],
                    place: data['properties']['place'],
                    time: data['properties']['time'],
                    tsunami: data['properties']['tsunami'],
                    mag_type: data['properties']['magType'],
                    title: data['properties']['title'],
                    longitude: data['geometry']['coordinates'][0],
                    latitude: data['geometry']['coordinates'][1],
                    external_url: data['properties']['url']
                )

            end

            if features_filtered.length > 0
                puts "#{features_filtered.length} datos guardados en la base de datos"
                # Earthquake.delete_all
            end
        else
            puts "Si no se guardan los datos puede ser por dos factores:"
            puts "- No se pudo obtener información de la paǵina"
            puts '- Los datos se guardarán después de una hora'
            # puts earthquake.errors.full_messages
        end

    end

end