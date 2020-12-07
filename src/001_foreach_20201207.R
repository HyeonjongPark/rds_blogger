
rm(list= ls())

library(parallel)
library(foreach)
library(doParallel)
library(data.table)
library(dplyr)
library(lubridate)
## data load
# sample data : r 내장 데이터 - ChickWeight

# 빅데이터를 처리할 떄 있어, for문이 벡터 단위의 연산보다 느리다는 것은 for문을 짜고 루프가 끝나길 한참동안 기다려본 사람은 알 것이다.
# 하지만 머릿속에 로직은 있지만, 이를 구현할 방법이 마땅히 떠오르지 않을 때 어쩔수 없이 for문을 쓰게된다.
# 크기가 작은 데이터셋을 for문으로 다루는 데 있어서는 단일 코어로도 충분히 프로세싱이 가능하다.
# 그러나 빅데이터의를 for문으로 처리하는 경우는 멀티 코어를 이용한 멀티프로세싱이 필요할 것이다.

# 오늘은 foreach와 doParallel을 이용한 멀티프로세싱에 대해 알아보고자 한다.


data = ChickWeight

new_df_time = data$Time %>% unique() %>% sort()

# 새로운 데이터셋 생성
new_df = data.frame(new_time = new_df_time, new_variation = NA)
new_df$new_time = as.character(new_dfnew_$time)
new_df_2 = rbind(new_df,new_df,new_df,new_df,new_df,new_df,new_df,new_df,new_df,new_df)


system.time({
  for(i in 1:nrow(new_df_2)) {
    max_weight = max(data$weight[data$Time == new_df_2[i,"new_time"]])
    min_weight = min(data$weight[data$Time == new_df_2[i,"new_time"]])
    
    new_df_2[i,"new_variation"] = max_weight - min_weight
  }
})




detectCores() # pc에서 사용 가능한 core 수

numCores = detectCores() - 1 # 모든 core를 사용하기에 pc에 부담이 되기 때문에 여분의 코어를 둔다
myCluster = makeCluster(numCores)

registerDoParallel(myCluster)

pkg = c("data.table", "dplyr")
system.time({
  foreach(i = 1:nrow(new_df_2), .combine = c, .packages = pkg) %dopar% {
    max_weight = max(data$weight[data$Time == new_df_2[i,"new_time"]])
    min_weight = min(data$weight[data$Time == new_df_2[i,"new_time"]])
    
    new_df_2[i,"new_variation"] = max_weight - min_weight
  }
})


stopCluster(myCluster)


