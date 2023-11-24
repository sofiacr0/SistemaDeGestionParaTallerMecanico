from flask import Flask, render_template, request
import pymysql

app = Flask(__name__)

# Configuración de la base de datos (reemplaza los valores con los tuyos)
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'root',
    'database': 'TallerMecanico',
}
# Ruta para mostrar el formulario
@app.route('/')
def index():
    return render_template('formulario2.html')

# Ruta para procesar el formulario
@app.route('/procesar_formulario', methods=['POST'])
def procesar_formulario():
    IDCliente = request.form['IDCliente']
    FechaEntrada = request.form['FechaEntrada']
    FechaSalida = request.form['FechaSalida']
    Servicio = request.form['Servicio']
    Empleado = request.form['Empleado']

    # Conexión a la base de datos
    connection = pymysql.connect(**db_config)

    try:
        with connection.cursor() as cursor:
            # Realiza la inserción en la base de datos (reemplaza 'nombre_tabla' con el nombre de tu tabla)
            sql = "INSERT INTO CITA (IDCliente, FechaEntrada, FechaSalida, Servicio, Empleado) VALUES (%s, %s, %s, %s, %s)"
            cursor.execute(sql, (IDCliente, FechaEntrada, FechaSalida, Servicio, Empleado))
        
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
