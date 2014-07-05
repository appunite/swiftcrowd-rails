json.(user, :id, :name, :birthdate, :uuid)
json.avatar_url user.avatar.url if user.avatar.url
json.twitter user.twitter if user.twitter
json.website user.website if user.website
json.facebook user.facebook if user.facebook
json.github user.github if user.github
json.birthdate user.birthdate if user.birthdate
