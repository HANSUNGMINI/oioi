const columns = [
    {header: '아이디', name: 'APD_OWNER'},
    {header: '상품명', name: 'APD_NAME'},
    {header: '제목', name: 'APD_DETAIL'},
    {header: '카테고리', name: 'APD_CATEGORY'},
    {header: '등록일', name: 'APD_REG_DATE'},
    {header: '상세보기'
      , name: 'hide'
      , renderer: {type: detail_btn}
      , witdh : '50px'
    },
]



// 조회할 테이블
const table = "auction";