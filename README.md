# Task Management App

## ERD


### User 

| Column Name   |   DataType    |
| :----:        |  :----:       | 
| id            |   Int         | 
| name          |   string      | 
| email         |   string      | 
| password      |   string      | 
| create_at     |   timestamp   |
| updated_at    |   timestamp   |

### Task

| Column Name   |   DataType    |
| :----:        |  :----:       | 
| id            |   Int         | 
| name          |   string      | 
| content       |   Text        | 
| status        |   string      | 
| deadline      |   timestamp   |
| create_at     |   timestamp   |
| updated_at    |   timestamp   |
| user_id       |   int         |

# EveryLeaf
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]
![](https://github.com/tigamadou/everyleaf/workflows/Linters/badge.svg)

Simple Facebook like app implementation with Ruby On Rails

## Built With

- Ruby,
- Ruby On Rails,

## Getting Started

To get a local copy up and running follow these simple example steps.
```
$ git clone git@github.com:tigamadou/everyleaf.git
```

Then you browse to the folder and exucute the following commands

```
 $ cd everyleaf
```


```
$ bundle install
```



Thus create the database and run the migrations

```
$ rake db:create
```
```
$ rails db:migrate
```


Now, you can open the app in your text editor to check out the forms created and run 'rails s' to test the app.

## Deployment to Heroku

### Prerequisite
- Heroku account
- Hero CLI
### Connect to herok
```
heroku login
```

### Create the app
```
heroku create
```
### Deploy 
```
git push heroku main
```
## Authors


👤 **Amadou IBRAHIM**

- Github: [@tigamadou](https://github.com/tigamadou)
- Twitter: [@tigamadou](https://twitter.com/tigamadou)
- Linkedin: [Amadou IBRAHIM](https://www.linkedin.com/in/amadou-ibrahim-75769167/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- [The Oddin Project](https://www.theodinproject.com/courses/ruby-on-rails/lessons/authentication)

## 📝 License

This project is [MIT](lic.url) licensed.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/tigamadou/everyleaf.svg?style=flat-square
[contributors-url]: https://github.com/tigamadou/everyleaf/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/tigamadou/everyleaf.svg?style=flat-square
[forks-url]: https://github.com/tigamadou/everyleaf/network/members
[stars-shield]: https://img.shields.io/github/stars/tigamadou/everyleaf.svg?style=flat-square
[stars-url]: https://github.com/tigamadou/everyleaf/stargazers
[issues-shield]: https://img.shields.io/github/issues/tigamadou/everyleaf.svg?style=flat-square
[issues-url]: https://github.com/tigamadou/everyleaf/issues
[license-shield]: https://img.shields.io/github/license/tigamadou/everyleaf.svg?style=flat-square
[license-url]: https://github.com/tigamadou/everyleaf/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/amadou-ibrahim
[product-screenshot]: images/screenshot.png

