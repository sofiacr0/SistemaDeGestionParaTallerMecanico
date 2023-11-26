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
@app.route('/inventario', methods=['GET', 'POST', 'PUT', 'DELETE'])
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
    if request.method == 'POST':
        Nombre = request.form['Nombre']
        CantidadEnStock = request.form['CantidadEnStock']
        FechaAdquisicion = request.form['FechaAdquisicion']
        PrecioCompra = request.form['PrecioCompra']
        PrecioVenta = request.form['PrecioVenta']
        IDProveedor = request.form['IDProveedor']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "INSERT INTO PIEZA (Nombre, CantidadEnStock, FechaAdquisicion, PrecioCompra, PrecioVenta, IDProveedor) VALUES (%s, %s, %s, %s, %s, %s)"
                cursor.execute(sql, (Nombre, CantidadEnStock,
                               FechaAdquisicion, PrecioCompra, PrecioVenta, IDProveedor))
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

    # ACTUALIZAR ARTICULO
    if request.method == 'PUT':
        IDPieza = request.form['IDPieza']
        Nombre = request.form['Nombre']
        CantidadEnStock = request.form['CantidadEnStock']
        FechaAdquisicion = request.form['FechaAdquisicion']
        PrecioCompra = request.form['PrecioCompra']
        PrecioVenta = request.form['PrecioVenta']
        IDProveedor = request.form['IDProveedor']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "UPDATE PIEZA SET Nombre=%s, CantidadEnStock=%s, FechaAdquisicion=%s, PrecioCompra=%s, PrecioVenta=%s, IDProveedor=%s WHERE IDPieza=%s"
                cursor.execute(sql, (IDPieza, Nombre, CantidadEnStock, 
                                     FechaAdquisicion, PrecioCompra, PrecioVenta, IDProveedor))

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

    # ELIMINAR ARTICULO
    if request.method == 'DELETE':
        IDPieza = request.form['IDPieza']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "DELETE FROM PIEZA WHERE IDPieza = %s"
                cursor.execute(sql, (IDPieza))

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


# SISTEMA DE GESTIÓN DE CITAS
@app.route('/citas', methods=['GET', 'POST', 'PUT', 'DELETE'])
def citas():
    # OBTIENE REGISTROS
    if request.method == 'GET':
        pass

    # AÑADE REGISTROS
    if request.method == 'POST':
        pass

    # ACTUALIZA REGISTROS
    if request.method == 'PUT':
        pass

    # ELIMINA REGISTROS
    if request.method == 'DELETE':
        pass


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
@app.route('/clientes', methods=['GET', 'POST', 'PUT', 'DELETE'])
def clientes():
    # OBTIENE REGISTROS
    if request.method == 'GET':
        pass

    # AÑADE REGISTROS
    if request.method == 'POST':
        pass

    # ACTUALIZA REGISTROS
    if request.method == 'PUT':
        pass

    # ELIMINA REGISTROS
    if request.method == 'DELETE':
        pass


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
