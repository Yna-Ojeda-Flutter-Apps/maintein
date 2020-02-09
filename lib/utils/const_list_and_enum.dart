// ____ General ____ //
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

enum DateFilter {All, Today, Month, Week, Null}

// ____ For Assessment Screens ____ //
const List<String> mwbQuestions = [
  'My life is on the right track',
  'I wish I could change some part of my life',
  'My future looks good',
  'I feel as though the best years of my life are over',
  'I like myself',
  'I feel there must be something wrong with me',
  'I can handle any problems that come up',
  'I feel like a failure',
  'I feel loved and trusted',
  'I seem to be left alone when I don’t want to be',
  'I feel close to people around me',
  'I have lost interest in other people and don’t care about them',
  'I feel I can do whatever I want to',
  'My life seems stuck in a rut',
  'I have energy to spare',
  'I can’t be bothered doing anything',
  'I smile and laugh a lot',
  'Nothing seems very much fun anymore',
  'I think clearly and creatively',
  'My thoughts go around in useless circles',
  'Satisfied',
  'Disconnected',
  'Optimistic',
  'Hopeless',
  'Useful',
  'Insignificant',
  'Confident',
  'Helpless',
  'Understood',
  'Lonely',
  'Loving',
  'Withdrawn',
  'Free-and-easy',
  'Tense',
  'Enthusiastic',
  'Depressed',
  'Good-natured',
  'Impatient',
  'Clear-headed',
  'Confused',
];

const eisQuestions = [
  'I know when to speak about my personal problems to others',
  'When I am faced with obstacles, I remember times I faced similar obstacles and overcame them',
  'I expect that I will do well on most things I try',
  'Other people find it easy to confide in me',
  'I find it hard to understand the non-verbal messages of other people',
  'Some of the major events of my life have led me to re-evaluate what is important and not important',
  'When my mood changes, I see new possibilities',
  'Emotions are one of the things that make my life worth living',
  'I am aware of my emotions as I experience them',
  'I expect good things to happen',
  'I like to share my emotions with others',
  'When I experience a positive emotion, I know how to make it last',
  'I arrange events others enjoy',
  'I seek out activities that make me happy',
  'I am aware of the non-verbal messages I send to others',
  'I present myself in a way that makes a good impression on others',
  'When I am in a positive mood, solving problems is easy for me',
  'By looking at their facial expressions, I recognize the emotions people are experiencing',
  'I know why my emotions changes',
  'When I am in a positive mood, I am able to come up with new ideas',
  'I have control over my emotions',
  'I easily recognize my emotions as I experience them',
  'I motivate myself by imagining a good outcome to tasks I take on',
  'I compliment others when they have done something well',
  'I am aware of the non-verbal messages other people send',
  'When another person tells me about an important event in his or her life, I almost feel as though I experienced this myself',
  'When I feel a change in emotions, I tend to come up with new ideas',
  'When I am faced with a challenge, I give up because I believe I will fail',
  'I know what other people are feeling just by looking at them',
  'I help other people feel better when they are down',
  'I use good moods to help myself keep trying in the face of obstacles',
  'I can tell how people are feeling by listening to the tone of their voice',
  'It is difficult for me to understand why people feel the way they do',
];
const List<String> mwbChoices = [
  'Not at all',
  'Occassionally',
  'Some of the time',
  'Often',
  'All of the time',
];
const List<String> eisChoices = [
  'Strongly Disagree',
  'Somewhat Disagree',
  'Neither Agree nor Disagree',
  'Somewhat Agree',
  'Strongly Agree',
];

// ____ For Active Listening ____ //
const List<String> conversationPrompts = [
  "What is your favorite movie and what happens in it?'",
  "Tell me about your family.",
  "Tell me about your pets or the pet you would like to have.",
  "What kind of music do you like to listen to?",
  "Tell me about what you watch on TV.",
  "What is your favorite toy to play with or what toy do you wish you had?",
  "Tell me about your favorite video games.",
  "Tell me about a funny or scary dream you had.",
  "What do you want to do five years from now?",
  "What do you do for Halloween? What did you dress up last time and what do you want to be this year?",
  "What do you do for Valentine’s Day?",
  "What do you do for Christmas and what is your favorite thing about it?",
  "When is your birthday and what did you do for your last birthday? What do you want to do for your next birthday?",
  "What is your favorite animal and why?",
  "What is your favorite movie?",
  "Do you have any hidden talents?",
  "What is your favorite color and why?",
  "What is your favorite holiday and why?",
  "What is your favorite game to play?",
  "What is your favorite sport and why?",
  "What are you excited about that’s going to happen soon?",
  "Where have you lived and which was your favorite place?",
  "What does your room look like?",
  "Tell me about your favorite book?",
  "What is your favorite thing about school and why?",
  "What are some things you don’t like to do and why?",
  "What do you like to do when you’re alone?",
  "What do you like to do in the summer?",
  "If you could meet anyone, who would it be?",
  "What do you like to do with other people?",
  "Tell me about a time you went camping or slept outside?",
  "What animal would you be and why?",
  "What would you change about yourself if you could change one thing?",
  "What are your favorite candies and/or treats?",
  "What is your favorite holiday and why?",
  "What are your favorite foods? What are some foods you don’t like?",
  "If you could buy anything you wanted, what would you buy?",
  "If you could go anywhere on vacation, where would you go?",
  "If you could live anywhere, where would you live and why?",
];
const String conversationPromptHeader = "Haven't listened to anyone yet? Go ask someone:";
const List<String> conversationPraise = ["Great job! You've exercised your listening skills at least once today.", "Amazing, you're on a roll! Improvements take practice, and you've been listening all day."];
const List<String> iHad = [
  'Postures and gestures that showed engagement',
  'Appropriate facial expression',
  'Appropriate eye contact',
  'Paraphrased what they said to check if I understood'
];
const List<String> iGave = [
  'Minimal verbal encouragers',
  'Infrequent timely and considered questions',
  'Attentive Silences'
];
const List<String> iCan = [
  'Pickup the speaker\'s feelings',
  'Summarize the speaker\'s major issues or points'
];
const List<String> iDidNot = [
  'Judge, criticize, label, diagnose, or give praise evaluation',
  'Avoid their concern',
  'Moralize or advise'
];

// ____ For Reflective Journal Writing____ //
const List<String> reflectionPrompts = [
  "Have I been using my time wisely?",
  "Have I taken anything for granted recently?",
  "Am I employing a healthy perspective?",
  "Am I living true to myself?",
  "Am I waking up in the morning ready to take on the day?",
  "Am I thinking negative thoughts before I fall asleep?",
  "Am I putting enough effort into my relationships?",
  "Am I taking care of myself physically?",
  "Am I letting matters that are out of my control stress me out?",
  "Am I achieving the goals that I’ve set for myself?",
  "Who am I, really?",
  "What worries me most about the future?",
  "If this were the last day of my life, would I have the same plans for today?",
  "What am I really scared of?",
  "Am I holding on to something I need to let go of?",
  "If not now, then when?",
  "What matters most in my life?",
  "What am I doing about the things that matter most in my life?",
  "Why do I matter?",
  "Have I done anything lately that’s worth remembering?",
  "Have I made someone smile today?",
  "What have I given up on?",
  "When did I last push the boundaries of my comfort zone?",
  "If I had to instill one piece of advice in a newborn baby, what advice would I give?",
  "What small act of kindness was I once shown that I will never forget?",
  "How will I live, knowing I will die?",
  "What do I need to change about myself?",
  "Is it more important to love or be loved?",
  "How many of my friends would I trust with my life?",
  "Who has had the greatest impact on my life?",
  "Would I break the law to save a loved one?",
  "Would I steal to feed a starving child?",
  "What do I want most in life?",
  "What is life asking of me?",
  "Which is worse: failing or never trying?",
  "If I try to fail and succeed, what have I done?",
  "What’s the one thing I’d like others to remember about me at the end of my life?",
  "Does it really matter what others think about me?",
  "To what degree have I actually controlled the course of my life?",
  "When all is said and done, what will I have said more than I’ve done?",
  "My favorite way to spend the day is . . .",
  "If I could talk to my teenage self, the one thing I would say is . . .",
  "The two moments I’ll never forget in my life are . . .",
  "Make a list of 30 things that make you smile.",
  "Write about a moment experienced through your body. Making love, making breakfast, going to a party, having a fight, an experience you’ve had or you imagine for your character. Leave out thought and emotion, and let all information be conveyed through the body and senses.",
  "The words I’d like to live by are . . .",
  "I couldn’t imagine living without . . .",
  "When I’m in pain—physical or emotional—the kindest thing I can do for myself is . . .",
  "Make a list of the people in your life who genuinely support you, and whom you can genuinely trust. Then, make time to hang out with them.",
  "What does unconditional love look like for you?",
  "What things would you do if you loved yourself unconditionally? How can you act on these things, even if you’re not yet able to love yourself unconditionally?",
  "I really wish others knew this about me . . .",
  "Name what is enough for you.",
  "If my body could talk, it would say . . .",
  "Name a compassionate way you’ve supported a friend recently. Then, write down how you can do the same for yourself.",
  "What do you love about life?",
  "What always brings tears to your eyes? As Paulo Coelho has said, tears are words that need to be written.",
  "Write about a time when your work felt real, necessary and satisfying to you, whether the work was paid or unpaid, professional or domestic, physical or mental.",
  "Write about your first love—whether it’s a person, place or thing.",
  "Using 10 words, describe yourself.",
  "What’s surprised you the most about your life or life in general?",
  "What can you learn from your biggest mistakes?",
  "I feel most energized when . . .",
  "Write a list of questions to which you urgently need answers.",
  "Make a list of everything that inspires you—whether books, websites, quotes, people, paintings, stores, or stars in the sky.",
  "What’s one topic you need to learn more about to help you live a more fulfilling life? Then, follow through and learn more about that topic.",
  "I feel happiest in my skin when . . .",
  "Make a list of everything you’d like to say no to.",
  "Make a list of everything you’d like to say yes to.",
  "Write the words you need to hear."
];
const List<String> journalPraise = ["Great job! You've practiced reflection at least once today.", "Amazing, you're on a roll! Reflections increases a person's self-awareness, and you've done it at least thrice today."];
const String journalPromptHeader = "No particular thoughts? Here's some brain food:";


// ____ For Settings & Notifications____ //
const journalReminderTitles = [
  "What's happened recently?",
  "What's the most interesting thing you've done recently?",
  "How has your day been?",
  "How has your week been?",
  "Share some of your thoughts recently",
  "Share what you've been feeling as of late",
  "Write about something that made you feel recently",
  "What have you been doing lately?",
  "Share something you want to do differently",
  "Write anything about your day",
  "What could make tomorrow better?",
  "How could have today been better?",
  "How have you been making others feel lately?",
  "How stressful have you been recently?"
];

const activeListeningReminderBodies = [
  "Remember to be mindful of your postures when listening",
  "Remember to use nods and gestures to show engagement",
  "Remember to use appropriate facial expression",
  "Remember to check if you've understood by paraphrasing",
  "Remember to give minimal verbal encouragers",
  "Remember to ask infrequent and considered questions",
  "Remember to allow attentive silences",
  "Try to pick up on the speaker's feelings when you do",
  "Remember to summarize the speaker's major issues or points",
  "Avoid judging or criticizing the speaker when you do",
  "Don't avoid the speaker's concern when you do",
  "Avoid moralizing or advising the speaker when you do"
];

const goalTrackingReminderTitles = [
  "What are your plans for today?",
  "What are your plans for the week?",
  "What do you want to achieve today?",
  "What do you want to achieve this week?"
];

const weekday = [Day.Sunday, Day.Monday, Day.Tuesday, Day.Wednesday, Day.Thursday, Day.Friday, Day.Saturday];
const List<String> weekdays = ["S", "M", "T", "W", "T", "F", "S"];
const List<String> periods = ["Daily", "Weekly"];
const List<String> reminderTypes = ["Assessments", "Reflective Journal", "Listening Journal", "Goal Tracker"];
const List<List<int>> notificationIndices = [
  [0,1,2,3,4,5,6],
  [7,8,9,10,11,12,13],
  [14,15,16,17,18,19,20],
  [21,22,23,24,25,26,27]
];
