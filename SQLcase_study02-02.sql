use dannys_diner_case_study;

--- describe about sales table
EXEC sp_help sales;
--- describe about menu table
EXEC SP_HELP MENU;
-- describe about members table
EXEC SP_HELP MEMBERS;
--- REALTIONS :- SALES(CUSTOMER_ID)-> MEMBERS(CUSTOMER_ID) AND SALES(PRODUCT_ID) -> MENU(PRODUCT_ID)



