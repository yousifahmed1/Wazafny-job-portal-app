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

  
  
}