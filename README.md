# MovieProject

You can search for movies and you can see movie list based on few category.

I have followed MVVM(Model-View-ViewModel) pattern in this project. Here, UIViewController does all the logic part of UI related and its own an object of its associated ViewModel. ViewModel does all the work using/via Model and update the UI if necessary.

To show the movie list or category list or category values list, I have used separate viewcontrollers which are subclass of  one common view controller with xib.  And I have override few methods in subclasses to do the work.

TODO:
1. RatingView handle touch event.
2. Protocol naming convention


NOTE:
1. For ratingView, I couldnot find same dimension empty/fill star image. So, there might be dicrepency in visibiity. Also, Rating view developed for just show rating only. 


