'use strict';

var React = require('react');
var LocalStorageMixin = require('react-localstorage');
var TreeView = React.createClass({
  propTypes: {
    collapsed: React.PropTypes.bool,
    defaultCollapsed: React.PropTypes.bool,
    nodeLabel: React.PropTypes.node.isRequired
  },

  mixins: [LocalStorageMixin],

  getLocalStorageKey: function(){
    return 'Treeview|' + this.props.elem.type;
  },

  getInitialState: function() {
    return {collapsed: this.props.defaultCollapsed};
  },

  handleClick: function(a, b, c) {
    this.setState({
      collapsed: !this.state.collapsed
    });
    this.props.onClick && this.props.onClick(a, b, c);
  },

  render: function() {
    var props = this.props;

    var collapsed = props.collapsed != null ?
      props.collapsed :
      this.state.collapsed;

    var arrowClassName = 'tree-view_arrow';
    var containerClassName = 'tree-view_children';
    if (collapsed) {
      arrowClassName += ' tree-view_arrow-collapsed';
      containerClassName += ' tree-view_children-collapsed';
    }

    var arrow =
      <div
          {...props}
        className={(props.className || '') + ' ' + arrowClassName}
        onClick={this.handleClick}>
        ▾
      </div>;

    return (
      <div className="tree-view">
          {arrow}
          {props.nodeLabel}
        <div className={containerClassName}>
            {props.children}
        </div>
      </div>
    );
  }
});

var TreeSearch = React.createClass({
  getInitialState: function(){
    return {
      searchValue: ''
    }
  },

  /**
   * Input box text has changed, trigger update of the autocomplete box.
   **/
  changeInput: function () {
    var searchValue = this.refs.searchInput.getDOMNode().value;
    this.setState({searchValue: searchValue});
    this.props.changeInput(searchValue);
  },

  render: function(){

    return (
      <div className="react-search">
        <input type="text" className="input-text" ref="searchInput" onKeyUp={this.changeInput} />
        <i className="fa fa-search fa-lg"></i>
        <i className="fa fa-times fa-lg" ></i>
      </div>
    );
  }
});

var TreeListNode = React.createClass({

  openLink: function(){
    location.href = this.props.href;
  },

  render: function(){
    return (
      <li className={this.props.current ? "node current" : "node"} >
        <a href={this.props.href} >{this.props.label}</a>
      </li>
    );
  }
});

var SideMenu = React.createClass({

  filterData: function(pattern) {
    //debugger;
    var data = $.merge([], this.props.dataSource);
    var newData = data.map(function(elem){
      if( !pattern || elem.label.toLowerCase().includes(pattern)){
        var newChildrens = elem.children.map(function(child) {
          return $.extend(child, {visible: true});
        });
        return $.extend(elem, {children: newChildrens, visible: true});
      }else if(elem.children){
        var countVisibleChildren = 0;
        var newChildrens = elem.children.map(function(child) {
          if ( !pattern || child.label.toLowerCase().includes(pattern)) {
            countVisibleChildren++;
            return $.extend(child, {visible: true});
          }else
          {
            return $.extend(child, {visible: false});
          }
        });
        return $.extend(elem, {children: newChildrens,
        visible: countVisibleChildren > 0});
      }
      return $.extend(elem, {visible: false});
    });
    //debugger;
    this.setState({dataSource: newData});
  },

  getInitialState: function(){
    this.filterData("");
    return {
      dataSource: this.props.dataSource
    }
  },

  render: function() {

    return (
      <div>
        <TreeSearch changeInput={this.filterData} key={"menu-search"} />
        <div className="menu-tree">
          <div className="menu-tree-inner" >

        {this.state.dataSource.map(function(node, i) {
          var type = node.type;
          var childrensList = node.children.map(function(child, j) {
            if(child.visible)
            {
              return(
                <TreeListNode label={child.label} href={child.href} current={child.current} />
              )
            }
          });
          var label = <span className="node">{node.label}</span>;
          if(node.visible){
            return (
              <TreeView elem={node} key={type + '|' + i} nodeLabel={label} defaultCollapsed={false} >
                <ul>
                  {childrensList}
                </ul>
              </TreeView>
            );
          }else{
            return('');
          }
        }, this)}
        </div>
        </div>
      </div>
    );
  }
});

module.exports = SideMenu;
