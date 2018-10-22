library(RSelenium) 
library(rvest) 
rt <- remoteDriver(remoteServerAddr = 'localhost', 
                   port = 4445L, # 포트번호 입력 
                   browserName = "chrome") 

rt$open() 
rt$navigate("http://ksp.credu.com/ksp/servlet/controller.gate.common.GateConstServlet?p_grcode=000002&p_ssochk=N&p_gubun=&p_ifsubj=&p_ifyear=&p_ifsubjseq=&p_ifdistcode=") 

html <- rt$getPageSource()[[1]] 
html <- read_html(html) 



btnLogin <-
  rt$findElement(using = "xpath", value = "//*[@id='glovalWrap']/div/div[1]/ul/li[1]/a/img")
btnLogin$clickElement();

# # xpath 방식 
id <- rt$findElement(using="xpath", value='//*[@id="id"]')
pw <- rt$findElement(using="xpath", value='//*[@id="pw"]')
id$sendKeysToElement(list("dennis1945"))
pw$sendKeysToElement(list("1234"))

# #실시간 검색어 읽어오기 상위 20개 
# tWords <- html %>% html_nodes("span.ah_k") %>% html_text() 
# tWords[1:20] 



# # css selector 방식 
# id <- rt$findElement(using="css selector", value="input#id") 
# pw <- rt$findElement(using="css selector", value="#pw") 
# 
# 

# 
btn <- rt$findElement(using="xpath", value='//*[@id="frmNIDLogin"]/fieldset/input')
btn$clickElement()
#rt$close()