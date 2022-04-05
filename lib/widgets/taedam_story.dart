import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

var titleTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w900,
  color: Color(0xFFFFA9A9),
);

var storyTextStyle = TextStyle(
  fontSize: 15.5,
  fontWeight: FontWeight.w700,
  color: Color(0XFFA79A8E),
  //fontFamily: 'Noto_Sans_KR',
  height: 1.3,
);

var taedamStories = [
  taedamStory1,
  taedamStory2,
  taedamStory3,
  taedamStory4,
  taedamStory5,
  taedamStory6,
  taedamStory7,
  taedamStory8,
  taedamStory9,
  taedamStory10,
];

var taedamStory1 = [
  Container(
    //width: 30.0,
    height: 250.0,
    child: Container(
      //aspectRatio: 2 / 3,
      child: Image.asset(
        'assets/images/1주차.gif',

        //height: 20.h,
        //width: 10.w,
        fit: BoxFit.contain,
      ),
    ),
  ),
  SizedBox(
    height: 5,
  ),
  Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '1. 태명을 정해주세요',
              style: titleTextStyle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '태아는 엄마 아빠의 목소리를 들으면서, 뇌 뿐만 아니라 정서적으로도 발달하게 됩니다. 아이를 생각하면서 예쁜 태명을 정해 불러주는 습관을 만들어보세요!  태명이 생기면, 태담이 아직 어색한 부모님들도 훨씬 수월할 거랍니다.',
            style: storyTextStyle,
          ),
        ],
      ),
      SizedBox(
        height: 28,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '1. 태담을 나누는 시간을 정해보세요.',
              style: titleTextStyle,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '바쁜 현대사회. 태담은 잘 나누고 계신가요? 실천은 하는데 잘 하고 있는지 모르겠다면, 맘소리의 1일1토픽과 함께 꾸준히 실천해봅시다. 하루 중, 태담을 나누는 시간을 정해서 태아에게 매일 사랑을 전해주세요. 규칙적인 시간과 장소에서 태담을 나누면, 태아는 해당 시간에 태교를 받을 준비를 하기 때문에 효과를 더 높일 수 있답니다.',
            style: storyTextStyle,
          ),
        ],
      ),
      SizedBox(
        height: 28,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '3. 토픽 & 녹음',
              style: titleTextStyle,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '태담 시간을 설정하셨나요? 지정 시간에 매일 하나씩 제공되는 태담 토픽으로, 태아와 이야기를 나누어보세요. 태담이 힘든 날엔 태담 녹음본을 PLAY하여 엄마의 수고를 덜어줄 수도 있답니다. 아기가 태어난 후, 녹음된 이야기들로 아기에게 10개월간의 추억을 선물하세요.',
            style: storyTextStyle,
          ),
        ],
      ),
      SizedBox(
        height: 28,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '4. 인사로 태담을 시작해주세요.',
              style: titleTextStyle,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '태담, 태아에게 말을 거는 행위는 아직 어색하게 느껴질 수 있습니다. 태아에게 간단한 인사부터 시작하며 태담 습관을 만들어봅시다. (EX. 기상시 "동동이 잘 잤니~?", 퇴근 후 "동동아 아빠 다녀왔어~", 자기 전 "우리 동동이 잘자~" 등 )',
            style: storyTextStyle,
          ),
        ],
      ),
      SizedBox(
        height: 28,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '5. 태아를 사랑한다는 말로 마무리해줍니다.',
              style: titleTextStyle,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '태아에게도 인지능력이 있다는 사실을 아시나요? 엄마가 슬프면 태아도 슬프고, 부정적인 내용의 태담은 좋지 않습니다. 항상 긍정적인 말을 건네고 사랑한다는 말로 태담을 마무리해주세요.',
            style: storyTextStyle,
          ),
        ],
      ),
      SizedBox(
        height: 28,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '6. 몸과 마음을 건강하게 해주세요.',
              style: titleTextStyle,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '갑작스러운 변화에 놀라셨죠? 가장 중요한 태교는 엄마의 건강입니다. 엄마가 스트레스를 받으면, 아이에게도 고스란히 전달된답니다. 앞으로 10개월 동안 건강한 시간을 만들어 보자는 마음가짐을 굳게 먹어주세요.',
            style: storyTextStyle,
          ),
        ],
      ),
    ]),
  )
];

var taedamStory2 = [
  Container(
    height: 250.0,
    child: Container(
      child: Image.asset(
        'assets/images/2주차.gif',
        fit: BoxFit.contain,
      ),
    ),
  ),
  SizedBox(
    height: 5,
  ),
  Padding(
    padding: EdgeInsets.all(15),
    child: Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '아빠의 참여가 꼭 필요해요!',
              style: titleTextStyle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '아빠의 중저음 목소리는 태담에 매우 효과적입니다. 아빠의 목소리는 엄마의 목소리보다 양수를 잘 통과하기 때문이죠. 따라서 아빠의 목소리는 태아에게 더 잘들리고, 뇌를 자극할 수 있어요. 배우자의 참여가 태교의 지속적인 실천에 도움이 된다는 연구 결과도 있답니다. 앞으로 아빠의 참여를 돕는 토픽을 자주 넣어드릴게요, 참여해주실 거죠? :)',
              style: storyTextStyle,
            ),
          ],
        ),
        SizedBox(
          height: 28,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '저녁 8시 ~ 밤 12시',
              style: titleTextStyle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '태아는 주로 저녁 8시에서 밤 12시에 깨어있습니다. 퇴근 후 아빠와 함께 태담을 나누고 잠들면 딱이겠죠? 너무 늦은 시간에 태담을 하면 태아의 생체리듬을 방해할 수 있습니다. 퇴근시간이 늦어지면, 아빠와 함께 녹음한 태담을 PLAY 해주어도 좋아요.',
              style: storyTextStyle,
            ),
          ],
        ),
        SizedBox(
          height: 28,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '태담은 조용한 장소가 좋아요.',
              style: titleTextStyle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '소음이 심한 곳에서는 태담이 태아에게 잘 전달이 안된답니다. 따라서 가능한 조용한 장소에서 편안한 분위기로 태담을 나누어주세요.',
              style: storyTextStyle,
            ),
          ],
        ),
        SizedBox(
          height: 28,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '자주 말 걸어줄 수록 좋아요.',
              style: titleTextStyle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '청각자극은 태아의 뇌 성장에 가장 효과적입니다. 아직 태아가 들을 수 는 없지만, 태담은 엄마와 태아가 나누는 ‘마음’의 커뮤니케이션이기 때문에 임신 초기부터 태담을 실천해주는 것은 태아에게 좋은 영향을 줍니다.',
              style: storyTextStyle,
            ),
          ],
        ),
      ],
    ),
  )
];

var taedamStory3 = [
  Container(
    height: 250.0,
    child: Container(
      child: Image.asset(
        'assets/images/3주차.gif',
        fit: BoxFit.contain,
      ),
    ),
  ),
  SizedBox(
    height: 5,
  ),
  Padding(
    padding: EdgeInsets.all(15),
    child: Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '몸과 정신을 편안하게',
              style: titleTextStyle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '피로감과 입덧이 심한 시기입니다. 태담도 중요하지만, 엄마의 건강관리가 무엇보다 중요해요.  태담이 힘든 날에는, 지금까지 나눈 태담녹음을 PLAY 시켜주세요. 이 방법도 효과가 있답니다. 기분전환을 위해 간단한 스트레칭과 산책은 해주세요.',
              style: storyTextStyle,
            ),
          ],
        ),
        SizedBox(
          height: 28,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '어떻게 이야기를 나눠야할까?',
              style: titleTextStyle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '태담은 특별한 게 아니에요. 태명을 불러주며, 항상 동행하는 것처럼 말을 건네주세요. 짧고 간단하게 끝나는 말보다는 차근차근 하루에 있었던 일들을 들려주는 것이 좋아요. 이야기를 들려주면서, 간간히 아기의 의견을 물어보는식으로 반응을 이끌어주세요. ( EX. 엄마는 요즘 사과가 너무 맛있어. 동동이도 사과 맛있었어? )',
              style: storyTextStyle,
            ),
          ],
        ),
        SizedBox(
          height: 28,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '태아가 항상 함께 하고 있음을 기억해주세요.',
              style: titleTextStyle,
            ),
            SizedBox(
              height: 28,
            ),
            Text(
              '태아는 항상 엄마와 아빠의 목소리를 듣고있습니다. 태담을 나누는 때가 아니더라도, 엄마와 아빠가 항상 다정한 목소리로 대화를 나누어 주세요.',
              style: storyTextStyle,
            ),
          ],
        ),
      ],
    ),
  )
];

var taedamStory4 = [
  Container(
    height: 250.0,
    child: Container(
      child: Image.asset(
        'assets/images/4주차.gif',
        fit: BoxFit.contain,
      ),
    ),
  ),
  SizedBox(
    height: 5,
  ),
  Padding(
    padding: EdgeInsets.all(15),
    child: Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '태아에게 엄마 아빠의 소리가 닿고있어요!',
              style: titleTextStyle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '임신 3~4개월부터 태아에게 소리가 닿기 시작합니다. 5개월부터는 실제로 소리를를 들을 수 있답니다. 아빠와 함께 소리의 높낮이를 갖고, 정해진 시간에 꾸준히 태담을 나눠주세요.',
              style: storyTextStyle,
            ),
          ],
        ),
        SizedBox(
          height: 28,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '엄마가 즐거워야 태아도 즐거워요.',
              style: titleTextStyle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '태교를 위해서 억지로 싫어하는 노래를 틀거나, 글을 읽을 필요는 없어요. 엄마가 스트레스를 받으면 그대로 태아에게 전달되기 때문입니다. 노래의 장르는 상관이 없지만, 엄마를 편안하게해주는 알파파 자극 음악이 좋습니다.',
              style: storyTextStyle,
            ),
          ],
        ),
        SizedBox(
          height: 28,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '태담일기를 들려주세요.',
              style: titleTextStyle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '태담이 어려운 부모님들을 위해, 하루일기를 작성해 태담으로 들려주세요. 태아에 대한 마음, 일상, 감정 등을 적어두었다가 태담으로 들려주면 좋습니다. 시간이 지나서도, 생생하게 기록을 간직할 수 있을거에요.',
              style: storyTextStyle,
            ),
          ],
        ),
      ],
    ),
  )
];

var taedamStory5 = [
  Container(
    height: 250.0,
    child: Container(
      child: Image.asset(
        'assets/images/3주차.gif',
        fit: BoxFit.contain,
      ),
    ),
  ),
  SizedBox(
    height: 5,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '엄마 목소리가 들려요!',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '5개월부터는 태아도 소리를 들을 수 있습니다. 태담 태교에 더욱 집중해주세요. 태아의 정서, 사회성, 두뇌발달에 정말 효과적입니다. 아직 청각이 완전히 발달하지는 않았지만, 꾸준한 태담을 통해 곧 엄마아빠의 목소리를 기억하게 될거에요.',
        style: storyTextStyle,
      ),
    ],
  ),
  SizedBox(
    height: 8,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '뇌를 발달시키는 태교법',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '태동이 진행되는 시기입니다. 동시에 태아의 전두엽 세포도 활성화 되기 시작합니다! 따라서 태동이 시작되면, 단순한 동화책도 좋지만 생각을 요구하는 사회과학책 같은 것을 읽는 것이 태아의 뇌발달에 긍정적인 자극을 줄거에요.',
        style: storyTextStyle,
      ),
    ],
  ),
  SizedBox(
    height: 28,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '음악보다 더 중요한 것은 태담',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '음악을 들려주는 것도 좋지만, 엄마의 목소리는 자궁 내에서 측정되는 다양한 소리 중 가장 우세한 소리로 태아의 뇌를 자극합니다. 따라서 좋아하는 음악을 엄마나 아빠가 직접 불러주면 2배의 효과를 볼 수 있습니다.',
        style: storyTextStyle,
      ),
    ],
  ),
];

var taedamStory6 = [
  Container(
    height: 250.0,
    child: Container(
      child: Image.asset(
        'assets/images/3주차.gif',
        fit: BoxFit.contain,
      ),
    ),
  ),
  SizedBox(
    height: 5,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '바깥 세상의 소리가 들리기 시작했어요.',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '이시기의 태아는 자궁내외의 소리를 들을 수 있고, 뇌세포의 크기와 복잡성이 증가합니다. 이때 태아에게 친숙한 엄마,아빠의 목소리를 통한 청각적 자극이 태아의 더 좋은 뇌세포를 만듭니다. 수필집, 태교집, 동화책들을 읽어주세요.',
        style: storyTextStyle,
      ),
    ],
  ),
  SizedBox(
    height: 28,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '너무 학습적인 책이나 내용은 피하기',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '조기교육을 목표로 태담을 진행하는 것은 좋지 않습니다. 종종 엄마들은 조기교육으로서의 태교에 부담과 스트레스를 느낍니다. 이는 고스란히 태아에게 전달되기 때문에 역효과가 날 수 있습니다. 태내 환경,충분한 영양공급, 편안한 마음, 유해물질의 차단이 가장 중요함을 명심해주세요.',
        style: storyTextStyle,
      ),
    ],
  ),
  SizedBox(
    height: 28,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '태담을 나눌 때는 배 위에 손을 얹어서',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '엄마의 심장소리, 장이 움직이는 소리 등 자궁안은 조용하지 않습니다.  배를 쓰다듬으며 태담을 나눌경우, 엄마아빠의 목소리 전달에 방해가 될 수 있습니다. 하지만 촉각을 통해서도 태아는 정서적인 교감을 형성하기 떄문에, 태담을 나누지 않을때에는 적극적으로 배를 쓰다듬어주는게 좋습니다.',
        style: storyTextStyle,
      ),
    ],
  ),
];

var taedamStory7 = [
  Container(
    height: 250.0,
    child: Container(
      child: Image.asset(
        'assets/images/3주차.gif',
        fit: BoxFit.contain,
      ),
    ),
  ),
  SizedBox(
    height: 5,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '태아의 움직임에 반응해주세요.',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '태동이 활발하게 진행되는 시기입니다. 태아의 움직임에 귀를 기울이고, 움직임이 느껴질 때마다, "기분이 좋아~?" "건강하게 자라고 있구나~"등의 반응을 보여주세요. 태아와의 유대감을 형성할 수 있습니다.',
        style: storyTextStyle,
      ),
    ],
  ),
  SizedBox(
    height: 28,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '엄마,아빠의 노래를 자주 들려주세요.',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '태아의 청각은 28주에 완전히 완성되고, 소리, 리듬, 멜로디 등에 반응합니다.  따라서 엄마 아빠가 함께 노래를 불러주거나 동요를 들려주면, 태아의 정서와 뇌발달에 큰 도움이 될 거에요.',
        style: storyTextStyle,
      ),
    ],
  ),
  SizedBox(
    height: 28,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '편지 태담을 들려주세요.',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '이 시기가 되면 태아는 바깥의 소리를 들을 수 있을 뿐 아니라, 엄마아빠의 목소리를 구별할 수 있습니다. 엄마 아빠가 번갈아가며, 테아에게 마음을 담은 편지를 태담으로 들려주세요.  태어난 아기가 나중에 녹음본을 들었을 때, 무척 감동을 받을거에요!',
        style: storyTextStyle,
      ),
    ],
  ),
];

var taedamStory8 = [
  Container(
    height: 250.0,
    child: Container(
      child: Image.asset(
        'assets/images/3주차.gif',
        fit: BoxFit.contain,
      ),
    ),
  ),
  SizedBox(
    height: 5,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '리듬감 있는 음악을 들려주세요.',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '임신후기입니다. 이 시기에는 태아가 소리의 높낮이를 기억할 수 있을 뿐 아니라, 신생아 만큼 뇌의 구조가 복잡해집니다. 이때 음악의 리듬은 뇌발달을 위한 자극에 효과적입니다. 엄마와 아빠가 함께 리듬감 있는 노래를 자주 불러주세요.  하지만 너무 과격한 음악은 태아를 불안하게 할 수 있습니다.',
        style: storyTextStyle,
      ),
    ],
  ),
  SizedBox(
    height: 28,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '엄마,아빠의 목소리 & 사물의 소리를 구별할 수 있어요.',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '소리 구별이 가능하고, 눈을 뜰 수 있게되고 초점을 맞추는 연습도 한답니다. 맘소리의 1일1토픽으로, 꾸준히 태담을 실천해주세요 !',
        style: storyTextStyle,
      ),
    ],
  ),
  SizedBox(
    height: 28,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '명상을 통해 마음의 안정을 찾아주세요.',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '이시기의 태아는 감정이 풍부해져, 엄마가 불안하거나 화가나면 함께 불안함을 느낍니다. 지난 기간을 돌아보며 아기를 맞을 마음의 준비를 해주세요. 지금까지 남긴 태담 녹음은 분명 아이에게 훗날 소중한 선물이 될 거에요.',
        style: storyTextStyle,
      ),
    ],
  ),
];

var taedamStory9 = [
  Container(
    height: 250.0,
    child: Container(
      child: Image.asset(
        'assets/images/3주차.gif',
        fit: BoxFit.contain,
      ),
    ),
  ),
  SizedBox(
    height: 5,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '극복과 응원의 메세지를 건네주세요.',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '이시기의 태아는 오감이 발달하고 뇌의 움직임이 활발해지므로 지속적으로 자극을 주는게 좋아습니다. 배가 많이 불러와 힘들지만, "몸이 많이 무겁지만, 곧 동동이를 만날 수 있겠네." ,"엄마가 힘낼게 "등의 극복의 메세지를 건네주세요. 태아와 엄마 모두, 서로가 힘이 될거에요. ',
        style: storyTextStyle,
      ),
    ],
  ),
  SizedBox(
    height: 28,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '아기가 좋아하는 자연음이나 태교 음악을 들려주세요.',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '태아는 시냇물이 흐리는 소리나 새들이 지저귀는 소리 등 자연의 소리를 좋아합니다. 모차르트의 세레나데 비발디의 사계 등과 같은, 잔잔하면서 자연을 테마로한 클래식 음악을 들려주세요.',
        style: storyTextStyle,
      ),
    ],
  ),
  SizedBox(
    height: 28,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '충분한 휴식과 수면을 취해주세요.',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '출산에 대한 불안이 있을 수 있습니다. 명상과 호흡법이 큰 도움이 될 거에요. 임신 후기에는 피로감이 높기 떄문에 편안한 장소에서 언제든 휴식을 취할 수 있게 해주세요.',
        style: storyTextStyle,
      ),
    ],
  ),
];

var taedamStory10 = [
  Container(
    height: 250.0,
    child: Container(
      child: Image.asset(
        'assets/images/3주차.gif',
        fit: BoxFit.contain,
      ),
    ),
  ),
  SizedBox(
    height: 5,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '만남을 암시하는 메세지를 건네주세요.',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '아기와의 만남이 임박했습니다. 편안한 마음과 자세로 "이제 곧 만나겠네~.", "그동안 고생했어 동동아~" 와 같이 만남을 암시하는 메세지를 건네주세요. 태아는 엄마의 음성과 다른 소리를 구별 할 수 있기 때문에, 출산 24시간 안에 엄마의 음성을 기억해 안정을 찾을 수 있습니다.',
        style: storyTextStyle,
      ),
    ],
  ),
  SizedBox(
    height: 28,
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '출산을 앞둔 마지막 달!',
        style: titleTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '이시기의 엄마는 마음이 불안하고, 몸 곳곳에서 출산을 위한 준비가 시작됩니다.  마지막까지 태담을 나누는 것이 좋지만, 어렵게 느껴질 경우에는 10개월간의 녹음을 재생시켜 태담을 대신해도 좋습니다. 곧 태어날 아기와의 만남을 생각하며 마음을 가다듬어주세요.',
        style: storyTextStyle,
      ),
    ],
  ),
];
