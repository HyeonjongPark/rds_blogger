
install.packages("KeyboardSimulator")

library(KeyboardSimulator)


### page 1
mouse.move(282,570)
mouse.click()

Sys.sleep(0.3)
keybd.press('pagedown')

mouse.move(343,574)
Sys.sleep(0.2)
mouse.click()

Sys.sleep(1) # page 전환


### page 2

## 이름
mouse.move(566,843)
Sys.sleep(0.2)
mouse.click()

Sys.sleep(0.5)


mouse.move(229,766)
Sys.sleep(0.2)
mouse.click()

Sys.sleep(0.2)
keybd.press("Ctrl+c")
Sys.sleep(0.3)

mouse.move(336,163)
Sys.sleep(0.2)
mouse.click()

Sys.sleep(0.3)
keybd.press("Ctrl+v")
Sys.sleep(0.2)


## 핸드폰
mouse.move(566,843)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(0.5)


mouse.move(456,768)
Sys.sleep(0.2)
mouse.click()

Sys.sleep(0.2)
keybd.press("Ctrl+c")
Sys.sleep(0.3)

mouse.move(336,327)
Sys.sleep(0.2)
mouse.click()

Sys.sleep(0.3)
keybd.press("Ctrl+v")
Sys.sleep(0.2)



## 메일
mouse.move(566,843)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(0.5)


mouse.move(665,753)
Sys.sleep(0.2)
mouse.click()

Sys.sleep(0.2)
keybd.press("Ctrl+c")
Sys.sleep(0.3)

mouse.move(336,478)
Sys.sleep(0.2)
mouse.click()

Sys.sleep(0.3)
keybd.press("Ctrl+v")
Sys.sleep(0.2)

mouse.move(432,553)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(1)


### page 3

mouse.move(328,734)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(0.2)

mouse.move(427,811)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(1)



### page 4

## 2
mouse.move(981,464)
Sys.sleep(0.2)
keybd.press("pagedown")

mouse.move(566,843)
Sys.sleep(0.2)
mouse.click()

Sys.sleep(0.5)


mouse.move(850,755)
Sys.sleep(0.2)
mouse.click()

Sys.sleep(0.2)
keybd.press("Ctrl+c")
Sys.sleep(0.3)

mouse.move(328,252)
Sys.sleep(0.2)
mouse.click()

Sys.sleep(0.3)
keybd.press("Ctrl+v")
Sys.sleep(0.2)


## 3
mouse.move(319,480)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(0.2)



mouse.move(994,395)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(0.2)

keybd.press("pageup")

## 1

mouse.move(222,845)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(0.2)

keybd.press("down")
Sys.sleep(0.2)
keybd.press("enter")

Sys.sleep(1)
keybd.press("Ctrl+a")
Sys.sleep(0.3)
keybd.press("Ctrl+c")
Sys.sleep(0.3)

keybd.press("Alt+f4")
Sys.sleep(0.3)

mouse.move(330,667)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(0.2)


keybd.press("Ctrl+v")
Sys.sleep(0.3)


mouse.move(932,407)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(0.2)

keybd.press("end")
Sys.sleep(0.2)
keybd.press("end")
Sys.sleep(0.2)
keybd.press("up")
Sys.sleep(0.2)
keybd.press("up")
Sys.sleep(0.2)
keybd.press("up")
Sys.sleep(0.2)



mouse.move(222,845)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(0.2)

keybd.press("down")
Sys.sleep(0.2)
keybd.press("enter")

Sys.sleep(1)
keybd.press("Ctrl+a")
Sys.sleep(0.3)
keybd.press("Ctrl+c")
Sys.sleep(0.3)

keybd.press("Alt+f4")
Sys.sleep(0.2)

mouse.move(328,175)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(0.2)


keybd.press("Ctrl+v")
Sys.sleep(0.3)


mouse.move(985,196)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(0.2)

keybd.press("end")
Sys.sleep(0.2)
keybd.press("up")
Sys.sleep(0.2)

mouse.move(416,171)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(1)



### page 5

keybd.press("home")
Sys.sleep(0.3)

mouse.move(426,767)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(1)


### page 6
mouse.move(,)
Sys.sleep(0.2)
mouse.click()
Sys.sleep(1)




































# mouse cursor의 현재 위치 파악하기
mouse.get_cursor()

# 파악한 cursor의 현재위치로 mouse 좌표 이동
mouse.move(566,843)

# 마우스 좌클릭
mouse.click()

keybd.press("Ctrl+a")
Sys.sleep(0.3)
keybd.press("Ctrl+c")
Sys.sleep(0.3)
keybd.press("Ctrl+v")
Sys.sleep(0.3)
keybd.press("Ctrl+v")



# Alt + Tab을 사용하는 방법
# 누른 상태 유지
keybd.press("Alt", hold = TRUE)

# 누르기
keybd.press('Tab')

# Alt 떼주기
keybd.release('Alt')



keybd.press("Alt+f4")

keybd.press("Ctrl+A")




### 메모장쪽으로 이동
mouse.move(566,843)

