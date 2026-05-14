# Examples - flutter_country_picker

Complete examples showing how to use the flutter_country_picker package in real-world scenarios.

## 📱 Basic Usage

### Simple Implementation

```dart
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Code Picker',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      home: const CountryPickerExample(),
    );
  }
}

class CountryPickerExample extends StatefulWidget {
  const CountryPickerExample({Key? key}) : super(key: key);

  @override
  State<CountryPickerExample> createState() => _CountryPickerExampleState();
}

class _CountryPickerExampleState extends State<CountryPickerExample> {
  late Country selectedCountry;

  @override
  void initState() {
    super.initState();
    // Pre-select USA
    selectedCountry = countryList.byCode('US') ?? countryList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Code Picker'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountryPicker(
                onCountrySelected: (selection) {
                  setState(() {
                    selectedCountry = selection.country;
                  });
                },
                initialCountry: selectedCountry,
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Country',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text('Name: ${selectedCountry.name}'),
                      Text('Code: ${selectedCountry.code}'),
                      Text('Dial Code: ${selectedCountry.dialCode}'),
                      Text('Flag: ${selectedCountry.flag}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 📞 Phone Number Input Form

### Complete Form with Validation

```dart
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class PhoneInputForm extends StatefulWidget {
  const PhoneInputForm({Key? key}) : super(key: key);

  @override
  State<PhoneInputForm> createState() => _PhoneInputFormState();
}

class _PhoneInputFormState extends State<PhoneInputForm> {
  late Country selectedCountry;
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    selectedCountry = countryList.byCode('US') ?? countryList.first;
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    return null;
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      final fullPhone = selectedCountry.dialCode + phoneController.text;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Phone: $fullPhone'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Number Form'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Country picker
              CountryPicker(
                onCountrySelected: (selection) {
                  setState(() => selectedCountry = selection.country);
                },
                initialCountry: selectedCountry,
                primaryColor: Colors.blue,
              ),
              const SizedBox(height: 24),

              // Phone input
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter phone number',
                  prefixText: '${selectedCountry.dialCode} ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Text(
                    selectedCountry.flag,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: validatePhone,
              ),
              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: submitForm,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 🎨 Custom Styling Example

### Themed Country Picker

```dart
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class ThemedCountryPicker extends StatefulWidget {
  const ThemedCountryPicker({Key? key}) : super(key: key);

  @override
  State<ThemedCountryPicker> createState() => _ThemedCountryPickerState();
}

class _ThemedCountryPickerState extends State<ThemedCountryPicker> {
  late Country selectedCountry;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    selectedCountry = countryList.byCode('GB') ?? countryList.first;
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDarkMode ? Colors.purple : Colors.blue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Themed Country Picker'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => setState(() => isDarkMode = !isDarkMode),
          ),
        ],
      ),
      body: Theme(
        data: isDarkMode
            ? ThemeData.dark(useMaterial3: true)
            : ThemeData.light(useMaterial3: true),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Light theme
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CountryPicker(
                    onCountrySelected: (selection) {
                      setState(() => selectedCountry = selection.country);
                    },
                    initialCountry: selectedCountry,
                    primaryColor: primaryColor,
                    enableSearch: true,
                    showFlagEmoji: true,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Selected: ${selectedCountry.name}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 🔍 Search Example

### Advanced Search with Results Display

```dart
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class SearchExample extends StatefulWidget {
  const SearchExample({Key? key}) : super(key: key);

  @override
  State<SearchExample> createState() => _SearchExampleState();
}

class _SearchExampleState extends State<SearchExample> {
  final searchController = TextEditingController();
  late List<Country> searchResults;

  @override
  void initState() {
    super.initState();
    searchResults = countryList;
    searchController.addListener(updateSearch);
  }

  void updateSearch() {
    setState(() {
      if (searchController.text.isEmpty) {
        searchResults = countryList;
      } else {
        searchResults = countryList.search(searchController.text);
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Search'),
      ),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search countries...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: searchController.clear,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Found ${searchResults.length} countries',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          // Results list
          Expanded(
            child: searchResults.isEmpty
                ? Center(
                    child: Text(
                      'No countries found',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final country = searchResults[index];
                      return ListTile(
                        leading: Text(
                          country.flag,
                          style: const TextStyle(fontSize: 24),
                        ),
                        title: Text(country.name),
                        subtitle: Text(country.dialCode),
                        trailing: Text(country.code),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
```

---

## 🌍 Region Filter Example

### Filter Countries by Region

```dart
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class RegionFilterExample extends StatefulWidget {
  const RegionFilterExample({Key? key}) : super(key: key);

  @override
  State<RegionFilterExample> createState() => _RegionFilterExampleState();
}

class _RegionFilterExampleState extends State<RegionFilterExample> {
  late String selectedRegion;
  late List<Country> regionCountries;

  @override
  void initState() {
    super.initState();
    final regions = countryList.regions;
    selectedRegion = regions.isNotEmpty ? regions.first : 'Europe';
    updateRegionCountries();
  }

  void updateRegionCountries() {
    setState(() {
      regionCountries = countryList.byRegion(selectedRegion);
    });
  }

  @override
  Widget build(BuildContext context) {
    final regions = countryList.regions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries by Region'),
      ),
      body: Column(
        children: [
          // Region selector
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedRegion,
              onChanged: (value) {
                if (value != null) {
                  selectedRegion = value;
                  updateRegionCountries();
                }
              },
              items: regions
                  .map((region) => DropdownMenuItem(
                        value: region,
                        child: Text(region),
                      ))
                  .toList(),
            ),
          ),

          // Countries list
          Expanded(
            child: ListView.builder(
              itemCount: regionCountries.length,
              itemBuilder: (context, index) {
                final country = regionCountries[index];
                return ListTile(
                  leading: Text(
                    country.flag,
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(country.name),
                  subtitle: Text('${country.code} • ${country.dialCode}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 🎯 Complete App Example

### Full-featured Demo Application

```dart
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

void main() {
  runApp(const CompleteExampleApp());
}

class CompleteExampleApp extends StatelessWidget {
  const CompleteExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Code Picker Complete',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const CompleteExample(),
    );
  }
}

class CompleteExample extends StatefulWidget {
  const CompleteExample({Key? key}) : super(key: key);

  @override
  State<CompleteExample> createState() => _CompleteExampleState();
}

class _CompleteExampleState extends State<CompleteExample> {
  late Country selectedCountry;
  final phoneController = TextEditingController();
  final recentlySelected = <Country>[];

  @override
  void initState() {
    super.initState();
    selectedCountry = countryList.byCode('US') ?? countryList.first;
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void handleCountrySelection(CountrySelection selection) {
    setState(() {
      selectedCountry = selection.country;
      if (!recentlySelected.contains(selectedCountry)) {
        recentlySelected.insert(0, selectedCountry);
        if (recentlySelected.length > 5) {
          recentlySelected.removeLast();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Code Picker'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Select Your Country',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),

              // Country picker
              CountryPicker(
                onCountrySelected: handleCountrySelection,
                initialCountry: selectedCountry,
                primaryColor: Colors.blue,
                enableSearch: true,
                showFlagEmoji: true,
              ),
              const SizedBox(height: 24),

              // Selected country info
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Country Information',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            selectedCountry.flag,
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedCountry.name,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  '${selectedCountry.code} • ${selectedCountry.dialCode}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Phone input
              Text(
                'Enter Phone Number',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: 'Phone number',
                  prefixText: '${selectedCountry.dialCode} ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),

              // Recently selected
              if (recentlySelected.isNotEmpty) ...[
                Text(
                  'Recently Selected',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recentlySelected.length,
                    itemBuilder: (context, index) {
                      final country = recentlySelected[index];
                      return GestureDetector(
                        onTap: () => handleCountrySelection(
                          CountrySelection(country: country),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 8.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    country.flag,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    country.code,
                                    style: Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 💡 Tips & Best Practices

### 1. Pre-select User's Country
```dart
// Get user's device locale
final localeCountryCode = Localizations.localeOf(context).countryCode;
final userCountry = countryList.byCode(localeCountryCode ?? 'US');

CountryPicker(
  initialCountry: userCountry,
  onCountrySelected: (selection) { },
)
```

### 2. Persist Selection
```dart
// Save to SharedPreferences
final prefs = await SharedPreferences.getInstance();
await prefs.setString('selected_country', selectedCountry.code);

// Restore later
final savedCode = prefs.getString('selected_country');
final country = countryList.byCode(savedCode ?? 'US');
```

### 3. Format Phone Numbers
```dart
final country = countryList.byCode('US');
if (country != null) {
  final formatted = country.formatPhoneNumber('2125551234');
  print(formatted); // +1 (212) 555-1234
}
```

### 4. Custom Callbacks
```dart
CountryPicker(
  onCountrySelected: (selection) {
    print('Selected: ${selection.country.name}');
    print('At: ${selection.selectedAt}');
  },
  onDialogOpen: () => print('Dialog opened'),
  onDialogClose: () => print('Dialog closed'),
)
```

---

## 📚 Resources

- [Main Package Documentation](README.md)
- [API Reference](docs/API.md)
- [GitHub Repository](https://github.com/lukman48/flutter_country_picker)
- [pub.dev Package](https://pub.dev/packages/flutter_country_picker)

---

## 🎉 Get Started

Add to your `pubspec.yaml`:
```yaml
dependencies:
  flutter_country_picker: ^1.0.0
```

Then start using it in your app! Happy coding! 🚀
