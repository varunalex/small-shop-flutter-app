class Validator {
  final String label;
  final String value;
  final bool required;
  final int min;
  final bool isNumber;
  final bool isEmail;
  // Constructor
  Validator({
    this.label: 'This field',
    this.value: '',
    this.required: true,
    this.min: 0,
    this.isNumber: false,
    this.isEmail: false,
  });

  dynamic validate() {
    // required
    if (value.isEmpty && required) return label + ' is required';

    // Minimum length
    if (value.length < min && min != 0)
      return label +
          'should contain at least ' +
          min.toString() +
          ' characters';

    // RegExp
    // isNumber
    if (!RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value) && isNumber)
      return label + ' should be a number';
    // isEmail
    if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value) &&
        isEmail) {
      return 'Please enter a valid email';
    }
  }
}
