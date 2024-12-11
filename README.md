# README

## Known Issues and Limitations

### Speech Translation Accuracy
- **Delay Between Interactions**: Users must wait **1 second** after pressing the button to speak and another **1 second** before pressing the button again to stop the recording. This ensures the app correctly picks up the audio and avoids mistakenly marking words said correctly as being incorrect.  

### API Limitations
- **First API Call Issue**: When a user clicks on the first word marked as incorrect for pronunciation feedback, the **first call does not produce audio output**. However, subsequent calls function as expected.
- **Word Recognition Gaps**: Some words may not exist in the API. Since the open API we are using is free, it may not cover certain word pronunciations comprehensively. This applies especially in regard to names, etc.

### App-Specific Issues

- **Pronunciation Feedback Colors Reset**: Sometimes, when closing the pronunciation feedback, the colors of the words reset to black instead of maintaining their feedback status.

- **Incomplete Navigation Tabs**: Navigation tabs were not a primary focus during development. For example, the leaderboard button is non-functional at this stage.

- **Mute Functionality Issue**: When muting from the main screen and then attempting to mute from the story pause overlay, users need to perform the action twice for the mute functionality to work properly.

### Items limiting 90% test Coverage

---

## Testing Instructions for TA/Professor

### Please use This Pre-Configured Test Account
- **Username**: `sample_user@email.com`  
- **Password**: `password`  

This account contains pre-existing data that can be reviewed, such as streak information and the number of hours logged.

---

## Features Overview We Wanted to Point Out

### Locked Stories
- The app includes infrastructure for locked stories, allowing users to "purchase" additional content. However, the purchase process is not fully implemented. Users currently cannot complete transactions using cards or virtual payment methods. This feature is included to showcase the intent to provide premium content in the future. 
---

## Testing Explanations and Limitations for Code Coverage
### ViewModels
###### AuthViewModel
In the AuthViewModel, there are specific areas that remain uncovered by tests due to constraints. In terms of error handling with catch statements and failures, many of the catch blocks in the code (such as for save_login_time() and logout()) include print statements which were manually checked during development to ensure the output was the correct message. Also, some catch blocks handle errors related to the sign-in processes with Firestore. These were manually tested during development to check that the errors were caught correctly. These catch blocks were not unit tested due to real-time dependencies of Firestore and error variability, which led to inconsistent results in test results, despite working correctly in the app and when checked in the entries of the database. 
Additionally, the update_completed_stories() function could not be directly tested due to constraints in the testing environment. However, this method is called within the UserDataViewModel method, fetch_num_books_read(), which was covered by unit tests. This allowed the team to verify that the update_completed_stories() method works as expected within the context of the entire system, even though it was not explicitly covered by automated tests.

### Models
Tests for the User and Story models are written under StutterQuestTests/ModelTests. These tests pass in Xcode, however are not reflected in the team's Xcode's code coverage report. This may be due to the way the test schema has been set up, but if this occurs, please note the model tests created for grading. 


### DataRepository (StoryRepository)
The tests for the StoryRepository class are located under StutterQuestTests/DataRepositoryTests. However, the assertion statements within the test are not being run for the get() method, likely due to the asynchronous execution of the Firestore operations for adding and fetching data, this likely leads to a delay between the operation and completion causing the assert statements to not run. 

### Services
The team did not write tests for two service files, SpeechRecognizer.swift and PronounciationService.swift, which are related to the API used by the team. These files are from external services provided by third-party libraries, which causes the responses and behaviors to be beyond the team's control such as for server load or specific input data. Since their behavior, downtime, and potential latency are related to external services, it is difficult to create consistent and reliable unit tests. Thus, the team checked the functionality and performance of the services manually by observing the behavior of the services, such as the API Limitations outlined above. Additionally, through user testing, we were able to get feedback to ensure the app met expectations and needs, allowing for identifying any issues or potential improvements. 
