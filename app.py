from flask import Flask, render_template, request, jsonify, redirect, url_for
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


# LOGIN
@app.route('/', methods=['GET','POST'])
def login():
    if request.method == 'POST':
        try:
            # Obtén los datos del formulario
            username = request.form['username']
            password = request.form['password']

            # Realiza la validación (puedes cambiar esto según tus necesidades)
            if username == 'user' and password == 'user':
                # Redirige a la página de paneldecontrol.html
                return redirect(url_for('paneldecontrol'))
            else:
                # Maneja el caso de credenciales incorrectas (puedes personalizar este mensaje)
                return "Credenciales incorrectas"
        except KeyError:
            # Maneja el caso en el que las claves no estén presentes en la solicitud
            return "Datos de formulario incorrectos"  
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
                cursor.execute('SELECT * FROM vista_piezas')
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
                cursor.execute(sql, (Nombre, CantidadEnStock, FechaAdquisicion,
                               PrecioCompra, PrecioVenta, IDProveedor, IDPieza))

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
    # OBTENER REGISTROS
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

    # AÑADIR REGISTROS
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

    # ACTUALIZAR REGISTROS
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
                sql = "UPDATE CITA SET IDCliente=%s, FechaEntrada=%s, FechaSalida=%s, IDServicio=%s, IDEmpleado=%s WHERE IDCita=%s "
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

    # ELIMINAR REGISTROS
    if request.method == 'DELETE':
        IDCita = request.form['IDCita']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "DELETE FROM CITA WHERE IDCita = %s"
                cursor.execute(sql, (IDCita))

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
@app.route('/empleados', methods=['GET', 'POST', 'PUT', 'DELETE'])
def empleados():
    # OBTIENE REGISTROS
    if request.method == 'GET':
        connection = None
        try:
            connection = get_db_connection()
            with connection.cursor() as cursor:
                cursor.execute('SELECT * FROM vista_empleados')
                result = cursor.fetchall()
        except Exception as e:
            print(f"Error en la base de datos: {e}")
            result = None
        finally:
            if connection:
                connection.close()
            return render_template('empleados.html', data=result)
        
    # AÑADIR ARTICULO
    if request.method == 'POST':
        Nombre = request.form['Nombre']
        Apellido1 = request.form['Apellido1']
        Apellido2 = request.form['Apellido2']
        Telefono = request.form['Telefono']
        IDPuesto = request.form['IDPuesto']
        Estado = request.form['Estado']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "INSERT INTO EMPLEADO (Nombre, Apellido1, Apellido2, Telefono, IDPuesto, Estado) VALUES (%s, %s, %s, %s, %s, %s)"
                cursor.execute(sql, (Nombre, Apellido1,
                                Apellido2, Telefono, IDPuesto, Estado))
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
        IDEmpleado = request.form['IDEmpleado']
        Nombre = request.form['Nombre']
        Apellido1 = request.form['Apellido1']
        Apellido2 = request.form['Apellido2']
        Telefono = request.form['Telefono']
        IDPuesto = request.form['IDPuesto']
        Estado = request.form['Estado']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "UPDATE EMPLEADO SET Nombre=%s, Apellido1=%s, Apellido2=%s, Telefono=%s, IDPuesto=%s, Estado=%s WHERE IDEmpleado=%s"
                cursor.execute(sql, (Nombre, Apellido1, Apellido2,
                               Telefono, IDPuesto, Estado, IDEmpleado))

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
        IDEmpleado = request.form['IDEmpleado']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "DELETE FROM EMPLEADO WHERE IDEmpleado = %s"
                cursor.execute(sql, (IDEmpleado))

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


# SISTEMA DE GESTIÓN DE CLIENTES
@app.route('/clientes', methods=['GET', 'POST', 'PUT', 'DELETE'])
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

    # AÑADIR REGISTROS
    if request.method == 'POST':
        Nombre = request.form['Nombre']
        Apellido1 = request.form['Apellido1']
        Apellido2 = request.form['Apellido2']
        Telefono = request.form['Telefono']
        Email = request.form['Email']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "INSERT INTO CLIENTE (Nombre, Apellido1, Apellido2, Telefono, Email) VALUES (%s, %s, %s, %s, %s)"
                cursor.execute(sql, (Nombre, Apellido1, Apellido2, Telefono, Email))
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

    # ACTUALIZAR REGISTROS
    if request.method == 'PUT':
        IDCliente = request.form['IDCliente']
        Nombre = request.form['Nombre']
        Apellido1 = request.form['Apellido1']
        Apellido2 = request.form['Apellido2']
        Telefono = request.form['Telefono']
        Email = request.form['Email']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "UPDATE CLIENTE SET Nombre=%s, Apellido1=%s, Apellido2=%s, Telefono=%s, Email=%s WHERE IDCliente=%s "
                cursor.execute(sql, (Nombre, Apellido1, Apellido2, Telefono, Email, IDCliente))

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

    # ELIMINAR REGISTROS
    if request.method == 'DELETE':
        IDCliente = request.form['IDCliente']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "DELETE FROM CLIENTE WHERE IDCliente = %s"
                cursor.execute(sql, (IDCliente))

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


# SISTEMA DE GESTIÓN DE VEHICULOS
@app.route('/vehiculos', methods=['GET', 'POST', 'PUT', 'DELETE'])
def vehiculos():
    # OBTIENE REGISTROS
    if request.method == 'GET':
        connection = None
        try:
            connection = get_db_connection()
            with connection.cursor() as cursor:
                cursor.execute('SELECT * FROM vista_vehiculos')
                result = cursor.fetchall()
        except Exception as e:
            print(f"Error en la base de datos: {e}")
            result = None
        finally:
            if connection:
                connection.close()
            return render_template('vehiculos.html', data=result)
        
    # AÑADIR REGISTROS
    if request.method == 'POST':
        Marca = request.form['Marca']
        Modelo = request.form['Modelo']
        Anio = request.form['Anio']
        Placa = request.form['Placa']
        Color = request.form['Color']
        IDCliente = request.form['IDCliente']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "INSERT INTO VEHICULO (Marca, Modelo, Anio, Placa, Color, IDCliente) VALUES (%s, %s, %s, %s, %s, %s)"
                cursor.execute(sql, (Marca, Modelo, Anio, Placa, Color, IDCliente))
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
        IDVehiculo = request.form['IDVehiculo']
        Marca = request.form['Marca']
        Modelo = request.form['Modelo']
        Anio = request.form['Anio']
        Placa = request.form['Placa']
        Color = request.form['Color']
        IDCliente = request.form['IDCliente']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "UPDATE VEHICULO SET Marca=%s, Modelo=%s, Anio=%s, Placa=%s, Color=%s, IDCliente=%s WHERE IDVehiculo=%s"
                cursor.execute(sql, (Marca, Modelo, Anio,
                               Placa, Color, IDCliente, IDVehiculo))

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
        IDVehiculo = request.form['IDVehiculo']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "DELETE FROM VEHICULO WHERE IDVehiculo = %s"
                cursor.execute(sql, (IDVehiculo))

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


# SISTEMA DE GESTIÓN DE SERVICIOS
@app.route('/servicios', methods=['GET', 'POST', 'PUT', 'DELETE'])
def servicios():
    # OBTIENE REGISTROS
    if request.method == 'GET':
        connection = None

        try:
            connection = get_db_connection()
            with connection.cursor() as cursor:
                cursor.execute('SELECT * FROM vista_servicios')
                result = cursor.fetchall()
        except Exception as e:
            print(f"Error en la base de datos: {e}")
            result = None
        finally:
            if connection:
                connection.close()
            return render_template('servicios.html', data=result)
        
     # AÑADIR REGISTROS
    if request.method == 'POST':
        Nombre = request.form['Nombre']
        Descripcion = request.form['Descripcion']
        Costo = request.form['Costo']
        Garantia = request.form['Garantia']
        IDEmpleado = request.form['IDEmpleado']
        IDVehiculo = request.form['IDVehiculo']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "INSERT INTO SERVICIO (Nombre, Descripcion, Costo, Garantia, IDEmpleado, IDVehiculo) VALUES (%s, %s, %s, %s, %s, %s)"
                cursor.execute(sql, (Nombre, Descripcion, Costo, Garantia, IDEmpleado, IDVehiculo))
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

    # ACTUALIZAR REGISTROS
    if request.method == 'PUT':
        IDServicio = request.form['IDServicio']
        Nombre = request.form['Nombre']
        Descripcion = request.form['Descripcion']
        Costo = request.form['Costo']
        Garantia = request.form['Garantia']
        IDEmpleado = request.form['IDEmpleado']
        IDVehiculo = request.form['IDVehiculo']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "UPDATE SERVICIO SET Nombre=%s, Descripcion=%s, Costo=%s, Garantia=%s, IDEmpleado=%s, IDVehiculo=%s WHERE IDServicio=%s"
                cursor.execute(sql, (Nombre, Descripcion, Costo, Garantia, IDEmpleado, IDVehiculo, IDServicio))

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

    # ELIMINAR REGISTROS
    if request.method == 'DELETE':
        IDServicio = request.form['IDServicio']

        connection = pymysql.connect(**db_config)

        try:
            with connection.cursor() as cursor:
                sql = "DELETE FROM SERVICIO WHERE IDServicio = %s"
                cursor.execute(sql, (IDServicio))

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


if __name__ == '__main__':
    app.run(debug=True)
