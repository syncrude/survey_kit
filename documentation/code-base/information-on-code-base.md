[Back to Main Page](../../README.md)

# Contents

1. [Directories in this package](#directories-in-this-package)
2. [How the Survey Kit package is setup](#how-the-survey-kit-package-is-setup)
    1. [Survey Configuration](#survey-configuration)
    2. [Survey Controller](#survey-controller)
    3. [Models](#models)
        1. [Answer Formats](#answer-formats)
        2. [Content Widgets](#content-widgets)
        3. [Result Widgets](#result-widgets)
        4. [Step Widget](#step-widget)
        5. [(Deprecated) - Predefined Widgets ](#deprecated---predefined-widgets)
    4. [Navigator](#navigator)
    5. [Presenter](#presenter)
    6. [Task](#task)
    7. [Utilities](#utilities)

## Information on this code base.

### Directories in this package

This package is setup with a number of directories that are used for different purposes.

1. `.github` This directory contains the CI/CD (Continuous Integration/Continuous Deployment) code. It includes configuration files and scripts that automate various tasks such as building, testing, and deploying the codebase.
2. `android` This directory contains the Android-specific settings and configurations for the codebase. It may include files related to the Android project setup, dependencies, build configurations, and other Android-specific resources.
3. `documentation` This directory contains the documentation for this repository. It includes important information, guides, tutorials, and any other relevant documentation to help users understand and work with the codebase effectively.
4. `example` This directory contains an example of how to use this package or codebase. It typically includes sample code, demos, or a small project that demonstrates the functionality and usage of the codebase.
5. `i18n` This directory contains internationalization files. It is used for managing translations and localization of the codebase to support multiple languages or regions. It may include language-specific resource files or configuration files for internationalization frameworks.
6. `ios` This directory contains the iOS-specific settings and configurations for the codebase. It may include files related to the iOS project setup, dependencies, build configurations, and other iOS-specific resources.
7. `lib` This directory contains the Dart source code files that define the functionality and logic of the package. These files include classes, functions, models, enums, and other code elements that implement the desired features of the package.
8. `test` This directory contains the tests for this package.

## How the Survey Kit package is setup

The main package file that is used is named [survey_kit.dart](../../lib/survey_kit.dart) and exists in the `lib` directory. The pub.dev package name is declared at the top `library survery_kit;`. 

After the declaration, the file contains export statements. These exports specify the public APIs that are accessible to users of the package. These APIs may include classes representing survey steps, answer formats, result models, and other components of the survey functionality. Additionally, the file may export utility functions, enums, or constants that are relevant to the package.

The exports are broken down into the following groups:

### Survey Configuration

The [survey_configuration.dart](../../lib/src/configuration/survey_configuration.dart) file is used to define a configuration class called SurveyConfiguration that provides configuration data for surveys in a Flutter application. It allows sharing this configuration data across the widget tree.

In simple terms, this file helps set up and manage the settings and behavior of surveys in an application. It includes properties such as survey progress configuration, task navigator, survey controller, localized strings for internationalization, and padding for the survey UI.

The SurveyConfiguration class is designed as an InheritedWidget, which means it can be accessed and used by descendant widgets in the widget tree. This allows different parts of the application to access and use the same survey configuration without passing it explicitly through function parameters.

The file also includes a static method called of that allows accessing the nearest SurveyConfiguration instance from a given BuildContext. This method is useful for retrieving the survey configuration in descendant widgets without having to pass it down manually.

### Survey Controller

The [survey_controller.dart](../../lib/src/controller/survey_controller.dart) file is responsible for managing the navigation and state of a survey in a Flutter application. It provides functions that handle moving to the next step, going back to the previous step, and closing the survey.

In simple terms, this file helps control the flow of a survey by defining methods that handle different actions. Here's a breakdown of what each method does:

1. The `nextStep` method is used to navigate to the next step in the survey. It takes in the BuildContext and an optional StepResult as parameters. If a callback function called onStepNext is provided, it calls that function with the context and step result. Otherwise, it triggers the NextStep event on the SurveyStateProvider, which is responsible for managing the survey state.

2. The `stepBack` method is used to navigate back to the previous step in the survey. It takes in the BuildContext and an optional StepResult as parameters. If a callback function called onStepBack is provided, it calls that function with the context and step result. Otherwise, it triggers the StepBack event on the SurveyStateProvider.

3. The `closeSurvey` method is used to close the survey and perform any necessary actions. It takes in the BuildContext and an optional StepResult as parameters. If a callback function called onCloseSurvey is provided, it calls that function with the context and step result. Otherwise, it triggers the CloseSurvey event on the SurveyStateProvider.

These methods provide flexibility for customizing the behavior of the survey navigation and allowing developers to define their own logic for handling different survey actions.

### Models
These classes handle the convertion and shaping of the information in a step.

#### Answer Formats

This file, [answer_format.dart](../../lib/src/model/answer/answer_format.dart), is responsible for defining an abstract class called AnswerFormat and its subclasses. It also includes a factory method for creating an AnswerFormat object from JSON data.

In simple terms, this file provides a structure for different types of answer formats that can be used in a survey. Here's a breakdown of what the code does:

1. The AnswerFormat class is an abstract class that serves as a blueprint for different types of answer formats. It includes properties such as the question text and answer type.

2. The subclasses of AnswerFormat (e.g., MultipleChoiceAnswerFormat, SingleChoiceAnswerFormat, etc.) provide specific implementations for different types of answer formats. Each subclass may have additional properties and methods specific to that answer format.

3. The `createView` method is a required method that needs to be implemented by each subclass. It takes a Step object and a StepResult object as parameters and returns a Widget that represents the view for that answer format in the survey.

4. The `fromJson` factory method is used to create an AnswerFormat object from a JSON representation. It takes a JSON map as input, extracts the type property from the map, and based on the type, creates and returns the corresponding subclass of AnswerFormat.

5. The `toJson` factory method is used to output the type of answer format this AnswerFormat is. It is returned in JSON format.

Overall, this file provides a framework for defining and working with different types of answer formats in a survey. It allows developers to create custom answer formats by subclassing AnswerFormat and provides a way to deserialize JSON data into specific answer format objects.

*** Within the same directory *** 

There are all of the different types of answer formats that can be used in the package. All of these answer formats are JSON serializable. The JsonSerializable annotation in Flutter is part of the json_serializable package, which provides automatic code generation for JSON serialization and deserialization. It follows the "Serialization/Deserialization" pattern.


#### Content Widgets

This [content.dart](../../lib/src/model/content/content.dart) file defines a class called Content that represents different types of content in a Flutter application. The class includes methods for converting the content to and from JSON, as well as a method for creating a widget based on the content type.

In simple terms, this file provides a way to define and handle different types of content in an application. Here's a breakdown of what the code does:

1. The Content class has a factory method called fromJson that takes a JSON map as input and returns an instance of the Content class or one of its subclasses (AudioContent, TextContent, VideoContent, MarkdownContent, LottieContent) based on the type property in the JSON. This method is used to deserialize JSON data into the appropriate content object.

2. The `toJson` method converts the Content object to a JSON map. It includes the id and contentType properties of the content.

3. The `createWidget` method is an abstract method that needs to be implemented by each subclass of Content. It returns a Widget that represents the visual representation of the content.

Overall, this file provides a framework for defining and working with different types of content in a Flutter application. It allows developers to create custom content types by subclassing Content and provides methods for serialization/deserialization to JSON and creating widgets based on the content type.

*** Within the same directory *** 

There are all of the different types of content types that can be used in the package.


#### Result Widgets

The result widgets are used to handle the results of how the user moves through the survey. The types of results are:

1. The [Step Result](../../lib/src/model/result/step_result.dart) file is responsible for defining the StepResult class, which represents the result of a step in a survey or questionnaire within a Flutter application.

2. The [Survey Result](../../lib/src/model/result/survey_result.dart) file is responsible for defining the SurveyResult class, which represents the result of a survey in a Flutter applicatio

3. The [Time Result](../../lib/src/model/result/time_result.dart) file is resposible for defining a converter class called _TimeOfDayConverter that handles the conversion between TimeOfDay objects and JSON data. It provides methods for converting JSON data to a TimeOfDay object and vice versa.

4. The [Video Result](../../lib/src/model/result/video_result.dart) file is responsible for defining the VideoResult class, which represents the the start time that a video was presented and how long the user viewed the video.


#### Step Widget

The purpose of the [step.dart](../../lib/src/model/step.dart) file is to define the Step class, which represents a survey step in a Flutter application. The class has properties such as id, isMandatory, answerFormat, buttonText, content, and stepShell. These properties store information about the survey step, including its unique identifier, whether it is mandatory, the answer format, button text, content to be displayed, and the step shell used for displaying the step.

#### (Deprecated) - Predefined Widgets 

These predefined steps provide a structured way to organize and present a survey or questionnaire to the user. They help guide the user through the survey process, from the introduction to answering specific questions, and finally to the completion of the survey. The same functionality can now be acheived through using the 'Step Widget'. This is depricated and will be removed in future versions of the library.

The three types of the predefined are:

1. ***Introduction Step***: The Introduction Step is used to introduce the survey or questionnaire to the user. It typically includes a welcome message, instructions, or any other content that provides context and guidance to the user before they begin answering the survey questions. This step helps set the expectations and purpose of the survey.

2. ***Question Steps***: The Question Step represents a step in the survey that includes a question for the user to answer. It can be used to gather specific information or feedback from the user. The Question Step may include various types of questions such as multiple-choice, single-choice, text input, or other custom question formats. It allows the user to provide their response or input based on the question asked.

3. ***Completion Step***: The Completion Step represents the final step of a survey or questionnaire. It is typically used to indicate that the survey has been completed. This step may include a message or summary of the survey results, a thank you note, or any other content that should be displayed at the end of the survey.

### Navigator

The navigator files handle how the presentation of the survey steps are presented to the user depending on navigation types and rules.

1. ***Navigation Rules***: There are two types of navigation rules, direct navigation and conditional.

    In simple terms, the difference between direct and conditional navigational rules lies in how they determine the next step in a survey or questionnaire:

    1. ***Direct Navigational Rule***: A direct navigational rule specifies a fixed next step for a particular survey step. It means that regardless of the user's input or previous responses, the next step will always be the same. It follows a predefined path without any conditions or evaluations. For example, if the current step is Step A, the direct navigational rule may state that the next step is Step B.

    2. ***Conditional Navigational Rule***: A conditional navigational rule determines the next step based on specific conditions or mappings. It allows for dynamic navigation based on the user's input or previous responses. The rule includes a mapping function that evaluates the input or results and maps them to a specific step identifier. For example, if the current step is Step A and the user's input matches a certain condition, the conditional navigational rule may specify that the next step is Step B. However, if the input does not match any condition, it may lead to a different step, such as Step C or Step D.

    In summary, direct navigational rules have a fixed next step, while conditional navigational rules allow for dynamic navigation based on conditions or mappings.

2. ***Task Navigators***

The task navigators handle the transitions from one question to another.

There are 2 types of navigators in this package.
    1. ***Ordered Task Navigator***: This provides the functionality to navigate through an ordered task by determining the next, previous, and first steps based on the current step and the task's list of steps. It extends the TaskNavigator class and overrides specific methods to customize the navigation behavior for ordered tasks.

    2. ***Navigatable Task Navigator***: This provides the functionality to navigate through a navigable task by determining the next, previous, and first steps based on the current step, task rules, and previous results. It extends the TaskNavigator class and overrides specific methods to customize the navigation behavior for navigable tasks.


### Presenter

The presenter files contain the models and functionality to manage the state and navigation of a survey, handle survey events, update the survey state, and retrieve survey-related information.

The main file for managing state in this flutter package is the [survey_state_provider.dart](../../lib/src/presenter/survey_state_provider.dart) which defines a class called SurveyStateProvider that manages the state and navigation of a survey in a Flutter application. Here's a breakdown of what this file does:

    * The SurveyStateProvider class extends the ChangeNotifier class, which allows it to notify listeners when the state changes.

    * The class includes properties such as taskNavigator, onResult, stepShell, and navigatorKey. These properties store information about the task navigator, the callback function for survey results, the step shell, and the navigator key.

    * The class maintains a current survey state (_state) and provides a getter method (state) to access it.

    * It includes methods to update the survey state (updateState) and retrieve the survey state from the current BuildContext (of).

    * The class keeps track of a set of question results (results) and the start date of the survey (startDate).

    * It includes an onEvent method that handles different survey events such as starting the survey, moving to the next step, going back to the previous step, and closing the survey. It updates the survey state accordingly and performs navigation actions.

    * The class has private methods (_handleInitialStep, _handleNextStep, _handleClose, _handleSurveyFinished, _addResult, _getResultByStepIdentifier) that handle specific survey events and update the survey state accordingly.

    * It provides additional methods to retrieve the current step index, get a step result by its identifier, and count the total number of steps in the survey.

    * The file also includes an extension method (SurveyStateExt) to easily access the SurveyStateProvider from the current BuildContext.

### Task

The task files are the models and classes for the Tasks that are handled in the task navigators and task rules.

### Utilities

The utility files are helper files that are used throughout the package. They include:
    * date/time conversions
    * utilities to transform iterables into lists with seperators
    * min and max values of integers in flutter
    * mixins that are intended to be used with a `StatefulWidget` to add date measurement functionality, and retrieving a previous step result
    * constants used in the UI.

### Views & Widget

These directories contain all of the widgets that are used in the survey package.



[Back To Top](#contents)
