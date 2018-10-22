# 1) R에서 Selenium을 사용하려면 JAVA가 설치 되어 있어야 한다.
# 2) 관련 드라이버 설치
 http://selenium-release.storage.googleapis.com/index.html 
 https://github.com/mozilla/geckodriver
 https://sites.google.com/a/chromium.org/chromedriver/

# 3) CMD에 입력  
# cd C:\selenium
# java -Dwebdriver.gecko.driver="geckodriver.exe" -jar selenium-server-standalone-3.9.1.jar -port 4445

# 4) R에서 사용법
# ex) 네이버를 기준으로

library(RSelenium) 
library(rvest) 
rt <- remoteDriver(remoteServerAddr = 'localhost', 
                   port = 4445L, # 포트번호 입력 
                   browserName = "chrome") 
rt

rt$open() 
rt$navigate("http://www.kmooc.kr/") 
rt

html <- rt$getPageSource()[[1]] 
html <- read_html(html) 
//*[@id="global-navigation"]/nav/div/ul[2]/li[2]/a
#로그인화면 불러오기
btnLogin <- rt$findElement(using = "xpath", value = '//*[@id="global-navigation"]/nav/div/ul[2]/li[2]/a')
btnLogin$clickElement();


#실시간 검색어 읽어오기 상위 20개 
tWords <- html %>% html_nodes("span.ah_k") %>% html_text() 
tWords[1:20] 


# # xpath 방식 
 id <- rt$findElement(using="xpath", value='//*[@id="login-email"]') 
 pw <- rt$findElement(using="xpath", value='//*[@id="login-password"]') 
# 
# # css selector 방식 
# id <- rt$findElement(using="css selector", value="input#id") 
# pw <- rt$findElement(using="css selector", value="#pw") 
# 
# 
id$sendKeysToElement(list("hoyoungk12@naver.com")) 
pw$sendKeysToElement(list("dlfnflf65#")) 

//*[@id="frmNIDLogin"]/fieldset/input
#


 btn <- rt$findElement(using="xpath", value='//*[@id="login"]/button')
 btn$clickElement()
# rt$close() 
 
 