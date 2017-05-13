library(randomForest)
my_model <- readRDS("newsrf.rds")

n_tokens_title = 91
n_tokens_content = 700
num_hrefs = 4
num_self_hrefs = 2
num_imgs = 3
num_videos = 1
num_keywords = 6
data_channel_is_lifestyle = 0
data_channel_is_entertainment	= 0
data_channel_is_bus = 0
data_channel_is_socmed = 0
data_channel_is_tech = 0
data_channel_is_world = 0
self_reference_min_shares = 7
self_reference_max_shares = 22
weekday_is_monday = 0
weekday_is_tuesday = 0
weekday_is_wednesday = 0
weekday_is_thursday = 1
weekday_is_friday = 0
weekday_is_saturday = 0
weekday_is_sunday = 0
is_weekend = 1
news_input = data.frame(n_tokens_title,n_tokens_content,num_hrefs,num_self_hrefs,num_imgs,num_videos,num_keywords,data_channel_is_lifestyle,
                        data_channel_is_entertainment,data_channel_is_bus,data_channel_is_socmed,data_channel_is_tech,
                        data_channel_is_world,self_reference_min_shares,self_reference_max_shares,
                        weekday_is_monday,weekday_is_tuesday,weekday_is_wednesday,weekday_is_thursday,weekday_is_friday,
                        weekday_is_saturday,weekday_is_sunday,is_weekend)
pred <- predict(my_model , news_input)
print(pred==1)


