# AskMe

AskMe is an application that serves as a clone of [ask.fm](https://ask.fm/). It provides a platform where users can register, ask questions anonymously or openly, answer questions, filter questions by hashtags, customize the page's color, and set up their avatar using [Gravatar](https://en.gravatar.com/).

## Technology Stack

AskMe is built using Ruby on Rails version 7.0.4. The authentication and authorization functionalities have been implemented manually without relying on any external gems. The CSS styling has also been done manually, providing a custom look and feel to the application. Font Awesome gem was utilized to create icons throughout the application. Additionally, the user's nickname is used instead of the ID in user routes to enhance user experience. The n+1 query problem has been resolved using the Bullet gem.

## Getting Started

To get started with AskMe, please follow the steps below:

### Prerequisites

Make sure you have Ruby 3.1.4 installed on your system. You can use a version manager like [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://github.com/rvm/rvm) for this purpose.

### Installation

1. Clone the repository by running the following command in your terminal:
```
git clone https://github.com/dr-or/askme
```

2. Enter the project folder:
```
cd askme
```

3. Install the required dependencies by running the following command:
```
bundle config set --local without 'production'
bundle install
```

4. Perform the necessary database migrations:
```
bundle exec rails db:migrate
```

5. Start the local server by running the following command:
```
bundle exec rails s
```

<sub> You can stop the server at any time by pressing **\`Ctrl + C\`** on your keyboard. </sub> 

##### Now you're all set to explore and use AskMe. Enjoy your experience!
