import 'package:flutter/material.dart';
import '../models.dart';
import '../data/countries.dart';

/// Main country code picker button widget
class CountryCodePicker extends StatefulWidget {
  final ValueChanged<CountrySelection> onCountrySelected;
  final Country? initialCountry;
  final VoidCallback? onDialogOpen;
  final VoidCallback? onDialogClose;
  final Color? primaryColor;
  final bool enableSearch;
  final bool showFlagEmoji;
  final TextStyle? textStyle;
  final double? height;

  const CountryCodePicker({
    Key? key,
    required this.onCountrySelected,
    this.initialCountry,
    this.onDialogOpen,
    this.onDialogClose,
    this.primaryColor,
    this.enableSearch = true,
    this.showFlagEmoji = true,
    this.textStyle,
    this.height,
  }) : super(key: key);

  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  late Country selectedCountry;

  @override
  void initState() {
    super.initState();
    selectedCountry = widget.initialCountry ?? countryList.first;
  }

  void _openDialog() {
    widget.onDialogOpen?.call();
    showDialog(
      context: context,
      builder: (_) => _CountryPickerDialog(
        selectedCountry: selectedCountry,
        onCountrySelected: (country) {
          setState(() => selectedCountry = country);
          widget.onCountrySelected(CountrySelection(country: country));
          Navigator.pop(context);
          widget.onDialogClose?.call();
        },
        enableSearch: widget.enableSearch,
        primaryColor: widget.primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _openDialog,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: widget.height ?? 56,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showFlagEmoji) ...[
                Text(
                  selectedCountry.flag,
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedCountry.dialCode,
                      style: widget.textStyle ??
                          Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      selectedCountry.code,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_drop_down,
                color: widget.primaryColor ?? Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dialog for selecting country
class _CountryPickerDialog extends StatefulWidget {
  final Country selectedCountry;
  final ValueChanged<Country> onCountrySelected;
  final bool enableSearch;
  final Color? primaryColor;

  const _CountryPickerDialog({
    required this.selectedCountry,
    required this.onCountrySelected,
    required this.enableSearch,
    this.primaryColor,
  });

  @override
  State<_CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<_CountryPickerDialog> {
  late List<Country> filteredCountries;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    filteredCountries = countryList;
    searchController = TextEditingController();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      filteredCountries = countryList.search(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.primaryColor ?? Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Country',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          // Search box
          if (widget.enableSearch)
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search country...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          _onSearchChanged();
                        },
                      )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ),
          // Country list
          Expanded(
            child: filteredCountries.isEmpty
                ? Center(
                  child: Text(
                    'No countries found',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
                : ListView.builder(
                  itemCount: filteredCountries.length,
                  itemBuilder: (context, index) {
                    final country = filteredCountries[index];
                    final isSelected = country.code == widget.selectedCountry.code;
                    return Material(
                      color: isSelected
                          ? (widget.primaryColor ?? Theme.of(context).primaryColor)
                              .withOpacity(0.1)
                          : Colors.transparent,
                      child: ListTile(
                        leading: Text(
                          country.flag,
                          style: const TextStyle(fontSize: 24),
                        ),
                        title: Text(country.name),
                        subtitle: Text(country.dialCode),
                        trailing: isSelected
                            ? Icon(
                              Icons.check,
                              color: widget.primaryColor ??
                                  Theme.of(context).primaryColor,
                            )
                            : null,
                        onTap: () => widget.onCountrySelected(country),
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
