import 'package:hive_flutter/hive_flutter.dart';
import '../models/disaster_model.dart';
import '../models/medical_model.dart';
import '../models/checklist_model.dart';

/// Data Repository - Mengelola semua akses data offline menggunakan Hive
class DataRepository {
  static const String _disastersBoxName = 'disasters';
  static const String _medicalBoxName = 'medical_emergencies';
  static const String _checklistBoxName = 'checklist_items';
  static const String _settingsBoxName = 'app_settings';

  static DataRepository? _instance;
  static DataRepository get instance => _instance ??= DataRepository._internal();

  DataRepository._internal();

  late Box<Disaster> _disastersBox;
  late Box<MedicalEmergency> _medicalBox;
  late Box<ChecklistItem> _checklistBox;
  late Box<dynamic> _settingsBox;

  bool _isInitialized = false;

  /// Inisialisasi Hive dan membuka semua box
  Future<void> initialize() async {
    if (_isInitialized) return;

    await Hive.initFlutter();
    
    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DisasterAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(MedicalEmergencyAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(ChecklistItemAdapter());
    }

    // Open boxes
    _disastersBox = await Hive.openBox<Disaster>(_disastersBoxName);
    _medicalBox = await Hive.openBox<MedicalEmergency>(_medicalBoxName);
    _checklistBox = await Hive.openBox<ChecklistItem>(_checklistBoxName);
    _settingsBox = await Hive.openBox(_settingsBoxName);

    // Seed data jika box kosong
    if (_disastersBox.isEmpty) {
      await _seedDisasters();
    }
    if (_medicalBox.isEmpty) {
      await _seedMedical();
    }
    if (_checklistBox.isEmpty) {
      await _seedChecklist();
    }
    if (_settingsBox.isEmpty) {
      await _seedSettings();
    }

    _isInitialized = true;
  }

  // MARK: Disaster Data

  List<Disaster> getAllDisasters() {
    return _disastersBox.values.toList();
  }

  Disaster? getDisasterById(String id) {
    return _disastersBox.get(id);
  }

  Future<void> saveDisaster(Disaster disaster) async {
    await _disastersBox.put(disaster.id, disaster);
  }

  Future<void> deleteDisaster(String id) async {
    await _disastersBox.delete(id);
  }

  // MARK: Medical Data

  List<MedicalEmergency> getAllMedicalEmergencies() {
    return _medicalBox.values.toList();
  }

  MedicalEmergency? getMedicalById(String id) {
    return _medicalBox.get(id);
  }

  Future<void> saveMedical(MedicalEmergency medical) async {
    await _medicalBox.put(medical.id, medical);
  }

  Future<void> deleteMedical(String id) async {
    await _medicalBox.delete(id);
  }

  // MARK: Checklist Data

  List<ChecklistItem> getAllChecklistItems() {
    return _checklistBox.values.toList();
  }

  List<ChecklistItem> getChecklistByCategory(String category) {
    return _checklistBox.values
        .where((item) => item.category == category)
        .toList();
  }

  Future<void> saveChecklist(ChecklistItem item) async {
    await _checklistBox.put(item.id, item);
  }

  Future<void> toggleChecklist(String id) async {
    final item = _checklistBox.get(id);
    if (item != null) {
      await _checklistBox.put(id, item.toggle());
    }
  }

  int getCheckedCountByCategory(String category) {
    return getChecklistByCategory(category)
        .where((item) => item.isChecked)
        .length;
  }

  // MARK: Settings Data

  bool get isDarkMode => _settingsBox.get('darkMode', defaultValue: true);
  set isDarkMode(bool value) {
    _settingsBox.put('darkMode', value);
  }

  bool get isNotificationsEnabled =>
      _settingsBox.get('notifications', defaultValue: false);
  set isNotificationsEnabled(bool value) {
    _settingsBox.put('notifications', value);
  }

  String get language => _settingsBox.get('language', defaultValue: 'id');
  set language(String value) {
    _settingsBox.put('language', value);
  }

  String get appVersion =>
      _settingsBox.get('appVersion', defaultValue: '1.0.0');

  // MARK: Seed Data

  Future<void> _seedDisasters() async {
    final seedData = [
      Disaster(
        id: 'gempa',
        title: 'Gempa Bumi',
        description: 'Getaran permukaan tanah akibat pelepasan energi tektonik.',
        assetPath: 'assets/natural_disaster_list.html',
        icon: '🌍',
        symptoms: ['Rasa mual', 'Pusing', 'Luka karena reruntuhan'],
        precautions: [
          'DROP - Berlutut ke tanah',
          'COVER - Lindungi kepala dan leher',
          'HOLD ON - Pegangan sampai getaran berhenti',
        ],
      ),
      Disaster(
        id: 'banjir',
        title: 'Banjir',
        description: 'Banjir bandang dan genangan akibat curah hujan tinggi.',
        assetPath: 'assets/natural_disaster_list.html',
        icon: '🌊',
        symptoms: ['Hipotermia', 'Infeksi kulit', 'Dehidrasi'],
        precautions: [
          'Pindahkan ke tempat tinggi',
          'Matikan listrik utama',
          'Siapkan air bersih dan makanan kaleng',
        ],
      ),
      Disaster(
        id: 'gunung_meletus',
        title: 'Gunung Meletus',
        description: 'Aktivitas vulkanik yang mengeluarkan lava, abu, dan gas.',
        assetPath: 'assets/natural_disaster_list.html',
        icon: '🌋',
        symptoms: ['Gangguan pernapasan', 'Iritasi mata', 'Luka bakar'],
        precautions: [
          'Gunakan masker/penutup hidung',
          'Evakuasi ke zona aman',
          'Jauhi daerah aliran lahar',
        ],
      ),
      Disaster(
        id: 'tsunami',
        title: 'Tsunami',
        description: 'Gelombang laut besar akibat gempa bawah laut.',
        assetPath: 'assets/natural_disaster_list.html',
        icon: '🌊',
        symptoms: ['Tenggelam', 'Luka benturan', 'Hipotermia'],
        precautions: [
          'Pergi ke daratan tinggi',
          'Hindari garis pantai',
          'Waspadai sinyal peringatan alam',
        ],
      ),
      Disaster(
        id: 'kekeringan',
        title: 'Kekeringan',
        description: 'Kurangnya pasokan air dalam waktu lama.',
        assetPath: 'assets/natural_disaster_list.html',
        icon: '☀️',
        symptoms: ['Dehidrasi', 'Heat stroke', 'Kekurangan nutrisi'],
        precautions: [
          'Hemat penggunaan air',
          'Simpan cadangan air minum',
          'Hindari aktivitas luar ruangan jam panas',
        ],
      ),
      Disaster(
        id: 'tanah_longsor',
        title: 'Tanah Longsor',
        description: 'Perpindahan massa tanah dan batuan menuruni lereng.',
        assetPath: 'assets/natural_disaster_list.html',
        icon: '⛰️',
        symptoms: ['Luka benturan', 'Patah tulang', 'Gangguan pernapasan'],
        precautions: [
          'Evakuasi daerah rawan longsor',
          'Hindari membangun di tepi tebing',
          'Perhatikan retakan tanah setelah hujan',
        ],
      ),
    ];

    for (final disaster in seedData) {
      await _disastersBox.put(disaster.id, disaster);
    }
  }

  Future<void> _seedMedical() async {
    final seedData = [
      MedicalEmergency(
        id: 'pingsan',
        title: 'Pingsan',
        description: 'Kehilangan kesadaran sementara akibat aliran darah ke otak berkurang.',
        assetPath: 'assets/medical_emergency_list.html',
        icon: '🤕',
        symptoms: ['Wajah pucat', 'Berkeringat dingin', 'Nadi cepat'],
        firstAid: [
          'Baringkan korban di tempat datar',
          'Tinggikan kaki sekitar 30cm',
          'Longgarkan pakaian ketat',
          'Pastikan sirkulasi udara baik',
          'Jangan berikan minum sampai sadar penuh',
        ],
      ),
      MedicalEmergency(
        id: 'fraktur',
        title: 'Patah Tulang',
        description: 'Retak atau putus pada tulang akibat benturan atau jatuh.',
        assetPath: 'assets/medical_emergency_list.html',
        icon: '🦴',
        symptoms: ['Nyeri hebat', 'Pembengkakan', 'Deformitas'],
        firstAid: [
          'Imobilisasi area yang patah',
          'Kompres es untuk mengurangi bengkak',
          'Jangan gerakkan bagian yang cedera',
          'Gunakan bidai jika tersedia',
        ],
      ),
      MedicalEmergency(
        id: 'jerawat_bakar',
        title: 'Luka Bakar',
        description: 'Kerusakan jaringan kulit akibat panas, kimia, atau listrik.',
        assetPath: 'assets/medical_emergency_list.html',
        icon: '🔥',
        symptoms: ['Kulit merah', 'Luka melepuh', 'Nyeri'],
        firstAid: [
          'Dinginkan dengan air mengalir 10-15 menit',
          'Jangan pecahkan lepuhan',
          'Balut dengan kain bersih',
          'Hindari es langsung pada luka',
        ],
      ),
      MedicalEmergency(
        id: 'darah_merasap',
        title: 'Pendarahan',
        description: 'Kehilangan darah akibat pembuluh darah rusak.',
        assetPath: 'assets/medical_emergency_list.html',
        icon: '🩸',
        symptoms: ['Darah keluar dari luka', 'Pusing', 'Nadi cepat'],
        firstAid: [
          'Tekan langsung pada luka',
          'Tinggikan bagian yang berdarah',
          'Gunakan perban bersih',
          'Hubungi darurat jika pendarahan tidak berhenti',
        ],
      ),
      MedicalEmergency(
        id: 'heat_stroke',
        title: 'Heat Stroke',
        description: 'Suhu tubuh naik drastis (>40°C) akibat paparan panas berlebihan.',
        assetPath: 'assets/medical_emergency_list.html',
        icon: '☀️',
        symptoms: ['Suhu tinggi', 'Kulit kemerahan', 'Pingsan'],
        firstAid: [
          'Pindahkan ke tempat teduh',
          'Turunkan suhu tubuh dengan kompres dingin',
          'Berikan air minum perlahan',
          'Lepaskan pakaian berlebih',
        ],
      ),
    ];

    for (final medical in seedData) {
      await _medicalBox.put(medical.id, medical);
    }
  }

  Future<void> _seedChecklist() async {
    final seedData = [
      // Kesiapan Bencana
      ChecklistItem(id: 'c1', title: 'Tas siaga bencana siap', category: 'bencana'),
      ChecklistItem(id: 'c2', title: 'Air minum cadangan (3 hari)', category: 'bencana'),
      ChecklistItem(id: 'c3', title: 'Makanan kaleng dan pembuka', category: 'bencana'),
      ChecklistItem(id: 'c4', title: 'Obat-obatan p3k lengkap', category: 'bencana'),
      ChecklistItem(id: 'c5', title: 'Senter dan baterai cadangan', category: 'bencana'),
      ChecklistItem(id: 'c6', title: 'Radio baterai / power bank', category: 'bencana'),
      ChecklistItem(id: 'c7', title: 'Dokumen penting tersimpan aman', category: 'bencana'),
      // Kesiapan Medis
      ChecklistItem(id: 'm1', title: 'Kelola obat rutin bulanan', category: 'medis'),
      ChecklistItem(id: 'm2', title: 'Periksa kesehatan berkala', category: 'medis'),
      ChecklistItem(id: 'm3', title: 'Simpan riwayat medis keluarga', category: 'medis'),
      ChecklistItem(id: 'm4', title: 'Pahami asuransi kesehatan', category: 'medis'),
      ChecklistItem(id: 'm5', title: 'Nomor darurat tersimpan di HP', category: 'medis'),
    ];

    for (final item in seedData) {
      await _checklistBox.put(item.id, item);
    }
  }

  Future<void> _seedSettings() async {
    await _settingsBox.put('darkMode', true);
    await _settingsBox.put('notifications', false);
    await _settingsBox.put('language', 'id');
    await _settingsBox.put('appVersion', '1.0.0');
  }

  /// Tutup semua box Hive
  Future<void> close() async {
    await _disastersBox.close();
    await _medicalBox.close();
    await _checklistBox.close();
    await _settingsBox.close();
  }
}