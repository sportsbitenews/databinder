part of databinder_impl;

class Scope {
  ModelObservers modelObservers;
  DomObservers domObservers;
  Transformations transformations;
  List<Scope> children = [];

  Scope({Transformations transformations}){
    modelObservers = new ModelObservers(this);
    domObservers = new DomObservers(this);
    this.transformations = (?transformations) ? transformations : new Transformations.standard();
  }

  registerModelObserver(ObservableExpression exp, ObserverCallback callback)
    => modelObservers.register(exp, callback);

  registerDomObserver(h.EventListenerList list, h.EventListener listener)
    => domObservers.register(list, listener);

  registerTransformation(String type, Transformation t)
    => transformations.register(type, t);

  transformation(String type)
    => transformations.find(type);

  destroy(){
    modelObservers.removeAll();
    domObservers.removeAll();
  }

  digest(){
    var iteration = 0;
    while(dirtyCheck()){
      iteration += 1;
      if(iteration == 10) throw new ModelObserverException();
    }
  }

  dirtyCheck(){
    bool localObserversDirty = modelObservers.dirtyCheck();
    return children.reduce(localObserversDirty, (memo, curr) => memo || curr.dirtyCheck());
  }

  createChild(){
    var childScope = new Scope(transformations: transformations.copy());
    children.add(childScope);
    return childScope;
  }
}