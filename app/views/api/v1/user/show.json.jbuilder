json.(user, :id, :name, :uuid, :authentication_token)

json.partial!('api/v1/users/user', user: user) 