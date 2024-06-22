const columns = [
    {header: '아이디', name: 'US_ID'},
    {header: '닉네임', name: 'US_NICK'},
    {header: '회원명', name: 'US_NAME'},
    {header: '가입일', name: 'US_REG_DATE'},
    {header: '상세보기'
      , name: 'hide'
      , renderer: {type: detail_btn}
      , witdh : '50px'
    },
]



// 조회할 테이블
const table = "user";