import 'package:flutter_test/flutter_test.dart';
import 'package:country_picker/country_picker.dart';

void main() {
  group('Country Model Tests', () {
    test('Country equality', () {
      final us1 = Country(
        code: 'US',
        name: 'United States',
        flag: '🇺🇸',
        dialCode: '+1',
      );
      final us2 = Country(
        code: 'US',
        name: 'United States',
        flag: '🇺🇸',
        dialCode: '+1',
      );
      expect(us1, equals(us2));
    });

    test('Country display name', () {
      final country = Country(
        code: 'US',
        name: 'United States',
        flag: '🇺🇸',
        dialCode: '+1',
      );
      expect(country.displayName, equals('🇺🇸 United States +1'));
    });

    test('Country searchable text', () {
      final country = Country(
        code: 'US',
        name: 'United States',
        flag: '🇺🇸',
        dialCode: '+1',
      );
      expect(
        country.searchableText,
        equals('united states us +1'),
      );
    });

    test('Phone number formatting', () {
      final country = Country(
        code: 'US',
        name: 'United States',
        flag: '🇺🇸',
        dialCode: '+1',
        phoneFormat: '+1 (XXX) XXX-XXXX',
      );
      final formatted = country.formatPhoneNumber('2125551234');
      expect(formatted, contains('+1'));
    });
  });

  group('Country List Tests', () {
    test('Search countries', () {
      final results = countryList.search('United');
      expect(results.isNotEmpty, true);
      expect(results.any((c) => c.name.contains('United')), true);
    });

    test('Find country by code', () {
      final country = countryList.byCode('US');
      expect(country?.code, equals('US'));
    });

    test('Find country by dial code', () {
      final country = countryList.byDialCode('+1');
      expect(country?.code, equals('US'));
    });

    test('Get countries by region', () {
      final europeanCountries = countryList.byRegion('Europe');
      expect(europeanCountries.isNotEmpty, true);
    });

    test('Get all unique regions', () {
      final regions = countryList.regions;
      expect(regions.isNotEmpty, true);
      expect(regions.contains('Europe'), true);
    });
  });

  group('CountrySelection Tests', () {
    test('CountrySelection creation', () {
      final country = Country(
        code: 'US',
        name: 'United States',
        flag: '🇺🇸',
        dialCode: '+1',
      );
      final selection = CountrySelection(country: country);
      expect(selection.country.code, equals('US'));
      expect(selection.selectedAt, isNotNull);
    });
  });
}
