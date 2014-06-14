package com.example.app

import slick.driver.PostgresDriver.simple._
import scala.collection.immutable.TreeMap
import java.security.MessageDigest
import javax.xml.bind.annotation.adapters.HexBinaryAdapter
import java.util.Date

class MyScalatraServlet extends QuinielaStack with DatabaseSupport{
  def md5(s: String) = new HexBinaryAdapter().marshal(MessageDigest.getInstance("MD5").digest(s.getBytes))

  //inicio
  get("/") {
    contentType = "text/html"
    val nregistrados: Int = db.withSession{implicit session => usuariosdb.list().size}
    ssp("inicio.ssp", "mensajes" -> getMensajes, "user" -> session.getAttribute("user"), "nregistrados" -> nregistrados)
  }

  def getMensajes: List[((MensajeChat,Usuario), Int)] = {
    val msjs: List[(MensajeChat,Usuario)] = db.withSession{ implicit session =>

      val q = for {
        msj <- mensajesChat
        usr <- usuariosdb if (msj.autor_id === usr.id)
      } yield (msj, usr)

      q.list()
    }

    msjs.sortBy(_._1.fecha_emision).reverse.zipWithIndex
  }

  //registro
  get("/registro"){
    contentType = "text/html"
    ssp("registro.ssp", "user" -> session.getAttribute("user"))
  }

  post("/registro"){
    contentType = "text/html"

    val username = params("username")
    val pass = md5(params("password"))

    logger.info(s"Registrando a $username")

    val userexists = db.withSession{ implicit session => {
      val q = usuariosdb.findBy(_.ident)
      q(username).firstOption.isDefined
    }}

    if (!userexists){
      db.withSession{ implicit session => {
        usuariosdb.insert(new Usuario(-1, username, pass))
      }}

      ssp("/login", "success" -> "Ya te registraste")
    } else{
      ssp("/registro", "error" -> "Este usuario ya existe..")
    }
  }

  get("/login"){
    contentType = "text/html"

    ssp("login.ssp")
  }

  post("/login"){
    contentType = "text/html"
    val username = params("username")
    val pass = md5(params("password"))

    logger.info(s"Identificando a $username")
    val u: Option[Usuario] = db.withSession{ implicit session => usuariosdb.filter(u => u.ident === username && u.pw === pass ).firstOption}

    u match {
      case Some(user) => {
        logger.info("Login exitoso")
        session.setAttribute("user", user)
        redirect("/quiniela")
      }
      case _ => {
        logger.info("Login fallo")
        ssp("login.ssp", "warning" -> "Usuario/contraseña mala")
      }
    }
  }

  get("/logout"){
    session.setAttribute("user", null)
    redirect("/")
  }

  /*implicit val dateOrdering = new Ordering[java.sql.Date] {
    def compare(x: java.sql.Date, y: java.sql.Date) = x.compareTo(y)
  }*/

  //lista partidos
  get("/quiniela"){
    val user = session.getAttribute("user")
    contentType = "text/html"

    if (user != null){
      val partidos: List[Partido] = db.withSession{
        implicit session =>
        partidosdb.list()
      }

      val loggedUser = user.asInstanceOf[Usuario]
      val predicciones: List[(Partido,Prediccion)] = db.withSession{
        implicit session =>
          //prediccines del usuario logueado
          val ps: List[Prediccion] = prediccionesdb.filter(_.user_id === loggedUser.id).list()

          //si no tiene ni una, crearle
          if (ps.isEmpty){
            val newPs = partidosdb.list().map(p => new Prediccion(-1, loggedUser.id, p.id, -1, -1))
            newPs.foreach(prediccionVacia => prediccionesdb.insert(prediccionVacia))
          }

          //producto punto con partidos (join con partidos)
          val q = for {
            pa <- partidosdb
            pr <- prediccionesdb if (pr.partido_id === pa.id && pr.user_id === loggedUser.id)
          } yield (pa, pr)

          q.list()
      }

      val prediccionesPorFecha: TreeMap[Date,List[(Partido,Prediccion)]] = {
        val m = predicciones.groupBy(pp => pp._1.fecha)
        TreeMap(m.toSeq:_*)
      }

      ssp("quiniela.ssp", "mensajes" -> getMensajes, "prediccionesPorFecha" -> prediccionesPorFecha, "user" -> session.getAttribute("user"))
    } else {
      ssp("login.ssp", "info" -> "Necesitás un login para accesar aquí")
    }
  }

  get("/predicciones/:ident"){
    val user = session.getAttribute("user")
    contentType = "text/html"

    if (user != null){
      val partidos: List[Partido] = db.withSession{
        implicit session =>
          partidosdb.list()
      }

      //val loggedUser = user.asInstanceOf[Usuario]
      val userID: Long = db.withSession{ implicit session =>
        usuariosdb.filter(_.ident === params("ident")).firstOption.fold(-1L)(u => u.id)
      }

      val predicciones: List[(Partido,Prediccion)] = db.withSession{
        implicit session =>
        //prediccines del usuario logueado
        //producto punto con partidos (join con partidos)
        val q = for {
            pa <- partidosdb
            pr <- prediccionesdb if (pr.partido_id === pa.id && pr.user_id === userID)
        } yield (pa, pr)

        q.list()
      }

      val prediccionesPorFecha: TreeMap[Date,List[(Partido,Prediccion)]] = {
        val m = predicciones.groupBy(pp => pp._1.fecha)
        TreeMap(m.toSeq:_*)
      }

      ssp("predicciones_jugador.ssp", "ident" -> params("ident"), "mensajes" -> getMensajes, "prediccionesPorFecha" -> prediccionesPorFecha, "user" -> session.getAttribute("user"))
    } else {
      ssp("login.ssp", "info" -> "Necesitás un login para accesar aquí")
    }
  }

  post("/update"){
      val loggedUser = session.getAttribute("user")
      contentType = "text/html"

      if (loggedUser != null){
        val user: Usuario= loggedUser.asInstanceOf[Usuario]

        //por cada partido, obtener la prediccion
        val partidos: List[Partido] = db.withSession{
        implicit session => {
          partidosdb.list()
        }}

        val predicciones: List[Prediccion] = partidos.map(partido => {
          //id: Long, user_id: Long, partido_id: Long, goles_equipo1: Int, goles_equipo2: Int
          val goles_equipo1: Int = try {
            params(partido.id + "_goles_equipo1").toInt
          } catch { case e:Exception => -1}

          val goles_equipo2: Int = try {
            params(partido.id + "_goles_equipo2").toInt
          } catch { case e:Exception => -1}

          new Prediccion(-1, user.id, partido.id, goles_equipo1, goles_equipo2)
        })

        val now = new Date();

        db.withSession{ implicit session => {
          predicciones.foreach(p => {
            //si es valido
            val partido = partidos.find(_.id == p.partido_id).get
            if (partido.fecha.after(now)){
              val q = for { pdb <- prediccionesdb if pdb.user_id === p.user_id && pdb.partido_id === p.partido_id } yield (pdb.goles_equipo1, pdb.goles_equipo2)
              q.update((p.goles_equipo1, p.goles_equipo2))
            }
          })
        }}

        redirect("/quiniela")
      } else
        ssp("login.ssp", "info" -> "Necesitás un login para accesar aquí")
  }

  def calcularPuntaje(predicciones: List[Prediccion], resultados: List[Resultado]): Int = {
    val puntosPorPrediccion:List[Int] = predicciones.map(prediccion => resultados.find(r => r.partido_id == prediccion.partido_id) match {
      case None => 0
      case Some(resultado) => {
        var pts = 0;
        //gano el equipo 1 y acerto
        if ((resultado.goles_equipo1 > resultado.goles_equipo2) && (prediccion.goles_equipo1 > prediccion.goles_equipo2 ))
          pts += 3;

        //gano el equipo 2 y acerto
        if ((resultado.goles_equipo1 < resultado.goles_equipo2) && (prediccion.goles_equipo1 < prediccion.goles_equipo2 ))
          pts += 3;

        //hubo empate y acerto
        if ((resultado.goles_equipo1 == resultado.goles_equipo2) && (prediccion.goles_equipo1 == prediccion.goles_equipo2 ))
          pts += 3;

        //acerto el marcador?
        if ((resultado.goles_equipo1 == prediccion.goles_equipo1) && (resultado.goles_equipo2 == prediccion.goles_equipo2)){
          pts += 2;

          //fue el unico que acerto el resultado para este partido?
          val prediccionCount: Int = db.withSession{ implicit session => prediccionesdb.filter(p =>
            ((p.partido_id === prediccion.partido_id) && (p.goles_equipo1 === resultado.goles_equipo1) && (p.goles_equipo2 === resultado.goles_equipo2))
          ).list().size}
          if (prediccionCount == 1)
            pts += 1
        }

        pts
      }
    })

    puntosPorPrediccion.sum
  }

  get("/puntuaciones"){
    val loggedUser = session.getAttribute("user")
    contentType = "text/html"

    if (loggedUser != null){
      val usuarios: List[((Usuario, Int), Int)] = db.withSession{implicit session =>{

        val usrs = usuariosdb.list()
        val resultados = resultadosdb.list()

        val usuariosConPuntaje: List[(Usuario,Int)] = usrs.map(usr => {
          val predicciones= prediccionesdb.filter(_.user_id === usr.id).list()
          val pts = calcularPuntaje(predicciones, resultados)
          logger.info("Calificando a "+usr.ident + " con " + predicciones.size + " predicciones y " + resultados.size + " resultados  ... "+pts)
          (usr, pts )
        })

        usuariosConPuntaje.sortBy(_._2).reverse.zipWithIndex
      }}

      ssp("puntuaciones.ssp", "usuarios" -> usuarios, "user" -> session.getAttribute("user"), "mensajes" -> getMensajes)
    } else
      ssp("login.ssp", "info" -> "Necesitás un login para accesar aquí")
  }

  notFound {
    findTemplate(requestPath) map { path =>
      contentType = "text/html"
      layoutTemplate(path)
    } orElse serveStaticResource() getOrElse redirect("/")
  }

  post("/mensaje/:texto"){
    val loggedUser = session.getAttribute("user")

    if (loggedUser != null){
      val user: Usuario = loggedUser.asInstanceOf[Usuario]
      val texto = params("texto")
      val now = new Date()
      logger.info(user.ident + " dice: "+texto)
      db.withSession{implicit session => mensajesChat.insert(new MensajeChat(-1, user.id, texto, now))}
    }else{
      List[MensajeChat]()
    }

    redirect("/")
  }

  get("/meter-resultado"){
    val equipos: List[String] = db.withSession{ implicit session =>
    val q = for { p <- partidosdb} yield p.equipo2
    q.list()
    }

    ssp("meter-resultado.ssp", "equipos" -> equipos)
  }

  post("/meter-resultado"){
    try {
      val equipo1 = params("equipo1")
      val equipo2 = params("equipo2")

      val goles_equipo1 = params("goles_equipo1").toInt
      val goles_equipo2 = params("goles_equipo2").toInt

      insertarResultado(equipo1, equipo2, goles_equipo1, goles_equipo2)
    } catch { case e: Exception => redirect("/meter-resultado")}
  }

  def insertarResultado(equipo1: String, equipo2: String, goles_equipo1: Int, goles_equipo2: Int) {
    db.withSession{
      implicit session =>
        val partido_id: Long = partidosdb.filter(p => p.equipo1 === equipo1 && p.equipo2 === equipo2).first().id

        if (partido_id > 0){
          //meter o actualizar resultado
          val q = for { res <- resultadosdb if res.partido_id === partido_id} yield (res)

          q.list() match{
            case Nil => resultadosdb.insert(new Resultado(partido_id, goles_equipo1, goles_equipo2))
            case _ => {
              val uq = for { res <- resultadosdb if res.partido_id === partido_id} yield (res.goles_equipo1,res.goles_equipo2)
              uq.update((goles_equipo1,goles_equipo2))
            }
          }
        }else{
          logger.error(s"No se pudo encontrar el partido $equipo1 vs $equipo2")
        }
    }
  }
}
