# typesense_demo

this project shows how to use typsense cloud in a flutter app
![image](https://user-images.githubusercontent.com/59013444/178934621-b87d1e3f-9445-4995-b4a1-4bb8a88466be.png)
![image](https://user-images.githubusercontent.com/59013444/178934481-f72ea20a-4c3a-4075-b8e0-1970b4dd352f.png)
![image](https://user-images.githubusercontent.com/59013444/178934543-b9eb28a0-10d5-412a-8aa5-f423a65a00a7.png)

## File List
homepage.dart: class the reusable app bar
typesenseSearch.dart: this file contains code to configure typesense client and also contain a function to run  user query in typesense server
appbar.dart: contains all the code for search bar, suggestions, result, sort and filter
productList.dart: this class inherts fro provider package and responsible for state management. it contains function for sort and filter
searchResultModal.dart: modal to store result returned from typesense server
secondpage.dart: just a page to show the next screen
