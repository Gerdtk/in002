
const express = require('express');
const mysql = require('mysql');
const session = require('express-session');
const bcrypt = require('bcrypt');
const cors = require('cors');

class Server{
    constructor(){
        this.app = express();
        this.port = process.env.PORT;

        this.middlewares();
        this.routes();
        this.listen();
        this.conectarBd();

    }
    conectarBd(){
        this.con = mysql.createPool({
            host: "localhost",
            user: "Admin",
            password: "Sus50!",
            database: "pdr01"
        });


        /* this.con.connect(function(err) {
        if (err) throw err;
        console.log("Connected!"); // funicion callback
        }); */
    }
    middlewares(){
        this.app.use(cors());
        this.app.use(express.static('./public'));
        this.app.use(express.json());
        this.app.use(express.urlencoded({extended:true}));
        this.app.set("view engine","ejs");
        this.app.set("trust proxy");
        this.app.use(session({ 
            secret: 'clave',
            resave: false,
            saveUninitialized: true, 
            cookie: { secure: false }
        }));
    }
    routes(){
        this.app.post("/login", (req, res) => {
            let user = req.body.usuario;
            let pass = req.body.Cont;
        
            console.log("Usuario ingresado:", user);
        
            this.con.query("SELECT idUsuario, usuario, Cont, Rol, Nombre FROM usuarios WHERE usuario = ?", [user], (err, results, fields) => {
                if (err) {
                    console.error("Error en la consulta:", err);
                    return res.status(500).send("Error en el servidor.");
                }
        
                if (results.length > 0) {
                    bcrypt.compare(pass, results[0].Cont, (err, isMatch) => {
                        if (err) {
                            console.error("Error al comparar las contraseñas:", err);
                            return res.status(500).send("Error al comparar las contraseñas.");
                        }
        
                        if (isMatch) {
                            console.log("Credenciales correctas");
                            
                            // Guardar información en la sesión
                            req.session.user = user;
                            req.session.rol = results[0].Rol; // Asegúrate de acceder correctamente a Rol
                            req.session.nombre = results[0].Nombre; // Guardar el nombre del usuario en la sesión
                            req.session.idUsuario = results[0].idUsuario; //Guardar el id del usuario
        
                            // Redirigir o renderizar según el Rol
                            if (results[0].Rol === "Admin") {
                                res.render("paginaInicialA", {
                                    usuario: results[0].Nombre,
                                    rol: results[0].Rol
                                });
                            } else {
                                res.render("paginaInicial", {
                                    usuario: results[0].Nombre,
                                    rol: results[0].Rol
                                });
                            }
                        } else {
                            console.log("Contraseña incorrecta");
                            res.status(401).send("Credenciales incorrectas.");
                        }
                    });
                } else {
                    console.log("Usuario no encontrado");
                    res.status(404).send("Usuario no encontrado.");
                }
            });
        });
        
        /* else {
                    console.log("Usuario no existe");
                    res.render('errori', {mensaje: "Usuario o contraseña incorrecta"});
                }
            });
        }); */

    this.app.get('/apg', (req,res) => {
        res.render('paginaInicialA');// redirige a pag inicial con generar usuario.
    });
    this.app.get('/pagIn', (req, res) => {
                res.render('paginaInicial'); // Redirige a pag inicial sin generar usuario.
            });
    this.app.get('/agregar', (req, res) => {
        res.render('AgregarUsuario');//envio a registro de usuario.
    });
    this.app.get('/mobi', (req, res) => {
            res.render('mobi'); // Redirige a mobiliario
    });
        this.app.get('/api/mobi', (req, res) => {
            this.con.query('SELECT NoId as NoSerie, NombreMobiliario as Nombre, Costo, FechaAgregacion as Fecha, EstadoRequerido as Estado, Cantidad FROM mobiliario', (err, results) => {
                if (err) {
                    console.error(err);
                    res.status(500).json({ error: "Error al obtener los datos" });
                    return;
                }
                res.json(results); // Enviar los datos como JSON
            });
    });
    this.app.put('/api/mobi/:noSerie', (req, res) => {
        const { noSerie } = req.params;  // Usamos NoSerieMobiliario para identificar el registro
        const { EstadoRequerido } = req.body;  // Solo actualizamos el estado
    
        const sql = `
            UPDATE mobiliario
            SET EstadoRequerido = ?
            WHERE NoId = ?
        `;
    
        this.con.query(sql, [EstadoRequerido, noSerie], (err, result) => {
            if (err) {
                console.error('Error al editar estado:', err);
                return res.status(500).json({ message: 'Error al editar estado' });
            }
            res.status(200).json({ message: 'Estado actualizado correctamente' });
            console.log(noSerie, EstadoRequerido);
        });
    });
    //Agregar los  datos mobiliario
    this.app.post('/api/mobi', (req, res) => {
        const mobiliario = req.body;  // Los datos que llegan del frontend
      
        const queries = mobiliario.map(item => {
          return new Promise((resolve, reject) => {
            const { NoId, NombreMobiliario, Costo, FechaAgregacion, EstadoRequerido, Cantidad } = item;
      
            // Inserción de cada ítem en la base de datos
            const sql = `
              INSERT INTO mobiliario (NoId, NombreMobiliario, Costo, FechaAgregacion, EstadoRequerido, Cantidad)
              VALUES (?, ?, ?, ?, ?, ?)
            `;
      
            this.con.query(sql, [NoId, NombreMobiliario, Costo, FechaAgregacion, EstadoRequerido, Cantidad], (err, result) => {
              if (err) {
                reject(err);
              } else {
                resolve(result);
              }
            });
          });
        });
      
        // Ejecutar todas las inserciones
        Promise.all(queries)
          .then(() => {
            res.status(200).json({ message: 'Mobiliario agregado correctamente' });
          })
          .catch((error) => {
            console.error('Error al agregar mobiliario:', error);
            res.status(500).json({ message: 'Error al agregar mobiliario' });
          });
      });
    
      // eliminar.................
    this.app.delete('/api/mobi/:noSerie', (req, res) => {
        const { noSerie } = req.params;  // Usamos NoSerieMobiliario para identificar el registro
    
        const sql = `DELETE FROM mobiliario WHERE NoId = ?`;
    
        this.con.query(sql, [noSerie], (err, result) => {
            if (err) {
                console.error('Error al eliminar mobiliario:', err);
                return res.status(500).json({ message: 'Error al eliminar mobiliario' });
            }
            res.status(200).json({ message: 'Mobiliario eliminado correctamente' });
        });
    });
        
        
        this.app.get("/hola" , (req,res) => { 
            if(req.session.user){
                res.send("hellow " + req.session.user);
                console.log(req.session.idUsuario);
            } else{
                res.send("no se inicio secion correctamente"); //registro y comprobacion de usuarios
            };
            
        });
        this.app.post("/consultar", (req,res)=> {
            res.render('consular');
        });
        // Agregar usuario....................................
        this.app.post('/registrar', (req, res) => {
            const { IdUsuario, Usuario, Cont, Nombre, Apellido1, Apellido2, FechaAgregacion, Rol } = req.body; 
            const salt = bcrypt.genSaltSync(12);
            const hashedCont = bcrypt.hashSync(Cont, salt);
        
            const datos = [Usuario, hashedCont, Nombre, Apellido1, Apellido2, FechaAgregacion, Rol];
            const sql = "INSERT INTO usuarios (Usuario, Cont, Nombre, Apellido1, Apellido2, FechaCreacion, Rol) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
            this.con.query(sql, datos, (err, results) => {
                if (err) {
                    console.error("Error al registrar usuario:", err);
                    return res.status(500).send("Error al registrar usuario: " + err.message);
                }
                
                console.log("Usuario registrado correctamente:", results);
                res.render('paginaInicial', { mensaje: 'Usuario registrado correctamente', usuario: Usuario });
            });
        });
            this.app.get('/plant', (req, res) => {
                res.render('plant'); // Redirige a plantas
        });
        this.app.get('/api/plant', (req, res) => {
            this.con.query('SELECT NoId as NoSerie, NombrePlanta as Nombre, FechaAgregacion as Fecha, EstadoRequerido as Estado FROM plantasgeneral', (err, result) => {
                if (err) {
                    console.error(err);
                    res.status(500).json({ error: "Error al obtener los datos" });
                    return;
                }
                res.json(result); // Enviar los datos como JSON
            });
        });
        // agregar 
        this.app.post('/api/plant', (req, res) => {
            const plantas = req.body;  // Los datos que llegan del frontend
          
            const queries = plantas.map(item => {
              return new Promise((resolve, reject) => {
                const { NoId, NombrePlanta, FechaAgregacion, EstadoRequerido, cantidad } = item;
          
                // Inserción de cada ítem en la base de datos
                const sqlagregar = `
                  INSERT INTO plantasgeneral (NoId, NombrePlanta, FechaAgregacion, EstadoRequerido, cantidad )
                  VALUES (?, ?, ?, ?, ?)
                `;
          
                this.con.query(sqlagregar, [NoId, NombrePlanta, FechaAgregacion, EstadoRequerido, cantidad ], (err, result) => {
                  if (err) {
                    reject(err);
                  } else {
                    resolve(result);
                  }
                });
              });
            });
          
            // Ejecutar todas las inserciones
            Promise.all(queries)
              .then(() => {
                res.status(200).json({ message: 'Mobiliario agregado correctamente' });
              })
              .catch((error) => {
                console.error('Error al agregar mobiliario:', error);
                res.status(500).json({ message: 'Error al agregar mobiliario' });
              });
        });
        //editar
        this.app.put('/api/plant/:noSerie', (req, res) => {
            const { noSerie } = req.params;  // Usamos NoSerieMobiliario para identificar el registro
            const { EstadoRequerido } = req.body;  // Solo actualizamos el estado
            const usuario = req.session.nombre
            const idus = req.session.idUsuario
        
            const sqlActualizarEstado = `
                UPDATE plantasgeneral
                SET EstadoRequerido = ?
                WHERE NoId = ?
            `;
        this.con.query(sqlActualizarEstado, [EstadoRequerido, noSerie], (err, result) => {
            if (err) {
                console.error('Error al editar estado:', err);
                return res.status(500).json({ message: 'Error al editar estado' });
        }

        // Obtener el nombre de la planta desde la base de datos
        this.con.query('SELECT NombrePlanta FROM plantasgeneral WHERE NoId = ?', [noSerie], (err, result) => {
            if (err) {
                console.error('Error al obtener el nombre de la planta:', err);
                return res.status(500).json({ message: 'Error al obtener el nombre de la planta' });
            }
        
        if (result.length === 0){
            console.error('no se encontro la planta con No de Id', noSerie);
            return res.status(404).json([ {message: 'Planta no encontrada'} ]);
        }
        const nombrePlanta = result[0]?.NombrePlanta || 'Desconocida';  // Nombre de la planta

        // Paso 2: Registrar la edición en la tabla logplantas
        const sqlLog = `
            INSERT INTO logplantas (idplantas, idUsuario, Nombre, FechaModificacion, Accion, NombrePlanta)
            VALUES (?, ?, ?, NOW(), 'salida', ?)
        `;
            // Insertar el registro en logplantas
                this.con.query(sqlLog, [noSerie, idus, usuario, nombrePlanta], (err, result) => {
                    if (err) {
                        console.error('Error al registrar en logplantas:', err);
                        return res.status(500).json({ message: 'Error al registrar en logplantas' });
                    }

                // Responder con éxito
                    return res.status(200).json({ message: 'Estado actualizado correctamente y log registrado' });
                });
            });
        });
        });
        //eliminar
        this.app.delete('/api/plant/:noSerie', (req, res) => {
            const { noSerie } = req.params;  // Usamos NoSerieMobiliario para identificar el registro
        
            const sql = `DELETE FROM plantasgeneral WHERE NoId = ?`;
        
            this.con.query(sql, [noSerie], (err, result) => {
                if (err) {
                    console.error('Error al eliminar mobiliario:', err);
                    return res.status(500).json({ message: 'Error al eliminar mobiliario' });
                }
                res.status(200).json({ message: 'Mobiliario eliminado correctamente' });
            });
        });
        // Endpoint para datos de mobiliario, generacion de pdf'
        this.app.get('/api/mobiliario', (req, res) => {
            const query = 'SELECT * FROM mobiliario';
            this.con.query(query, (err, results) => {
                if (err) {
                    res.status(500).send('Error al obtener datos de mobiliario');
                } else {
                    res.json(results);
                }
            });
        });
        // Endpoint para datos de plantas
        this.app.get('/api/plantas', (req, res) => {
            const query = 'SELECT * FROM plantasgeneral';
            this.con.query(query, (err, results) => {
                if (err) {
                    res.status(500).send('Error al obtener datos de plantas');
                } else {
                    res.json(results);
                }
            });
        });
    // se repite la funcion callback, para el requerimiento del usuario(req) y su respuesta(res)
        //salidas
        this.app.get('/api/plantas/log', (req, res) =>{
            const sql = `SELECT * FROM logplantas`;  // Consulta que obtiene todos los registros de logplantas

        this.con.query(sql, (err, result) => {
            if (err) {
                console.error('Error al obtener los datos de logplantas:', err);
                return res.status(500).json({ message: 'Error al obtener los datos de logplantas' });
        }

        // Responder con los datos en formato JSON
        res.status(200).json(result);
        });
    });
};
    
    listen() {
        this.app.listen(this.port, ()=>{
            console.log("servidor escuchando:http://127.0.0.1:" + this.port);
        });
    }

}
