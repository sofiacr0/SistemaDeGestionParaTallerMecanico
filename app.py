from flask import Flask, render_template
import pymysql

app = Flask(__name__)

# Configuración de la conexión a la base de datos
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'root',
    'database': 'TallerMecanico',
}

# Función para obtener una conexión a la base de datos
def get_db_connection():
    return pymysql.connect(**db_config)


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
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            cursor.execute('SELECT * FROM CITA')
            result = cursor.fetchall()

    except Exception as e:
        print(f"Error en la base de datos: {e}")
        result = None  # Si hay un error, establece result en None

    finally:
        if connection:
            connection.close()

    return render_template('citas.html', data=result)

if __name__ == '__main__':
    app.run(debug=True)
