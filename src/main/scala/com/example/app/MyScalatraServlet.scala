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

      ssp("/login", "success" -> "Ya te registraste, ahora login:")
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

      ssp("quiniela.ssp", "partidos" -> partidos, "user" -> session.getAttribute("user"))
    } else {
      ssp("login.ssp", "info" -> "Necesit&aacute;s un login para accesar aqu&iacute;")
    }
  }

  notFound {
    findTemplate(requestPath) map { path =>
      contentType = "text/html"
      layoutTemplate(path)
    } orElse serveStaticResource() getOrElse redirect("/")
  }
}
