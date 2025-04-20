class Validators {

    // Validator for required fields
  String? requiredFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // Validator for email
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Validator for phone number
  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final phoneRegex = RegExp(r'^\+?\d{10,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }

    // Check if the URL starts with http:// or https://
    bool hasValidScheme = value.startsWith('http://') || value.startsWith('https://');

    try {
      // Try parsing the URL to validate its format
      final uri = Uri.parse(value);

      // Check if it has a valid host
      if (uri.host.isEmpty) {
        return 'Invalid URL: missing host';
      }

      // Check if it has a valid scheme
      if (!hasValidScheme) {
        return 'URL must start with http:// or https://';
      }

      return null; // Valid URL
    } catch (e) {
      return 'Invalid URL format';
    }
  }
  
}