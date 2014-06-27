package com.example.app

import java.util.Date
import slick.driver.PostgresDriver.simple._
import scala.slick.model.ForeignKeyAction
import scala.slick.ast.TypedType

//import scala.slick.lifted.TypeMapper

/**
 * Created by kmels on 8/06/14.
 */

case class Usuario(id: Long, ident: String, pw: String)
case class Prediccion(id: Long, user_id: Long, partido_id: Long, goles_equipo1: Int, goles_equipo2: Int)
case class Partido(id: Long, equipo1: String, equipo2: String, fecha: Date)
case class Resultado(partido_id: Long, goles_equipo1: Int, goles_equipo2: Int)
case class GanadorPredicto(partido_id: Long, user_id: Long, equipo: String)
case class Ganador(partido_id: Long, equipo: String)
case class MensajeChat(id: Long, autor_id: Long, texto: String, fecha_emision: Date)

class MensajesChat(tag: Tag) extends Table[MensajeChat](tag, "mensajes_chat"){
  def id = column[Long]("id", O.PrimaryKey, O.AutoInc)
  def autor_id = column[Long]("autor_id")
  def texto = column[String]("texto")
  def fecha_emision = column[Date]("fecha")

  implicit val DateMapper = MappedColumnType.base[Date, Long](
    d => d.getTime(), //from date to long
    t => new Date(t)
  )

  def autor = foreignKey("AUTOR_FK", autor_id, TableQuery[Usuarios])(_.id, onDelete=ForeignKeyAction.Cascade)

  def * = (id, autor_id, texto, fecha_emision) <> (MensajeChat.tupled, MensajeChat.unapply)
}
class Usuarios(tag: Tag) extends Table[Usuario](tag, "usuarios"){
  def id = column[Long]("id", O.PrimaryKey, O.AutoInc)
  def ident = column[String]("ident")
  def pw = column[String]("pw")

  def * = (id, ident, pw) <> (Usuario.tupled, Usuario.unapply)
}

class GanadoresPredictos(tag: Tag) extends Table[GanadorPredicto](tag, "ganador_predicto"){
  def partido_id = column[Long]("partido_id")
  def user_id = column[Long]("user_id")
  def equipo = column[String]("equipo_predicto")

  def * = (partido_id, user_id, equipo) <> (GanadorPredicto.tupled, GanadorPredicto.unapply)
}

class Ganadores(tag: Tag) extends Table[Ganador](tag, "ganadores"){
  def partido_id = column[Long]("partido_id")
  def equipo = column[String]("equipo_ganador")

  def * = (partido_id, equipo) <> (Ganador.tupled, Ganador.unapply)
}

class Predicciones(tag: Tag) extends Table[Prediccion](tag, "predicciones"){
  def id = column[Long]("id", O.PrimaryKey, O.AutoInc)
  def user_id = column[Long]("user_id")
  def partido_id = column[Long]("partido_id")
  def goles_equipo1 = column[Int]("goles_equipo1")
  def goles_equipo2 = column[Int]("goles_equipo2")

  def user = foreignKey("USER_FK", user_id, TableQuery[Usuarios])(_.id, onDelete=ForeignKeyAction.Cascade)
  def partido = foreignKey("PARTIDO_FK", partido_id, TableQuery[Partidos])(_.id, onDelete=ForeignKeyAction.Cascade)

  def * = (id, user_id, partido_id, goles_equipo1, goles_equipo2) <> (Prediccion.tupled, Prediccion.unapply)
}

case class Partidos(tag: Tag) extends Table[Partido](tag, "partidos"){
  def id = column[Long]("id", O.PrimaryKey, O.AutoInc)
  def equipo1 =column[String]("equipo1")
  def equipo2 = column[String]("equipo2")

  implicit val DateMapper = MappedColumnType.base[Date, Long](
    d => d.getTime(), //from date to long
    t => new Date(t)
  )

  def fecha = column[Date]("fecha")

  def * = (id, equipo1, equipo2, fecha) <> (Partido.tupled, Partido.unapply)
}

case class Resultados(tag: Tag) extends Table[Resultado](tag, "resultados"){
  def partido_id = column[Long]("id")
  def goles_equipo1 = column[Int]("goles_equipo1")
  def goles_equipo2 = column[Int]("goles_equipo2")
  def partido = foreignKey("PARTIDO_FK", partido_id, TableQuery[Partidos])(_.id, onDelete=ForeignKeyAction.Cascade)

  def * = (partido_id, goles_equipo1, goles_equipo2) <> (Resultado.tupled, Resultado.unapply)
}
