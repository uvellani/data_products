#load data set
data(Titanic)
#convert to dataframe
titanic <- as.data.frame(Titanic)
#create a data set for modeling that expands the freq to individual rows
fitdat <- titanic[rep(1:nrow(titanic), titanic$Freq), -5]

#load ggplot
library(ggplot2)

shinyServer(
        function(input, output) {
           #this is for plot of first tab  
           output$plot <- renderPlot({ 
                   if (input$paxclass!="All") {
                           #creates a subset based on the selected variable
                           titanic <- titanic[titanic$Class==input$paxclass,] 
                   } 
                   
                   if (input$paxage!="All") {
                           #creates a subset based on the selected variable
                           titanic <- titanic[titanic$Age==input$paxage,] 
                   } 
                   
                   if (input$paxsex!="All") {
                           #creates a subset based on the selected variable
                           titanic <- titanic[titanic$Sex==input$paxsex,] 
                   }
                   
                   #aggregates the counts
                   agg <- aggregate(Freq~Survived,data=titanic,sum)  
                   #survival rate
                   srate <- round(agg[agg$Survived=="Yes",]$Freq/sum(agg$Freq),4)*100
                   #check for NaN
                   srate <- ifelse(is.finite(srate),srate," ")
                   
                   #plot
                   ggplot(agg,aes(x=factor(Survived),y=Freq,fill=Survived), color=Survived) +
                     xlab("Survived") + ylab("Number of Passengers") + 
                     geom_bar(stat="identity", width=0.5,position = position_dodge(width = 0.5)) +
                     ggtitle(paste0("Survival rate within selected group(%): ",srate)) + 
                     theme(plot.title = element_text(lineheight=2, face="bold"))
           },height = 500, width = 400 )
        
           #modelling for second tab based on selected variable
           output$model1 <- renderPrint({
                    fitform <- paste0("Survived~",input$radio)
                    fit <- glm(fitform,family=binomial,fitdat)
                    exp(summary(fit)$coef[,1])
           }) 
           output$model2 <- renderPrint({
                   fitform <- paste0("Survived~",input$radio)
                   fit <- glm(fitform,family=binomial,fitdat)
                   1/exp(summary(fit)$coef[,1])
           })
           
           #modelling for third tab based on selected variable
           output$model3 <- renderPrint({
                   if (input$radio2=="Class"){
                           propfit <- prop.test(table(fitdat$Class,fitdat$Survived),correct=FALSE)
                   }
                   if (input$radio2=="Sex"){
                           propfit <- prop.test(table(fitdat$Sex,fitdat$Survived),correct=FALSE)
                   }
                   if (input$radio2=="Age"){
                           propfit <- prop.test(table(fitdat$Age,fitdat$Survived),correct=FALSE)
                   }
                   
                   propfit["estimate"]
                   
           })
           
           #modelling for third tab based on selected variable
           output$model4 <- renderPrint({

                   if (input$radio2=="Class"){
                           propfit <- prop.test(table(fitdat$Class,fitdat$Survived),correct=FALSE)
                   }
                   if (input$radio2=="Sex"){
                           propfit <- prop.test(table(fitdat$Sex,fitdat$Survived),correct=FALSE)
                   }
                   if (input$radio2=="Age"){
                           propfit <- prop.test(table(fitdat$Age,fitdat$Survived),correct=FALSE)
                   }
                   
                   propfit["p.value"]
                   
           })
           
        }
)