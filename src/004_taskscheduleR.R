# install.packages("taskscheduleR")

library(taskscheduleR)

## schedule 기능 추가 
# 특정 시간대에 있는 
taskscheduler_create(taskname = "kakao_vive", rscript = "./src/003_keyboard_simulator.R", days = "*", schedule = "DAILY",
                     starttime = "18:29", startdate = format(Sys.Date(), "%Y%m%d", debug = TRUE))

# 몇번 제출할 지, n_submission 변수로 지정
n_submission = 2

for(i in 1:n_submission) {
  source("./src/003_keyboard_simulator.R")
}

