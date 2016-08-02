
# ipairs behavior

## ipairs like lua 5.1

Status: OK

```
b12e0ba5da6a474e05ff3a5a7867f334  results/ipairs51/lua5.1.txt
b12e0ba5da6a474e05ff3a5a7867f334  results/ipairs51/lua5.2.txt
b12e0ba5da6a474e05ff3a5a7867f334  results/ipairs51/lua5.3.txt
b12e0ba5da6a474e05ff3a5a7867f334  results/ipairs51/luajit-2.0.txt
b12e0ba5da6a474e05ff3a5a7867f334  results/ipairs51/reference.txt
```

## ipairs like lua 5.2

Status: OK

```
c7468c37e06466f5f1782c3ee64e5f4a  results/ipairs52/lua5.1.txt
c7468c37e06466f5f1782c3ee64e5f4a  results/ipairs52/lua5.2.txt
c7468c37e06466f5f1782c3ee64e5f4a  results/ipairs52/lua5.3.txt
c7468c37e06466f5f1782c3ee64e5f4a  results/ipairs52/luajit-2.0.txt
c7468c37e06466f5f1782c3ee64e5f4a  results/ipairs52/reference.txt
```

## ipairs like lua 5.3

Status: probably OK

```
1b58ac3b7ae8f9e218f6d08ac83f22e6  results/ipairs53/lua5.1.txt
1b58ac3b7ae8f9e218f6d08ac83f22e6  results/ipairs53/lua5.2.txt
1b58ac3b7ae8f9e218f6d08ac83f22e6  results/ipairs53/lua5.3.txt
1b58ac3b7ae8f9e218f6d08ac83f22e6  results/ipairs53/luajit-2.0.txt
1b58ac3b7ae8f9e218f6d08ac83f22e6  results/ipairs53/reference.txt
```

## my custom ipairs

Status: OK

```
ba8805cb95d2047997db03f6ea521c3e  results/ipairs53custom/lua5.1.txt
ba8805cb95d2047997db03f6ea521c3e  results/ipairs53custom/lua5.2.txt
ba8805cb95d2047997db03f6ea521c3e  results/ipairs53custom/lua5.3.txt
ba8805cb95d2047997db03f6ea521c3e  results/ipairs53custom/luajit-2.0.txt
```

Known bug
=========

The `results/native/lua53.txt` is wrong.
The lua5.3 used did not follow the standard 5.3 behavior due to [LUA_COMPAT_IPAIRS](https://www.lua.org/source/5.3/luaconf.h.html#LUA_COMPAT_IPAIRS) enabled.

