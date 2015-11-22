library(markdown)
#creates a 4 tab UI with the necessary inout widgets and output rendering
shinyUI(navbarPage("Titanic Survival Analysis",
        tabPanel("Home",
                 mainPanel(
                         h2("The study of the Titanic disaster"),
                         p("The purpose of this app is to provide an interactive tool to study the Titanic disaster.
                           The Titanic was a ship that sank on its maiden voyage and a majority of the passengers drowned. 
                           But taking a closer look at the survivors by various category of passengers, it is easy to see that the 
                           deaths didn't occur randomly and some groups fared better than the others. This tool helps to take a
                           closer look at those differences from a statistical stand point."),
                         br(),
                         p("The app has three components - exploratory analysis, linear regression model and 
                           a hypothesis test of proportion."),
                         br(),
                         h4("Explore"),
                         p("The selected combination of varaibles are plotted to compare the survival and deaths in the histogram plot. 
                         The survival rate for the selected variables is also shown."),
                         br(),
                         h4("Model"),
                         p("A logisitc regression model is built with Survived(Yes/No) as response and the selected variable(Class,Sex or Age) as predictors 
                           to analyze the response within members of that group."), 
                         br(),
                         h4("Probability"),
                         p("This test compares the proportion of survivors within a group to analyse whether there is a significant difference in proportions. 
                           For e.g does the proportion of males who survived to the total number of males significantly
                           differ from the proportion of female survivors to total females.")                         
                         
                 )
                 ),           
        tabPanel("Explore",
                sidebarLayout(
                        sidebarPanel(
                                h4("Select variables to analyze"),
                                br(),
                                selectInput("paxclass", "Choose a class:", 
                                            choices = c("All","1st","2nd",'3rd',"Crew")),
                                selectInput("paxsex", "Choose sex:", 
                                            choices = c("All","Male","Female")),
                                selectInput("paxage", "Choose age group:", 
                                            choices = c("All","Adult","Child"))
                                    ),
                        mainPanel(
                                h5(" This plot compares the number of survivors of the groups selected."),
                                plotOutput("plot")
                                 )
                        )
                ),
        tabPanel("Model",
                 sidebarLayout(
                     sidebarPanel(
                             h4("Select variable"),
                        radioButtons("radio", label="",
                                choices = list("Class" = "Class", "Sex" = "Sex", "Age Group" = "Age"), 
                                      selected = "Class")
                         ),
                         mainPanel(
                                 h2("Logistic Regression Model"),
                                 p("Each of the key predictors, Class, Sex and Age are used to gauge the odds of survival within the selected group."),  
                                 h3("Odds of Survival"),
                                 verbatimTextOutput("model1"),
                                 p("This shows the relative odds compared to the control group. For e.g. the odds of a passenger in second class 
                                   surviving is less that half(0.42) the the odds of a first class passenger. Odds of a female is more than ten times a male(10.14) 
                                   and an adult has less than half a child's odds(0.41)." ),
                                 br(),
                                 h3("Inverse of Odds of Survival"),
                                 verbatimTextOutput("model2"),
                                 p("This shows the odds from the opposite side (1/odds). For e.g. the odds of a first class passenger 
                                   surviving is more than twice that of a second class passenger(2.35). The odds of a male surviving is less than ten percent that 
                                   of a female(0.09) and a child has more that twice the odds of a male (2.41).")
                                 
                         )
                 )

                ),
        tabPanel("Probability",
                 sidebarLayout(
                         sidebarPanel(
                                 radioButtons("radio2", label = h4("Select variable"),
                                              choices = list("Class" = "Class", "Sex" = "Sex", "Age Group" = "Age"), 
                                              selected = "Class")
                         ),
                         mainPanel(
                                 h2("Hypothesis Test of Proportions"),
                                 p("This tests the likelihood that the survival rates within a group are statistically the same.
                                   For e.g is the proportion of men who survived equal to the proportion of women. 
                                   The null hypothesis is that the proportions are equal." ),
                                 h3("Proportions"),
                                 verbatimTextOutput("model3"),
                                 p("These are the proportions calculated by prop.test for the members of the group."),
                                 br(),
                                 h3("Probability"),
                                 verbatimTextOutput("model4"),
                                 p("This is the probability that the proportions above are statistically equal. 
                                   At a 95% confidence level the null hypothesis is rejected because in all cases the probability is less than 0.05")
                                 
                         )
                 )
                 
        )
        )

)