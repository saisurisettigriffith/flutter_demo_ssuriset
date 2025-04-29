final _emailRegEx = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");

String? validateEmail(String? v) =>
    v != null && _emailRegEx.hasMatch(v) ? null : 'Enter a valid email';

String? validatePassword(String? v) =>
    v != null && RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{8,}$').hasMatch(v)
        ? null
        : 'Min 8 chars, letter & number';

String? validateName(String? v) =>
    v != null && RegExp(r"^[A-Za-z ,.'-]{2,}$").hasMatch(v)
        ? null
        : 'Enter your full name';