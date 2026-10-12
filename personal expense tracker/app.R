# ============================================================
# PERSONAL EXPENSE TRACKER AND ANALYSIS SYSTEM
# Professional Shiny Dashboard
# ============================================================

library(shiny)
library(ggplot2)

# ============================================================
# 1. LOAD OR CREATE DATA
# ============================================================

if (file.exists("expenses.csv")) {
  
  expenses <- read.csv(
    "expenses.csv",
    stringsAsFactors = FALSE
  )
  
  expenses$Date <- as.Date(expenses$Date)
  
} else {
  
  expenses <- data.frame(
    Expense_ID = 1:5,
    
    Date = as.Date(c(
      "2026-09-01",
      "2026-09-03",
      "2026-09-05",
      "2026-09-10",
      "2026-09-15"
    )),
    
    Category = c(
      "Food",
      "Transport",
      "Education",
      "Shopping",
      "Entertainment"
    ),
    
    Amount = c(
      250,
      100,
      500,
      800,
      300
    ),
    
    Description = c(
      "Lunch",
      "Bus fare",
      "Books",
      "Clothes",
      "Movie"
    )
  )
  
  write.csv(
    expenses,
    "expenses.csv",
    row.names = FALSE
  )
}


# ============================================================
# 2. PROFESSIONAL CSS DESIGN
# ============================================================

custom_css <- tags$head(
  
  tags$style(HTML("

    /* -----------------------------
       MAIN BODY
    ----------------------------- */

    body {
      background-color: #f4f7fb;
      font-family: 'Segoe UI', Arial, sans-serif;
      color: #263238;
    }


    /* -----------------------------
       NAVIGATION BAR
    ----------------------------- */

    .navbar {
      background: linear-gradient(
        90deg,
        #172554,
        #1d4ed8
      ) !important;

      border: none !important;
      border-radius: 0 !important;
      box-shadow: 0 3px 12px rgba(0,0,0,0.15);
    }

    .navbar-brand {
      color: white !important;
      font-size: 22px !important;
      font-weight: bold !important;
    }

    .navbar-nav > li > a {
      color: white !important;
      font-weight: 500;
      transition: 0.3s;
    }

    .navbar-nav > li > a:hover {
      background-color: rgba(255,255,255,0.15) !important;
    }


    /* -----------------------------
       DASHBOARD TITLE
    ----------------------------- */

    .dashboard-title {
      font-size: 32px;
      font-weight: 700;
      color: #172554;
      margin-top: 20px;
      margin-bottom: 5px;
    }

    .dashboard-subtitle {
      color: #64748b;
      font-size: 16px;
      margin-bottom: 25px;
    }


    /* -----------------------------
       HERO BANNER
    ----------------------------- */

    .hero {
      background:
        linear-gradient(
          rgba(23,37,84,0.82),
          rgba(29,78,216,0.78)
        ),
        url('https://images.unsplash.com/photo-1554224155-6726b3ff858f');

      background-size: cover;
      background-position: center;

      min-height: 230px;

      border-radius: 18px;

      padding: 45px;

      color: white;

      margin-bottom: 30px;

      box-shadow:
        0 8px 25px rgba(0,0,0,0.15);
    }

    .hero h1 {
      font-size: 36px;
      font-weight: 700;
      margin-bottom: 12px;
    }

    .hero p {
      font-size: 17px;
      max-width: 650px;
      line-height: 1.6;
    }


    /* -----------------------------
       SUMMARY CARDS
    ----------------------------- */

    .summary-card {

      background: white;

      border-radius: 16px;

      padding: 24px;

      margin-bottom: 25px;

      min-height: 145px;

      box-shadow:
        0 5px 18px rgba(0,0,0,0.08);

      transition: all 0.3s ease;

      border-left: 5px solid #2563eb;
    }

    .summary-card:hover {

      transform: translateY(-5px);

      box-shadow:
        0 10px 25px rgba(0,0,0,0.13);
    }

    .card-icon {

      font-size: 32px;

      margin-bottom: 10px;
    }

    .card-title {

      color: #64748b;

      font-size: 14px;

      text-transform: uppercase;

      letter-spacing: 1px;
    }

    .card-value {

      font-size: 28px;

      font-weight: 700;

      color: #172554;

      margin-top: 8px;
    }


    /* -----------------------------
       CONTENT CARDS
    ----------------------------- */

    .content-card {

      background: white;

      border-radius: 16px;

      padding: 25px;

      margin-bottom: 25px;

      box-shadow:
        0 5px 18px rgba(0,0,0,0.07);
    }

    .content-card h3 {

      color: #172554;

      font-weight: 600;

      margin-top: 0;

      border-bottom: 2px solid #e2e8f0;

      padding-bottom: 12px;

      margin-bottom: 20px;
    }


    /* -----------------------------
       BUTTONS
    ----------------------------- */

    .btn-primary {

      background: linear-gradient(
        90deg,
        #2563eb,
        #1d4ed8
      ) !important;

      border: none !important;

      border-radius: 8px !important;

      padding: 10px 20px !important;

      font-weight: 600 !important;

      transition: 0.3s;
    }

    .btn-primary:hover {

      transform: translateY(-2px);

      box-shadow:
        0 5px 12px rgba(37,99,235,0.35);
    }


    .btn-danger {

      border-radius: 8px !important;

      font-weight: 600 !important;
    }


    /* -----------------------------
       INPUT BOXES
    ----------------------------- */

    .form-control {

      border-radius: 8px !important;

      border: 1px solid #cbd5e1 !important;

      padding: 10px !important;
    }

    .form-control:focus {

      border-color: #2563eb !important;

      box-shadow:
        0 0 0 3px rgba(37,99,235,0.12) !important;
    }


    /* -----------------------------
       TABLE
    ----------------------------- */

    .table {

      background: white;

      border-radius: 10px;

      overflow: hidden;
    }

    .table > thead > tr > th {

      background-color: #172554 !important;

      color: white !important;

      border: none !important;

      padding: 14px !important;
    }

    .table > tbody > tr > td {

      padding: 12px !important;

      vertical-align: middle !important;
    }

    .table > tbody > tr:hover {

      background-color: #eff6ff !important;
    }


    /* -----------------------------
       SECTION HEADERS
    ----------------------------- */

    .section-title {

      font-size: 24px;

      font-weight: 700;

      color: #172554;

      margin-bottom: 20px;
    }


    /* -----------------------------
       FOOTER
    ----------------------------- */

    .footer {

      text-align: center;

      color: #64748b;

      padding: 25px;

      margin-top: 30px;

      border-top: 1px solid #e2e8f0;
    }

  "))
)


# ============================================================
# 3. DASHBOARD UI
# ============================================================

dashboard_page <- tabPanel(
  
  "🏠 Dashboard",
  
  custom_css,
  
  div(
    
    class = "container-fluid",
    
    # Hero section
    div(
      
      class = "hero",
      
      h1("💰 Personal Expense Tracker"),
      
      p(
        "Track your daily expenses, understand your spending habits, ",
        "and make better financial decisions using data-driven analysis."
      ),
      
      p(
        strong("Expense Management & Analysis System Using R")
      )
    ),
    
    
    # Page title
    div(
      class = "dashboard-title",
      "Financial Overview"
    ),
    
    div(
      class = "dashboard-subtitle",
      "A quick summary of your current expense information"
    ),
    
    
    # Summary cards
    fluidRow(
      
      column(
        
        4,
        
        div(
          class = "summary-card",
          
          div(
            class = "card-icon",
            "💰"
          ),
          
          div(
            class = "card-title",
            "Total Expense"
          ),
          
          div(
            class = "card-value",
            textOutput("total_expense")
          )
        )
      ),
      
      
      column(
        
        4,
        
        div(
          class = "summary-card",
          
          div(
            class = "card-icon",
            "🧾"
          ),
          
          div(
            class = "card-title",
            "Total Transactions"
          ),
          
          div(
            class = "card-value",
            textOutput("expense_count")
          )
        )
      ),
      
      
      column(
        
        4,
        
        div(
          class = "summary-card",
          
          div(
            class = "card-icon",
            "📊"
          ),
          
          div(
            class = "card-title",
            "Average Expense"
          ),
          
          div(
            class = "card-value",
            textOutput("average_expense")
          )
        )
      )
    ),
    
    
    # Charts
    fluidRow(
      
      column(
        
        6,
        
        div(
          
          class = "content-card",
          
          h3("📊 Spending by Category"),
          
          plotOutput(
            "category_plot",
            height = "350px"
          )
        )
      ),
      
      
      column(
        
        6,
        
        div(
          
          class = "content-card",
          
          h3("📅 Monthly Spending"),
          
          plotOutput(
            "monthly_plot",
            height = "350px"
          )
        )
      )
    ),
    
    
    # Recent expenses
    div(
      
      class = "content-card",
      
      h3("🧾 Recent Expenses"),
      
      tableOutput("recent_table")
    ),
    
    
    # Footer
    div(
      
      class = "footer",
      
      "Personal Expense Tracker | Developed using R & Shiny"
    )
  )
)


# ============================================================
# 4. ADD EXPENSE PAGE
# ============================================================

add_page <- tabPanel(
  
  "➕ Add Expense",
  
  div(
    
    class = "container",
    
    br(),
    
    div(
      
      class = "content-card",
      
      h2(
        class = "section-title",
        "➕ Add New Expense"
      ),
      
      p(
        "Enter the details of your new expense below."
      ),
      
      dateInput(
        "date",
        "📅 Expense Date",
        value = Sys.Date()
      ),
      
      selectInput(
        
        "category",
        
        "📂 Category",
        
        choices = c(
          "Food",
          "Transport",
          "Education",
          "Shopping",
          "Entertainment",
          "Health",
          "Bills",
          "Other"
        )
      ),
      
      numericInput(
        
        "amount",
        
        "💰 Amount (₹)",
        
        value = 0,
        
        min = 0
      ),
      
      textInput(
        
        "description",
        
        "📝 Description",
        
        placeholder = "Example: Lunch at college"
      ),
      
      br(),
      
      actionButton(
        
        "add_expense",
        
        "➕ Add Expense",
        
        class = "btn-primary"
      )
    )
  )
)


# ============================================================
# 5. MANAGE EXPENSE PAGE
# ============================================================

manage_page <- tabPanel(
  
  "⚙️ Manage Expenses",
  
  div(
    
    class = "container",
    
    br(),
    
    div(
      
      class = "content-card",
      
      h2(
        class = "section-title",
        "⚙️ Manage Expenses"
      ),
      
      h3("✏️ Update Expense"),
      
      numericInput(
        "update_id",
        "Expense ID",
        value = 1,
        min = 1
      ),
      
      dateInput(
        "update_date",
        "Date",
        value = Sys.Date()
      ),
      
      selectInput(
        
        "update_category",
        
        "Category",
        
        choices = c(
          "Food",
          "Transport",
          "Education",
          "Shopping",
          "Entertainment",
          "Health",
          "Bills",
          "Other"
        )
      ),
      
      numericInput(
        "update_amount",
        "Amount (₹)",
        value = 0,
        min = 0
      ),
      
      textInput(
        "update_description",
        "Description"
      ),
      
      actionButton(
        "update_expense",
        "✏️ Update Expense",
        class = "btn-primary"
      ),
      
      hr(),
      
      h3("🗑️ Delete Expense"),
      
      numericInput(
        "delete_id",
        "Expense ID to Delete",
        value = 1,
        min = 1
      ),
      
      actionButton(
        "delete_expense",
        "🗑️ Delete Expense",
        class = "btn-danger"
      )
    )
  )
)


# ============================================================
# 6. EXPENSE RECORDS PAGE
# ============================================================

records_page <- tabPanel(
  
  "📋 Expense Records",
  
  div(
    
    class = "container-fluid",
    
    br(),
    
    div(
      
      class = "content-card",
      
      h2(
        class = "section-title",
        "📋 Complete Expense Records"
      ),
      
      p(
        "All expenses currently stored in the system."
      ),
      
      tableOutput("expense_table")
    )
  )
)


# ============================================================
# 7. COMPLETE UI
# ============================================================

ui <- navbarPage(
  
  title = "💰 Expense Tracker",
  
  theme = NULL,
  
  dashboard_page,
  
  add_page,
  
  manage_page,
  
  records_page
)


# ============================================================
# 8. SERVER
# ============================================================

server <- function(input, output, session) {
  
  
  # ----------------------------------------------------------
  # Reactive expense data
  # ----------------------------------------------------------
  
  expense_data <- reactiveVal(expenses)
  
  
  # ----------------------------------------------------------
  # TOTAL EXPENSE
  # ----------------------------------------------------------
  
  output$total_expense <- renderText({
    
    total <- sum(expense_data()$Amount)
    
    paste0(
      "₹ ",
      format(
        total,
        big.mark = ",",
        nsmall = 2
      )
    )
  })
  
  
  # ----------------------------------------------------------
  # NUMBER OF EXPENSES
  # ----------------------------------------------------------
  
  output$expense_count <- renderText({
    
    nrow(expense_data())
  })
  
  
  # ----------------------------------------------------------
  # AVERAGE EXPENSE
  # ----------------------------------------------------------
  
  output$average_expense <- renderText({
    
    data <- expense_data()
    
    if (nrow(data) == 0) {
      
      "₹ 0.00"
      
    } else {
      
      paste0(
        "₹ ",
        format(
          mean(data$Amount),
          big.mark = ",",
          nsmall = 2
        )
      )
    }
  })
  
  
  # ==========================================================
  # CATEGORY CHART
  # ==========================================================
  
  output$category_plot <- renderPlot({
    
    data <- expense_data()
    
    if (nrow(data) == 0) {
      return(NULL)
    }
    
    category_total <- aggregate(
      Amount ~ Category,
      data = data,
      FUN = sum
    )
    
    ggplot(
      category_total,
      aes(
        x = reorder(Category, Amount),
        y = Amount
      )
    ) +
      
      geom_col(
        fill = "#2563eb",
        width = 0.7
      ) +
      
      coord_flip() +
      
      labs(
        x = NULL,
        y = "Amount (₹)"
      ) +
      
      theme_minimal(base_size = 14) +
      
      theme(
        panel.grid.minor = element_blank(),
        plot.background = element_rect(
          fill = "white",
          color = NA
        )
      )
  })
  
  
  # ==========================================================
  # MONTHLY CHART
  # ==========================================================
  
  output$monthly_plot <- renderPlot({
    
    data <- expense_data()
    
    if (nrow(data) == 0) {
      return(NULL)
    }
    
    data$Month <- format(
      data$Date,
      "%Y-%m"
    )
    
    monthly_total <- aggregate(
      Amount ~ Month,
      data = data,
      FUN = sum
    )
    
    ggplot(
      monthly_total,
      aes(
        x = Month,
        y = Amount
      )
    ) +
      
      geom_col(
        fill = "#16a34a",
        width = 0.6
      ) +
      
      labs(
        x = "Month",
        y = "Amount (₹)"
      ) +
      
      theme_minimal(base_size = 14) +
      
      theme(
        panel.grid.minor = element_blank(),
        plot.background = element_rect(
          fill = "white",
          color = NA
        )
      )
  })
  
  
  # ==========================================================
  # RECENT EXPENSES
  # ==========================================================
  
  output$recent_table <- renderTable({
    
    data <- expense_data()
    
    data <- data[
      order(
        data$Date,
        decreasing = TRUE
      ),
    ]
    
    data <- head(data, 5)
    
    data$Date <- format(
      data$Date,
      "%Y-%m-%d"
    )
    
    data$Amount <- paste0(
      "₹ ",
      format(
        data$Amount,
        big.mark = ",",
        nsmall = 2
      )
    )
    
    data
  })
  
  
  # ==========================================================
  # COMPLETE EXPENSE TABLE
  # ==========================================================
  
  output$expense_table <- renderTable({
    
    data <- expense_data()
    
    data$Date <- format(
      data$Date,
      "%Y-%m-%d"
    )
    
    data$Amount <- paste0(
      "₹ ",
      format(
        data$Amount,
        big.mark = ",",
        nsmall = 2
      )
    )
    
    data
  })
  
  
  # ==========================================================
  # ADD EXPENSE
  # ==========================================================
  
  observeEvent(input$add_expense, {
    
    data <- expense_data()
    
    if (input$amount <= 0) {
      
      showNotification(
        "Please enter a valid amount.",
        type = "error"
      )
      
      return()
    }
    
    
    new_id <- if (nrow(data) == 0) {
      
      1
      
    } else {
      
      max(data$Expense_ID) + 1
    }
    
    
    new_expense <- data.frame(
      
      Expense_ID = new_id,
      
      Date = as.Date(input$date),
      
      Category = input$category,
      
      Amount = input$amount,
      
      Description = input$description
    )
    
    
    data <- rbind(
      data,
      new_expense
    )
    
    
    expense_data(data)
    
    
    write.csv(
      data,
      "expenses.csv",
      row.names = FALSE
    )
    
    
    showNotification(
      "✅ Expense added successfully!",
      type = "message"
    )
  })
  
  
  # ==========================================================
  # UPDATE EXPENSE
  # ==========================================================
  
  observeEvent(input$update_expense, {
    
    data <- expense_data()
    
    id <- input$update_id
    
    if (!(id %in% data$Expense_ID)) {
      
      showNotification(
        "❌ Expense ID not found.",
        type = "error"
      )
      
      return()
    }
    
    
    index <- which(
      data$Expense_ID == id
    )
    
    
    data$Date[index] <-
      as.Date(input$update_date)
    
    data$Category[index] <-
      input$update_category
    
    data$Amount[index] <-
      input$update_amount
    
    data$Description[index] <-
      input$update_description
    
    
    expense_data(data)
    
    
    write.csv(
      data,
      "expenses.csv",
      row.names = FALSE
    )
    
    
    showNotification(
      "✅ Expense updated successfully!",
      type = "message"
    )
  })
  
  
  # ==========================================================
  # DELETE EXPENSE
  # ==========================================================
  
  observeEvent(input$delete_expense, {
    
    data <- expense_data()
    
    id <- input$delete_id
    
    
    if (!(id %in% data$Expense_ID)) {
      
      showNotification(
        "❌ Expense ID not found.",
        type = "error"
      )
      
      return()
    }
    
    
    data <- data[
      data$Expense_ID != id,
    ]
    
    
    expense_data(data)
    
    
    write.csv(
      data,
      "expenses.csv",
      row.names = FALSE
    )
    
    
    showNotification(
      "🗑️ Expense deleted successfully!",
      type = "message"
    )
  })
  
}


# ============================================================
# 9. RUN APPLICATION
# ============================================================

shinyApp(
  ui = ui,
  server = server
)