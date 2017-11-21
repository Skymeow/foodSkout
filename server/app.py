from flask import Flask, request, make_response
from flask_restful import Resource, Api
from pymongo import MongoClient
from utils.mongo_json_encoder import JSONEncoder
import bcrypt
from bson.json_util import dumps
import json
import pdb
# import User


app = Flask(__name__)
# app.config.from_pyfile('config.cfg')
mongo = MongoClient('localhost', 27017)
# mongo = MongoClient(app.config['MONGODB_URI'])
# app.db = mongo.trip_planner_development
app.db = mongo.foodskout
app.bcrypt_rounds = 12
api = Api(app)


def auth_validation(email, user_password):
    # Find user by email
    user_col = app.db.users
    database_user = user_col.find_one({'email': email})
    if database_user is None:
        return({"error": "email not found"}, 404, None)
    db_password = database_user.get('password')
    user_id = database_user["_id"]

    password = user_password.encode('utf-8')
    # pdb.set_trace()
    # Check if client password from login matches database password
    if bcrypt.hashpw(password, db_password) == db_password:
        # Let them in
        return (user_id, 200, None)
    return (None, 400, None)


def auth_function(func):
    def wrapper(*args, **kwargs):
        auth = request.authorization
        print(auth)
        validation = auth_validation(auth.username, auth.password)
        if validation[1] is 400 or validation[1] is 404:
            return (
                    'Could not verify your access level for that URL.\n'
                    'You have to login with proper credentials', 401,
                    {'Authentication': 'Basic base64"'}
                   )
        else:
            return func(*args, validation[0], **kwargs)
    return wrapper

# Write Resources here
class User(Resource):

    def post(self):
        user_col = app.db.users
        json = request.json
        if 'username' in json and 'email' in json and 'password' in json:
            user = user_col.find_one({
                'email': json['email']
            })
            if user:
                return ({'error': 'user already exists'}, 409, None)

            encoded_password = json['password'].encode('utf-8')
            app.bcrypt_rounds = 12

            hashed = bcrypt.hashpw(
                encoded_password, bcrypt.gensalt(app.bcrypt_rounds)
            )

            json['password'] = hashed
            app.db.users.insert_one(json)
            json.pop('password')
            return (json, 201, None)
        elif 'username' in json and 'password' in json:
                return ({'error': 'no email was specified'}, 400, None)
        elif 'username' not in json or 'email' not in json or 'password' not in json:
                return ({'error': 'missing fields'}, 400, None)
        else:
            print("no se posteo na")
            return (None, 400, "Hola negro que pajo?")

    @auth_function
    def get(self, user_id):
        user_collection = app.db.users
        user = user_collection.find_one({"_id": user_id})
        user.pop('password')
        return(user, 200, None)

    @auth_function
    def put(self, user_id):
        user_email = request.args.get('email')
        username = request.json.get('username')
        json = request.json

        if user_email is None:
            return ({'error': 'no specified email for user'}, 404, None)

        user_col = app.db.users

        user = user_col.find_one({
            'email': user_email
        })

        if user is not None:
            if 'username' in json:
                user['username'] = username

            if 'email' in json:
                user['email'] = json['email']
            user_col.save(user)

            user.pop('password')
            return (user, 200, None)

        return ({'error': 'no user with that email found'}, 404, None)

    @auth_function
    def delete(self, user_id):
        user_col = app.db.users
        email = request.args.get('email')
        user_to_delete = user_col.find_one({
            'email': email
        })
        if user_to_delete is None:
            return ({'error': 'User with email ' + email + " does not exist"}, 404, None)

        user_col.remove(user_to_delete)
        return ({'deleted': 'User with email ' + email + " has been deleted"}, 200, None)


class Organ(Resource):

    # @auth_function
    def get(self):
        """Get an organ. If no parameter was specified, then get all organs"""
        args = request.args
        organs_col = app.db.organs

        # if 'destination' in args or 'start_date' in args:
        #     trip_destination = args.get('destination')
        #     trip_start_date = args.get('start_date')
        #     trip = organs_col.find_one({
        #         'destination': trip_destination
        #     })
        #     if trip is None:
        #         return ({'error': 'no trip found'}, 404, None)
        #
        #     return (trip, 200, None)

        # print(user_id)
        organs = organs_col.find()
        # organs = organs_col.find({"user_id": user_id})
        organs = json.loads(dumps(organs))
        print(organs)
        return (organs, 200, None)

    # @auth_function
    def post(self):
        organs_col = app.db.organs
        json = request.json
        print(json)

        # if ('destination' not in json
        # or 'start_date' not in json
        # or user_id is None):
        #     return ({'error': 'missing required fields'}, 400, None)
        # else:
        #     json['user_id'] = user_id
        organs_col.insert_one(json)
        return (json, 201, None)
    #
    # @auth_function
    # def put(self, user_id):
    #     args = request.args
    #     json = request.json
    #     organs_col = app.db.organs
    #
    #     trip_destination = json.get('destination') if json.get('destination') else None
    #     trip_start_date = args.get('start_date') if args.get('start_date') else None
    #     print(json)
    #     print(args)
    #     trip = organs_col.find_one({
    #         'destination': trip_destination
    #     })
    #
    #     if json.get('waypoints'):
    #         waypoints = json.get('waypoints')
    #
    #         if waypoints[0].get('destination') is None:
    #             return (
    #                 {'error': 'Updating/Adding a waypoint without specifying destination'},
    #                 403,
    #                 None
    #                 )
    #         location = waypoints[0].get('location')
    #         if location.get('latitude') is None or location.get('longitude') is None:
    #             return (
    #                 {'error': 'latitude or longitude is missing for the waypoint'},
    #                 403,
    #                 None
    #                 )
    #
    #     if trip is not None:
    #         if 'destination' in json:
    #             trip['destination'] = json['destination']
    #
    #         if 'start_date' in json:
    #             trip['start_date'] = json['start_date']
    #
    #         if 'completed' in json:
    #             trip['completed'] = json['completed']
    #
    #         organs_col.save(trip)
    #         return (trip, 200, None)
    #
    #     return ({'error': 'no trip with that destination found'}, 404, None)
    #
    # @auth_function
    # def delete(self, id):
    #     args = request.args
    #     trip_id = args.get('_id') if args.get('_id') else None
    #
    #     if trip_id is None:
    #         return({'error': 'trip with id does not exist'}, 404, None)
    #
    #     organs_col = app.db.organs
    #     organs_col.delete_one({'_id': trip_id})
    #     return(None, 200, None)


# Add api routes here
# api.add_resource(User, '/users')
api.add_resource(Organ, '/organs')


#  Custom JSON serializer for flask_restful
@api.representation('application/json')
def output_json(data, code, headers=None):
    resp = make_response(JSONEncoder().encode(data), code)
    resp.headers.extend(headers or {})
    return resp

if __name__ == '__main__':
    # Turn this on in debug mode to get detailled information about request
    # related exceptions: http://flask.pocoo.org/docs/0.10/config/
    app.config['TRAP_BAD_REQUEST_ERRORS'] = True
    app.run()
