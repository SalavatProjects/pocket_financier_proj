abstract class AppConstants {
  static const Duration duration200 = Duration(milliseconds: 200);

  static const List<String> tlcCodes = ['USD', 'EUR', 'JPY', 'KRW', 'KZT', 'CNY', 'GBP'];

  static const Map<String, (String name, String iconPath)> currencyContent = {
    'USD' : ('Dollar', 'assets/icons/usd.svg'),
    'EUR' : ('Euro', 'assets/icons/euro.svg'),
    'JPY' : ('Yen', 'assets/icons/yen.svg'),
    'KRW' : ('Won', 'assets/icons/won.svg'),
    'KZT' : ('Tenge', 'assets/icons/tenge.svg'),
    'CNY' : ('Yuan', 'assets/icons/yuan.svg'),
    'GBP' : ('Pound', 'assets/icons/pound.svg'),
  };
  static const List<(String shortName, String imagePath, String title, String text)> studyInfo = [
    ('Getting Started',
    'assets/images/getting_started.png',
    'Getting Started with Trading',
    ' Understanding cryptocurrency is essential in today’s digital economy. This guide demystifies crypto basics, covering blockchain, digital wallets, and key terminology like Bitcoin, Ethereum, and altcoins. Learn how transactions are verified through mining or proof-of-stake and why decentralization matters. Discover the risks and rewards of crypto investments and tips for navigating this volatile market securely. By the end, you’ll be equipped to take your first steps in the crypto world with confidence.'
    ),
    ('A New Financial Era',
    'assets/images/a_new_financial_era.png',
    'A New Financial Era: Blockchain Learning',
    ' Education in cryptocurrency is more accessible than ever. Top institutions like MIT and Stanford offer blockchain programs, while platforms like Coursera, Udemy, and edX host beginner-friendly courses. Topics range from blockchain development to crypto trading strategies. With hands-on projects and expert-led instruction, these courses ensure a comprehensive understanding of blockchain technology. Gain the skills you need to succeed in crypto’s rapidly evolving landscape by enrolling in one of these programs today.',
    ),
    ('Changing Education',
    'assets/images/about_currency.png',
    'How Crypto is Changing Education',
    ' Cryptocurrency and blockchain technology are transforming the education sector. Universities are adopting blockchain for secure credential verification, reducing fraud and administrative costs. Students can now pay tuition fees in Bitcoin at institutions like the University of Nicosia. Moreover, decentralized platforms are creating peer-to-peer learning systems, democratizing access to education. This article explores how crypto’s innovative applications are shaping the future of global education.'
    )
  ];

  static const List<(String shortName, String imagePath, String title, String text)> newsInfo = [
    ('Investment Strategies',
    'assets/images/Investment_Strategies.png',
    'Investment Strategies: Crypto Trends',
    ' The cryptocurrency market has reached unprecedented heights in 2025, with Bitcoin surpassing \$50,000 and Ethereum crossing the \$3,500 mark. Major altcoins like Solana and Cardano also saw significant gains, driven by institutional adoption and favorable regulatory developments. Analysts predict continued growth as blockchain applications expand in finance, healthcare, and beyond. Investors are cautioned to balance optimism with awareness of market volatility.'
    ),
    ('Economic Outlook',
    'assets/images/Economic_Outlook.png',
    'Economic Outlook: Central Bank Digital Currencies',
    ' Global central banks are accelerating efforts to develop Central Bank Digital Currencies (CBDCs). Countries like China, Sweden, and the U.S. are testing digital yuan, e-krona, and digital dollars. CBDCs aim to modernize payment systems, increase financial inclusion, and compete with decentralized cryptocurrencies. However, concerns over privacy, implementation costs, and potential impacts on traditional banking systems persist. This article delves into the pros and cons of CBDC adoption.'
    ),
    ('Stock Markets',
    'assets/images/follow_the_charts.png',
    'Stock Markets React to Inflation Data',
    ' Global stock markets showed mixed reactions to the latest inflation data. While U.S. indices like the S&P 500 and Nasdaq experienced slight dips, European markets saw modest gains. Tech stocks bore the brunt of investor anxiety, with rising bond yields impacting valuations. However, energy and commodities sectors performed strongly amid geopolitical tensions and supply chain concerns. This article examines the financial landscape and what’s ahead for global markets.')
  ];
}