part of databinder_test;

class Person {
  String name;
  int age;

  Person(this.name, [this.age]);

  doubleAge(e)
    => age = age * 2;

  methodWithoutArguments(){
    throw new Exception("Cannot be called through callbacks");
  }
}

Element bind(String text, object){
  var element = new Element.html(text);

  var binder = new DataBinder(element, object);
  binder.bind();

  return element;
}
