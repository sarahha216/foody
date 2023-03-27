String? validateEmail(String value) {
  if(value.isEmpty){
    return 'Please enter email';
  }
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)){
    return 'Enter valid email';
  }else{
    return null;
  }
}


String? validatePassword(String value){
  if(value.isEmpty){
    return 'Please enter password';
  }
  if(value.length<8){
    return 'Password should be more than 8 characters';
  }
  return null;
}

String? conformPassword(String value, String value2){
  if(value!=value2){
    return 'Conform password invalid';
  }
  else{
    return null;
  }
}