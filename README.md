### This is the front-end part of k8s deployment project

- front-end [here](https://github.com/isdance/k8s-client)
- back-end
- database [here](https://github.com/isdance/k8s-postgre)
- deployment

#### Install

```js
npm i
```

#### run

```js
npm start
```

#### build in docker

```sh
docker build -t isdance/client .
```

#### run in docker

```sh
docker run -p 80:80 --name client --detach isdance/client
```
