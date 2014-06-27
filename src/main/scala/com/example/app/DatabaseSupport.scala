package com.example.app

/**
 * Created by kmels on 8/06/14.
 */
import slick.driver.PostgresDriver.simple._
import com.mchange.v2.c3p0.ComboPooledDataSource
import scala.slick.jdbc.meta.MTable
import org.slf4j.LoggerFactory

/**
 * Created by kmels on 29/05/14.
 */

object DatabaseHolder{
  def createDatasource = new ComboPooledDataSource

  val dbconn = createDatasource

  val database = Database.forDataSource(dbconn)

  def closeDBPool {dbconn.close()}
}

trait DatabaseSupport {
  val logger = LoggerFactory.getLogger(getClass)
  def db = DatabaseHolder.database

  val partidosdb = TableQuery[Partidos]
  val usuariosdb = TableQuery[Usuarios]
  val prediccionesdb = TableQuery[Predicciones]
  val mensajesChat = TableQuery[MensajesChat]
  val resultadosdb = TableQuery[Resultados]
  val ganadoresPredictosdb = TableQuery[GanadoresPredictos]
  val ganadoresdb = TableQuery[Ganadores]
}