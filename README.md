# ECommerce

## Setting Up ECommerce Website Locally

Follow these steps to set up the ECommerce website on your local system:

1. **Clone the Repository**
   - Go to the GitHub repository of the ColdFusion website you want to clone.
   - Clone the repository to your local system using Git.

2. **Set Up Local MySQL Database**
   - Install MySQL Server on your local system if you haven't already.
   - Open the file located at `dbscripts/ecommerce.sql` in the cloned folder.
   - Copy all the SQL commands from the file and execute them in your MySQL SQL editor to create the necessary tables and populate data.

3. **Install ColdFusion 2018**
   - Download ColdFusion 2018 installer from the Adobe website or authorized distributor.
   - Follow the installation instructions and configure ColdFusion to use the web server of your choice.
   - Configure ColdFusion to use the local MySQL database you created earlier as the datasource.

4. **Move Website Files**
   - Move the cloned ECommerce website files to the web root directory of ColdFusion. The default location is typically `wwwroot`.

5. **Run the Website Locally**
   - Open a web browser and navigate to the URL where the ColdFusion website is hosted locally (e.g., `http://localhost:port/ECommerce`).
   - Verify that the website is accessible and functioning correctly.
