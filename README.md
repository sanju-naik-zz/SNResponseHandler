SNResponseHandler
=================

Avoid iOS mobile app crash due to Invalid response from server by using SNResponseHandler 


INTRODUCTION : 

	Are you sure that your server always returns valid response in Production environment ? might fail sometimes & cause mobile app to crash isn't it? So we need to have someone to take care of it from client side (mobile app).. So here you go.

"SNResponseHandler".. Before saving/parsing any response from server check whether its valid by calling "isSuccessResponse:" on "SNResponseHandler",It iterates through response, finds if there are any nil values for keys if so it reports with alert, avoids your app from crashing,Its powerful enough to parse any complex responses.

USAGE :

	You can use this with JSON server, Add SNResponseHandler class files into your Project . then import SNResponseHandler.h into your class where you parse response from server, In your method iterate through response until you go to a structure where in it matches with your data model, then send that structure(Dictionary) to "isSuccessResponse:" then on it takes care.

In Demo app, I am demonstrating with a saved response structure,Library data from parse & adding user details to it with Facebook login. 
