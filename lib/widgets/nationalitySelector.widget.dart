import 'package:country_flags/country_flags.dart';
import 'package:destino_quisqueya_front/utilities/const/app_colors.dart';
import 'package:flutter/material.dart';

class Country {
  final String code;
  final String name;
  final String dialCode;
  final String iso3;
  final Map<String, String> translations;

  const Country({
    required this.code,
    required this.name,
    this.dialCode = '',
    this.iso3 = '',
    this.translations = const {},
  });

  /// Obtiene el nombre del país en el idioma especificado
  /// Si no existe la traducción, devuelve el nombre por defecto
  String getName([String languageCode = 'es']) {
    if (translations.isEmpty) return name;
    return translations[languageCode] ?? translations['es'] ?? name;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;
}

/// Servicio para búsqueda de países
class CountryService {
  /// Normaliza una cadena removiendo tildes y convirtiendo a minúsculas
  /// para hacer búsquedas más flexibles
  static String _normalizeString(String text) {
    return text
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ñ', 'n')
        .replaceAll('ü', 'u')
        .replaceAll('Á', 'a')
        .replaceAll('É', 'e')
        .replaceAll('Í', 'i')
        .replaceAll('Ó', 'o')
        .replaceAll('Ú', 'u')
        .replaceAll('Ñ', 'n')
        .replaceAll('Ü', 'u');
  }

  /// Busca países por query, buscando en código, nombre, dialCode, iso3 y traducciones
  /// La búsqueda es flexible e ignora tildes
  static List<Country> search(
    String query, {
    String? languageCode,
    List<Country> countries = const [],
  }) {
    if (query.isEmpty) return countries;

    final normalizedQuery = _normalizeString(query.trim());
    if (normalizedQuery.isEmpty) return countries;

    return countries.where((country) {
      // Buscar en código
      if (_normalizeString(country.code).contains(normalizedQuery)) {
        return true;
      }

      // Buscar en nombre según idioma
      final nameToSearch = languageCode != null
          ? country.getName(languageCode)
          : country.name;

      if (_normalizeString(nameToSearch).contains(normalizedQuery)) {
        return true;
      }

      // Buscar en dialCode (si existe)
      if (country.dialCode.isNotEmpty &&
          _normalizeString(country.dialCode).contains(normalizedQuery)) {
        return true;
      }

      // Buscar en iso3 (si existe)
      if (country.iso3.isNotEmpty &&
          _normalizeString(country.iso3).contains(normalizedQuery)) {
        return true;
      }

      // Buscar en traducciones
      if (languageCode != null) {
        // Buscar solo en la traducción del idioma especificado
        final translation = country.translations[languageCode];
        if (translation != null &&
            _normalizeString(translation).contains(normalizedQuery)) {
          return true;
        }
      } else {
        // Buscar en todas las traducciones
        if (country.translations.values.any(
          (v) => _normalizeString(v).contains(normalizedQuery),
        )) {
          return true;
        }
      }

      return false;
    }).toList();
  }
}

class NationalitySelectorWidget extends StatelessWidget {
  final String? selectedCountryCode;
  final ValueChanged<String?> onChanged;
  final String? labelText;
  final String hintText;
  final String languageCode;

  const NationalitySelectorWidget({
    super.key,
    this.selectedCountryCode,
    required this.onChanged,
    this.labelText,
    this.hintText = 'Seleccionar nacionalidad',
    this.languageCode = 'es',
  });

  static const List<Country> countries = [
    Country(
      code: 'AD',
      name: 'Andorra',
      dialCode: '+376',
      iso3: 'AND',
      translations: {'es': 'Andorra', 'en': 'Andorra'},
    ),
    Country(
      code: 'AE',
      name: 'United Arab Emirates',
      dialCode: '+971',
      iso3: 'ARE',
      translations: {
        'es': 'Emiratos Árabes Unidos',
        'en': 'United Arab Emirates',
      },
    ),
    Country(
      code: 'AF',
      name: 'Afghanistan',
      dialCode: '+93',
      iso3: 'AFG',
      translations: {'es': 'Afganistán', 'en': 'Afghanistan'},
    ),
    Country(code: 'AG', name: 'Antigua y Barbuda'),
    Country(code: 'AI', name: 'Anguila'),
    Country(code: 'AL', name: 'Albania'),
    Country(code: 'AM', name: 'Armenia'),
    Country(code: 'AO', name: 'Angola'),
    Country(code: 'AQ', name: 'Antártida'),
    Country(code: 'AR', name: 'Argentina'),
    Country(code: 'AS', name: 'Samoa Americana'),
    Country(code: 'AT', name: 'Austria'),
    Country(code: 'AU', name: 'Australia'),
    Country(code: 'AW', name: 'Aruba'),
    Country(code: 'AX', name: 'Islas Åland'),
    Country(code: 'AZ', name: 'Azerbaiyán'),
    Country(code: 'BA', name: 'Bosnia y Herzegovina'),
    Country(code: 'BB', name: 'Barbados'),
    Country(code: 'BD', name: 'Bangladesh'),
    Country(code: 'BE', name: 'Bélgica'),
    Country(code: 'BF', name: 'Burkina Faso'),
    Country(code: 'BG', name: 'Bulgaria'),
    Country(code: 'BH', name: 'Baréin'),
    Country(code: 'BI', name: 'Burundi'),
    Country(code: 'BJ', name: 'Benín'),
    Country(code: 'BL', name: 'San Bartolomé'),
    Country(code: 'BM', name: 'Bermudas'),
    Country(code: 'BN', name: 'Brunéi'),
    Country(code: 'BO', name: 'Bolivia'),
    Country(code: 'BQ', name: 'Caribe Neerlandés'),
    Country(code: 'BR', name: 'Brasil'),
    Country(code: 'BS', name: 'Bahamas'),
    Country(code: 'BT', name: 'Bután'),
    Country(code: 'BV', name: 'Isla Bouvet'),
    Country(code: 'BW', name: 'Botsuana'),
    Country(code: 'BY', name: 'Bielorrusia'),
    Country(code: 'BZ', name: 'Belice'),
    Country(code: 'CA', name: 'Canadá'),
    Country(code: 'CC', name: 'Islas Cocos'),
    Country(code: 'CD', name: 'República Democrática del Congo'),
    Country(code: 'CF', name: 'República Centroafricana'),
    Country(code: 'CG', name: 'República del Congo'),
    Country(code: 'CH', name: 'Suiza'),
    Country(code: 'CI', name: 'Costa de Marfil'),
    Country(code: 'CK', name: 'Islas Cook'),
    Country(code: 'CL', name: 'Chile'),
    Country(code: 'CM', name: 'Camerún'),
    Country(code: 'CN', name: 'China'),
    Country(code: 'CO', name: 'Colombia'),
    Country(code: 'CR', name: 'Costa Rica'),
    Country(code: 'CU', name: 'Cuba'),
    Country(code: 'CV', name: 'Cabo Verde'),
    Country(code: 'CW', name: 'Curazao'),
    Country(code: 'CX', name: 'Isla de Navidad'),
    Country(code: 'CY', name: 'Chipre'),
    Country(code: 'CZ', name: 'República Checa'),
    Country(code: 'DE', name: 'Alemania'),
    Country(code: 'DJ', name: 'Yibuti'),
    Country(code: 'DK', name: 'Dinamarca'),
    Country(code: 'DM', name: 'Dominica'),
    Country(
      code: 'DO',
      name: 'Dominican Republic',
      dialCode: '+1',
      iso3: 'DOM',
      translations: {'es': 'República Dominicana', 'en': 'Dominican Republic'},
    ),
    Country(code: 'DZ', name: 'Argelia'),
    Country(code: 'EC', name: 'Ecuador'),
    Country(code: 'EE', name: 'Estonia'),
    Country(code: 'EG', name: 'Egipto'),
    Country(code: 'EH', name: 'Sahara Occidental'),
    Country(code: 'ER', name: 'Eritrea'),
    Country(
      code: 'ES',
      name: 'Spain',
      dialCode: '+34',
      iso3: 'ESP',
      translations: {'es': 'España', 'en': 'Spain'},
    ),
    Country(code: 'ET', name: 'Etiopía'),
    Country(code: 'FI', name: 'Finlandia'),
    Country(code: 'FJ', name: 'Fiyi'),
    Country(code: 'FK', name: 'Islas Malvinas'),
    Country(code: 'FM', name: 'Micronesia'),
    Country(code: 'FO', name: 'Islas Feroe'),
    Country(code: 'FR', name: 'Francia'),
    Country(code: 'GA', name: 'Gabón'),
    Country(code: 'GB', name: 'Reino Unido'),
    Country(code: 'GD', name: 'Granada'),
    Country(code: 'GE', name: 'Georgia'),
    Country(code: 'GF', name: 'Guayana Francesa'),
    Country(code: 'GG', name: 'Guernsey'),
    Country(code: 'GH', name: 'Ghana'),
    Country(code: 'GI', name: 'Gibraltar'),
    Country(code: 'GL', name: 'Groenlandia'),
    Country(code: 'GM', name: 'Gambia'),
    Country(code: 'GN', name: 'Guinea'),
    Country(code: 'GP', name: 'Guadalupe'),
    Country(code: 'GQ', name: 'Guinea Ecuatorial'),
    Country(code: 'GR', name: 'Grecia'),
    Country(code: 'GS', name: 'Islas Georgia del Sur y Sandwich del Sur'),
    Country(code: 'GT', name: 'Guatemala'),
    Country(code: 'GU', name: 'Guam'),
    Country(code: 'GW', name: 'Guinea-Bisáu'),
    Country(code: 'GY', name: 'Guyana'),
    Country(code: 'HK', name: 'Hong Kong'),
    Country(code: 'HM', name: 'Islas Heard y McDonald'),
    Country(code: 'HN', name: 'Honduras'),
    Country(code: 'HR', name: 'Croacia'),
    Country(code: 'HT', name: 'Haití'),
    Country(code: 'HU', name: 'Hungría'),
    Country(code: 'ID', name: 'Indonesia'),
    Country(code: 'IE', name: 'Irlanda'),
    Country(code: 'IL', name: 'Israel'),
    Country(code: 'IM', name: 'Isla de Man'),
    Country(code: 'IN', name: 'India'),
    Country(code: 'IO', name: 'Territorio Británico del Océano Índico'),
    Country(code: 'IQ', name: 'Irak'),
    Country(code: 'IR', name: 'Irán'),
    Country(code: 'IS', name: 'Islandia'),
    Country(code: 'IT', name: 'Italia'),
    Country(code: 'JE', name: 'Jersey'),
    Country(code: 'JM', name: 'Jamaica'),
    Country(code: 'JO', name: 'Jordania'),
    Country(code: 'JP', name: 'Japón'),
    Country(code: 'KE', name: 'Kenia'),
    Country(code: 'KG', name: 'Kirguistán'),
    Country(code: 'KH', name: 'Camboya'),
    Country(code: 'KI', name: 'Kiribati'),
    Country(code: 'KM', name: 'Comoras'),
    Country(code: 'KN', name: 'San Cristóbal y Nieves'),
    Country(code: 'KP', name: 'Corea del Norte'),
    Country(code: 'KR', name: 'Corea del Sur'),
    Country(code: 'KW', name: 'Kuwait'),
    Country(code: 'KY', name: 'Islas Caimán'),
    Country(code: 'KZ', name: 'Kazajistán'),
    Country(code: 'LA', name: 'Laos'),
    Country(code: 'LB', name: 'Líbano'),
    Country(code: 'LC', name: 'Santa Lucía'),
    Country(code: 'LI', name: 'Liechtenstein'),
    Country(code: 'LK', name: 'Sri Lanka'),
    Country(code: 'LR', name: 'Liberia'),
    Country(code: 'LS', name: 'Lesoto'),
    Country(code: 'LT', name: 'Lituania'),
    Country(code: 'LU', name: 'Luxemburgo'),
    Country(code: 'LV', name: 'Letonia'),
    Country(code: 'LY', name: 'Libia'),
    Country(code: 'MA', name: 'Marruecos'),
    Country(code: 'MC', name: 'Mónaco'),
    Country(code: 'MD', name: 'Moldavia'),
    Country(code: 'ME', name: 'Montenegro'),
    Country(code: 'MF', name: 'San Martín'),
    Country(code: 'MG', name: 'Madagascar'),
    Country(code: 'MH', name: 'Islas Marshall'),
    Country(code: 'MK', name: 'Macedonia del Norte'),
    Country(code: 'ML', name: 'Malí'),
    Country(code: 'MM', name: 'Myanmar'),
    Country(code: 'MN', name: 'Mongolia'),
    Country(code: 'MO', name: 'Macao'),
    Country(code: 'MP', name: 'Islas Marianas del Norte'),
    Country(code: 'MQ', name: 'Martinica'),
    Country(code: 'MR', name: 'Mauritania'),
    Country(code: 'MS', name: 'Montserrat'),
    Country(code: 'MT', name: 'Malta'),
    Country(code: 'MU', name: 'Mauricio'),
    Country(code: 'MV', name: 'Maldivas'),
    Country(code: 'MW', name: 'Malaui'),
    Country(
      code: 'MX',
      name: 'Mexico',
      dialCode: '+52',
      iso3: 'MEX',
      translations: {'es': 'México', 'en': 'Mexico'},
    ),
    Country(code: 'MY', name: 'Malasia'),
    Country(code: 'MZ', name: 'Mozambique'),
    Country(code: 'NA', name: 'Namibia'),
    Country(code: 'NC', name: 'Nueva Caledonia'),
    Country(code: 'NE', name: 'Níger'),
    Country(code: 'NF', name: 'Isla Norfolk'),
    Country(code: 'NG', name: 'Nigeria'),
    Country(code: 'NI', name: 'Nicaragua'),
    Country(code: 'NL', name: 'Países Bajos'),
    Country(code: 'NO', name: 'Noruega'),
    Country(code: 'NP', name: 'Nepal'),
    Country(code: 'NR', name: 'Nauru'),
    Country(code: 'NU', name: 'Niue'),
    Country(code: 'NZ', name: 'Nueva Zelanda'),
    Country(code: 'OM', name: 'Omán'),
    Country(code: 'PA', name: 'Panamá'),
    Country(code: 'PE', name: 'Perú'),
    Country(code: 'PF', name: 'Polinesia Francesa'),
    Country(code: 'PG', name: 'Papúa Nueva Guinea'),
    Country(code: 'PH', name: 'Filipinas'),
    Country(code: 'PK', name: 'Pakistán'),
    Country(code: 'PL', name: 'Polonia'),
    Country(code: 'PM', name: 'San Pedro y Miquelón'),
    Country(code: 'PN', name: 'Islas Pitcairn'),
    Country(code: 'PR', name: 'Puerto Rico'),
    Country(code: 'PS', name: 'Palestina'),
    Country(code: 'PT', name: 'Portugal'),
    Country(code: 'PW', name: 'Palaos'),
    Country(code: 'PY', name: 'Paraguay'),
    Country(code: 'QA', name: 'Catar'),
    Country(code: 'RE', name: 'Reunión'),
    Country(code: 'RO', name: 'Rumania'),
    Country(code: 'RS', name: 'Serbia'),
    Country(code: 'RU', name: 'Rusia'),
    Country(code: 'RW', name: 'Ruanda'),
    Country(code: 'SA', name: 'Arabia Saudí'),
    Country(code: 'SB', name: 'Islas Salomón'),
    Country(code: 'SC', name: 'Seychelles'),
    Country(code: 'SD', name: 'Sudán'),
    Country(code: 'SE', name: 'Suecia'),
    Country(code: 'SG', name: 'Singapur'),
    Country(code: 'SH', name: 'Santa Elena'),
    Country(code: 'SI', name: 'Eslovenia'),
    Country(code: 'SJ', name: 'Svalbard y Jan Mayen'),
    Country(code: 'SK', name: 'Eslovaquia'),
    Country(code: 'SL', name: 'Sierra Leona'),
    Country(code: 'SM', name: 'San Marino'),
    Country(code: 'SN', name: 'Senegal'),
    Country(code: 'SO', name: 'Somalia'),
    Country(code: 'SR', name: 'Surinam'),
    Country(code: 'SS', name: 'Sudán del Sur'),
    Country(code: 'ST', name: 'Santo Tomé y Príncipe'),
    Country(code: 'SV', name: 'El Salvador'),
    Country(code: 'SX', name: 'Sint Maarten'),
    Country(code: 'SY', name: 'Siria'),
    Country(code: 'SZ', name: 'Esuatini'),
    Country(code: 'TC', name: 'Islas Turcas y Caicos'),
    Country(code: 'TD', name: 'Chad'),
    Country(code: 'TF', name: 'Territorios Australes Franceses'),
    Country(code: 'TG', name: 'Togo'),
    Country(code: 'TH', name: 'Tailandia'),
    Country(code: 'TJ', name: 'Tayikistán'),
    Country(code: 'TK', name: 'Tokelau'),
    Country(code: 'TL', name: 'Timor Oriental'),
    Country(code: 'TM', name: 'Turkmenistán'),
    Country(code: 'TN', name: 'Túnez'),
    Country(code: 'TO', name: 'Tonga'),
    Country(code: 'TR', name: 'Turquía'),
    Country(code: 'TT', name: 'Trinidad y Tobago'),
    Country(code: 'TV', name: 'Tuvalu'),
    Country(code: 'TW', name: 'Taiwán'),
    Country(code: 'TZ', name: 'Tanzania'),
    Country(code: 'UA', name: 'Ucrania'),
    Country(code: 'UG', name: 'Uganda'),
    Country(code: 'UM', name: 'Islas Ultramarinas de Estados Unidos'),
    Country(
      code: 'US',
      name: 'United States',
      dialCode: '+1',
      iso3: 'USA',
      translations: {'es': 'Estados Unidos', 'en': 'United States'},
    ),
    Country(code: 'UY', name: 'Uruguay'),
    Country(code: 'UZ', name: 'Uzbekistán'),
    Country(code: 'VA', name: 'Ciudad del Vaticano'),
    Country(code: 'VC', name: 'San Vicente y las Granadinas'),
    Country(code: 'VE', name: 'Venezuela'),
    Country(code: 'VG', name: 'Islas Vírgenes Británicas'),
    Country(code: 'VI', name: 'Islas Vírgenes de los Estados Unidos'),
    Country(code: 'VN', name: 'Vietnam'),
    Country(code: 'VU', name: 'Vanuatu'),
    Country(code: 'WF', name: 'Wallis y Futuna'),
    Country(code: 'WS', name: 'Samoa'),
    Country(code: 'XK', name: 'Kosovo'),
    Country(code: 'YE', name: 'Yemen'),
    Country(code: 'YT', name: 'Mayotte'),
    Country(code: 'ZA', name: 'Sudáfrica'),
    Country(code: 'ZM', name: 'Zambia'),
    Country(code: 'ZW', name: 'Zimbabue'),
  ];

  static String? getCountryName(
    String? countryCode, [
    String languageCode = 'es',
  ]) {
    if (countryCode == null || countryCode.isEmpty) return null;
    try {
      return countries
          .firstWhere((c) => c.code.toUpperCase() == countryCode.toUpperCase())
          .getName(languageCode);
    } catch (e) {
      return null;
    }
  }

  static Country? getCountryByCode(String? countryCode) {
    if (countryCode == null || countryCode.isEmpty) return null;
    try {
      return countries.firstWhere(
        (c) => c.code.toUpperCase() == countryCode.toUpperCase(),
      );
    } catch (e) {
      return null;
    }
  }

  void _showCountrySelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CountrySelectorBottomSheet(
        selectedCountryCode: selectedCountryCode,
        languageCode: languageCode,
        onCountrySelected: (countryCode) {
          onChanged(countryCode);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedCountry = getCountryByCode(selectedCountryCode);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              labelText!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
          ),
        ],
        GestureDetector(
          onTap: () => _showCountrySelector(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.lightSecondary, width: 1),
            ),
            child: Row(
              children: [
                if (selectedCountryCode != null) ...[
                  SizedBox(
                    width: 32,
                    height: 24,
                    child: CountryFlag.fromCountryCode(
                      selectedCountryCode!,
                      theme: const ImageTheme(
                        width: 32,
                        height: 24,
                        shape: RoundedRectangle(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ] else ...[
                  Icon(
                    Icons.flag_outlined,
                    color: AppColors.lightSecondary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    selectedCountry != null
                        ? selectedCountry.getName(languageCode)
                        : hintText,
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedCountry != null
                          ? (Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary)
                          : AppColors.lightSecondary,
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: AppColors.lightSecondary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CountrySelectorBottomSheet extends StatefulWidget {
  final String? selectedCountryCode;
  final String languageCode;
  final ValueChanged<String?> onCountrySelected;

  const _CountrySelectorBottomSheet({
    required this.selectedCountryCode,
    required this.languageCode,
    required this.onCountrySelected,
  });

  @override
  State<_CountrySelectorBottomSheet> createState() =>
      _CountrySelectorBottomSheetState();
}

class _CountrySelectorBottomSheetState
    extends State<_CountrySelectorBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Country> _filteredCountries = NationalitySelectorWidget.countries;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterCountries);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCountries);
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries() {
    final query = _searchController.text;
    setState(() {
      _filteredCountries = CountryService.search(
        query,
        languageCode: widget.languageCode,
        countries: NationalitySelectorWidget.countries,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.lightSecondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text(
                  'Seleccionar Nacionalidad',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightTextPrimary,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  color: AppColors.lightSecondary,
                ),
              ],
            ),
          ),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar país...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.lightSecondary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.lightPrimary,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Countries list
          Expanded(
            child: _filteredCountries.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppColors.lightSecondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No se encontraron países',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.lightSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredCountries.length,
                    itemBuilder: (context, index) {
                      final country = _filteredCountries[index];
                      final isSelected =
                          widget.selectedCountryCode?.toUpperCase() ==
                          country.code.toUpperCase();

                      return InkWell(
                        onTap: () => widget.onCountrySelected(country.code),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.lightPrimary.withOpacity(0.1)
                                : Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40,
                                height: 30,
                                child: CountryFlag.fromCountryCode(
                                  country.code,
                                  theme: const ImageTheme(
                                    width: 40,
                                    height: 30,
                                    shape: RoundedRectangle(4),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  country.getName(widget.languageCode),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? AppColors.lightPrimary
                                        : AppColors.lightTextPrimary,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.lightPrimary,
                                  size: 24,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
