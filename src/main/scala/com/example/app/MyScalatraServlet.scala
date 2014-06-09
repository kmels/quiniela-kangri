package com.example.app

import org.scalatra._
import scalate.ScalateSupport
import slick.driver.PostgresDriver.simple._

class MyScalatraServlet extends QuinielaStack with DatabaseSupport{
  get("/") {
    <html>
      <body>
        <h1>Quiniela Kangris</h1>

        <ul>
          <li><a href="/quiniela/">Quiniela</a></li>
        </ul>
      </body>
    </html>
  }

  //lista partidos
  get("/quiniela/"){
    contentType = "text/html"
    val partidos: List[Partido] = db.withSession{
      implicit session =>
      partidosdb.list()
    }

    ssp("quiniela.ssp","partidos" -> partidos)
  }
  
}
