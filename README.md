A command line app helps to generate repeat code.
I refer (get cli)[https://pub.dev/packages/get_cli] to make this cli


// To install:
```
pub global activate hpf_cli
```

// To create a project:\n
// Note: you can use any name, ex: `hpf create project:movie`\n
```
hpf create project:movie
```
or
```
hpf create -p movie
```

// To create a screen:\n
// (Screen have controller, state)\n
// Note: you can use any name, ex: `hpf create screen:login`\n
```
hpf create screen:home
```
or
```
hpf create -sn home
```

// To create an use case:\n
// Note: you can use any name, ex: `hpf create use_case:get_user_info`\n
```
hpf create use_case:get_user_info
```
or
```
hpf create -uc get_user_info
```

// To create a repository:\n
// Note: you can use any name, ex: `hpf create repo:user`\n
```
hpf create repo:user
```
or
```
hpf create -rp user
```