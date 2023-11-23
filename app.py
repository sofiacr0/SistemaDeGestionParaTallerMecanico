from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('login.html')

@app.route('/paneldecontrol')
def paneldecontrol():
    return render_template('paneldecontrol.html')

@app.route('/inventario')
def inventario():
    return render_template('inventario.html')

@app.route('/citas')
def citas():
    return render_template('citas.html')

if __name__ == '__main__':
    app.run(debug=True)
