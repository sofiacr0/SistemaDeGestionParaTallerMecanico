from flask import Flask, render_template, request
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


@app.route('/citas', methods=['GET', 'POST'])
def citas():
    if request.method == 'GET':
        try:
            connection = get_db_connection()
            with connection.cursor() as cursor:
                cursor.execute('SELECT * FROM CITA')
                result = cursor.fetchall()

        except Exception as e:
            print(f"Error en la base de datos: {e}")
            result = None 

        finally:
            if connection:
                connection.close()
            return render_template('citas.html', data=result)
        
    if request.method == 'POST':
        IDCliente = request.form['IDCliente']
        FechaEntrada = request.form['FechaEntrada']
        FechaSalida = request.form['FechaSalida']
        IDServicio = request.form['IDServicio']
        IDEmpleado = request.form['IDEmpleado']

        # Conexión a la base de datos
        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                # Realiza la inserción en la base de datos (reemplaza 'nombre_tabla' con el nombre de tu tabla)
                sql = "INSERT INTO CITA (IDCliente, FechaEntrada, FechaSalida, IDServicio, IDEmpleado) VALUES (%s, %s, %s, %s, %s)"
                cursor.execute(sql, (IDCliente, FechaEntrada, FechaSalida, IDServicio, IDEmpleado))

            # Commit para aplicar los cambios
            connection.commit()

            mensaje = "Registro insertado correctamente"
        except Exception as e:
            # Si hay algún error, se hace rollback
            connection.rollback()
            mensaje = "Error al insertar el registro: " + str(e)
        finally:
            # Cierra la conexión
            connection.close()

        return mensaje

if __name__ == '__main__':
    app.run(debug=True)
