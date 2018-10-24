CarrierWave.configure do |config|
    config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: 'AKIAJMGU2QQFK6GS5WNQ',
        aws_secret_access_key: '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',
        region: 'ap-northeast-1'
    }

    if Rails.env.development?                                                                                                                   
        CarrierWave.configure do |config|
            config.cache_storage = :file
        end 
      elsif Rails.env.test?
        CarrierWave.configure do |config|
            config.cache_storage = :file
        end 
      else
        CarrierWave.configure do |config|
            config.fog_directory = 'muscle-share'
            config.cache_storage = :fog
        end 
    end
end