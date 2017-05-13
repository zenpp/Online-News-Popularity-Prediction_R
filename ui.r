library(shiny)
news = read.csv('OnlineNewsPopularity.csv')

shinyUI(navbarPage("Online New Popularity Prediction",
          tabPanel("Prediction",
            fluidRow(
              column(6,
                     textInput("title", "Title",placeholder = "Input Title"),
                     textAreaInput("content", "Content",  width = "350px" , height = "450px" ,placeholder = "Input article content"),
                     verbatimTextOutput("predict_result")
              ),
              column(6, 
                     textInput("no_link", "No. of link" ),
                     textInput("no_img", "No. of image"),
                     textInput("no_video", "No. of video"),
                     textInput("keyword", "No. of keyword"),
                     textInput("min_ref_shares","Minimum of referenced article share"),
                     textInput("max_ref_shares","Maximum of referenced article share"),
                     selectInput("days", label = ("Day Publish"), 
                                 choices = list("Monday" = 1, "Tuesday" = 2,
                                                "Wednesday" = 3 , "Thursday" = 4 , "Friday" = 5,
                                                "Weekend" = 6), selected = 1),
                     selectInput("types", label = ("Type of Article"), 
                                 choices = list("Lifestyle" = 1, "Entertainment" = 2,
                                                "Business" = 3 , "Socail Media" = 4 , "Technology" = 5,
                                                "World" = 6 ,"None" = 7), selected = 1),
                     actionButton("predict", "Predict")
                     
              )
            )
            
          ),
          tabPanel("Analysis",
                   fluidPage(
                     headerPanel(h3('Attribute Corelation Analysis')),
                     sidebarPanel(
                       selectInput('variable', 'Variable',
                                   choices = c("n_tokens_title" = names(news)[[3]],
                                               "n_tokens_content" = names(news)[[4]],
                                               "num_hrefs" = names(news)[[5]],
                                               "num_self_hrefs" = names(news)[[6]],
                                               "num_imgs" = names(news)[[7]],
                                               "num_videos" = names(news)[[8]],
                                               "num_keywords" = names(news)[[9]],
                                               "data_channel_is_lifestyle" = names(news)[[10]],
                                               "data_channel_is_entertainment" = names(news)[[11]],
                                               "data_channel_is_bus" = names(news)[[12]],
                                               "data_channel_is_socmed" = names(news)[[13]],
                                               "data_channel_is_tech" = names(news)[[14]],
                                               "data_channel_is_world" = names(news)[[15]],
                                               "self_reference_min_shares" = names(news)[[16]],
                                               "self_reference_max_shares" = names(news)[[17]],
                                               "weekday_is_monday" = names(news)[[18]],
                                               "weekday_is_tuesday" = names(news)[[19]],
                                               "weekday_is_wednesday" = names(news)[[20]],
                                               "weekday_is_thursday" = names(news)[[21]],
                                               "weekday_is_friday" = names(news)[[22]],
                                               "is_weekend" = names(news)[[24]]
                                   ),
                                   selected = "timedelta")
                     )    
                ),
                mainPanel(
                  plotOutput('plot1')
                )
          )
                   
))