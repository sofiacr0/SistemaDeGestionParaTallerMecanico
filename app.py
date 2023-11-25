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


@app.route('/citas', methods=['GET', 'POST', 'PUT', 'DELETE'])
def citas():

    # GET: Este método se utiliza para solicitar datos de un recurso específico. En Flask, se utiliza comúnmente para recuperar información del servidor.

    if request.method == 'GET':
        connection = None  # Initialize connection variable with None

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

    # POST: Este método se utiliza para enviar datos al servidor para ser procesados. Por lo general, se utiliza para enviar información confidencial como contraseñas o para enviar datos que serán procesados y almacenados en el servidor.

    if request.method == 'POST':
        IDCliente = request.form['IDCliente']
        FechaEntrada = request.form['FechaEntrada']
        FechaSalida = request.form['FechaSalida']
        IDServicio = request.form['IDServicio']
        IDEmpleado = request.form['IDEmpleado']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "INSERT INTO CITA (IDCliente, FechaEntrada, FechaSalida, IDServicio, IDEmpleado) VALUES (%s, %s, %s, %s, %s)"
                cursor.execute(sql, (IDCliente, FechaEntrada,
                               FechaSalida, IDServicio, IDEmpleado))
            connection.commit()
            mensaje = "Registro insertado correctamente"
        except Exception as e:
            connection.rollback()
            mensaje = "Error al insertar el registro: " + str(e)
        finally:
            connection.close()
        return mensaje

    # PUT: Se utiliza para actualizar un recurso en el servidor. En Flask, puede ser utilizado para modificar información existente en el servidor.

    # DELETE: Como su nombre indica, este método se utiliza para eliminar un recurso en el servidor.


if __name__ == '__main__':
    app.run(debug=True)
