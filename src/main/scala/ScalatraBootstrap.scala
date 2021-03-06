import com.example.app._
import java.text.SimpleDateFormat
import org.scalatra._
import javax.servlet.ServletContext
import java.util
import scala.slick.jdbc.meta.MTable
import slick.driver.PostgresDriver.simple._

class ScalatraBootstrap extends LifeCycle with DatabaseSupport{
  override def init(context: ServletContext) {
    context.mount(new MyScalatraServlet, "/*")

    logger.info("Creaando tablas ...")
    db.withSession{
      implicit session =>
        if (MTable.getTables("partidos").list().isEmpty)
          (partidosdb.ddl).create
        if (MTable.getTables("usuarios").list().isEmpty)
          (usuariosdb.ddl).create
        if (MTable.getTables("predicciones").list().isEmpty)
          (prediccionesdb.ddl).create
        if (MTable.getTables("mensajes_chat").list().isEmpty)
          (mensajesChat.ddl).create
        if (MTable.getTables("resultados").list().isEmpty)
          (resultadosdb.ddl).create
        if (MTable.getTables("ganador_predicto").list().isEmpty)
          (ganadoresPredictosdb.ddl).create
        if (MTable.getTables("ganadores").list().isEmpty)
          (ganadoresdb.ddl).create
    }

    primeraRonda()
  }

  val dateFormat = new SimpleDateFormat("d/MM/yyyy hh:mm")

  def primeraRonda(){
    logger.info("Metiendo primera ronda")

    // Grupo A
    insertarPartido("Brasil", "Croacia", at("12/06/2014 14:00"))
    insertarResultado("Brasil","Croacia", 3, 1)
    insertarPartido("México", "Camerún", at("13/06/2014 10:00"))
    insertarResultado("México","Camerún", 1, 0)
    insertarPartido("Brasil", "México", at("17/06/2014 13:00"))
    insertarPartido("Camerún", "Croacia", at("18/06/2014 16:00"))
    insertarPartido("Camerún", "Brasil", at("23/06/2014 14:00"))
    insertarPartido("Croacia", "México", at("23/06/2014 14:00"))

    // Grupo B
    insertarPartido("España", "Holanda", at("13/06/2014 13:00"))
    //insertarResultado("España","Holanda", 1, 1)
    insertarPartido("Chile", "Australia", at("13/06/2014 16:00"))
    insertarPartido("España", "Chile", at("18/06/2014 13:00"))
    insertarPartido("Australia", "Holanda", at("18/06/2014 10:00"))
    insertarPartido("Australia", "España", at("23/06/2014 10:00"))
    insertarPartido("Holanda", "Chile", at("23/06/2014 10:00"))

    // Grupo C
    insertarPartido("Colombia", "Grecia", at("14/06/2014 10:00"))
    insertarPartido("Costa de Marfil", "Japón", at("14/06/2014 19:00"))
    insertarPartido("Colombia", "Costa de Marfil", at("19/06/2014 10:00"))
    insertarPartido("Japón", "Grecia", at("19/06/2014 16:00"))
    insertarPartido("Japón", "Colombia", at("24/06/2014 14:00"))
    insertarPartido("Grecia", "Costa de Marfil", at("24/06/2014 15:00"))

    // Grupo D
    insertarPartido("Uruguay", "Costa Rica", at("14/06/2014 13:00"))
    insertarPartido("Inglaterra", "Italia", at("14/06/2014 16:00"))
    insertarPartido("Uruguay", "Inglaterra", at("19/06/2014 13:00"))
    insertarPartido("Italia", "Costa Rica", at("20/06/2014 10:00"))
    insertarPartido("Italia", "Uruguay", at("24/06/2014 10:00"))
    insertarPartido("Costa Rica", "Inglaterra", at("24/06/2014 10:00"))

    // Grupo E
    insertarPartido("Suiza", "Ecuador", at("15/06/2014 10:00"))
    insertarPartido("Francia", "Honduras", at("15/06/2014 13:00"))
    insertarPartido("Suiza", "Francia", at("20/06/2014 13:00"))
    insertarPartido("Honduras", "Ecuador", at("20/06/2014 16:00"))
    insertarPartido("Honduras", "Suiza", at("25/06/2014 14:00"))
    insertarPartido("Ecuador", "Francia", at("25/06/2014 14:00"))

    // Grupo F
    insertarPartido("Argentina", "Bosnia-Herzegovina", at("15/06/2014 16:00"))
    insertarPartido("Irán", "Nigeria", at("16/06/2014 13:00"))
    insertarPartido("Argentina", "Irán", at("21/06/2014 10:00"))
    insertarPartido("Nigeria", "Bosnia-Herzegovina", at("21/06/2014 16:00"))
    insertarPartido("Nigeria", "Argentina", at("25/06/2014 10:00"))
    insertarPartido("Bosnia-Herzegovina", "Irán", at("25/06/2014 10:00"))

    // Grupo G
    insertarPartido("Alemania", "Portugal", at("16/06/2014 10:00"))
    insertarPartido("Ghana", "Estados Unidos", at("16/06/2014 16:00"))
    insertarPartido("Alemania", "Ghana", at("21/06/2014 13:00"))
    insertarPartido("Estados Unidos", "Portugal", at("22/06/2014 16:00"))
    insertarPartido("Estados Unidos", "Alemania", at("26/06/2014 10:00"))
    insertarPartido("Portugal", "Ghana", at("26/06/2014 10:00"))

    // Grupo H
    insertarPartido("Bélgica", "Algeria", at("17/06/2014 10:00"))
    insertarPartido("Rusia", "Corea del Sur", at("17/06/2014 16:00"))
    insertarPartido("Bélgica", "Rusia", at("22/06/2014 10:00"))
    insertarPartido("Corea del Sur", "Algeria", at("22/06/2014 13:00"))
    insertarPartido("Algeria", "Rusia", at("26/06/2014 14:00"))
    insertarPartido("Corea del Sur", "Bélgica", at("26/06/2014 14:00"))

    //octavos de final
    insertarPartido("Brasil", "Chile", at("28/06/2014 10:00"))
    insertarPartido("Colombia", "Uruguay", at("28/06/2014 14:00"))
    insertarPartido("Holanda", "México", at("29/06/2014 10:00"))
    insertarPartido("Costa Rica", "Grecia", at("29/06/2014 14:00"))

    insertarPartido("Francia", "Nigeria", at("30/06/2014 10:00"))
    insertarPartido("Alemania", "Algeria", at("30/06/2014 14:00"))
    insertarPartido("Argentina", "Suiza", at("01/07/2014 10:00"))
    insertarPartido("Bélgica", "Estados Unidos", at("01/07/2014 14:00"))

    // cuartos
    insertarPartido("Francia", "Alemania", at("04/07/2014 10:00"))
    insertarPartido("Brasil", "Colombia", at("04/07/2014 14:00"))
    insertarPartido("Argentina", "Bélgica", at("05/07/2014 10:00"))
    insertarPartido("Holanda", "Costa Rica", at("05/07/2014 14:00"))

    //semis
    insertarPartido("Brasil", "Alemania", at("08/07/2014 14:00"));
    insertarPartido("Holanda", "Argentina", at("09/07/2014 14:00"));    

    //finales
    insertarPartido("Brasil", "Holanda", at("12/07/2014 14:00"));    
    insertarPartido("Alemania", "Argentina", at("12/07/2014 14:00"));    
  }

  def at(p: String) = dateFormat.parse(p)

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

  // si no existe en db, inserta el partido
  def insertarPartido(equipo1: String, equipo2: String, fecha: util.Date) = {
    db.withSession{
      implicit session =>
          partidosdb.filter(p => p.equipo1 === equipo1 && p.equipo2 === equipo2).list() match{
          case Nil => {
            //val partido = new Partido(-1, equipo1, equipo2, new java.sql.Date(fecha.getTime()) )
            val partido = new Partido(-1, equipo1, equipo2, fecha)

            logger.info(s"Insertando $partido")
            partidosdb.insert(partido)
          }
          case _ => {
            logger.info(s"$equipo1 vs $equipo2 ya existe, cambiando hora")
            val q = for { p <- partidosdb if p.equipo1 === equipo1 && p.equipo2 === equipo2} yield (p.fecha)
            q.update(new java.sql.Date(fecha.getTime))
          }
        }
    }
  }
}
