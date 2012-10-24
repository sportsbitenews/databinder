part of databinder;

class TextNodeDescriptor {
  final Text node;
  final List<String> boundNames;

  TextNodeDescriptor(this.node, this.boundNames);

  String get value
    => node.text;

  set value(newValue)
    => node.text = newValue;

  void visit(visitor)
    => visitor.visitText(this);
}

class AttributeDescriptor {
  final Element element;
  final String attrName;
  final List<String> boundNames;

  AttributeDescriptor(this.element, this.attrName, this.boundNames);

  String get value
    => element.attributes[attrName];

  set value(newValue)
    => element.attributes[attrName] = newValue;

  void visit(visitor)
    => visitor.visitAttribute(this);
}

class DataBindingDescriptor {
  final Element element;
  final String propName;

  DataBindingDescriptor(this.element, this.propName);

  String get value
    => element.value;

  set value(newValue)
    => element.value = newValue.toString();

  void visit(visitor)
    => visitor.visitDataBinding(this);
}

class DataActionDescriptor {
  final Element element;
  final String expression;

  DataActionDescriptor(this.element, this.expression);

  String get eventName
    => expression.split(":")[0];

  String get methodName
    => expression.split(":")[1];

  void visit(visitor)
    => visitor.visitDataAction(this);
}

class ElementNodeDescriptor {
  Element element;
  final List children;

  ElementNodeDescriptor(this.element, this.children);
  ElementNodeDescriptor.empty(this.element) : children = [];

  void visit(visitor)
    => visitor.visitElement(this);
}
