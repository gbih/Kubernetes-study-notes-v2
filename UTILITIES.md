 # Various utilities & gists

### Search and Replace In-Place

Example (OSX-specific)

```
gsed -i '' -e 's/set1162/set1163/g' `grep 'set1162' -rl *`
```

OSX-specific:

```
gsed -i '' -e 's/set1162/set1163/g' `grep 'set1162' -rl *`
```



Explanation:

* Replace In-Place: `sed -i`:
    - Use sed to replace inline with the specified file extension. For example, `sed -i ''` means replace inline with same file extension.

* Search directory recursively: `grep name -rl *`
    - Example: `grep 'set1163' -rl *`

---
