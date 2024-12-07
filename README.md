# README

## Known Issues and Limitations

### Speech Translation Accuracy
- **Delay Between Interactions**: Users must wait **1 second** after pressing the button to speak and another **1 second** before pressing the button again to stop the recording. This ensures the app correctly picks up the audio and avoids mistakenly marking words said correctly as being incorrect.  

### API Limitations
- **First API Call Issue**: When a user clicks on the first word marked as incorrect for pronunciation feedback, the **first call does not produce audio output**. However, subsequent calls functions as expected.
- **Word Recognition Gaps**: Some words may not exist in the API. Since the open API we are using is free, it may not cover certain word pronunciations comprehensively. This applies especially in regards to names, etc. 

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
