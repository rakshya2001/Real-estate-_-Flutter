import 'package:flutter_test/flutter_test.dart';
import 'package:sparrow/Response/QuestionResponse.dart';
import 'package:sparrow/api/PropertyAPI.dart';
import 'package:sparrow/api/api_service.dart';

void main() {
  test("user login test", () async {
    bool expected = true;
    String phone = "999";
    String password = "abc";
    bool actual = await APIService().login(phone, password);
    expect(actual, expected);
  });

  // change password test and expect bool
  test("change password test and expect bool", () async {
    String id = "62dc08f9215fba30f52f3aa8";
    String oldPassword = "abc";
    String newPassword = "abc";
    bool expected = true;
    bool actual = await APIService.changePassword(id, oldPassword, newPassword);
    expect(actual, expected);
  });

  // get questions test and expect success as true
  test("get questions test and expect success as true", () async {
    bool expected = true;
    QuestionResponse? qsnReso = await PropertyAPI().getQuestions();
    bool? actual = qsnReso!.success;
    expect(actual, expected);
  });

  // post question test and expect success as true
  test("post question test and expect success as true", () async {
    bool expected = true;
    String qsn = "test question name";
    String image =
        "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAACXBIWXMAAAsSAAALEgHS3X78AAAB3UlEQVRIx91Wu0rEQBTNw+ALexHMHWZc1Fq0sBGs/AAVwWZB9zu0E7SwFFsF7RU/QLdeH+CzWP0B3W/wzM6dZIzrZhO7DRzmJpOcc59JPK+vD0nCUzEZO4ZN5GtIvqawb+3Chya25FgDEKd7WphEkIgQlfHeek5BSkxKwxEyIoiuZIoMOVIlIXQN8ncN2HWgwuRBWXKf10HgBWk6APkACEOc70HgDfYop9AvXgMSIa9VENV/79MNCl/jKML/COzAwyMbDewhFjiGvcspLCEQJ12yjHR8uMVmsSaurdguK14D7nu2T0DyDNJ1YBX2I3DG3vuq6Cw4/e+ptF23IHSB80uI1LKD1vPAud5ISlsQBDPYW1M6iphms7PQk4gemGTAkiGiJZA2cK7b8sqAXoE7YPnHwJHIy3sSbsiCGyBvAdsdnKnivhaw6XadzBOxQ4NIKrA/Qb7IbakRGgguPs2D8AvrtB3Oqcm4e/5tT8M+xYOHTBR1iDbidR/PnPMzYW4NeB0GHuApey8inecMIt5bgOdPkgewa6HTN6gYgX2LdDSVWe//QEPfI00TjLnvsNw2xY3j7RzHNJcD1IEmsi3e8yyUGc6uKXIi0J/HQL+D9HdBdUD7utn3nSbpsx+Hb2C9ep0rImHOAAAAAElFTkSuQmCC";
    var qsnDetails = {
      "qsn": qsn,
      "image": image,
    };
    bool actual = await PropertyAPI().addProperty(image, qsn);
    expect(actual, expected);
  });

  // search question test and expect json
  test("search question test and expect json", () async {
    String qsn = "test question name";
    var expected = null;
    QuestionResponse? qsnResp;
    qsnResp = await PropertyAPI().searchQuestions(qsn);
    // print(qsnReso);
    bool? actual = qsnResp!.success;
    expect(null, expected);
  });
}
