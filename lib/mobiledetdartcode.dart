// To parse this JSON data, do
//
//     final jason = jasonFromJson(jsonString);

import 'dart:convert';

Jason jasonFromJson(String str) => Jason.fromJson(json.decode(str));

String jasonToJson(Jason data) => json.encode(data.toJson());

class Jason {
    Data data;

    Jason({
        this.data,
    });

    factory Jason.fromJson(Map<String, dynamic> json) => new Jason(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    List<String> mainSpecs;
    SubSpecs subSpecs;

    Data({
        this.mainSpecs,
        this.subSpecs,
    });

    factory Data.fromJson(Map<String, dynamic> json) => new Data(
        mainSpecs: new List<String>.from(json["main_specs"].map((x) => x)),
        subSpecs: SubSpecs.fromJson(json["sub_specs"]),
    );

    Map<String, dynamic> toJson() => {
        "main_specs": new List<dynamic>.from(mainSpecs.map((x) => x)),
        "sub_specs": subSpecs.toJson(),
    };
}

class SubSpecs {
    List<Battery> display;
    List<Battery> storage;
    List<Battery> general;
    List<Battery> software;
    List<Battery> camera;
    List<Battery> battery;
    List<Battery> connectivity;
    List<Battery> processor;
    List<Battery> sensors;
    List<Battery> sound;

    SubSpecs({
        this.display,
        this.storage,
        this.general,
        this.software,
        this.camera,
        this.battery,
        this.connectivity,
        this.processor,
        this.sensors,
        this.sound,
    });

    factory SubSpecs.fromJson(Map<String, dynamic> json) => new SubSpecs(
        display: new List<Battery>.from(json["Display"].map((x) => Battery.fromJson(x))),
        storage: new List<Battery>.from(json["Storage"].map((x) => Battery.fromJson(x))),
        general: new List<Battery>.from(json["General"].map((x) => Battery.fromJson(x))),
        software: new List<Battery>.from(json["Software"].map((x) => Battery.fromJson(x))),
        camera: new List<Battery>.from(json["Camera"].map((x) => Battery.fromJson(x))),
        battery: new List<Battery>.from(json["Battery"].map((x) => Battery.fromJson(x))),
        connectivity: new List<Battery>.from(json["Connectivity"].map((x) => Battery.fromJson(x))),
        processor: new List<Battery>.from(json["Processor"].map((x) => Battery.fromJson(x))),
        sensors: new List<Battery>.from(json["Sensors"].map((x) => Battery.fromJson(x))),
        sound: new List<Battery>.from(json["Sound"].map((x) => Battery.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Display": new List<dynamic>.from(display.map((x) => x.toJson())),
        "Storage": new List<dynamic>.from(storage.map((x) => x.toJson())),
        "General": new List<dynamic>.from(general.map((x) => x.toJson())),
        "Software": new List<dynamic>.from(software.map((x) => x.toJson())),
        "Camera": new List<dynamic>.from(camera.map((x) => x.toJson())),
        "Battery": new List<dynamic>.from(battery.map((x) => x.toJson())),
        "Connectivity": new List<dynamic>.from(connectivity.map((x) => x.toJson())),
        "Processor": new List<dynamic>.from(processor.map((x) => x.toJson())),
        "Sensors": new List<dynamic>.from(sensors.map((x) => x.toJson())),
        "Sound": new List<dynamic>.from(sound.map((x) => x.toJson())),
    };
}

class Battery {
    String specKey;
    String specValue;

    Battery({
        this.specKey,
        this.specValue,
    });

    factory Battery.fromJson(Map<String, dynamic> json) => new Battery(
        specKey: json["spec_key"],
        specValue: json["spec_value"],
    );

    Map<String, dynamic> toJson() => {
        "spec_key": specKey,
        "spec_value": specValue,
    };
}
