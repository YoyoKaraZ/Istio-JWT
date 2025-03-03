from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/paris")
def paris():
    return render_template("city.html", city="Paris", image="paris.png")

@app.route("/londres")
def londres():
    return render_template("city.html", city="Londres", image="londres.png")

@app.route("/singapour")
def singapour():
    return render_template("city.html", city="Singapour", image="singapour.png")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

