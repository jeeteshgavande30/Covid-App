// ignore_for_file: unused_local_variable

import 'package:http/http.dart';
import 'dart:convert';
import 'package:corona_app/globals.dart' as g;

class Data {
  Future<void> getLiveData() async {
    // History
    Response resp = await get(
        Uri.parse('https://data.covid19india.org/v4/min/timeseries.min.json'));
    Map vacdata = jsonDecode(resp.body);
    vacdata = vacdata["TT"]["dates"];

    vacdata.forEach((key, value) {
      double a = 0,
          c = 0,
          d = 0,
          r = 0,
          da = 0,
          dc = 0,
          dd = 0,
          dr = 0,
          t1 = 0,
          t2 = 0,
          v1 = 0,
          v2 = 0;

      if (value["total"]["confirmed"] != null) {
        c = value["total"]["confirmed"].toDouble();
      }
      if (value["total"]["recovered"] != null) {
        r = value["total"]["recovered"].toDouble();
      }
      if (value["total"]["deceased"] != null) {
        d = value["total"]["deceased"].toDouble();
      }
      if (value["delta"]["confirmed"] != null) {
        dc = value["delta"]["confirmed"].toDouble();
      }
      if (value["delta"]["recovered"] != null) {
        dr = value["delta"]["recovered"].toDouble();
      }
      if (value["delta"]["deceased"] != null) {
        dd = value["delta"]["deceased"].toDouble();
      }
      if (value["total"]["vaccinated1"] != null) {
        t1 = value["total"]["vaccinated1"].toDouble();
      }

      if (value["total"]["vaccinated2"] != null) {
        t2 = value["total"]["vaccinated2"].toDouble();
      }

      if (value["delta"]["vaccinated1"] != null) {
        v1 = value["delta"]["vaccinated1"].toDouble();
      }

      if (value["delta"]["vaccinated2"] != null) {
        v2 = value["delta"]["vaccinated2"].toDouble();
      }
      g.date.add(key);
      g.active.add(c - d - r);
      g.confirmed.add(c);
      g.recovered.add(r);
      g.deaths.add(d);
      g.dailyactive.add(dc - dr - dd);
      g.dailyconfirmed.add(dc);
      g.dailyrecovered.add(dr);
      g.dailydeaths.add(dd);
      g.totalvaccinated.add(t1 + t2);
      g.totalvaccinated1.add(t1);
      g.totalvaccinated2.add(t2);
      g.vaccinated1.add(v1);
      g.vaccinated2.add(v2);
    });

    //Statewise Data
    Response response =
        await get(Uri.parse('https://disease.sh/v3/covid-19/gov/India'));
    Map res = jsonDecode(response.body);
    List tempdata = res["states"];
    for (var i = 0; i < tempdata.length; i++) {
      String p = tempdata[i]["state"];
      double a = tempdata[i]["active"].toDouble();
      double c = tempdata[i]["cases"].toDouble();
      double r = tempdata[i]["recovered"].toDouble();
      double d = tempdata[i]["deaths"].toDouble();
      double ta = tempdata[i]["todayActive"].toDouble();
      double tc = tempdata[i]["todayCases"].toDouble();
      double tr = tempdata[i]["todayRecovered"].toDouble();
      double td = tempdata[i]["todayDeaths"].toDouble();

      g.states.add(p);
      g.activecases.add(a);
      g.recoveredcases.add(r);
      g.confirmedcases.add(c);
      g.deathscases.add(d);
      g.todayactivecases.add(ta);
      g.todayrecoveredcases.add(tr);
      g.todayconfirmedcases.add(tc);
      g.todaydeathscases.add(td);
    }

    g.newActiveCases = res["total"]["todayActive"];
    g.totalActiveCases = res["total"]["active"];
    g.newConfirmedCases = res["total"]["todayCases"];
    g.totalConfirmedCases = res["total"]["cases"];
    g.newDeathCases = res["total"]["todayDeaths"];
    g.totalDeathCases = res["total"]["deaths"];
    g.newRecoveredCases = res["total"]["todayRecovered"];
    g.totalRecoveredCases = res["total"]["recovered"];

    // Assigning value
    g.casesPieValue = (100 *
        (g.newConfirmedCases /
            (g.newConfirmedCases + g.newDeathCases + g.newRecoveredCases)));

    g.deathPieValue = (100 *
        (g.newDeathCases /
            (g.newConfirmedCases + g.newDeathCases + g.newRecoveredCases)));

    g.recoverPieValue = (100 *
        (g.newRecoveredCases /
            (g.newConfirmedCases + g.newDeathCases + g.newRecoveredCases)));

    print("success");
  }
}
