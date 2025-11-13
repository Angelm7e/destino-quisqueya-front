import 'package:destino_quisqueya_front/models/destiny.model.dart';
import 'package:destino_quisqueya_front/models/itinerary.model.dart';
import 'package:destino_quisqueya_front/utilities/const/app_colors.dart';
import 'package:destino_quisqueya_front/utilities/const/constants.dart';
import 'package:destino_quisqueya_front/utilities/dummyData/places.dart';
import 'package:destino_quisqueya_front/widgets/buttom.widget.dart';
import 'package:flutter/material.dart';

class ItineraryFormScreen extends StatefulWidget {
  const ItineraryFormScreen({super.key, this.itinerary});

  static const String routeName = '/itineraryForm';

  final Itinerary? itinerary; // null para crear, con valor para editar

  @override
  State<ItineraryFormScreen> createState() => _ItineraryFormScreenState();
}

class _ItineraryFormScreenState extends State<ItineraryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  List<Place> _selectedPlaces = [];
  bool _isLoading = false;

  bool get isEditing => widget.itinerary != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      final itinerary = widget.itinerary!;
      _nameController.text = itinerary.name;
      _descriptionController.text = itinerary.description;
      _startDate = itinerary.startDate;
      _endDate = itinerary.endDate;
      _selectedPlaces = List.from(itinerary.places);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      locale: const Locale('es', 'DO'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.lightPrimary, //color del círculo y encabezado
              onPrimary: Colors.white, //color del texto dentro del círculo
              onSurface: AppColors
                  .lightSecondary, //color del texto de los días normales
            ),
            // textButtonTheme: TextButtonThemeData(
            //   style: TextButton.styleFrom(
            //     foregroundColor: AppColors
            //         .primaryBlue, //color de los botones (CANCELAR/OK)
            //   ),
            // ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        // Si la fecha de fin es anterior a la de inicio, ajustarla
        if (_endDate != null && _endDate!.isBefore(picked)) {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _selectEndDate() async {
    if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Primero selecciona la fecha de inicio'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate!,
      firstDate: _startDate!,
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      locale: const Locale('es', 'DO'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.lightPrimary, //color del círculo y encabezado
              onPrimary: Colors.white, //color del texto dentro del círculo
              onSurface: AppColors
                  .lightSecondary, //color del texto de los días normales
            ),
            // textButtonTheme: TextButtonThemeData(
            //   style: TextButton.styleFrom(
            //     foregroundColor: AppColors
            //         .primaryBlue, //color de los botones (CANCELAR/OK)
            //   ),
            // ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  void _selectPlaces() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _PlacesSelectorBottomSheet(
        selectedPlaces: _selectedPlaces,
        onPlacesSelected: (places) {
          setState(() {
            _selectedPlaces = places;
          });
        },
      ),
    );
  }

  Future<void> _saveItinerary() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona las fechas del viaje'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_selectedPlaces.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona al menos un lugar'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simular guardado
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditing
                ? 'Itinerario actualizado exitosamente'
                : 'Itinerario creado exitosamente',
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.lightSuccess,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar itinerario' : 'Nuevo itinerario'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Nombre del itinerario
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre del itinerario',
                  hintText: 'Ej: Semana Santa en Samaná',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Descripción
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  hintText: 'Describe tu itinerario...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Fechas
              Text(
                'Fechas del viaje',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _DateSelector(
                      label: 'Fecha de inicio',
                      date: _startDate,
                      onTap: _selectStartDate,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _DateSelector(
                      label: 'Fecha de fin',
                      date: _endDate,
                      onTap: _selectEndDate,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Lugares
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lugares a visitar',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _selectPlaces,
                    icon: const Icon(Icons.add),
                    label: Text(
                      _selectedPlaces.isEmpty
                          ? 'Agregar lugares'
                          : 'Editar lugares',
                    ),
                  ),
                ],
              ),

              if (_selectedPlaces.isEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'No has seleccionado lugares aún',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                )
              else
                ..._selectedPlaces.map(
                  (place) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          place.photos.first,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(place.name),
                      subtitle: Text('${place.province}, ${place.country}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _selectedPlaces.removeWhere(
                              (p) => p.id == place.id,
                            );
                          });
                        },
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 32),

              // Botón guardar
              DQButtom(
                onTap: _isLoading
                    ? () {}
                    : () {
                        _saveItinerary();
                      },
                isLoading: _isLoading,
                labeltext: isEditing ? 'Actualizar' : 'Crear itinerario',
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget selector de fecha
class _DateSelector extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;

  const _DateSelector({
    required this.label,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: AppColors.lightPrimary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    date != null
                        ? '${date!.day}/${date!.month}/${date!.year}'
                        : 'Seleccionar fecha',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: date != null
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: date != null ? null : Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Bottom Sheet para seleccionar lugares
class _PlacesSelectorBottomSheet extends StatefulWidget {
  final List<Place> selectedPlaces;
  final Function(List<Place>) onPlacesSelected;

  const _PlacesSelectorBottomSheet({
    required this.selectedPlaces,
    required this.onPlacesSelected,
  });

  @override
  State<_PlacesSelectorBottomSheet> createState() =>
      _PlacesSelectorBottomSheetState();
}

class _PlacesSelectorBottomSheetState
    extends State<_PlacesSelectorBottomSheet> {
  late List<Place> _selectedPlaces;

  @override
  void initState() {
    super.initState();
    _selectedPlaces = List.from(widget.selectedPlaces);
  }

  void _togglePlace(Place place) {
    setState(() {
      final index = _selectedPlaces.indexWhere((p) => p.id == place.id);
      if (index >= 0) {
        _selectedPlaces.removeAt(index);
      } else {
        _selectedPlaces.add(place);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(horizontalPadding),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Seleccionar lugares',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${_selectedPlaces.length} seleccionados',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.lightPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: placesDummy.length,
              itemBuilder: (context, index) {
                final place = placesDummy[index];
                final isSelected = _selectedPlaces.any((p) => p.id == place.id);

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  color: isSelected
                      ? AppColors.lightPrimary.withOpacity(0.1)
                      : null,
                  child: CheckboxListTile(
                    value: isSelected,
                    onChanged: (_) => _togglePlace(place),
                    title: Text(place.name),
                    subtitle: Text('${place.province}, ${place.country}'),
                    secondary: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        place.photos.first,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    activeColor: AppColors.lightPrimary,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onPlacesSelected(_selectedPlaces);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightPrimary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Aplicar'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
