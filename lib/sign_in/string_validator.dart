
abstract class StringValidator {
  bool isValid(String value);
  bool nameIsValid(int length);
  bool phoneIsValid(int length);
  bool codeIsValid(int length);
}

class NonEmptyStringValidator extends StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }

  @override
  bool nameIsValid(int length){
    return length > 3;
  }

  @override
  bool phoneIsValid(int length){
    return length == 10;
  }

  @override
  bool codeIsValid(int length){
    return length == 6;
  }
}

class PhoneNumberValidator {
  final StringValidator phoneValidator = NonEmptyStringValidator();
}

class CodeValidator {
  final StringValidator codeValidator = NonEmptyStringValidator();
}

class NameValidator {
  final StringValidator nameValidator = NonEmptyStringValidator();
  final String invalidNameError = 'Name should have at least 4 characters in minimum.';
}