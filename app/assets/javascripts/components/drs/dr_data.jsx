const DRSTATUS = {
  0: {
    label: 'На уточнении',
    tr_classname: 'eng',
    links: [{ val: 1, label: 'Уточнить и открыть.' }]
  },
  1: {
    label: 'Открыт',
    tr_classname: 'tec',
    links: [
      { val: 0, label: 'Вернуть на уточнение' },
      { val: 2, label: 'Принять в работу' }
    ]
  },
  2: {
    label: 'Принят в работу',
    tr_classname: 'eng',
    links: [{ val: 3, label: 'Готов к проверке' }]
  },
  3: {
    label: 'Готов к проверке',
    tr_classname: 'eng',
    links: [
      { val: 4, label: 'Закрыть' },
      { val: 5, label: 'Вернуть на доработку' }
    ]
  },
  4: {
    label: 'Закрыт',
    tr_classname: 'tec',
    links: []
  },
  5: {
    label: 'Вернут на доработку',
    tr_classname: 'eng',
    links: [{ val: 3, label: 'Готов к проверке' }]
  }
};

module.exports.DRSTATUS = DRSTATUS;
