# 10.3.2b Filtering objects with field selectors

### Objective

1. Explore how to filter objects by non-label properties
2. This technique is very useful.


### Notes

1. We do this via `field selectors`
2. The set of fields we can use in a field selector depends on the object type.
3. The `metadata.name` and `metadata.namespace` fields are always supported. 
4. Field selectors support the equal (= or ==) and not equal (!=) operator.
5. We can combine mutual field selectors by separating them with a comma.

### Misc

This is a better way to wait for a namespace (or any object) to be instantiated, where we use the jsonpath:

```
kubectl wait --for=jsonpath=.status.phase=Active ns/chp10-set1032b
```

This references this post:

> Conditions are generally better than phase. Phases were a mistake in our original pod implementation because they implied a single unified state machine, but we found that instead we had multiple orthogonal states that are better represented as separate conditions. You could try `kubectl wait --for=jsonpath=.status.phase=wish-i-was-a-condition`

https://github.com/kubernetes/kubernetes/issues/83094#issuecomment-542721478

