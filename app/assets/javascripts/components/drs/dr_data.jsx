var React = require('react');
import PropTypes from 'prop-types';

const DRSTATUS = {
  6: {
    label: 'Открыт',
    tr_classname: 'tec',
    links: []
  },
  0: {
    label: 'Возвращен на уточнение',
    tr_classname: 'eng',
    links: [{ val: 1, label: 'Уточнить и открыть' }]
  },
  1: {
    label: 'Новый',
    tr_classname: 'tec',
    links: [
      { val: 2, label: 'Принять в работу' },
      { val: 0, label: 'Вернуть на уточнение' }
    ]
  },
  2: {
    label: 'Открыт',
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
    label: 'Возвращен на доработку',
    tr_classname: 'tec',
    links: [{ val: 3, label: 'Готов к проверке' }]
  }
};

const DRPRIORITY = {
  0: { label: 'Бессрочный', period: 200 },
  1: { label: 'Обычный', period: 40 },
  2: { label: 'Важный', period: 30 },
  3: { label: 'Очень важный', period: 20 },
  4: { label: 'Критический', period: 10 }
};

var prepareRow = function(row, date_now) {
  row['status'] = row['status'] ? row['status'] : 6;
  row['status_desc'] = DRSTATUS[row['status']].label;
  row['Priority'] = row['Priority'] ? row['Priority'] : 0;
  row['priority_desc'] = DRPRIORITY[row['Priority']].label;
  row['pds_engineer_worker'] = getEngBySysId(row['system']['id']);
  if (row['status'] == 4) {
    row['time_left'] = 'Закрыт';
    row['time_left_val'] = 36500;
  } else {
    var date1 = new Date(row['openedDate']);
    var timeDiff = date_now - date1;
    var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
    var time_left = DRPRIORITY[row['Priority']].period - diffDays;
    row['time_left_val'] = time_left;
    row['time_left'] =
      time_left > 0
        ? 'Осталось ' + time_left + ' дней'
        : 'Просрочен на ' + Math.abs(time_left) + ' дней';
  }
  return row;
};

var getEngBySysId = function(sys_id) {
  return sys_eng_list[sys_id]
    ? sys_eng_list[sys_id]['engineers']
      .map(function(eng, i) {
        return eng.eng_name;
      })
      .sort()
      .join(', ')
    : eng_sys_list[0]['eng_name'];
};

var sortList = function(a, b) {
  if (a.label < b.label) return -1;
  if (a.label > b.label) return 1;
  return 0;
};

var arrayToOpt = function(opt, i) {
  return (
    <option key={'opt-' + i} value={opt.value}>
      {opt.label}
    </option>
  );
};
const _DRSTATUS = DRSTATUS;
const _DRPRIORITY = DRPRIORITY;
export { _DRSTATUS as DRSTATUS };
export { _DRPRIORITY as DRPRIORITY };
export { prepareRow };
export { getEngBySysId };
export { sortList };
export { arrayToOpt };
