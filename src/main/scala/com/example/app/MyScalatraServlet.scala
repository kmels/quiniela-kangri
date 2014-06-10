package com.example.app

import org.scalatra._
import scalate.ScalateSupport
import slick.driver.PostgresDriver.simple._
import javax.xml.bind.annotation.adapters.HexBinaryAdapter
import java.security.MessageDigest

class MyScalatraServlet extends QuinielaStack with DatabaseSupport{
  def md5(s: String) = new HexBinaryAdapter().marshal(MessageDigest.getInstance("MD5").digest(s.getBytes))

  //inicio
  get("/") {
    contentType = "text/html"
    ssp("inicio.ssp", "user" -> session.getAttribute("user"))
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
        ssp("login.ssp", "warning" -> "Usuario/contrase&ntilde;a mala")
      }
    }
  }

  get("/logout"){
    session.setAttribute("user", null)
    redirect("/")
  }

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

      ssp("quiniela.ssp", "predicciones" -> predicciones, "user" -> session.getAttribute("user"))
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
        val partidos = db.withSession{
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

        db.withSession{ implicit session => {
          predicciones.foreach(p => {
            //if( ! prediccionesdb.filter(pdb => pdb.user_id === p.user_id && pdb.partido_id === p.partido_id).exists.run )
            //  prediccionesdb.insert(p)
            //else{
              val q = for { pdb <- prediccionesdb if pdb.user_id === p.user_id && pdb.partido_id === p.partido_id } yield (pdb.goles_equipo1, pdb.goles_equipo2)
              q.update((p.goles_equipo1, p.goles_equipo2))
            //}
          })
        }}

        redirect("/quiniela")
      } else
        ssp("login.ssp", "info" -> "Necesitás un login para accesar aquí")
  }

  get("/puntuaciones"){
    val loggedUser = session.getAttribute("user")
    contentType = "text/html"

    if (loggedUser != null){
      val usuarios: List[(Usuario, (Int, Int))] = db.withSession{implicit session =>{
        val usrs = usuariosdb.list()
        val pos = usrs.map(u => (u.id.toInt, 0))

        usrs.zip(pos)
      }}
      ssp("puntuaciones.ssp", "usuarios" -> usuarios, "user" -> session.getAttribute("user"))
    } else
      ssp("login.ssp", "info" -> "Necesitás un login para accesar aquí")
  }
  notFound {
    findTemplate(requestPath) map { path =>
      contentType = "text/html"
      layoutTemplate(path)
    } orElse serveStaticResource() getOrElse redirect("/")
  }
}
