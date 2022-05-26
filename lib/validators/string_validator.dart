
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

class PhoneAndNameValidators {
  final StringValidator phoneValidator = NonEmptyStringValidator();
  final StringValidator nameValidator = NonEmptyStringValidator();
}

class CodeValidator {
  final StringValidator codeValidator = NonEmptyStringValidator();
}