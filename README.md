##*Github Search App*

Github'ın Search Api'si kullanılarak geliştirilen İOS uygulamasıdır.

Uygulamayı geliştirirken kullandığım kaynak:(https://developer.github.com/v3/search/) 
##### Uygulama ile yapılabilen aramalar
- Repository 
- Kod
- Kullanıcı
- Issue 

#### Repo Arama

> GET /search/repositories

> https://api.github.com/search/repositories?q=tetris&sort=stars&order=desc

| Anahtar kelime   |    Değişken tipi       |  Açıklama |
|----------        |    :-------------:     |------:|
| q |  String | Arama yapılacak repository adını tutar.  |
| sort |    String   | Sıralamanın star, fork yada update sayısına göre yapılacağını belirtir.   |
| order | String |  Sıralama artan(asc) yada azalan(desc) sırada yapılacağını belirtir.   |



#### Kod Arama
> GET /search/code

> https://api.github.com/search/code?q=language:js+repo:jquery/jquery


| Anahtar kelime   |    Değişken tipi       |  Açıklama |
|----------|:-------------:|------:|
| q |  String | Arama yapılacak kelimeyi tutar.  |
| sort |    String   | --   |
| order | String |  Sıralama artan(asc) yada azalan(desc) sırada yapılacağını belirtir. Default olarak desc tanımlıdır.  |


#### Issue Arama
> GET /search/issues

> https://api.github.com/search/issues?q=windows&sort=created&order=asc


| Anahtar kelime   |    Değişken tipi       |  Açıklama |
|----------|:-------------:|------:|
| q |  String | Arama yapılacak kelimeyi tutar.  |
| sort |    String   | Sıralamanın comments, created yada updated sayısına göre yapılacağını belirtir.  |
| order | String |  Sıralama artan(asc) yada azalan(desc) sırada yapılacağını belirtir. Default olarak desc tanımlıdır.  |

#### Users Arama
> GET /search/users

> https://api.github.com/search/users?q=tom+repos:%3E42+followers:%3E1000



| Anahtar kelime   |    Değişken tipi       |  Açıklama |
|----------|:-------------:|------:|
| q |  String | Arama yapılacak kelimeyi tutar.  |
| sort |    String   | Sıralamanın followers, repositories yada joined sayısına göre yapılacağını belirtir.  |
| order | String |  Sıralama artan(asc) yada azalan(desc) sırada yapılacağını belirtir. Default olarak desc tanımlıdır.  |

### Screenshot:

<img src="https://github.com/tugcecokay/Github-Search-App/raw/master/screenshots/screenshot1.png" height="590" width="322">&nbsp;&nbsp;
<img src="https://github.com/tugcecokay/Github-Search-App/raw/master/screenshots/screenshot2.png" height="590" width="322">
<img src="https://github.com/tugcecokay/Github-Search-App/raw/master/screenshots/screenshot3.png" height="590" width="322">&nbsp;&nbsp;
<img src="https://github.com/tugcecokay/Github-Search-App/raw/master/screenshots/screenshot4.png" height="590" width="322">
<img src="https://github.com/tugcecokay/Github-Search-App/raw/master/screenshots/screenshot5.png" height="590" width="322">&nbsp;&nbsp;
<img src="https://github.com/tugcecokay/Github-Search-App/raw/master/screenshots/screenshot6.png" height="590" width="322">
