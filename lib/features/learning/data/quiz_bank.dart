import '../models/lesson_module.dart';

/// Full worksheet content for every module, organised into Parts A–L.
/// Only multiple-choice questions are auto-graded; the unlock gate (>50%)
/// is computed against [LessonModule.gradableQuestions].
const Map<String, List<QuizPart>> quizBank = {
  '1': _module1,
  '2': _module2,
  '3': _module3,
  '4': _module4,
  '5': _module5,
  '6': _module6,
};

// ────────────────────────────────────────────────────────────────────────
// Module 1 — What is Money?
// ────────────────────────────────────────────────────────────────────────
const List<QuizPart> _module1 = [
  QuizPart(
    id: 'A',
    title: 'Multiple Choice Questions',
    emoji: '📚',
    items: [
      QuizItem.mcq(
        id: 'm1q1',
        prompt: 'What is the main reason the barter system was difficult to use?',
        options: [
          'It was too expensive',
          'You needed to find someone who had what you wanted AND wanted what you had',
          'It only worked with food items',
          'It was invented too long ago',
        ],
        correctIndex: 1,
        explanation:
            'Barter required a "double coincidence of wants" — both people '
            'had to want exactly what the other was offering.',
      ),
      QuizItem.mcq(
        id: 'm1q2',
        prompt: 'Which of these was NOT mentioned as an early form of money?',
        options: ['Cowrie shells', 'Salt', 'Plastic coins', 'Cattle'],
        correctIndex: 2,
        explanation:
            'Shells, salt, and cattle were all used as early money. Plastic '
            'coins were never an early form of currency.',
      ),
      QuizItem.mcq(
        id: 'm1q3',
        prompt: 'What makes cryptocurrency different from regular money?',
        options: [
          "It's controlled by one government",
          'It only exists on paper',
          'No single person or government controls it',
          'It never changes in value',
        ],
        correctIndex: 2,
        explanation:
            'Cryptocurrency is decentralised — no single government or '
            'organisation controls it.',
      ),
      QuizItem.mcq(
        id: 'm1q4',
        prompt:
            'According to supply and demand, what happens to prices when many '
            'people want something rare?',
        options: [
          'Prices stay the same',
          'Prices go down',
          'Prices go up',
          'The item becomes free',
        ],
        correctIndex: 2,
        explanation:
            'When demand is high but supply is low, prices rise.',
      ),
      QuizItem.mcq(
        id: 'm1q5',
        prompt: 'Which is an example of a NEED (not a want)?',
        options: [
          'Designer sneakers when your old shoes work fine',
          'A new video game',
          'Food for lunch',
          'A second smartphone',
        ],
        correctIndex: 2,
        explanation:
            'Food is essential for survival — it is a need.',
      ),
    ],
  ),
  QuizPart(
    id: 'B',
    title: 'Quick Thinking Questions',
    emoji: '🤔',
    items: [
      QuizItem.longAnswer(
        id: 'm1q6',
        prompt:
            'Imagine money disappearing tomorrow. How would you get lunch at '
            'school?',
      ),
      QuizItem.longAnswer(
        id: 'm1q7',
        prompt:
            'Why do you think a bottle of water costs \$1 at a grocery store '
            'but \$5 at an amusement park?',
      ),
      QuizItem.fillBlanks(
        id: 'm1q8',
        prompt: 'List THREE qualities that make something good money:',
        blankLabels: ['1.', '2.', '3.'],
      ),
    ],
  ),
  QuizPart(
    id: 'C',
    title: 'Real-Life Scenarios',
    emoji: '💡',
    intro:
        'Scenario 1 — The Birthday Money Dilemma: Maya receives \$40 for her '
        'birthday. She wants to buy a \$35 video game, save \$15 for a bike '
        'fund, and spend \$10 on snacks with friends.',
    items: [
      QuizItem.longAnswer(
        id: 'm1q9',
        prompt: "What's the problem with Maya's plan?",
      ),
      QuizItem.fillBlanks(
        id: 'm1q10',
        prompt: 'Give Maya advice on how to budget her \$40:',
        blankLabels: [
          'Save: \$',
          'Video game: \$',
          'Snacks: \$',
          'Reasoning:',
        ],
      ),
      QuizItem.prompt(
        id: 'm1s2',
        prompt: 'Scenario 2 — The School Store Sale',
        subtitle:
            'Your school store normally sells notebooks for \$3 each. Today '
            'they\'re on sale for \$2 each, but you already have 5 notebooks '
            'at home that are barely used.',
      ),
      QuizItem.longAnswer(
        id: 'm1q11',
        prompt:
            'Should you buy more notebooks? Explain your reasoning using the '
            'concept of wants vs. needs.',
      ),
    ],
  ),
  QuizPart(
    id: 'D',
    title: 'Critical Thinking',
    emoji: '🎯',
    items: [
      QuizItem.fillBlanks(
        id: 'm1q12',
        prompt:
            'If you could create a new type of money for your school, what '
            'would you use and why? Consider that good money should be: '
            'durable, portable, divisible, uniform, limited, and accepted '
            'by everyone.',
        blankLabels: [
          'My school money would be:',
          'Why this would work:',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm1q13',
        prompt:
            "Do you think physical cash will still exist when you're 30 "
            'years old? Give TWO reasons for your answer.',
        blankLabels: [
          'My prediction (Yes / No):',
          'Reason 1:',
          'Reason 2:',
        ],
      ),
    ],
  ),
  QuizPart(
    id: 'E',
    title: 'Money in Your Life',
    emoji: '🏆',
    items: [
      QuizItem.fillBlanks(
        id: 'm1q14',
        prompt:
            'This week, write down THREE different ways you saw or used '
            'money (cash, card, digital, etc.):',
        blankLabels: ['1.', '2.', '3.'],
      ),
      QuizItem.longAnswer(
        id: 'm1q15',
        prompt:
            "What's one money mistake you've made or seen someone make? "
            'What lesson did you learn from it?',
      ),
    ],
  ),
  QuizPart(
    id: 'F',
    title: 'Bonus Challenge',
    emoji: '🎮',
    items: [
      QuizItem.longAnswer(
        id: 'm1q16',
        prompt:
            "You're a merchant in ancient Rome. You have 2 sheep and want to "
            'buy bread (costs 1/4 sheep), cloth (costs 1/2 sheep), and '
            'pottery (costs 1 sheep). How would you make these trades '
            'without coins? What problems would you face?',
      ),
    ],
  ),
  QuizPart(
    id: 'G',
    title: 'Self-Assessment',
    emoji: '📊',
    intro: 'Rate your understanding (1 = don\'t understand, 5 = completely understand).',
    items: [
      QuizItem.rating(
        id: 'm1r1',
        prompt: 'Rate your understanding of each topic:',
        blankLabels: [
          'The history of money',
          'Wants vs. needs',
          'How prices are determined',
          'Digital vs. physical money',
          'Basic budgeting',
        ],
      ),
      QuizItem.shortAnswer(
        id: 'm1r2',
        prompt: 'One thing I learned today:',
      ),
      QuizItem.shortAnswer(
        id: 'm1r3',
        prompt: 'One question I still have:',
      ),
    ],
  ),
];

// ────────────────────────────────────────────────────────────────────────
// Module 2 — Smart Spending: Wants vs Needs
// ────────────────────────────────────────────────────────────────────────
const List<QuizPart> _module2 = [
  QuizPart(
    id: 'A',
    title: 'Multiple Choice Questions',
    emoji: '🧠',
    items: [
      QuizItem.mcq(
        id: 'm2q1',
        prompt: 'What is the most reliable way to tell if something is a NEED?',
        options: [
          'Your friends all have it',
          "It's on sale at a good price",
          "You can't survive or function properly without it",
          "You've wanted it for a long time",
        ],
        correctIndex: 2,
        explanation:
            'Needs are things you cannot live or function well without.',
      ),
      QuizItem.mcq(
        id: 'm2q2',
        prompt:
            'Which psychological trick do advertisers commonly use to create '
            'urgency?',
        options: [
          'Showing happy families using the product',
          '"Limited time offer - only 24 hours left!"',
          'Using celebrity endorsements',
          'Comparing their product to competitors',
        ],
        correctIndex: 1,
        explanation:
            'Countdown timers and "limited time" deals create urgency so you '
            'buy without thinking.',
      ),
      QuizItem.mcq(
        id: 'm2q3',
        prompt: 'What is delayed gratification?',
        options: [
          'Never buying anything you want',
          'Always buying the cheapest option',
          'Waiting to get something you want instead of buying it immediately',
          "Only buying things when they're on sale",
        ],
        correctIndex: 2,
        explanation:
            'Delayed gratification means waiting — letting time test whether '
            'you really want or need something.',
      ),
      QuizItem.mcq(
        id: 'm2q4',
        prompt: 'According to the "cost per use" concept, which is better value?',
        options: [
          '₹200 shoes you wear 10 times',
          '₹400 shoes you wear 50 times',
          'The cheaper option is always better value',
          'Brand name always means better value',
        ],
        correctIndex: 1,
        explanation:
            '₹200 ÷ 10 = ₹20 per use; ₹400 ÷ 50 = ₹8 per use — the second '
            'pair is better value.',
      ),
      QuizItem.mcq(
        id: 'm2q5',
        prompt:
            'What should you do FIRST when friends pressure you to buy '
            'something expensive?',
        options: [
          'Buy it so you fit in with the group',
          "Lie about not having enough money",
          'Remember your personal budget and values',
          "Ask your parents for more money",
        ],
        correctIndex: 2,
        explanation:
            'Anchor decisions in your own budget and values before reacting '
            'to peer pressure.',
      ),
    ],
  ),
  QuizPart(
    id: 'B',
    title: 'Scenario Analysis',
    emoji: '💭',
    intro:
        'Scenario 1 — The Group Gift Dilemma: Your friends want everyone to '
        'contribute ₹150 for a group birthday gift for your classmate. You '
        'think ₹50 per person would be more reasonable and you\'ve been '
        'saving your money for a new book series.',
    items: [
      QuizItem.longAnswer(
        id: 'm2q6',
        prompt: 'Identify the main conflict in this scenario.',
      ),
      QuizItem.longAnswer(
        id: 'm2q7',
        prompt: 'What would you say to your friends? Write your response.',
      ),
      QuizItem.fillBlanks(
        id: 'm2q8',
        prompt: 'List two alternatives that might work for everyone:',
        blankLabels: ['1.', '2.'],
      ),
      QuizItem.prompt(
        id: 'm2s2',
        prompt: 'Scenario 2 — The Flash Sale Temptation',
        subtitle:
            "You're browsing online and see a \"70% OFF - Flash Sale - 2 "
            "Hours Only!\" for a gaming headset you've wanted. It's now ₹900 "
            "instead of ₹3000, but you hadn't planned to buy it and it would "
            "use most of your savings.",
      ),
      QuizItem.fillBlanks(
        id: 'm2q9',
        prompt: 'What psychological tricks is this advertisement using? Name at least two:',
        blankLabels: ['1.', '2.'],
      ),
      QuizItem.fillBlanks(
        id: 'm2q10',
        prompt: 'What should you do before making this purchase? List three actions:',
        blankLabels: ['1.', '2.', '3.'],
      ),
    ],
  ),
  QuizPart(
    id: 'C',
    title: 'Wants vs Needs Classification',
    emoji: '🎯',
    intro: 'For each item, mark W (Want), N (Need), or B (Both).',
    items: [
      QuizItem.classify(
        id: 'm2c',
        prompt: 'Classify each item:',
        blankLabels: [
          'Winter jacket in January',
          'Latest smartphone model',
          'School lunch',
          'Brand-name school backpack',
          'Birthday gift for best friend',
        ],
        classifyOptions: ['Want', 'Need', 'Both'],
      ),
      QuizItem.longAnswer(
        id: 'm2c_explain',
        prompt: 'For any "Both" answers above, explain why it could be both:',
      ),
    ],
  ),
  QuizPart(
    id: 'D',
    title: 'Budgeting Challenge',
    emoji: '💰',
    intro: 'You have ₹800 for the month. Plan your spending using the categories below.',
    items: [
      QuizItem.numeric(
        id: 'm2q15',
        prompt: 'Your Monthly Budget (₹):',
        blankLabels: [
          'School supplies needed',
          'Savings goal',
          'Fun activities with friends',
          'Emergency fund',
          'Personal wants',
          'TOTAL (should equal ₹800)',
        ],
      ),
      QuizItem.longAnswer(
        id: 'm2q16',
        prompt: 'What was your biggest priority in creating this budget?',
      ),
      QuizItem.longAnswer(
        id: 'm2q17',
        prompt: 'What was the hardest choice you had to make?',
      ),
    ],
  ),
  QuizPart(
    id: 'E',
    title: 'Resistance Strategies',
    emoji: '🛡️',
    items: [
      QuizItem.longAnswer(
        id: 'm2q18',
        prompt:
            'Your friends say: "Don\'t buy cheap gifts, people will think '
            'you don\'t care about them!" Your response:',
      ),
      QuizItem.longAnswer(
        id: 'm2q19',
        prompt:
            'Everyone in your group is buying expensive matching outfits for '
            'a school event, but you can\'t afford it. Your response:',
      ),
      QuizItem.longAnswer(
        id: 'm2q20',
        prompt:
            'A friend says: "Just ask your parents for more money - they\'ll '
            'give it to you if you really want something." Your response:',
      ),
    ],
  ),
  QuizPart(
    id: 'F',
    title: 'Smart Shopping Skills',
    emoji: '🔍',
    items: [
      QuizItem.fillBlanks(
        id: 'm2q21',
        prompt:
            'Before buying anything over ₹200, create your personal '
            'checklist. Fill in the blanks:',
        blankLabels: [
          'Wait ____ hours before purchasing',
          'Compare prices at ____ different stores',
          'Read at least ____ customer reviews',
          'Ask myself: "Is this a ____ or a ____?"',
          'Consider: "Will I still want this ____?"',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm2q22',
        prompt:
            'You want to buy a new pair of headphones. List three things you '
            'should research:',
        blankLabels: ['1.', '2.', '3.'],
      ),
    ],
  ),
  QuizPart(
    id: 'G',
    title: 'Delayed Gratification Practice',
    emoji: '📈',
    items: [
      QuizItem.fillBlanks(
        id: 'm2q23',
        prompt:
            'Think of something you really want that costs more than ₹500. '
            'Fill out this savings plan:',
        blankLabels: [
          'Item I want',
          'Total cost (₹)',
          'Money I can save per week (₹)',
          'Number of weeks needed',
          'Target date',
        ],
      ),
      QuizItem.longAnswer(
        id: 'm2q24',
        prompt:
            "What will you do when you're tempted to spend your savings on "
            'something else?',
      ),
      QuizItem.fillBlanks(
        id: 'm2q25',
        prompt: 'How will you stay motivated while saving? List two strategies:',
        blankLabels: ['1.', '2.'],
      ),
    ],
  ),
  QuizPart(
    id: 'H',
    title: 'Create Your Money Values',
    emoji: '🎪',
    items: [
      QuizItem.fillBlanks(
        id: 'm2q26',
        prompt:
            "List your top 3 personal values (what's most important to you):",
        blankLabels: ['1.', '2.', '3.'],
      ),
      QuizItem.longAnswer(
        id: 'm2q27',
        prompt:
            'How should your spending reflect these values? Give one example.',
      ),
      QuizItem.longAnswer(
        id: 'm2q28',
        prompt:
            'Write your personal "Money Rule" — one sentence that will guide '
            'your spending decisions.',
      ),
    ],
  ),
  QuizPart(
    id: 'I',
    title: 'Reflection and Commitment',
    emoji: '🏆',
    items: [
      QuizItem.longAnswer(
        id: 'm2q29',
        prompt:
            "What's one spending mistake you've made or seen someone make? "
            'What did you learn?',
      ),
      QuizItem.fillBlanks(
        id: 'm2q30',
        prompt:
            "Choose ONE skill from this worksheet that you'll practice this "
            'week. How will you practice?',
        blankLabels: ['Skill I\'ll practice', "How I'll practice it"],
      ),
    ],
  ),
  QuizPart(
    id: 'J',
    title: 'Self-Assessment',
    emoji: '📊',
    intro: 'Rate your confidence level (1 = not confident, 5 = very confident).',
    items: [
      QuizItem.rating(
        id: 'm2r1',
        prompt: 'Rate your confidence on each skill:',
        blankLabels: [
          'Telling wants from needs',
          'Resisting peer pressure',
          'Practicing delayed gratification',
          'Making a budget',
          'Smart shopping research',
        ],
      ),
      QuizItem.shortAnswer(
        id: 'm2r2',
        prompt: 'The most important thing I learned:',
      ),
      QuizItem.shortAnswer(
        id: 'm2r3',
        prompt: 'One question I still have:',
      ),
    ],
  ),
];

// ────────────────────────────────────────────────────────────────────────
// Module 3 — Budgeting Basics
// ────────────────────────────────────────────────────────────────────────
const List<QuizPart> _module3 = [
  QuizPart(
    id: 'A',
    title: 'Multiple Choice Questions',
    emoji: '💰',
    items: [
      QuizItem.mcq(
        id: 'm3q1',
        prompt: 'What are the four main budget categories (NWSG)?',
        options: [
          'Nice, Wild, Smart, Good',
          'Needs, Wants, Savings, Giving',
          'Numbers, Work, School, Games',
          'New, Weekly, Simple, Great',
        ],
        correctIndex: 1,
        explanation:
            'NWSG = Needs, Wants, Savings, Giving — the four core buckets.',
      ),
      QuizItem.mcq(
        id: 'm3q2',
        prompt: 'What does "pay yourself first" mean?',
        options: [
          'Always buy what you want before anything else',
          'Put money into savings before spending on other things',
          'Pay for your own things instead of asking parents',
          'Make sure you get paid before doing work',
        ],
        correctIndex: 1,
        explanation:
            'Move savings off the top before you start spending.',
      ),
      QuizItem.mcq(
        id: 'm3q3',
        prompt: 'Using the 50-30-15-5 rule, how should you allocate \$40?',
        options: [
          'Needs \$20, Wants \$12, Savings \$6, Giving \$2',
          'Needs \$15, Wants \$15, Savings \$5, Giving \$5',
          'Needs \$10, Wants \$10, Savings \$10, Giving \$10',
          'Needs \$25, Wants \$10, Savings \$3, Giving \$2',
        ],
        correctIndex: 0,
        explanation:
            '50% of \$40 = \$20, 30% = \$12, 15% = \$6, 5% = \$2.',
      ),
      QuizItem.mcq(
        id: 'm3q4',
        prompt:
            'What should you do if you consistently overspend in one budget '
            'category?',
        options: [
          'Give up on budgeting completely',
          'Ignore it and hope it gets better',
          'Adjust your budget based on actual spending patterns',
          'Ask parents for more money',
        ],
        correctIndex: 2,
        explanation:
            'Review and adjust your budget based on what your real spending '
            'shows.',
      ),
      QuizItem.mcq(
        id: 'm3q5',
        prompt:
            "What's the best way to handle irregular expenses like field "
            'trips?',
        options: [
          "Don't budget for them since they're unpredictable",
          'Create a separate savings fund and contribute regularly',
          'Always borrow money when they come up',
          'Only participate if you have extra money that month',
        ],
        correctIndex: 1,
        explanation:
            'A small dedicated fund makes irregular expenses easy to handle.',
      ),
    ],
  ),
  QuizPart(
    id: 'B',
    title: 'Budget Calculation Practice',
    emoji: '📊',
    items: [
      QuizItem.numeric(
        id: 'm3q6',
        prompt:
            'Budget Allocation Challenge: You receive \$60 per month. Use '
            'the 50-30-15-5 rule to create your budget.',
        blankLabels: [
          'Needs (50%) (\$)',
          'Wants (30%) (\$)',
          'Savings (15%) (\$)',
          'Giving (5%) (\$)',
          'Total (should equal \$60)',
        ],
      ),
      QuizItem.numeric(
        id: 'm3q7',
        prompt:
            'Savings Goal Calculator: You want to buy a \$45 video game. If '
            'you can save \$6 per week, how many weeks will it take?',
        blankLabels: ['Weeks needed'],
      ),
      QuizItem.numeric(
        id: 'm3q8',
        prompt:
            'Party Planning Budget: You have \$80 to plan a birthday party '
            'for 10 friends. Allocate your money:',
        blankLabels: [
          'Food (\$)',
          'Decorations (\$)',
          'Activities (\$)',
          'Emergency fund (\$)',
          'Total (should equal \$80)',
        ],
      ),
      QuizItem.longAnswer(
        id: 'm3q8b',
        prompt: 'Explain your reasoning for the largest allocation:',
      ),
    ],
  ),
  QuizPart(
    id: 'C',
    title: 'Scenario-Based Problems',
    emoji: '🎯',
    intro:
        'Scenario 1 — The Field Trip Fund: Your class has a \$35 field trip '
        'in 7 weeks. You get \$8 allowance per week but need \$5 each week '
        'for school lunch.',
    items: [
      QuizItem.numeric(
        id: 'm3q9',
        prompt:
            'How much money do you have available to save each week? '
            '(\$8 - \$5 = \$ ___ per week)',
        blankLabels: ['Available per week (\$)'],
      ),
      QuizItem.numeric(
        id: 'm3q10',
        prompt: 'How much will you save in 7 weeks at this rate?',
        blankLabels: ['Total saved (\$)'],
      ),
      QuizItem.fillBlanks(
        id: 'm3q11',
        prompt:
            'Will you have enough? If not, what are two solutions?',
        blankLabels: [
          'Yes / No',
          'Shortfall (\$)',
          'Solution 1',
          'Solution 2',
        ],
      ),
      QuizItem.prompt(
        id: 'm3s2',
        prompt: 'Scenario 2 — The Budget Makeover',
        subtitle:
            "Your friend Maya's monthly budget (income: \$50) — Snacks "
            '\$30 · Games \$25 · Savings \$0 · Supplies \$5.',
      ),
      QuizItem.longAnswer(
        id: 'm3q12',
        prompt: "What's wrong with Maya's current budget?",
      ),
      QuizItem.numeric(
        id: 'm3q13',
        prompt: 'Create a better budget for Maya using the same \$50:',
        blankLabels: [
          'Needs (\$)',
          'Wants (\$)',
          'Savings (\$)',
          'Giving (\$)',
        ],
      ),
      QuizItem.longAnswer(
        id: 'm3q14',
        prompt: "What's the most important change you made and why?",
      ),
    ],
  ),
  QuizPart(
    id: 'D',
    title: 'Real-World Budgeting',
    emoji: '🛍️',
    items: [
      QuizItem.fillBlanks(
        id: 'm3q15',
        prompt:
            'Holiday Gift Budget: You have \$40 to buy gifts for 5 family '
            'members. Plan your spending (Name · Relationship · Amount · Gift idea).',
        blankLabels: [
          'Person 1 — name, relationship, amount, gift',
          'Person 2 — name, relationship, amount, gift',
          'Person 3 — name, relationship, amount, gift',
          'Person 4 — name, relationship, amount, gift',
          'Person 5 — name, relationship, amount, gift',
          'Total spent (\$)',
          'Money remaining (\$)',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm3q16',
        prompt:
            'Three-Goal Savings Plan: You want to save for three different '
            'goals. Allocate \$20 per month.',
        blankLabels: [
          'Short-term goal (1 month) — name & amount',
          'Medium-term goal (6 months) — name & amount',
          'Long-term goal (1 year) — name & amount',
          'Which goal is most important and why?',
        ],
      ),
    ],
  ),
  QuizPart(
    id: 'E',
    title: 'Budget Problem Solving',
    emoji: '🎪',
    items: [
      QuizItem.numeric(
        id: 'm3q17',
        prompt:
            'The Envelope Method: You decide to try the envelope method with '
            '\$30. How much would you put in each envelope?',
        blankLabels: [
          'School Lunch (\$)',
          'Fun Money (\$)',
          'Savings (\$)',
          'Emergency (\$)',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm3q18',
        prompt:
            'The 24-Hour Rule: You see a \$25 jacket you really want, but it '
            'would use most of your "wants" budget for the month. List 3 '
            'questions you should ask yourself during the 24-hour waiting '
            'period:',
        blankLabels: ['1.', '2.', '3.'],
      ),
      QuizItem.longAnswer(
        id: 'm3q19',
        prompt:
            'Budget Adjustment: You planned to spend \$10 on entertainment '
            "this month, but you've already spent \$15 with one week left. "
            'What are your options and which do you choose? Explain.',
      ),
    ],
  ),
  QuizPart(
    id: 'F',
    title: 'Tracking and Tools',
    emoji: '📱',
    intro:
        'For one week, you tracked every purchase: '
        'Mon school lunch \$3 (Need) · Tue candy \$2 (Want) · Wed supplies '
        '\$5 (Need) · Thu movie \$8 (Want) · Fri donation \$1 (Giving) · '
        'Sat savings \$4 (Savings).',
    items: [
      QuizItem.numeric(
        id: 'm3q20',
        prompt: 'Calculate your weekly totals:',
        blankLabels: [
          'Needs (\$)',
          'Wants (\$)',
          'Savings (\$)',
          'Giving (\$)',
          'Total spent (\$)',
        ],
      ),
      QuizItem.longAnswer(
        id: 'm3q21',
        prompt:
            'Based on this spending pattern, what would you change about '
            'your budget?',
      ),
    ],
  ),
  QuizPart(
    id: 'G',
    title: 'Personal Budgeting Plan',
    emoji: '🏆',
    items: [
      QuizItem.fillBlanks(
        id: 'm3q22',
        prompt: 'Create your personal monthly budget:',
        blankLabels: [
          'My monthly income (\$)',
          'Needs (\$) and %',
          'Wants (\$) and %',
          'Savings (\$) and %',
          'Giving (\$) and %',
          'My biggest spending priority',
          'My most important savings goal',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm3q23',
        prompt:
            "What's one budgeting strategy from this module that you want "
            'to try, and how will you implement it?',
        blankLabels: ['Strategy', 'How I will implement it'],
      ),
    ],
  ),
  QuizPart(
    id: 'H',
    title: 'Reflection and Commitment',
    emoji: '📈',
    items: [
      QuizItem.longAnswer(
        id: 'm3q24',
        prompt: "What's the biggest benefit of budgeting for someone your age?",
      ),
      QuizItem.longAnswer(
        id: 'm3q25',
        prompt: "What's the hardest part about sticking to a budget?",
      ),
      QuizItem.longAnswer(
        id: 'm3q26',
        prompt: "Write one \"budgeting rule\" you'll follow starting this week.",
      ),
    ],
  ),
  QuizPart(
    id: 'I',
    title: 'Self-Assessment',
    emoji: '📊',
    intro: 'Rate your confidence (1 = not confident, 5 = very confident).',
    items: [
      QuizItem.rating(
        id: 'm3r1',
        prompt: 'Rate your confidence on each skill:',
        blankLabels: [
          'Understanding budget categories',
          'Calculating budget percentages',
          'Planning for irregular expenses',
          'Using budgeting strategies',
          'Tracking spending',
        ],
      ),
      QuizItem.shortAnswer(
        id: 'm3r2',
        prompt: 'The most useful thing I learned:',
      ),
      QuizItem.shortAnswer(
        id: 'm3r3',
        prompt: 'One thing I want to practice more:',
      ),
    ],
  ),
];

// ────────────────────────────────────────────────────────────────────────
// Module 4 — Saving & Goal Setting
// ────────────────────────────────────────────────────────────────────────
const List<QuizPart> _module4 = [
  QuizPart(
    id: 'A',
    title: 'Multiple Choice Questions',
    emoji: '🧠',
    items: [
      QuizItem.mcq(
        id: 'm4q1',
        prompt: 'What makes a savings goal realistic and achievable?',
        options: [
          "It's something all your friends want too",
          "It's specific, possible with your income, and has a reasonable timeframe",
          "It's the most expensive thing you can think of",
          "It's something you can buy immediately",
        ],
        correctIndex: 1,
        explanation:
            'Good goals are specific, fit your income, and have a clear '
            'timeframe.',
      ),
      QuizItem.mcq(
        id: 'm4q2',
        prompt:
            'Which saving method is best for someone who tends to spend '
            'money impulsively?',
        options: [
          'Keeping cash in their pocket',
          'A clear jar where they can see the money',
          'A bank account or parent-held savings',
          'Under their mattress',
        ],
        correctIndex: 2,
        explanation:
            'Money that is harder to reach is harder to spend impulsively.',
      ),
      QuizItem.mcq(
        id: 'm4q3',
        prompt: 'What should you include in a Dream Goal Tracker?',
        options: [
          'Only the total cost of your goal',
          'Just a picture of what you want',
          'Goal item, cost, weekly savings plan, milestones, and target date',
          'Only your weekly allowance amount',
        ],
        correctIndex: 2,
        explanation:
            'A complete tracker has item, cost, weekly plan, milestones, '
            'and target date.',
      ),
      QuizItem.mcq(
        id: 'm4q4',
        prompt: 'How often should you update your savings tracker?',
        options: [
          'Only when you reach your final goal',
          'Once a month',
          'Every time you save money, no matter how small',
          'Only when you remember to do it',
        ],
        correctIndex: 2,
        explanation:
            'Updating every time you save keeps motivation high and your '
            'numbers accurate.',
      ),
      QuizItem.mcq(
        id: 'm4q5',
        prompt: "What should you do if you realize your savings goal isn't realistic?",
        options: [
          'Give up completely',
          'Ask parents to buy it for you instead',
          'Adjust the goal by extending time, reducing cost, or increasing income',
          "Wait until you're older to set any goals",
        ],
        correctIndex: 2,
        explanation:
            'Adjust the variables instead of abandoning the goal.',
      ),
    ],
  ),
  QuizPart(
    id: 'B',
    title: 'Budget Planning Challenge',
    emoji: '💭',
    intro:
        "You're planning a birthday party with ₹2000. Create a realistic "
        'budget.',
    items: [
      QuizItem.numeric(
        id: 'm4q6',
        prompt: 'Research and estimate costs for each category (₹):',
        blankLabels: [
          'Food and drinks',
          'Decorations',
          'Entertainment / games',
          'Return gifts',
          'Emergency fund',
          'Total',
        ],
      ),
      QuizItem.longAnswer(
        id: 'm4q7',
        prompt: 'Which category was hardest to budget for and why?',
      ),
      QuizItem.longAnswer(
        id: 'm4q8',
        prompt: 'If your total exceeds ₹2000, what would you cut first?',
      ),
      QuizItem.fillBlanks(
        id: 'm4q9',
        prompt:
            'What percentage of your budget did you allocate to the '
            'emergency fund?',
        blankLabels: ['Percentage (%)', 'Why is this important?'],
      ),
    ],
  ),
  QuizPart(
    id: 'C',
    title: 'Savings Goal Setting',
    emoji: '🎯',
    items: [
      QuizItem.fillBlanks(
        id: 'm4q10',
        prompt: 'Set up your personal Dream Goal:',
        blankLabels: [
          'What I want',
          'Total cost (₹)',
          'Timeline (weeks / months)',
          'Weekly savings needed (₹)',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm4q11',
        prompt: 'Break down your goal into milestones (amount + target date):',
        blankLabels: [
          '25% milestone',
          '50% milestone',
          '75% milestone',
          '100% milestone',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm4q12',
        prompt: 'Choose your saving method and explain why:',
        blankLabels: ["Method I'll use", 'Why this works for me'],
      ),
    ],
  ),
  QuizPart(
    id: 'D',
    title: 'Savings Methods Comparison',
    emoji: '💰',
    intro:
        'Rate each saving method from 1-5 for YOUR personality across the '
        'overall categories below.',
    items: [
      QuizItem.rating(
        id: 'm4q_rate',
        prompt: 'Rate each method (1 = poor for you, 5 = great for you):',
        blankLabels: [
          'Piggy bank / jar',
          'Bank account',
          'Parent-held savings',
          'Envelope system',
        ],
      ),
      QuizItem.shortAnswer(
        id: 'm4q13',
        prompt: 'Based on your ratings, which method will you try first?',
      ),
    ],
  ),
  QuizPart(
    id: 'E',
    title: 'Motivation and Tracking',
    emoji: '🎮',
    items: [
      QuizItem.fillBlanks(
        id: 'm4q14',
        prompt: 'Create your personal motivation toolkit:',
        blankLabels: [
          "Visual reminder I'll use",
          'Person who will encourage me',
          "How often they'll check in",
          'Weekly reward for meeting my savings goal',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm4q15',
        prompt:
            'If you feel like giving up on your goal, what will you do? '
            'List 3 strategies:',
        blankLabels: ['a)', 'b)', 'c)'],
      ),
      QuizItem.fillBlanks(
        id: 'm4q16',
        prompt: 'Design a fun weekly savings challenge for yourself:',
        blankLabels: ['Challenge', 'Reward if I succeed'],
      ),
    ],
  ),
  QuizPart(
    id: 'F',
    title: 'Real-World Application',
    emoji: '🔍',
    items: [
      QuizItem.fillBlanks(
        id: 'm4q17',
        prompt:
            'Price Research Challenge: Pick something you want and research '
            'its real cost.',
        blankLabels: [
          'Item',
          'Store 1 (₹)',
          'Store 2 (₹)',
          'Online (₹)',
          'Extra costs (shipping / accessories) (₹)',
          'Total realistic cost (₹)',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm4q18',
        prompt:
            'Budget Crisis Scenario: You planned to spend ₹500 on art '
            'supplies but only have ₹300 saved. List 3 solutions:',
        blankLabels: ['a)', 'b)', 'c)'],
      ),
    ],
  ),
  QuizPart(
    id: 'G',
    title: 'Goal Timeline Planning',
    emoji: '📊',
    items: [
      QuizItem.fillBlanks(
        id: 'm4q19',
        prompt: 'Plan your savings timeline for the next year:',
        blankLabels: [
          'Short-term goal (1-3 months) — amount & purpose',
          'Medium-term goal (6-12 months) — amount & purpose',
          'Long-term goal (1+ years) — amount & purpose',
        ],
      ),
      QuizItem.longAnswer(
        id: 'm4q20',
        prompt: 'Which goal excites you most and why?',
      ),
    ],
  ),
  QuizPart(
    id: 'H',
    title: 'Reflection and Commitment',
    emoji: '🏆',
    items: [
      QuizItem.longAnswer(
        id: 'm4q21',
        prompt:
            "What's one mistake people your age commonly make with money "
            'that you want to avoid?',
      ),
      QuizItem.longAnswer(
        id: 'm4q22',
        prompt: 'How will saving money help you become more independent?',
      ),
      QuizItem.shortAnswer(
        id: 'm4q23',
        prompt: "Complete this sentence: \"When I reach my savings goal, I will feel...\"",
      ),
      QuizItem.fillBlanks(
        id: 'm4q24',
        prompt: 'Write your personal "Savings Success Promise":',
        blankLabels: [
          'I, ____, promise to save ₹ ____ per week toward my goal of ____.',
          'When I face challenges, I will',
          'I will celebrate my progress by',
        ],
      ),
    ],
  ),
  QuizPart(
    id: 'I',
    title: 'Dream Visualization',
    emoji: '🎪',
    items: [
      QuizItem.fillBlanks(
        id: 'm4q25',
        prompt:
            "Close your eyes and imagine you've achieved your biggest "
            'savings goal. Describe that moment:',
        blankLabels: [
          'Where are you?',
          'Who is with you?',
          'How do you feel?',
          'What do you say?',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm4q26',
        prompt:
            'What life skill are you most excited to develop through saving? '
            '(Planning / Patience / Math skills / Decision making / Self-control)',
        blankLabels: ['Skill', 'Why this one?'],
      ),
    ],
  ),
  QuizPart(
    id: 'J',
    title: 'Self-Assessment',
    emoji: '📈',
    intro: 'Rate your confidence (1 = not confident, 5 = very confident).',
    items: [
      QuizItem.rating(
        id: 'm4r1',
        prompt: 'Rate your confidence on each skill:',
        blankLabels: [
          'Creating realistic budgets',
          'Setting achievable savings goals',
          'Choosing the right saving method',
          'Tracking progress consistently',
          'Staying motivated long-term',
        ],
      ),
      QuizItem.shortAnswer(
        id: 'm4r2',
        prompt: 'The most important thing I learned:',
      ),
      QuizItem.shortAnswer(
        id: 'm4r3',
        prompt: 'My #1 savings goal starting this week:',
      ),
    ],
  ),
];

// ────────────────────────────────────────────────────────────────────────
// Module 5 — Banking and Digital Money
// ────────────────────────────────────────────────────────────────────────
const List<QuizPart> _module5 = [
  QuizPart(
    id: 'A',
    title: 'Multiple Choice Questions',
    emoji: '🧠',
    items: [
      QuizItem.mcq(
        id: 'm5q1',
        prompt: 'What is the main advantage of keeping money in a bank over a piggy bank?',
        options: [
          'Banks are closer to home',
          'Money earns interest and is protected by insurance',
          'You can access money faster',
          "Banks don't charge any fees",
        ],
        correctIndex: 1,
        explanation:
            'Banks pay interest and are protected by deposit insurance.',
      ),
      QuizItem.mcq(
        id: 'm5q2',
        prompt: 'Which payment method works best when the internet is not available?',
        options: [
          'UPI payments',
          'Mobile wallet (if pre-loaded)',
          'Online banking',
          'QR code scanning',
        ],
        correctIndex: 1,
        explanation:
            'A pre-loaded mobile wallet can sometimes work offline; the '
            'others all need the internet.',
      ),
      QuizItem.mcq(
        id: 'm5q3',
        prompt: 'What should you NEVER share with anyone?',
        options: [
          'Your UPI ID',
          'Your name for transactions',
          'Your UPI PIN',
          'Your phone number',
        ],
        correctIndex: 2,
        explanation:
            'Your UPI PIN is like a password — never share it, even with '
            'someone claiming to be from your bank.',
      ),
      QuizItem.mcq(
        id: 'm5q4',
        prompt: 'How does compound interest help your savings grow?',
        options: [
          'Banks add extra money every month',
          'You earn interest on your interest',
          'The government gives you bonus money',
          'Your parents add money to match yours',
        ],
        correctIndex: 1,
        explanation:
            'Compound interest is interest earned on both your original '
            'money and the interest it has already earned.',
      ),
      QuizItem.mcq(
        id: 'm5q5',
        prompt: 'What happens to your money if a bank closes down?',
        options: [
          'You lose all your money',
          'Government insurance protects up to ₹5 lakh',
          'Only rich people get their money back',
          'You have to wait 10 years to get money back',
        ],
        correctIndex: 1,
        explanation:
            'In India, DICGC deposit insurance protects up to ₹5 lakh per '
            'depositor per bank.',
      ),
    ],
  ),
  QuizPart(
    id: 'B',
    title: 'Banking Basics',
    emoji: '💳',
    items: [
      QuizItem.fillBlanks(
        id: 'm5q6',
        prompt:
            'Complete the bank money cycle: You deposit ₹1000 → Bank pays '
            'you ___% interest → Bank lends your ₹1000 to someone else → '
            'Charges them ___% interest → Bank keeps the ___% difference.',
        blankLabels: ['Interest paid to you (%)', 'Interest charged (%)', 'Bank margin (%)'],
      ),
      QuizItem.numeric(
        id: 'm5q7',
        prompt:
            'Calculate compound interest: If you save ₹2000 at 5% annual '
            'interest:',
        blankLabels: [
          'After Year 1 (₹)',
          'After Year 2 (₹)',
          'After Year 3 (₹)',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm5q8',
        prompt:
            'Compare account types — fill in the table for a Savings Account '
            '(Current Account is for business transactions).',
        blankLabels: [
          'Savings — Purpose',
          'Current — Interest',
          'Savings — Best for',
          'Current — Best for',
        ],
      ),
    ],
  ),
  QuizPart(
    id: 'C',
    title: 'Digital Payment Methods',
    emoji: '📱',
    intro:
        'Match each payment method (UPI · Mobile Wallet · Debit Card · Cash '
        '· Net Banking) with its best use case.',
    items: [
      QuizItem.fillBlanks(
        id: 'm5q9',
        prompt: 'Best method for each scenario:',
        blankLabels: [
          'Buying ₹10 street food',
          'Online shopping for ₹800',
          'Sending ₹500 to cousin in another city',
          'Shopping at mall for ₹2000',
          'Paying school fees online',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm5q10',
        prompt:
            "What's the difference between UPI and Mobile Wallets? Fill the "
            'UPI column (Mobile Wallet uses a pre-loaded amount, sometimes '
            'works offline, has lower limits):',
        blankLabels: [
          'UPI — Money source',
          'UPI — Internet needed',
          'UPI — Transaction limits',
        ],
      ),
    ],
  ),
  QuizPart(
    id: 'D',
    title: 'Safety and Security',
    emoji: '🔒',
    items: [
      QuizItem.fillBlanks(
        id: 'm5q11',
        prompt:
            'Scam Alert! For each scenario write SAFE or SCAM and explain why.\n'
            'A: Someone calls saying "I\'m from your bank. Share your OTP to '
            'avoid account closure."\n'
            'B: Your friend asks for your UPI ID to send you birthday money.\n'
            'C: A website offers a 90% discount but asks for your banking '
            'password.',
        blankLabels: [
          'Scenario A — SAFE / SCAM and why',
          'Scenario B — SAFE / SCAM and why',
          'Scenario C — SAFE / SCAM and why',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm5q12',
        prompt: 'Create your personal security checklist by filling in the blanks:',
        blankLabels: [
          'Download apps only from ____',
          'Never share your ____ or ____ with anyone',
          'Enable ____ lock on banking apps',
          'Always check ____ name before sending money',
          'Use ____ internet connections for banking',
        ],
      ),
    ],
  ),
  QuizPart(
    id: 'E',
    title: 'Payment Decision Scenarios',
    emoji: '🏪',
    items: [
      QuizItem.fillBlanks(
        id: 'm5q13',
        prompt:
            "Scenario 1: You want to buy a ₹50 snack from a street vendor "
            "who doesn't accept digital payments.",
        blankLabels: ['Best payment method', 'Why this method'],
      ),
      QuizItem.fillBlanks(
        id: 'm5q14',
        prompt: 'Scenario 2: You need to buy ₹1500 worth of books online.',
        blankLabels: ['Best payment method', 'Why this method'],
      ),
      QuizItem.fillBlanks(
        id: 'm5q15',
        prompt:
            'Scenario 3: You want to send ₹200 birthday money to your cousin '
            'in Mumbai.',
        blankLabels: ['Best payment method', 'Why this method'],
      ),
    ],
  ),
  QuizPart(
    id: 'F',
    title: 'Cash vs Digital Analysis',
    emoji: '💰',
    items: [
      QuizItem.fillBlanks(
        id: 'm5q19',
        prompt:
            'For each situation, mark Cash Better or Digital Better and '
            'explain why:',
        blankLabels: [
          'Small vendor purchase (₹20)',
          'Large online purchase (₹3000)',
          'Power outage at store',
          'Want to track spending',
          'Sending money to distant friend',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm5q20a',
        prompt: 'Cash — 3 Advantages and 3 Disadvantages',
        blankLabels: [
          'Advantage a)',
          'Advantage b)',
          'Advantage c)',
          'Disadvantage a)',
          'Disadvantage b)',
          'Disadvantage c)',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm5q20b',
        prompt: 'Digital — 3 Advantages and 3 Disadvantages',
        blankLabels: [
          'Advantage a)',
          'Advantage b)',
          'Advantage c)',
          'Disadvantage a)',
          'Disadvantage b)',
          'Disadvantage c)',
        ],
      ),
    ],
  ),
  QuizPart(
    id: 'G',
    title: 'Emergency Situations',
    emoji: '🚨',
    items: [
      QuizItem.fillBlanks(
        id: 'm5q21',
        prompt:
            'Transaction Emergency! Your UPI payment of ₹800 failed but '
            'money was deducted from your account. List your action steps '
            'in order:',
        blankLabels: ['Step 1', 'Step 2', 'Step 3', 'Step 4'],
      ),
      QuizItem.fillBlanks(
        id: 'm5q22',
        prompt:
            'Wrong Payment! You accidentally sent ₹500 to the wrong UPI ID. '
            'What do you do?',
        blankLabels: [
          'Immediate action',
          "If they don't respond",
          'Prevention for future',
        ],
      ),
    ],
  ),
  QuizPart(
    id: 'H',
    title: 'Practical Banking',
    emoji: '📊',
    intro:
        "Maya's Banking Challenge: Maya has ₹10,000 and these goals — buy "
        'laptop ₹6000, save ₹3000 for trip, keep emergency money.',
    items: [
      QuizItem.fillBlanks(
        id: 'm5q24',
        prompt: "Create Maya's financial plan:",
        blankLabels: [
          'Savings account deposit (₹)',
          'Mobile wallet load (₹)',
          'Cash to keep (₹)',
          'Payment method for laptop',
        ],
      ),
      QuizItem.numeric(
        id: 'm5q25',
        prompt:
            'Interest Calculation: If Maya puts ₹5000 in a savings account '
            'with 4% annual interest, how much after:',
        blankLabels: ['6 months (₹)', '1 year (₹)', '2 years (₹)'],
      ),
    ],
  ),
  QuizPart(
    id: 'I',
    title: 'Real-World Application',
    emoji: '🎯',
    items: [
      QuizItem.fillBlanks(
        id: 'm5q26',
        prompt:
            'Teaching Grandparents: Your grandmother wants to learn UPI. '
            "List 5 safety rules you'll teach her:",
        blankLabels: ['a)', 'b)', 'c)', 'd)', 'e)'],
      ),
      QuizItem.fillBlanks(
        id: 'm5q27',
        prompt:
            'Future Planning: How will you use banking and digital payments '
            'in the next 6 months?',
        blankLabels: [
          'Savings goal — amount & purpose',
          'Digital payment goal',
          'Safety goal — I will never ____',
        ],
      ),
    ],
  ),
  QuizPart(
    id: 'J',
    title: 'Critical Thinking',
    emoji: '🔍',
    items: [
      QuizItem.fillBlanks(
        id: 'm5q28',
        prompt:
            'Innovation Challenge: Design a new digital payment feature for '
            'students.',
        blankLabels: [
          'Feature name',
          'What it does',
          'Why students need it',
          'How it keeps money safe',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm5q29',
        prompt:
            'Problem Solving: Your school wants all students to pay fees '
            'digitally, but some families only use cash. Suggest 3 solutions:',
        blankLabels: ['Solution 1', 'Solution 2', 'Solution 3'],
      ),
    ],
  ),
  QuizPart(
    id: 'K',
    title: 'Reflection',
    emoji: '🏆',
    items: [
      QuizItem.fillBlanks(
        id: 'm5q30',
        prompt: 'Before vs After: How has your understanding of banking changed?',
        blankLabels: [
          'Before this module, I thought',
          'Now I understand',
          'The biggest surprise was',
        ],
      ),
      QuizItem.rating(
        id: 'm5q31',
        prompt: 'Confidence Level — rate yourself (1-5):',
        blankLabels: [
          'Understanding how banks work',
          'Choosing right payment method',
          'Staying safe with digital payments',
          'Teaching others about digital money',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm5q32',
        prompt:
            "Action Plan: What's one thing you'll do differently with money "
            'this week?',
        blankLabels: ['I will', 'Because'],
      ),
    ],
  ),
  QuizPart(
    id: 'L',
    title: "Maya's Adventure Decisions",
    emoji: '🎮',
    intro:
        'Comic Scenario: Maya gets a call: "Congratulations! You\'ve won '
        '₹50,000! Just share your UPI PIN to claim the prize!"',
    items: [
      QuizItem.mcq(
        id: 'm5q33',
        prompt: 'What should Maya do?',
        options: [
          'Share the PIN immediately to get the money',
          'Ask them to call back later',
          "Hang up — it's obviously a scam",
          'Give them her UPI ID instead',
        ],
        correctIndex: 2,
        explanation:
            'Legitimate banks never call asking for your PIN. Hang up '
            'immediately.',
      ),
      QuizItem.longAnswer(
        id: 'm5q34',
        prompt: 'Why is this the right choice?',
      ),
      QuizItem.fillBlanks(
        id: 'm5q35',
        prompt:
            "Maya's Shopping Dilemma: Maya finds the same item for ₹1200 on "
            'two websites — Website A: professional, secure payment gateway. '
            'Website B: 50% extra off but asks for banking password. Which '
            'should she choose and why?',
        blankLabels: ['Choice', 'Reason'],
      ),
    ],
  ),
  QuizPart(
    id: 'M',
    title: 'Self-Assessment',
    emoji: '📈',
    intro: 'Rate your confidence (1 = not confident, 5 = very confident).',
    items: [
      QuizItem.rating(
        id: 'm5r1',
        prompt: 'Rate your confidence on each skill:',
        blankLabels: [
          'Banking knowledge',
          'Digital payment skills',
          'Safety awareness',
          'Smart payment choices',
          'Teaching others',
        ],
      ),
      QuizItem.shortAnswer(
        id: 'm5r2',
        prompt: 'The most important thing I learned:',
      ),
      QuizItem.shortAnswer(
        id: 'm5r3',
        prompt: 'My next money goal using banking:',
      ),
    ],
  ),
];

// ────────────────────────────────────────────────────────────────────────
// Module 6 — Investment Basics: Growing Your Money Tree
// ────────────────────────────────────────────────────────────────────────
const List<QuizPart> _module6 = [
  QuizPart(
    id: 'A',
    title: 'Multiple Choice Questions',
    emoji: '🧠',
    items: [
      QuizItem.mcq(
        id: 'm6q1',
        prompt: 'What is the main difference between saving and investing?',
        options: [
          'Saving is for rich people, investing is for poor people',
          'Saving has low risk and low returns, investing has higher risk and potentially higher returns',
          'There is no difference between them',
          'Saving is illegal, investing is legal',
        ],
        correctIndex: 1,
        explanation:
            'Saving is low-risk and slow; investing carries more risk but '
            'offers higher long-term return potential.',
      ),
      QuizItem.mcq(
        id: 'm6q2',
        prompt: 'The Rule of 72 helps you calculate:',
        options: [
          'How much money you need to retire',
          'How long it takes for your money to double',
          'What percentage to save each month',
          "How much tax you'll pay on investments",
        ],
        correctIndex: 1,
        explanation:
            'Divide 72 by your annual return rate to estimate years to '
            'double.',
      ),
      QuizItem.mcq(
        id: 'm6q3',
        prompt: 'Compound interest is powerful because:',
        options: [
          'You earn interest on your interest',
          'Banks give you extra money for free',
          "It's guaranteed to make you rich",
          'It only works for wealthy people',
        ],
        correctIndex: 0,
        explanation:
            'Earning interest on previously earned interest powers long-term '
            'compounding.',
      ),
      QuizItem.mcq(
        id: 'm6q4',
        prompt:
            'Which investment option typically offers the highest long-term '
            'growth potential?',
        options: ['Piggy bank', 'Savings account', 'Fixed deposit', 'Mutual funds'],
        correctIndex: 3,
        explanation:
            'Over the long term, equity-linked mutual funds have '
            'historically offered the highest growth.',
      ),
      QuizItem.mcq(
        id: 'm6q5',
        prompt: 'What should you do BEFORE starting to invest?',
        options: [
          'Quit school to focus on investing',
          'Borrow money to invest more',
          'Build an emergency fund',
          'Buy expensive investment books',
        ],
        correctIndex: 2,
        explanation:
            'An emergency fund is your safety net — set it up first.',
      ),
    ],
  ),
  QuizPart(
    id: 'B',
    title: 'Compound Interest Calculations',
    emoji: '🌱',
    items: [
      QuizItem.numeric(
        id: 'm6q6',
        prompt: 'Rule of 72 Practice — complete the table:',
        blankLabels: [
          '6% — years to double',
          '8% — years to double',
          '10% — years to double',
          '12% — years to double',
        ],
      ),
      QuizItem.numeric(
        id: 'm6q7',
        prompt: 'Growth Calculation: If you invest ₹1000 at 8% compound interest:',
        blankLabels: [
          'After Year 1 (₹)',
          'After Year 2 (₹)',
          'After Year 3 (₹)',
          'Total growth (₹)',
        ],
      ),
      QuizItem.numeric(
        id: 'm6q8',
        prompt:
            'Monthly SIP Challenge: You invest ₹500 every month for 2 years '
            'at 10% annual return. Estimate your final amount.',
        blankLabels: ['Final amount (₹)'],
      ),
      QuizItem.fillBlanks(
        id: 'm6q9',
        prompt:
            'Early vs Late Starter: Priya invests ₹2000/year at 20 for 10 '
            'years then stops. Rahul invests ₹4000/year at 30 for 30 years. '
            'At 8% returns, who has more at 60? Why?',
        blankLabels: ['Who has more', 'Why'],
      ),
    ],
  ),
  QuizPart(
    id: 'C',
    title: 'Investment Options Comparison',
    emoji: '🏦',
    items: [
      QuizItem.rating(
        id: 'm6q10s',
        prompt: 'Rate each option for SAFETY (1-5):',
        blankLabels: [
          'Piggy Bank',
          'Savings Account',
          'Fixed Deposit',
          'Mutual Funds',
        ],
      ),
      QuizItem.rating(
        id: 'm6q10g',
        prompt: 'Rate each option for GROWTH POTENTIAL (1-5):',
        blankLabels: [
          'Piggy Bank',
          'Savings Account',
          'Fixed Deposit',
          'Mutual Funds',
        ],
      ),
      QuizItem.numeric(
        id: 'm6q11',
        prompt:
            'Investment Allocation Challenge: You have ₹1000 monthly '
            'allowance. Allocate it:',
        blankLabels: [
          'Immediate expenses (₹)',
          'Emergency fund building (₹)',
          'Short-term savings (1-2 years) (₹)',
          'Long-term investment (5+ years) (₹)',
          'Total (should equal ₹1000)',
        ],
      ),
    ],
  ),
  QuizPart(
    id: 'D',
    title: 'True / False Statements',
    emoji: '📊',
    items: [
      QuizItem.trueFalse(
        id: 'm6q12',
        prompt:
            'Starting to invest at age 15 vs age 25 makes very little '
            'difference in final wealth.',
        correctIndex: 1, // False
        explanation:
            'False. An extra 10 years of compounding makes a huge difference '
            'in final wealth.',
      ),
      QuizItem.trueFalse(
        id: 'm6q13',
        prompt:
            "It's better to invest ₹5000 once than ₹500 per month for 10 "
            'months.',
        correctIndex: 1, // False
        explanation:
            'False. Investing monthly (SIP) builds discipline and reduces '
            'the risk of bad timing.',
      ),
      QuizItem.trueFalse(
        id: 'm6q14',
        prompt: 'Mutual funds are riskier than keeping money in a piggy bank.',
        correctIndex: 0, // True
        explanation:
            'True — mutual funds carry market risk, while a piggy bank loses '
            'no rupee count (but loses to inflation).',
      ),
      QuizItem.trueFalse(
        id: 'm6q15',
        prompt: 'Inflation reduces the purchasing power of money over time.',
        correctIndex: 0, // True
        explanation:
            'True — rising prices mean each rupee buys less.',
      ),
      QuizItem.trueFalse(
        id: 'm6q16',
        prompt: 'You need at least ₹1 lakh to start investing in mutual funds.',
        correctIndex: 1, // False
        explanation:
            'False — many SIPs let you start with as little as ₹100 or ₹500 '
            'per month.',
      ),
    ],
  ),
  QuizPart(
    id: 'E',
    title: 'Real-World Scenarios',
    emoji: '🎯',
    items: [
      QuizItem.fillBlanks(
        id: 'm6q17',
        prompt:
            'Scenario 1: Arjun wants to buy a ₹25,000 gaming console in 2 '
            'years.',
        blankLabels: [
          'Best investment strategy',
          'Monthly savings needed (₹, assume 6%)',
          'Why this approach',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm6q20',
        prompt:
            'Scenario 2: Priya wants to save for college fees (₹5 lakh) '
            'needed in 8 years.',
        blankLabels: [
          'Best investment strategy',
          'Monthly investment needed (₹, assume 10%)',
          'Risk level appropriate',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm6q23',
        prompt:
            'Scenario 3: Rohit has ₹10,000 gift money and no immediate plans '
            'for it. How should he allocate this money and why?',
        blankLabels: [
          'Emergency fund (₹)',
          'Short-term goals (₹)',
          'Long-term investment (₹)',
          'Reasoning',
        ],
      ),
    ],
  ),
  QuizPart(
    id: 'F',
    title: 'Investment Mistakes Prevention',
    emoji: '⚠️',
    items: [
      QuizItem.mcq(
        id: 'm6q26',
        prompt: 'Which of these is a RED FLAG for investment scams?',
        options: [
          'Guaranteed 50% returns in 6 months',
          '"Limited time offer - invest now or miss out forever"',
          '"My friend\'s cousin made ₹1 lakh in one month"',
          'All of the above',
        ],
        correctIndex: 3,
        explanation:
            'All of those are classic warning signs. If it sounds too good '
            'to be true, it almost certainly is.',
      ),
      QuizItem.fillBlanks(
        id: 'm6q27',
        prompt: 'Risk Management: List 3 ways to reduce investment risk:',
        blankLabels: ['a)', 'b)', 'c)'],
      ),
    ],
  ),
  QuizPart(
    id: 'G',
    title: 'Inflation and Time Value',
    emoji: '💡',
    items: [
      QuizItem.numeric(
        id: 'm6q28',
        prompt:
            'Inflation Impact: A movie ticket costs ₹250 today. With 5% '
            'annual inflation, what will it cost in:',
        blankLabels: ['5 years (₹)', '10 years (₹)', '20 years (₹)'],
      ),
      QuizItem.numeric(
        id: 'm6q29',
        prompt:
            'Purchasing Power: If you keep ₹10,000 in a piggy bank and '
            'inflation is 6% per year, what will its purchasing power be '
            "after 10 years (in today's terms)?",
        blankLabels: ['Purchasing power (₹)'],
      ),
      QuizItem.fillBlanks(
        id: 'm6q30',
        prompt:
            'Investment vs Inflation Race — does each WIN or LOSE against '
            '5% inflation?',
        blankLabels: [
          'Savings account (3% return)',
          'Fixed deposit (6% return)',
          'Mutual fund (10% return)',
        ],
      ),
    ],
  ),
  QuizPart(
    id: 'H',
    title: 'Goal Setting and Planning',
    emoji: '🚀',
    items: [
      QuizItem.fillBlanks(
        id: 'm6q31',
        prompt: 'Personal Investment Goals — set your SMART goals:',
        blankLabels: [
          'Short-term (1-2 years) — amount, purpose, monthly savings needed',
          'Medium-term (3-5 years) — amount, purpose, monthly investment needed',
          'Long-term (10+ years) — amount, purpose, monthly investment needed',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm6q32',
        prompt:
            'Investment Foundation Pyramid — number these steps in the '
            'correct order (1-5):',
        blankLabels: [
          'Start investing in mutual funds — order',
          'Build emergency fund — order',
          'Learn investment basics — order',
          'Set up regular income / allowance — order',
          'Create a budget and track expenses — order',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm6q33',
        prompt:
            'SIP Planning: You want to start a ₹500 monthly SIP. Plan your '
            'approach.',
        blankLabels: [
          'Which type of mutual fund',
          'How will you ensure consistency',
          'How often will you review',
          'What will you do if markets fall',
        ],
      ),
    ],
  ),
  QuizPart(
    id: 'I',
    title: 'Grow Your Garden Simulation',
    emoji: '🎮',
    intro:
        "You're starting your virtual money garden with ₹500/month across "
        'four options.',
    items: [
      QuizItem.numeric(
        id: 'm6q34',
        prompt: 'Garden Planning — allocate ₹500/month:',
        blankLabels: [
          'Piggy Bank Plant (0% growth) — ₹/month',
          'Savings Sprout (3% annual) — ₹/month',
          'Fixed Deposit Flower (6% annual) — ₹/month',
          'Mutual Fund Tree (10% annual) — ₹/month',
        ],
      ),
      QuizItem.longAnswer(
        id: 'm6q34b',
        prompt: 'Why did you choose this allocation?',
      ),
      QuizItem.mcq(
        id: 'm6q35',
        prompt:
            'Market Volatility: Your Mutual Fund Tree drops 15% in one '
            'month. What do you do?',
        options: [
          'Sell everything immediately',
          'Stop investing in mutual funds',
          'Continue with your SIP plan',
          'Put all future money in savings account',
        ],
        correctIndex: 2,
        explanation:
            'Stay disciplined — continuing your SIP during dips actually '
            'buys more units at lower prices.',
      ),
      QuizItem.longAnswer(
        id: 'm6q35b',
        prompt: 'Explain your choice.',
      ),
    ],
  ),
  QuizPart(
    id: 'J',
    title: 'Critical Thinking',
    emoji: '📈',
    items: [
      QuizItem.fillBlanks(
        id: 'm6q36',
        prompt:
            'Peer Pressure Scenario: Your friend says "My cousin doubled his '
            'money in 3 months by investing in XYZ company. We should do '
            'the same!"',
        blankLabels: ['Your response', 'Why this is risky'],
      ),
      QuizItem.fillBlanks(
        id: 'm6q37',
        prompt:
            'Family Discussion: Your parents are hesitant about you starting '
            'investments. List 3 points to convince them:',
        blankLabels: ['a)', 'b)', 'c)'],
      ),
      QuizItem.fillBlanks(
        id: 'm6q38',
        prompt:
            'Future Planning: How will your investment strategy change as '
            'you grow older?',
        blankLabels: ['At age 16', 'At age 20', 'At age 30'],
      ),
    ],
  ),
  QuizPart(
    id: 'K',
    title: 'Reflection and Commitment',
    emoji: '🏆',
    items: [
      QuizItem.fillBlanks(
        id: 'm6q39',
        prompt: 'Learning Journey:',
        blankLabels: [
          'Before this module, I thought investing was',
          'Now I understand investing is',
          'Biggest surprise',
        ],
      ),
      QuizItem.rating(
        id: 'm6q40',
        prompt: 'Confidence Check — rate your understanding (1-5):',
        blankLabels: [
          'Difference between saving and investing',
          'How compound interest works',
          'Choosing right investment for goals',
          'Understanding investment risks',
          'Creating long-term financial plans',
        ],
      ),
      QuizItem.fillBlanks(
        id: 'm6q41',
        prompt: 'Action Plan: What will you do in the next 30 days?',
        blankLabels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
      ),
      QuizItem.fillBlanks(
        id: 'm6q42',
        prompt: 'Money Tree Promise — complete this commitment statement:',
        blankLabels: [
          'I, ____, promise to start my investment journey by ____',
          'I will invest ₹ ____ every month towards my goal of ____',
          'My money tree will grow because I am committed to ____',
        ],
      ),
    ],
  ),
  QuizPart(
    id: 'L',
    title: 'Self-Assessment',
    emoji: '📊',
    intro: 'Rate your confidence (1 = not confident, 5 = very confident).',
    items: [
      QuizItem.rating(
        id: 'm6r1',
        prompt: 'Rate your confidence on each skill:',
        blankLabels: [
          'Understanding compound interest',
          'Choosing investment options',
          'Managing investment risks',
          'Setting realistic goals',
          'Long-term financial planning',
        ],
      ),
      QuizItem.shortAnswer(
        id: 'm6r2',
        prompt: 'The most important thing I learned:',
      ),
      QuizItem.shortAnswer(
        id: 'm6r3',
        prompt: 'My first investment goal:',
      ),
      QuizItem.shortAnswer(
        id: 'm6r4',
        prompt: 'I will help others by:',
      ),
    ],
  ),
];
