### This is the front-end part of k8s deployment project

- front-end [here](https://github.com/isdance/k8s-client)
- back-end
- database
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
docker run -p 3000:3000 --name client --detach isdance/client
```
