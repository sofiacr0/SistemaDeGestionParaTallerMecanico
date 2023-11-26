from flask import Flask, render_template, request, jsonify
import pymysql

app = Flask(__name__)

# Configuración de la conexión a la base de datos
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'root',
    'database': 'TallerMecanico',
    'charset': 'utf8mb4'
}

# Función para obtener una conexión a la base de datos


def get_db_connection():
    return pymysql.connect(**db_config)

# ESTO SE VA A ELIMINAR, SOLO ES PARA TENER TODAS LAS PAGINAS A LA MANO Y CHECARLAS MAS RAPIDO


@app.route('/')
def test():
    return render_template('test.html')

# LOGIN
@app.route('/login')
def home():
    return render_template('login.html')

# PANEL DE CONTROL


@app.route('/paneldecontrol')
def paneldecontrol():
    return render_template('paneldecontrol.html')

# SISTEMA DE GESTIÓN DE INVENTARIO

@app.route('/inventario', methods = ['GET', 'POST'])
def inventario():
    # OBTENER TABLA
    if request.method == 'GET':
        connection = None  
        try:
            connection = get_db_connection()
            with connection.cursor() as cursor:
                cursor.execute('SELECT * FROM PIEZA')
                result = cursor.fetchall()
        except Exception as e:
            print(f"Error en la base de datos: {e}")
            result = None
        finally:
            if connection:
                connection.close()
            return render_template('inventario.html', data=result)
     
    # AÑADIR ARTICULO
    # ACTUALIZAR ARTICULO
    # ELIMINAR ARTICULO

# SISTEMA DE GESTIÓN DE CITAS


@app.route('/citas', methods=['GET', 'POST', 'PUT', 'DELETE'])
def citas():
    # OBTIENE REGISTROS
    if request.method == 'GET':
        connection = None

        try:
            connection = get_db_connection()
            with connection.cursor() as cursor:
                cursor.execute('SELECT * FROM vista_citas')
                result = cursor.fetchall()
        except Exception as e:
            print(f"Error en la base de datos: {e}")
            result = None
        finally:
            if connection:
                connection.close()
            return render_template('citas.html', data=result)

    # AÑADE REGISTROS
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
            response = {'status': 'success',
                        'message': 'Registro insertado correctamente'}
        except Exception as e:
            connection.rollback()
            response = {'status': 'error',
                        'message': f'Error al insertar el registro: {str(e)}'}
        finally:
            connection.close()
        return jsonify(response)

    # ACTUALIZA REGISTROS
    if request.method == 'PUT':
        IDCita = request.form['IDCita']
        IDCliente = request.form['IDCliente']
        FechaEntrada = request.form['FechaEntrada']
        FechaSalida = request.form['FechaSalida']
        IDServicio = request.form['IDServicio']
        IDEmpleado = request.form['IDEmpleado']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "UPDATE CITA SET IDCliente=%s, FechaEntrada=%s, FechaSalida=%s, IDServicio=%s, IDEmpleado=%s WHERE IDCita=%s"
                cursor.execute(sql, (IDCliente, FechaEntrada,
                            FechaSalida, IDServicio, IDEmpleado, IDCita))

            connection.commit()
            response = {'status': 'success',
                        'message': 'Registro actualizado correctamente'}
        except Exception as e:
            connection.rollback()
            response = {'status': 'error',
                        'message': f'Error al actualizar el registro: {str(e)}'}
        finally:
            connection.close()
        return jsonify(response)

    # ELIMINA REGISTROS
    if request.method == 'DELETE':
        IDCita = request.form['IDCita']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "DELETE FROM CITA WHERE IDCita = %s"
                cursor.execute(sql, (IDCita,))

            connection.commit()
            response = {'status': 'success',
                        'message': 'Registro eliminado correctamente'}
        except Exception as e:
            connection.rollback()
            response = {'status': 'error',
                        'message': f'Error al eliminar el registro: {str(e)}'}
        finally:
            connection.close()
        return jsonify(response)

# SISTEMA DE GESTIÓN DE EMPLEADOS


@app.route('/empleados')
def empleados():
    # OBTIENE REGISTROS
    if request.method == 'GET':
        connection = None

        try:
            connection = get_db_connection()
            with connection.cursor() as cursor:
                cursor.execute('SELECT * FROM EMPLEADO')
                result = cursor.fetchall()
        except Exception as e:
            print(f"Error en la base de datos: {e}")
            result = None
        finally:
            if connection:
                connection.close()
            return render_template('empleados.html', data=result)

# SISTEMA DE GESTIÓN DE CLIENTES


@app.route('/clientes')
def clientes():
    # OBTIENE REGISTROS
    if request.method == 'GET':
        connection = None

        try:
            connection = get_db_connection()
            with connection.cursor() as cursor:
                cursor.execute('SELECT * FROM vista_clientes')
                result = cursor.fetchall()
        except Exception as e:
            print(f"Error en la base de datos: {e}")
            result = None
        finally:
            if connection:
                connection.close()
            return render_template('clientes.html', data=result)

# SISTEMA DE GESTIÓN DE VEHICULOS


@app.route('/vehiculos')
def vehiculos():
    # OBTIENE REGISTROS
    if request.method == 'GET':
        connection = None

        try:
            connection = get_db_connection()
            with connection.cursor() as cursor:
                cursor.execute('SELECT * FROM VEHICULO')
                result = cursor.fetchall()
        except Exception as e:
            print(f"Error en la base de datos: {e}")
            result = None
        finally:
            if connection:
                connection.close()
            return render_template('vehiculos.html', data=result)

# SISTEMA DE GESTIÓN DE SERVICIOS


@app.route('/servicios')
def servicios():
    # OBTIENE REGISTROS
    if request.method == 'GET':
        connection = None

        try:
            connection = get_db_connection()
            with connection.cursor() as cursor:
                cursor.execute('SELECT * FROM SERVICIO')
                result = cursor.fetchall()
        except Exception as e:
            print(f"Error en la base de datos: {e}")
            result = None
        finally:
            if connection:
                connection.close()
            return render_template('servicios.html', data=result)


if __name__ == '__main__':
    app.run(debug=True)
