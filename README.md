A command line app helps to generate a flutter project follows Clean architecture + Provider
I refered (get cli)[https://pub.dev/packages/get_cli] to make this cli


// To install:
```
pub global activate hpf_cli
```

// To create a project:

// Note: you can use any name, ex: `hpf create project:movie`
```
hpf create project:movie
```
// To create a page:

// (Page have controller, state)

// Note: you can use any name, ex: `hpf create page:login`
```
hpf create page:home
```
or
```
hpf create -p home
```

// To create a screen:

// (Screen have controller, state)

// Note: you can use any name, ex: `hpf create screen:login`
```
hpf create screen:home
```
or
```
hpf create -sn home
```

// To create an use case:

// Note: you can use any name, ex: `hpf create use_case:get_user_info`
```
hpf create use_case:get_user_info
```
or
```
hpf create -uc get_user_info
```

// To create a repository:

// Note: you can use any name, ex: `hpf create repo:user`

```
hpf create repo:user
```
or
```
hpf create -rp user
```