from flask import Flask, jsonify

app = Flask(__name__)

# Data for cities
CITIES = {
    "paris": {"name": "Paris", "image": "/static/paris.jpg"},
    "londres": {"name": "Londres", "image": "/static/londres.jpg"},
    "singapour": {"name": "Singapour", "image": "/static/singapour.jpg"},
}

@app.route("/")
def home():
    return jsonify({"message": "Bienvenue sur l'API Backend !"})

@app.route("/cities")
def get_cities():
    return jsonify(CITIES)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
