bool validateEmail(String value) {
  if(value.isEmpty){
    return false;
  }
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return (regex.hasMatch(value)) ? true : false;
}


bool validatePassword(String value){
  if(value.isEmpty){
    return false;
  }
  if(value.length<8){
    return false;
  }
  return true;
}

bool conformPassword(String value, String value2){
  if(value!=value2){
    return false;
  }
  else{
    return true;
  }
}