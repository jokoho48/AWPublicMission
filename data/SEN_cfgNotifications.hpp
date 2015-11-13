class Default {
    title = ""; // Tile displayed as text on black background. Filled by arguments.
    iconPicture = ""; // Small icon displayed in left part. Colored by "color", filled by arguments.
    iconText = ""; // Short text displayed over the icon. Colored by "color", filled by arguments.
    description = ""; // Brief description displayed as structured text. Colored by "color", filled by arguments.
    color[] = {1,1,1,1}; // Icon and text color
    duration = 7; // How many seconds will the notification be displayed
    priority = 0; // Priority; higher number = more important; tasks in queue are selected by priority
    difficulty[] = {}; // Required difficulty settings. All listed difficulties has to be enabled
};

class SEN_approvalBonus: Default {
    title = "Civilian Approval Bonus +%1";
    iconPicture = "media\SEN_imgTaskCiv_64.paa";
    description = "Civilian are now more frendly to you";
};

class SEN_liberate: Default {
    title = "Location Liberated!";
    iconPicture = "media\SEN_imgLiberate_64.paa";
    description = "The enemy surrenders! You've liberated %1!";
};

class SEN_ticketAdd: Default {
    title = "Tickets +%1";
    iconPicture = "media\SEN_imgTickets_64.paa";
    description = "New Tickets Added!";
};

class SEN_ticketSubstact: Default {
    title = "Tickets -%1";
    iconPicture = "media\SEN_imgTickets_64.paa";
    description = "Tickets Substracted!";
};
