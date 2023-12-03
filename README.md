# BombNews

BombNews is an application that shows news recently. Before starting the app I decided to use Statelful-Mvvm.

# What is MVVM and Why?
MVVM stands for Model, View, View Model. It describes the flow of our data and the separation of our concerns. The following imagery can represent it because use the power of observation completely and be able to write unit test easily. In addition, I used a stateful structure in the app. Stateful keeps all MVVM features but reinforces new features. Such as state and coordinator. It so a complicated approach for those who see the first time. So I applied a new approach to the state layer to both understand better and reduce the difficulties of architecture.

![ezgif com-webp-to-png](https://github.com/Brsrld/BombNews/assets/35069032/c0af5898-2714-4be7-bf3b-e0dafc2fc2d9)

You can find all the details about Statefull MVVM in this [article](https://medium.com/@brsrld/a-new-approach-to-stateful-mvvm-7cd54c710fa3).

# UI Testing and Unit Testing

I wrote Unit Tests in Swift before but I wrote UItest the first time. Unit test in SwiftUI is kind of different from uikit. In the uikit we can communicate viewController and viewModel with protocol. Because uikit doesn't have property wrappers. Thanks to property wrappers we can release every change of view model in the view same time. Basically, observers use combine infrastructure. ObjectWillChange acts like a publisher and we subscribe with property wrappers. In the unit case classes, we cannot use property wrapper so we have to use combine to listen to view models

Finally, a piece of [music](https://www.youtube.com/watch?v=I8ilQuCMmHA) for you to listen to when examining the project. 
