# Task App

Task App is a Flutter-based ticket management system designed for efficient communication between customers, support agents, and administrators.

## Features

- User role-based access (Customer, Support Agent, Admin)
- Ticket creation and management
- Real-time updates and notifications
- Dark mode support
- File attachment support

## Screenshots

[Add screenshots here]

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Launch the app using `flutter run`

## User Roles and Functionalities

### Role Selection Screen

The app starts with a role selection screen where users can choose their role:

- Customer
- Admin
- Support Agent

[Add screenshot of Role Selection Screen]



### Customer

1. Login/Register
2. Dashboard
   - View active tickets
   - Create new tickets
3. Create Ticket
   - Add title and description
   - Attach files (jpg, pdf)
4. View Ticket Details
   - See ticket status, description, and attachments
   - Add notes to the ticket
5. View all tickets

[Add screenshots of Customer screens]


### Support Agent

1. Login
2. Dashboard
   - View ticket statistics (Total, Active, Pending, Closed)
   - Quick access to all tickets
3. View All Tickets
   - Filter tickets by status
4. Ticket Details
   - View ticket information
   - Add notes/replies
   - Update ticket status

[Add screenshots of Support Agent screens]

### Admin

1. Login
2. Dashboard
   - View overall statistics (Users, Tickets)
   - Quick access to user management and all tickets
3. User Management
   - View all users
   - Add new support agents
4. View All Tickets
   - Similar to Support Agent view
5. Ticket Details
   - Similar to Support Agent view, with additional administrative options

[Add screenshots of Admin screens]

## Key Components

1. Authentication Service (`AuthService`)
2. Ticket Service (`TicketService`)
3. Theme Service (`ThemeService`)

## Workflow

1. User selects role on the Role Selection Screen
2. User logs in or registers (for customers)
3. User is directed to their respective dashboard based on their role
4. Users can perform role-specific actions (create tickets, manage tickets, etc.)
5. Logout returns users to the Role Selection Screen

## Development

This app is built using Flutter and follows a provider-based state management approach. Key files include:

- `main.dart`: App entry point and provider setup
- `screens/`: Contains all the screen widgets
- `services/`: Contains the core logic for authentication, ticket management, and theming
- `models/`: Data models for users and tickets

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

[Add your license information here]
