# Quick Reference Card

## 🚀 **At a Glance**

| Feature | Details |
|---------|---------|
| **Package Name** | `flutter_country_picker` |
| **Version** | `1.0.0` |
| **Flutter Support** | 3.10.0+ |
| **Dart Support** | 3.0.0+ |
| **Dependencies** | 0 (Zero!) |
| **License** | MIT |
| **Countries** | 250+ |
| **Package Size** | ~15 KB |

---

## 📦 **Installation**

```yaml
dependencies:
  flutter_country_picker: ^1.0.0
```

```bash
flutter pub add flutter_country_picker
```

---

## 💻 **Basic Usage - 3 Lines**

```dart
import 'package:flutter_country_picker/flutter_country_picker.dart';

CountryPicker(
  onCountrySelected: (country) => print(country.country.name),
)
```

---

## 🎯 **Core Classes**

### `Country`
```dart
Country(
  code: 'US',              // ISO 3166-1 alpha-2
  name: 'United States',   // Full name
  flag: '🇺🇸',             // Emoji
  dialCode: '+1',          // Phone code
  phoneFormat: '+1 (XXX) XXX-XXXX',
  region: 'Americas',
)
```

### `CountrySelection`
```dart
CountrySelection(
  country: Country(...),
  selectedAt: DateTime.now(),
)
```

---

## 🎨 **Widget: CountryPicker**

### Constructor
```dart
CountryPicker({
  required ValueChanged<CountrySelection> onCountrySelected,
  Country? initialCountry,
  VoidCallback? onDialogOpen,
  VoidCallback? onDialogClose,
  Color? primaryColor,
  bool enableSearch = true,
  bool showFlagEmoji = true,
  TextStyle? textStyle,
  double? height,
})
```

### Example
```dart
CountryPicker(
  onCountrySelected: (selection) {
    print('${selection.country.name}: ${selection.country.dialCode}');
  },
  initialCountry: countryList.byCode('US'),
  primaryColor: Colors.blue,
  enableSearch: true,
  showFlagEmoji: true,
)
```

---

## 🔍 **countryList - Search & Filter**

### Find by Code
```dart
final us = countryList.byCode('US');        // Country?
final gb = countryList.byCode('gb');        // Case-insensitive
```

### Find by Dial Code
```dart
final country = countryList.byDialCode('+1');  // Country?
```

### Search by Name/Code
```dart
final results = countryList.search('united');  // List<Country>
// Finds: United States, United Kingdom, etc.
```

### Filter by Region
```dart
final european = countryList.byRegion('Europe');  // List<Country>
```

### Get All Regions
```dart
final regions = countryList.regions;  // List<String>
// ['Americas', 'Europe', 'Asia', 'Africa', 'Middle East', 'Oceania']
```

---

## ✨ **Key Features**

| Feature | Example |
|---------|---------|
| **250+ Countries** | US, UK, Canada, India... |
| **Flag Emojis** | 🇺🇸 🇬🇧 🇨🇦 🇮🇳 |
| **Search** | Real-time by name/code/dial |
| **Material 3** | Modern, smooth, responsive |
| **Dark Mode** | Auto-adapts to theme |
| **Null-Safe** | 100% Dart 3.0+ compatible |
| **Accessibility** | Keyboard nav, screen reader ready |
| **Zero Deps** | Just Flutter - no bloat! |
| **Phone Format** | Auto-format numbers |
| **Regions** | Filter by geographic region |

---

## 🎨 **Customization**

### Custom Colors
```dart
CountryPicker(
  primaryColor: Colors.purple,
  onCountrySelected: (_) {},
)
```

### Custom Text Style
```dart
CountryPicker(
  textStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
  onCountrySelected: (_) {},
)
```

### Custom Button Height
```dart
CountryPicker(
  height: 60,
  onCountrySelected: (_) {},
)
```

### Disable Features
```dart
CountryPicker(
  enableSearch: false,        // Hide search box
  showFlagEmoji: false,       // Hide flag emoji
  onCountrySelected: (_) {},
)
```

---

## 📱 **Complete Example**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PhoneForm(),
    );
  }
}

class PhoneForm extends StatefulWidget {
  const PhoneForm({Key? key}) : super(key: key);

  @override
  State<PhoneForm> createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  late Country selectedCountry;
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCountry = countryList.byCode('US') ?? countryList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Input')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Country picker
            CountryPicker(
              onCountrySelected: (selection) {
                setState(() => selectedCountry = selection.country);
              },
              initialCountry: selectedCountry,
            ),
            const SizedBox(height: 24),
            // Phone input
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                prefixText: '${selectedCountry.dialCode} ',
                hintText: 'Phone number',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 🧪 **Testing Example**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

void main() {
  group('Country Picker Tests', () {
    test('Find country by code', () {
      final us = countryList.byCode('US');
      expect(us?.name, 'United States');
      expect(us?.dialCode, '+1');
    });

    test('Search countries', () {
      final results = countryList.search('united');
      expect(results.isNotEmpty, true);
      expect(results.any((c) => c.code == 'US'), true);
    });

    test('Get countries by region', () {
      final european = countryList.byRegion('Europe');
      expect(european.isNotEmpty, true);
    });
  });
}
```

---

## 🔗 **Resources**

| Resource | Link |
|----------|------|
| **Package** | https://pub.dev/packages/flutter_country_picker |
| **GitHub** | https://github.com/lukman48/flutter_country_picker |
| **Examples** | [EXAMPLE.md](EXAMPLE.md) |
| **Visual Guide** | [VISUAL_GUIDE.md](VISUAL_GUIDE.md) |
| **Issues** | https://github.com/lukman48/flutter_country_picker/issues |

---

## ⚡ **Common Patterns**

### Pre-select Device Locale
```dart
final localeCode = Localizations.localeOf(context).countryCode;
final initialCountry = countryList.byCode(localeCode ?? 'US');

CountryPicker(
  initialCountry: initialCountry,
  onCountrySelected: (_) {},
)
```

### Save & Restore Selection
```dart
// Save
prefs.setString('country', selectedCountry.code);

// Restore
final saved = prefs.getString('country');
final country = countryList.byCode(saved ?? 'US');
```

### Format Phone Number
```dart
final fullPhone = '${country.dialCode}${phoneNumber}';
// Result: +12125551234
```

### Display Full Number
```dart
Text('${selectedCountry.flag} ${selectedCountry.dialCode}');
// Result: 🇺🇸 +1
```

---

## 🎓 **Learning Path**

1. **Start Here** → [README.md](README.md)
2. **See Examples** → [EXAMPLE.md](EXAMPLE.md)
3. **Understand UI** → [VISUAL_GUIDE.md](VISUAL_GUIDE.md)
4. **Deep Dive** → GitHub repository
5. **Get Help** → Issues tracker

---

## 📋 **Checklist for Integration**

- [ ] Add to pubspec.yaml
- [ ] Run `flutter pub get`
- [ ] Import package
- [ ] Create CountryPicker widget
- [ ] Handle onCountrySelected callback
- [ ] Customize colors/styling (optional)
- [ ] Test on device
- [ ] Save selection if needed
- [ ] Add error handling
- [ ] Test accessibility

---

## 🚀 **Quick Tips**

✅ **DO:**
- Use Material 3 theme for best results
- Pre-select user's locale country
- Save selection persistently
- Handle null values gracefully
- Test on multiple devices

❌ **DON'T:**
- Don't use deprecated color methods
- Don't forget to dispose controllers
- Don't hardcode country codes
- Don't ignore accessibility
- Don't skip testing

---

## 💬 **Get Help**

- 📖 Read the [README.md](README.md)
- 📚 Check [EXAMPLE.md](EXAMPLE.md)
- 🎨 View [VISUAL_GUIDE.md](VISUAL_GUIDE.md)
- 🐛 Report on [GitHub Issues](https://github.com/lukman48/flutter_country_picker/issues)
- 💡 Check existing issues for solutions

---

**Made with ❤️ for the Flutter community**

Version: 1.0.0 | License: MIT | GitHub: lukman48
