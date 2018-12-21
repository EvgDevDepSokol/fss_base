/* global $ */
'use strict';

var React = require('react');
var createReactClass = require('create-react-class');
var LocalStorageMixin = require('react-localstorage');
import PropTypes from 'prop-types';
var TreeView = createReactClass({
  displayName: 'TreeView',

  propTypes: {
    collapsed: PropTypes.bool,
    defaultCollapsed: PropTypes.bool,
    nodeLabel: PropTypes.node.isRequired,
    onClick: PropTypes.func,
    elem: PropTypes.object
  },

  mixins: [LocalStorageMixin],

  getLocalStorageKey: function() {
    return 'Treeview|' + this.props.elem.type;
  },

  getInitialState: function() {
    return { collapsed: this.props.defaultCollapsed };
  },

  handleClick: function(a, b, c) {
    this.setState({
      collapsed: !this.state.collapsed
    });
    this.props.onClick && this.props.onClick(a, b, c);
  },

  render: function() {
    var props = this.props;
    var collapsed =
      props.collapsed != null ? props.collapsed : this.state.collapsed;

    var arrowClassName = 'tree-view_arrow';
    var containerClassName = 'tree-view_children';
    if (collapsed) {
      arrowClassName += ' tree-view_arrow-collapsed';
      containerClassName += ' tree-view_children-collapsed';
    }

    var arrow = (
      <div
        className={(props.className || '') + ' ' + arrowClassName}
        onClick={this.handleClick}
      >
        ▾
      </div>
    );
    var label = <div onClick={this.handleClick}>{props.nodeLabel}</div>;

    return (
      <div className="tree-view">
        {arrow}
        {label}
        <div className={containerClassName}>{props.children}</div>
      </div>
    );
  }
});

class TreeSearch extends React.Component {
  static propTypes = {
    changeInput: PropTypes.func
  };

  state = { searchValue: '' };

  changeInput = e => {
    var searchValue = e.target.value;
    this.setState({ searchValue: searchValue });
    this.props.changeInput(searchValue);
  };

  render() {
    return (
      <div className="react-search">
        <input
          type="text"
          className="input-text"
          //ref="searchInput"
          onKeyUp={this.changeInput}
        />
        <i className="fa fa-search fa-lg" />
      </div>
    );
  }
}

class TreeListNode extends React.Component {
  openLink = () => {
    location.href = this.props.href;
  };

  render() {
    return (
      <li className={this.props.current ? 'node current' : 'node'}>
        <a href={this.props.href}>{this.props.label}</a>
      </li>
    );
  }
}

var SideMenu = createReactClass({
  displayName: 'SideMenu',
  mixins: [LocalStorageMixin],

  getDefaultProps: function() {
    return {
      stateFilterKeys: ['scrollTop']
    };
  },

  getInitialState: function() {
    this.filterData('');
    return {
      dataSource: this.props.dataSource
    };
  },

  filterData: function(pattern) {
    if (!String.prototype.includes) {
      String.prototype.includes = function() {
        'use strict';
        return String.prototype.indexOf.apply(this, arguments) !== -1;
      };
    }
    var data = $.merge([], this.props.dataSource);
    var newChildrens;
    var newData = data.map(function(elem) {
      if (!pattern || elem.label.toLowerCase().includes(pattern)) {
        newChildrens = elem.children.map(function(child) {
          return $.extend(child, { visible: true });
        });
        return $.extend(elem, {
          children: newChildrens,
          visible: true
        });
      } else if (elem.children) {
        var countVisibleChildren = 0;
        newChildrens = elem.children.map(function(child) {
          if (!pattern || child.label.toLowerCase().includes(pattern)) {
            countVisibleChildren++;
            return $.extend(child, { visible: true });
          } else {
            return $.extend(child, { visible: false });
          }
        });
        return $.extend(elem, {
          children: newChildrens,
          visible: countVisibleChildren > 0
        });
      }
      return $.extend(elem, { visible: false });
    });
    return newData;
  },

  changeFilter: function(pattern) {
    var newData = this.filterData(pattern);
    this.setState({ dataSource: newData });
  },

  handleScroll: function(scrollTop) {
    this.setState({
      scrollTop
    });
  },

  render: function() {
    var menuTreeInner = (
      <div className="menu-tree-inner">
        {this.state.dataSource.map(function(node, i) {
          var type = node.type;
          var childrensList = node.children.map(function(child, j) {
            if (child.visible) {
              return (
                <TreeListNode
                  key={type + '|' + i + '|' + j}
                  label={child.label}
                  href={child.href}
                  current={child.current}
                />
              );
            }
          });
          var label = <span className="node">{node.label}</span>;
          if (node.visible) {
            return (
              <TreeView
                elem={node}
                key={type + '|' + i}
                nodeLabel={label}
                defaultCollapsed={false}
              >
                <ul>{childrensList}</ul>
              </TreeView>
            );
          } else {
            return '';
          }
        }, this)}
      </div>
    );

    return (
      <div>
        <TreeSearch changeInput={this.changeFilter} key={'menu-search'} />
        <Elem
          handleScroll={this.handleScroll}
          menuTreeInner={menuTreeInner}
          scrollTop={this.state.scrollTop}
        />
      </div>
    );
  }
});

class Elem extends React.Component {
  componentDidUpdate() {
    this.refs.elem.scrollTop = this.props.scrollTop;
  }

  render() {
    return (
      <div className="menu-tree" ref="elem" onScroll={this.onScroll}>
        {this.props.menuTreeInner}
      </div>
    );
  }

  onScroll = () => {
    this.props.handleScroll(this.refs.elem.scrollTop);
  };
}

module.exports = SideMenu;
