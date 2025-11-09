class DominicanPerson {
  String? cedula;
  String? nombres;
  String? apellido1;
  String? apellido2;
  String? fechaNacimiento;
  String? lugarNacimiento;
  String? idSexo;
  String? estadoCivil;
  String? ocupacion;
  String? nacionalidad;
  String? cedulaAnterior;
  String? provincia;
  String? referenciaCercana;
  String? direccionReferenciaCercana;
  String? sectordeRecidencia;

  DominicanPerson({
    this.cedula,
    this.nombres,
    this.apellido1,
    this.apellido2,
    this.fechaNacimiento,
    this.lugarNacimiento,
    this.idSexo,
    this.estadoCivil,
    this.ocupacion,
    this.nacionalidad,
    this.cedulaAnterior,
    this.provincia,
    this.referenciaCercana,
    this.direccionReferenciaCercana,
    this.sectordeRecidencia,
  });

  DominicanPerson.fromJson(Map<String, dynamic> json) {
    cedula = json['cedula'];
    nombres = json['nombres'];
    apellido1 = json['apellido1'];
    apellido2 = json['apellido2'];
    fechaNacimiento = json['fechaNacimiento'];
    lugarNacimiento = json['lugarNacimiento'];
    idSexo = json['idSexo'];
    estadoCivil = json['estadoCivil'];
    ocupacion = json['ocupacion'];
    nacionalidad = json['nacionalidad'];
    cedulaAnterior = json['cedulaAnterior'];
    provincia = json['provincia'];
    referenciaCercana = json['referenciaCercana'];
    direccionReferenciaCercana = json['direccionReferenciaCercana'];
    sectordeRecidencia = json['sectordeRecidencia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cedula'] = cedula;
    data['nombres'] = nombres;
    data['apellido1'] = apellido1;
    data['apellido2'] = apellido2;
    data['fechaNacimiento'] = fechaNacimiento;
    data['lugarNacimiento'] = lugarNacimiento;
    data['idSexo'] = idSexo;
    data['estadoCivil'] = estadoCivil;
    data['ocupacion'] = ocupacion;
    data['nacionalidad'] = nacionalidad;
    data['cedulaAnterior'] = cedulaAnterior;
    data['provincia'] = provincia;
    data['referenciaCercana'] = referenciaCercana;
    data['direccionReferenciaCercana'] = direccionReferenciaCercana;
    data['sectordeRecidencia'] = sectordeRecidencia;
    return data;
  }
}
