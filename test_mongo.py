# filepath: f:\End-to-End-Vehicle-Insurance-Project\test_mongo.py
# filepath: f:\End-to-End-Vehicle-Insurance-Project\test_mongo.py
import pymongo
from dotenv import load_dotenv
import os
load_dotenv()
url = os.getenv('MONGODB_URL')
client = pymongo.MongoClient(url, family=2)  # Force IPv4
try:
    client.admin.command('ping')
    print("Connection successful")
except Exception as e:
    print(f"Error: {e}")