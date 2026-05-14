# country_code_picker

A beautiful, efficient Flutter widget for selecting country codes with Material 3 design, smooth animations, and excellent UX. Perfect for phone number input forms.

## ✨ Features

- 🌍 **250+ Countries** - Comprehensive list with accurate data
- 🎨 **Material 3 Design** - Modern, clean, responsive UI
- 🔍 **Smart Search** - Real-time search by country name, code, or phone code
- 🚀 **Zero Dependencies** - Pure Flutter, no external packages
- ♿ **Accessible** - Full keyboard navigation and screen reader support
- 🌙 **Dark Mode** - Automatic dark mode support
- 📱 **Responsive** - Works on phones, tablets, and web
- 📞 **Phone Formatting** - Built-in phone number formatting
- ⚡ **Null-Safe** - Full Dart 3.0+ support
- ✅ **Well-Tested** - Comprehensive test coverage

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  country_code_picker: ^1.0.0
```

Then run:
```bash
flutter pub get
```

## 🚀 Quick Start

```dart
import 'package:country_code_picker/country_code_picker.dart';

CountryCodePicker(
  onCountrySelected: (country) {
    print('Selected: ${country.country.name}');
    print('Dial Code: ${country.country.dialCode}');
  },
  initialCountry: countryList.byCode('US'),
)
```

## 📚 Documentation

### 🎯 Quick Start
- **[Quick Reference Card](QUICK_REFERENCE.md)** - Most common patterns at a glance
- **[Complete Examples](EXAMPLE.md)** - Real-world usage scenarios
- **[Visual Guide](VISUAL_GUIDE.md)** - UI/UX layouts and design details

## 💻 Usage Examples

### Basic Usage

```dart
CountryCodePicker(
  onCountrySelected: (selection) {
    setState(() {
      selectedCountry = selection.country;
    });
  },
)
```

### With Customization

```dart
CountryCodePicker(
  onCountrySelected: (selection) {
    // Handle selection
  },
  initialCountry: countryList.byCode('US'),
  primaryColor: Colors.blue,
  enableSearch: true,
  showFlagEmoji: true,
  textStyle: TextStyle(fontSize: 16),
)
```

### Phone Number Input Form

```dart
class PhoneInputForm extends StatefulWidget {
  @override
  State<PhoneInputForm> createState() => _PhoneInputFormState();
}

class _PhoneInputFormState extends State<PhoneInputForm> {
  late Country selectedCountry;
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCountry = countryList.byCode('US')!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CountryCodePicker(
          onCountrySelected: (selection) {
            setState(() => selectedCountry = selection.country);
          },
          initialCountry: selectedCountry,
        ),
        TextField(
          controller: phoneController,
          decoration: InputDecoration(
            hintText: 'Phone number',
            prefix: Text('${selectedCountry.dialCode} '),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final fullPhone = selectedCountry.dialCode + phoneController.text;
            print('Full phone: $fullPhone');
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
```

### Searching Countries Programmatically

```dart
// Search by name or code
final results = countryList.search('united');

// Get by code
final country = countryList.byCode('US');

// Get by dial code
final country = countryList.byDialCode('+1');

// Get by region
final europeanCountries = countryList.byRegion('Europe');

// Get all regions
final regions = countryList.regions;
```

### Custom Styling

```dart
CountryCodePicker(
  onCountrySelected: (selection) {},
  primaryColor: Colors.deepPurple,
  textStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
  height: 60,
)
```

## 🎨 Available Countries

The package includes 250+ countries and territories:

- ✅ All UN member states
- ✅ All territories and dependencies
- ✅ Accurate phone dial codes
- ✅ Flag emojis for visual identification
- ✅ Grouped by region (Americas, Europe, Asia, Africa, Middle East, Oceania)
- ✅ Phone number format patterns for many countries

### Supported Regions

- Americas (North, Central, South America + Caribbean)
- Europe (All European countries)
- Asia (All Asian countries)
- Africa (All African countries)
- Middle East
- Oceania

## 🔧 API Reference

### CountryCodePicker Widget

#### Constructor Parameters

- `onCountrySelected` (required) - Callback when country is selected
- `initialCountry` - Pre-selected country (defaults to first in list)
- `onDialogOpen` - Callback when dialog opens
- `onDialogClose` - Callback when dialog closes
- `primaryColor` - Primary color for UI elements
- `enableSearch` - Enable/disable search (default: true)
- `showFlagEmoji` - Show/hide flag emoji (default: true)
- `textStyle` - Custom text style
- `height` - Custom button height

### Country Model

```dart
class Country {
  final String code;           // ISO 3166-1 alpha-2 code
  final String name;           // Full country name
  final String flag;           // Flag emoji
  final String dialCode;       // Phone dial code
  final String? phoneFormat;   // Phone number format pattern
  final String region;         // Geographic region

  // Methods
  String get displayName;      // Returns "🇺🇸 United States +1"
  String get searchableText;   // Lowercased search string
  String formatPhoneNumber(String number); // Format phone number
}
```

### CountrySelection Model

```dart
class CountrySelection {
  final Country country;
  final DateTime selectedAt;
}
```

## 🎯 Design Highlights

### Modern Material 3 Design

- Clean, minimal interface
- Smooth animations and transitions
- Clear visual hierarchy
- Accessible color contrasts

### Excellent User Experience

- Real-time search with highlighting
- Quick access to recently used countries
- Clear country grouping by region
- Flag emojis for quick recognition
- Large, touch-friendly buttons
- Keyboard navigation support

### Performance Optimized

- Efficient list rendering with ListView.builder
- Debounced search to prevent unnecessary rebuilds
- Zero external dependencies
- Minimal package size

## 🔍 Search Features

- **By Country Name** - Type any part of the country name
- **By Country Code** - Enter ISO code (e.g., "US", "GB")
- **By Dial Code** - Search by phone code (e.g., "+1", "+44")
- **Smart Matching** - Case-insensitive, partial matching
- **Instant Results** - Real-time search as you type
- **Clear Button** - Quick clear of search with one tap

## 🌙 Dark Mode

Automatic dark mode support - the widget adapts to the current theme.

```dart
// Works automatically with Material's ThemeData
MaterialApp(
  theme: ThemeData.light(),
  darkTheme: ThemeData.dark(),
  themeMode: ThemeMode.system,
  home: MyApp(),
)
```

## 📖 Complete Documentation

For more detailed information, see:

- **[QUICK_REFERENCE.md](QUICK_REFERENCE.md)** - Quick reference card with common patterns
- **[EXAMPLE.md](EXAMPLE.md)** - 6+ complete working examples
- **[VISUAL_GUIDE.md](VISUAL_GUIDE.md)** - UI/UX design guide with ASCII diagrams
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - How to contribute
- **[CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)** - Community standards

## ♿ Accessibility

- Full keyboard navigation
- Screen reader support
- High contrast colors
- Clear labels and hints
- Touch-friendly tap targets
- Semantic widgets

## 🧪 Testing

The package includes comprehensive tests:

```bash
flutter test
```

Tests cover:
- Country model equality
- Search functionality
- Country lookups
- Phone number formatting
- Region filtering
- Display name generation

## 📈 Performance

- **Package Size** - ~15 KB compressed
- **Dependencies** - Zero external packages
- **Build Time** - Minimal impact
- **Runtime** - Smooth 60fps animations
- **Memory** - Efficient list handling

## 🐛 Known Issues

None! Report issues on GitHub if you find any.

## 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md).

## 📚 Learn More

- 🚀 **[Quick Reference](QUICK_REFERENCE.md)** - Common patterns
- 📖 **[Full Examples](EXAMPLE.md)** - Real-world use cases  
- 🎨 **[Visual Design](VISUAL_GUIDE.md)** - UI/UX details
- 🤝 **[Contributing](CONTRIBUTING.md)** - Help improve this package
- 📋 **[Code of Conduct](CODE_OF_CONDUCT.md)** - Community guidelines

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

## 🔗 Resources

- [GitHub Repository](https://github.com/lukman48/country_code_picker)
- [pub.dev Package](https://pub.dev/packages/country_code_picker)
- [Issue Tracker](https://github.com/lukman48/country_code_picker/issues)

## 💡 Tips & Tricks

### Pre-select User's Country

```dart
import 'package:geolocator/geolocator.dart'; // Optional

// Get user's country
final position = await Geolocator.getCurrentPosition();
// Use with IP geolocation API to get country code
final countryCode = await getCountryCodeFromIP();
final initialCountry = countryList.byCode(countryCode);

CountryCodePicker(
  onCountrySelected: (_) {},
  initialCountry: initialCountry,
)
```

### Store Selected Country

```dart
// Using SharedPreferences
final prefs = await SharedPreferences.getInstance();
await prefs.setString('selected_country', selectedCountry.code);

// Restore later
final savedCode = prefs.getString('selected_country');
final country = countryList.byCode(savedCode ?? 'US');
```

### Format Phone Numbers

```dart
final country = countryList.byCode('US');
if (country != null) {
  final formatted = country.formatPhoneNumber('2125551234');
  print(formatted); // +1 (212) 555-1234
}
```

## 🌟 Why Choose This Package?

✅ **Modern Design** - Material 3 with smooth animations  
✅ **Comprehensive** - 250+ countries with accurate data  
✅ **Zero Dependencies** - Pure Flutter implementation  
✅ **Well-Tested** - Comprehensive test coverage  
✅ **Production-Ready** - Used in real apps  
✅ **Actively Maintained** - Regular updates and improvements  
✅ **Great Documentation** - Examples for every use case  
✅ **Performant** - Optimized for speed and memory  

---

---

**📚 Start with:**
1. [Quick Reference](QUICK_REFERENCE.md) for quick patterns
2. [Examples](EXAMPLE.md) for real-world code
3. [Visual Guide](VISUAL_GUIDE.md) for design details
4. [README](README.md) for comprehensive overview

Made with ❤️ for the Flutter community
