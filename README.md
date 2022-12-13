# RrCodeChallenge

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
- Run tests with `mix test`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Instructions For Challenge

- There are currently 5 failing tests in test/portfolio_management_tests.exs
- Your Job is to adjust the functions in portfolio_management.ex so these all pass.
- Are there any changes you'd make to the schema structure? Any additional tests you think would be valuable?

Domain Information/Terminology:

- Customers - a company that users our product
- Portfolio - This isn't represented in a db table, but it is the collective list of vendors that are related to a given customer.
- User - individual user, belongs to a customer
- Vendor - a separate company that does not directly interact with the product, but can belong to one or many customers' portfolios.
- CustomerVendor - This is a join table when a vendor belongs in a customers' portfolio.
- CustomerFolder - This describes a categorization that customers can define as a way of grouping their vendors in their portfolio.
- CustomerVendorAllocation - Join table - when a customer's vendor has been categorized into a customer's folder. Customer Vendor's can belong in many different folders.
- UserAvailableFolder - Another Join table - this one is between Customer Folder and User. It depicts the folders a user has access to, which subsiquently determine the vendors they have access to.
