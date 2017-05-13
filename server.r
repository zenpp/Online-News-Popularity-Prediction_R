library(shiny)
library(randomForest)
library(corrplot)
my_model <- readRDS("newsrf.rds")
news = read.csv('OnlineNewsPopularity.csv')

shinyServer(function(input, output) {
  
  predict_action <- eventReactive(input$predict, {
    n_tokens_title = as.integer(sapply(gregexpr("\\W+", input$title), length) + 1)
    n_tokens_content = as.integer(sapply(gregexpr("\\W+", input$content), length) + 1)
    num_hrefs = as.integer(input$no_link)
    num_self_hrefs = 2
    num_imgs = as.integer(input$no_img)
    num_videos = as.integer(input$no_video)
    num_keywords = as.integer(input$keyword)
    data_channel_is_lifestyle = as.integer(ifelse(input$types == 1 , 1 , 0))
    data_channel_is_entertainment	= as.integer(ifelse(input$types == 2 , 1 , 0))
    data_channel_is_bus = as.integer(ifelse(input$types == 3 , 1 , 0))
    data_channel_is_socmed = as.integer(ifelse(input$types == 4 , 1 , 0))
    data_channel_is_tech = as.integer(ifelse(input$types == 5 , 1 , 0))
    data_channel_is_world = as.integer(ifelse(input$types == 6 , 1 , 0))
    self_reference_min_shares = as.integer(input$min_ref_shares)
    self_reference_max_shares = as.integer(input$max_ref_shares)
    weekday_is_monday = as.integer(ifelse(input$days == 1 , 1 , 0))
    weekday_is_tuesday = as.integer(ifelse(input$days == 2 , 1 , 0))
    weekday_is_wednesday = as.integer(ifelse(input$days == 3 , 1 , 0))
    weekday_is_thursday = as.integer(ifelse(input$days == 4 , 1 , 0))
    weekday_is_friday = as.integer(ifelse(input$days == 5 , 1 , 0))
    weekday_is_saturday = as.integer(ifelse(input$days == 6 , 1 , 0))
    weekday_is_sunday = as.integer(ifelse(input$days == 7 , 1 , 0))
    is_weekend = as.integer(ifelse(input$days == 6 , 1 , 0))
    news_input = data.frame(n_tokens_title,n_tokens_content,num_hrefs,num_self_hrefs,num_imgs,num_videos,num_keywords,data_channel_is_lifestyle,
                                                    data_channel_is_entertainment,data_channel_is_bus,data_channel_is_socmed,data_channel_is_tech,
                                                    data_channel_is_world,self_reference_min_shares,self_reference_max_shares,
                                                    weekday_is_monday,weekday_is_tuesday,weekday_is_wednesday,weekday_is_thursday,weekday_is_friday,
                                                    weekday_is_saturday,weekday_is_sunday,is_weekend)
    pred <- predict(my_model , news_input)
    if(pred==1){
      pred = "Popular with 64.72% Accuracy"
    }else{
      pred = "Unpopular with 64.72% Accuracy"
    }
    
  })
  output$predict_result <- renderText({
    predict_action()
  })
  
  selectedData <- reactive({
    news[, c(input$variable)]
  })
  
  corelation <- reactive({
    cor(c(news$shares),data)
  })
  
  output$plot1 <- renderPlot({
    data <- switch(input$variable,
                   "n_tokens_title" = c(news$n_tokens_title),
                   "n_tokens_content" = c(news$n_tokens_content),
                   "num_hrefs" = c(news$num_hrefs),
                   "num_self_hrefs" = c(news$num_self_hrefs),
                   "num_imgs" = c(news$num_imgs),
                   "num_videos" = c(news$num_videos),
                   "num_keywords" = c(news$num_keywords),
                   "data_channel_is_lifestyle" = c(news$data_channel_is_lifestyle),
                   "data_channel_is_entertainment" = c(news$data_channel_is_entertainment),
                   "data_channel_is_bus" = c(news$data_channel_is_bus),
                   "data_channel_is_socmed" = c(news$data_channel_is_socmed),
                   "data_channel_is_tech" = c(news$data_channel_is_tech),
                   "data_channel_is_world" = c(news$data_channel_is_world),
                   "self_reference_min_shares" = c(news$self_reference_min_shares),
                   "self_reference_max_shares" = c(news$self_reference_max_shares),
                   "weekday_is_monday" = c(news$weekday_is_monday),
                   "weekday_is_tuesday" = c(news$weekday_is_tuesday),
                   "weekday_is_wednesday" = c(news$weekday_is_wednesday),
                   "weekday_is_thursday" = c(news$weekday_is_thursday),
                   "is_weekend" = c(news$is_weekend)
                   
    )
    plot(c(news$shares), data, xlab = "Share", ylab = c(input$variable))
  })
  
  
})
