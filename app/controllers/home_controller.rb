class HomeController < ApplicationController





  def index

    
    
    if request.url.include? 'code'
        code = request.url.split('=')[1]

        curlData = %x(curl -F 'client_secret=YfjAc4yl8VySjCd6_340udurzSS5YV-NTkxO5OgV' -F 'client_id=Klrxf7izFQ7wPvXZkW5O-kiv6W2Wg8qS'  -F 'grant_type=authorization_code'  -F 'redirect_uri=http://localhost:3000/home/index'  -F 'code=#{code}' https://login.uber.com/oauth/v2/token)

        p curlData

        data = JSON.parse(curlData)
        if data['access_token']
            p "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
            UserInfo.create({
                last_authenticated: data['last_authenticated'],
                token:              data['access_token'],
                refresh_token:      data['refresh_token'],
                expires_in:         data['expires_in'],
                scope:              data['scope'],
                token_type:         data['token_type'],
            })

            userData = %x(curl -H "Authorization: Bearer #{data['access_token']}" -H 'Accept-Language: en_US' -H 'Content-Type: application/json' 'https://api.uber.com/v1.2/me')
            userData = JSON.parse(userData)

            if userData['rider_id']
                p "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                @user = UserInfo.find_by_token(data['access_token'])
                @user.update_attributes({
                rider_id:        userData['rider_id'],
                picture:         userData['picture'],
                first_name:      userData['first_name'],
                last_name:       userData['last_name'],
                promo_code:      userData['promo_code'],
                email:           userData['email'],
                mobile_verified: userData['mobile_verified'],
                uuid:            userData['uuid'] })
            end
        end
    end
  end
end
