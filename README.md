# red\_haze - SoundCloud API gem
This is an unofficial Ruby gem for the Soundcloud API. It is OO and provides you with some nice objects with convenient methods. **All "☁" links point to the official SoundCloud documenation for that object.** Get hacking.


##Installation
`gem install red_haze` or add `gem 'red_haze'` to your bundle file
##Configuration
**RedHaze must be configured before use.** The following arguments can be provided to `RedHaze.configure(<ARGS>)`

|Arguments                                                                             |Usage                                                |
|:-----------                                                                          |:-----------                                         |
|`client_id: <CLIENT_ID>`                                                              |General, unauthenticated calls. _Minimum requirement_|
|`access_token: <ACCESS_TOKEN>`                                                        |Authenticated calls. Gives access to `Me`            |
|`client_id: <CLIENT_ID>,`<br> `client_secret: <CLIENT_SECRET>,`<br> `redirect_uri: <REDIRECT_URI>` | Required when requested/refreshing access tokens (see below) |

Alternatively, you can create a `config.yml` file (_see the config.yml.template_) to load a hash of these settings and use `RedHaze.configure_from_file('<FILE_NAME>')`

To sign up for a developer account and receive a `client_id` [go here](http://soundcloud.com/you/apps) 

###OAuth
After configuring RedHaze with the required attributes, hit the `RedHaze.authorize_url`. At your `redirect_uri`, pass the `code` parameter to `RedHaze.client.get_token_from_code(<CODE>)` and you'll be ready to make authenticated requests.

<hr>

##[☁](http://developers.soundcloud.com/docs/api/reference#users)User
Initialized via `RedHaze.user(<USER_ID>)`.

|Method       |Description                |
|:----------- |:-----------               |
|`.followings`|`Users` this user is following  |
|`.followers` |`Users` following this user|
|`.comments`  |user's `Comments`          |
|`.tracks`    |user's `Tracks`            |
|`.favorites` |user's favorite `Tracks`   |
|`.groups`    |user's `Groups`            |
|`.playlists` |user's `Playlists`         |


##[☁](http://developers.soundcloud.com/docs/api/reference#me)Me
Requires valid access token. Subclass of `User`. Access via `RedHaze.me`.

|Method            |Description                                               |
|:-----------      |:-----------                                              |
|`.activities`     |`Collection` of dashboard activities                      |
|`.follow!(arg)`   |Follows a given `User` or `user_id`                       |
|`.unfollow!(arg)` |Unfollows a given `User` or `user_id`                     |
|`.follows?(arg)`  |Checks if user follows a given `User` or `user_id`        |
|`.favorite!(arg)` |Favorites a given `Track` or `track_id`                   |
|`.unfavorite!(arg)`|Unfavorites a given `Track` or `track_id`                |
|`.favorite?!(arg)`|Checks if user has favorited a given `Track` or `track_id`|

<hr>

##[☁](http://developers.soundcloud.com/docs/api/reference#tracks)Track
Access via `RedHaze.track(<TRACK_ID>)`.

|Method       |Description                         |
|:----------- |:-----------                        |
|`.favoriters`|`Users` who have favorited track    |
|`.comments`  |`Comments` on track                 |
|`.shared_to`|`Users` who have access to the track|

<hr>

##[☁](http://developers.soundcloud.com/docs/api/reference#activities)Collection
Wrapper object returned from `Me#activities`. Returns a group of `activities` contained within the `items` attribute. Use `.next` to retrieve the next paginated `Collection`.

##[☁](http://developers.soundcloud.com/docs/api/reference#activities)Activity
Contained in `collection`. Links to an `origin` object.

<hr>

##[☁](http://developers.soundcloud.com/docs/api/reference#groups)Group
Access via `RedHaze.group(<GROUP_ID>)`.

|Method         |Description                  |
|:-----------   |:-----------                 |
|`.members`     |`Users` who have joined group|
|`.moderators`  |`Users` who are moderators   |
|`.contributors`|`Users` who have contributed |
|`.users`       |All of the above             |

<hr>

##[☁](http://developers.soundcloud.com/docs/api/reference#playlists)Playlist
Access via `RedHaze.Playlist(<PLAYLIST_ID>)`.

<hr>

##[☁](http://developers.soundcloud.com/docs/api/reference#comments)Comment
Access via `RedHaze.Comment(<COMMENT_ID>)`.

<hr>

#Contributing

Contributions via Issue/Bug reporting, Feature Requests, and Pull requests are encouraged. Please write tests (integrated if possible) for new features.
