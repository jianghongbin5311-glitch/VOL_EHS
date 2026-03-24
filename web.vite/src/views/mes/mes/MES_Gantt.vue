<template>
  <div class="gantt-container">
    <div
      id="CONTAINER_ID"
      style="width: 100%; position: relative"
      :style="{ height: height }"
    ></div>
  </div>
</template>
<script lang="jsx" setup>
import { ref, onErrorCaptured, onMounted } from 'vue'
import * as VTableGantt from '@visactor/vtable-gantt'
// import * as VRender from '@visactor/vtable/es/vrender';

const height = ref()
height.value = document.body.clientHeight - 100 + 'px'

onMounted(() => {
  // import * as VTableGantt from '@visactor/vtable-gantt';
  let ganttInstance
  const records = [
    {
      id: '1',
      title: '项目启动会议',
      start: '2024-01-01',
      type: 'milestone',
      progress: 100,
      parent: '0'
    },
    {
      id: '2',
      title: '项目启动与规划2',
      start: '2024-01-01',
      end: '2024-01-6',
      progress: 100,
      parent: '0'
    },
    {
      id: '3',
      title: '需求评审完成',
      start: '2024-01-6',
      type: 'milestone',
      progress: 100,
      parent: '0'
    },
    {
      id: '4',
      title: '技术方案设计',
      start: '2024-01-6',
      end: '2024-01-11',
      progress: 80,
      parent: '0'
    },
    {
      id: '5',
      title: '开发环境搭建完成',
      start: '2024-01-11',
      type: 'milestone',
      progress: 100,
      parent: '0'
    },
    {
      id: '6',
      title: '核心功能开发',
      start: '2024-01-12',
      end: '2024-01-18',
      progress: 60,
      parent: '0'
    },
    {
      id: '7',
      title: 'Beta版本发布',
      start: '2024-01-18',
      type: 'milestone',
      progress: 0,
      parent: '0'
    },
    {
      id: '8',
      title: '系统测试',
      start: '2024-01-19',
      end: '2024-01-23',
      progress: 60,
      parent: '0'
    },
    {
      id: '9',
      title: '性能测试完成',
      start: '2024-01-24',
      type: 'milestone',
      progress: 0,
      parent: '0'
    },
    {
      id: '10',
      title: '正式版本发布',
      start: '2024-01-01',
      end: '2024-2-23',
      type: 'milestone',
      progress: 0,
      parent: '0'
    }
  ]

  const columns = [
    {
      field: 'title',
      title: '任务名称',
      width: 200,
      style: {
        fontFamily: 'PingFang SC',
        padding: [8, 16]
      }
    },
    {
      field: 'progress',
      title: '进度',
      width: 100,
      style: {
        fontFamily: 'PingFang SC',
        padding: [8, 16],
        textAlign: 'center',
        color: (value) => (value >= 80 ? '#52c41a' : value >= 30 ? '#1890ff' : '#595959')
      }
    }
  ]
  //https://www.visactor.io/vtable/guide/gantt/gantt_task_show_mode
  const option = {
    records,
    //https://www.visactor.io/vtable/option/Gantt#taskListTable
    taskListTable: {
      columns,
      tableWidth: 'auto', // 220,//表格宽度
      // minTableWidth: 0,
      // maxTableWidth: 0,
      theme: {
        headerStyle: {
          borderColor: '#f0f0f0',
          fontSize: 13,
          fontFamily: 'PingFang SC',
          fontWeight: 500,
          color: '#262626',
          bgColor: '#fafafa',
          padding: [12, 16]
        },
        bodyStyle: {
          fontSize: 13,
          fontFamily: 'PingFang SC',
          color: '#595959',
          bgColor: '#ffffff',
          borderColor: '#f0f0f0',
          padding: [0, 16]
        }
      }
    },
    // frame: {
    //   outerFrameStyle: {
    //     borderColor: '#ebedf0',
    //     borderLineWidth: 1,
    //     cornerRadius: 12,
    //     padding: [1, 1, 1, 1]
    //   },
    //   verticalSplitLine: {
    //     lineColor: '#f0f0f0',
    //     lineWidth: 1
    //   }
    // },
    //https://www.visactor.io/vtable/option/Gantt
    frame: {
      //
      outerFrameStyle: {
        borderLineWidth: 1,
        borderColor: '#e1e4e8',
        cornerRadius: 8
      },
      verticalSplitLineMoveable: true, //配置拖动
      verticalSplitLine: {
        lineColor: '#e1e4e8',
        lineWidth: 1
      },
      horizontalSplitLine: {
        lineColor: '#e1e4e8',
        lineWidth: 1
      }
    },
    grid: {
      backgroundColor: '#fafaff',
      weekendBackgroundColor: 'rgba(94, 180, 245, 0.10)',
      verticalLine: {
        lineWidth: 1,
        lineColor: '#f5f5f5'
      },
      horizontalLine: {
        lineWidth: 1,
        lineColor: '#f5f5f5'
      }
    },
    headerRowHeight: 42,
    rowHeight: 40,
    taskBar: {
      startDateField: 'start',
      endDateField: 'end',
      progressField: 'progress',
      moveable: true,
      hoverBarStyle: {
        barOverlayColor: 'rgba(99, 144, 0, 0.2)'
      },
      frame: {
        verticalSplitLineMoveable: true
      },
      labelText: '{title} {progress}%',
      labelTextStyle: {
        // padding: 2,
        fontFamily: 'Arial',
        fontSize: 16,
        textAlign: 'left',
        textOverflow: 'ellipsis',
        color: 'rgb(240, 246, 251)'
      },
      barStyle: {
        width: 24,
        barColor: '#d6e4ff',
        completedBarColor: '#597ef7',
        cornerRadius: 12,
        borderLineWidth: 2,
        borderColor: 'rgb(7, 88, 150)'
      },
      milestoneStyle: {
        width: 16,
        fillColor: (value) => (value.record.progress >= 100 ? '#597ef7' : '#d6e4ff'),
        borderColor: '#597ef7',
        borderLineWidth: 0,
        labelText: '{title}',
        labelTextStyle: {
          fontSize: 16,
          color: 'rgb(1, 43, 75)'
        }
      }
    },
    timelineHeader: {
      colWidth: 50,
      backgroundColor: '#fafafa',
      horizontalLine: {
        lineWidth: 1,
        lineColor: '#f0f0f0'
      },
      verticalLine: {
        lineWidth: 1,
        lineColor: '#f0f0f0'
      },
      scales: [
        {
          unit: 'week',
          step: 1,
          format(date) {
            return `第${date.dateIndex}周`
          },
          style: {
            fontSize: 12,
            fontFamily: 'PingFang SC',
            textAlign: 'center',
            textBaseline: 'middle',
            color: '#262626',
            padding: [8, 0]
          }
        },
        {
          unit: 'day',
          step: 1,
          format(date) {
            return date.dateIndex.toString()
          },
          style: {
            fontSize: 12,
            fontFamily: 'PingFang SC',
            textAlign: 'center',
            textBaseline: 'middle',
            color: '#8c8c8c',
            padding: [8, 0]
          }
        }
      ]
    },
    markLine: [
      //设置右边图的起始日期(位置)
      {
        date: '2024-01-01',
        style: {
          lineWidth: 1,
          lineColor: 'blue',
          lineDash: [8, 4]
        }
      },
      {
        date: '2024-02-22',
        style: {
          lineWidth: 2,
          lineColor: 'red',
          lineDash: [8, 4]
        }
      }
    ],
    rowSeriesNumber: {
      title: '行号',
      dragOrder: true,
      headerStyle: {
        bgColor: '#EEF1F5',
        borderColor: '#e1e4e8'
      },
      style: {
        borderColor: '#e1e4e8'
      }
    },
    scrollStyle: {
      scrollRailColor: '#f5f5f5',
      visible: 'scrolling', //'always' | 'scrolling' | 'none' | 'focus'
      width: 5,
      scrollSliderColor: '#ccc',
      hover: {
        scrollSliderColor: '#bbb'
      }
    }
  }

  ganttInstance = new VTableGantt.Gantt(document.getElementById('CONTAINER_ID'), option)
  window['ganttInstance'] = ganttInstance

  //切换table隐藏显示
  const ganttElement = document.querySelector('.vtable-gantt')
  if (ganttElement) {
    const newElement = document.createElement('button')
    // newElement.textContent = '点击我'
    newElement.className = 'custom-button el-icon-sort'
    newElement.addEventListener('click', function () {
      option.taskListTable.tableWidth = option.taskListTable.tableWidth == 'auto' ? 0 : 'auto'
      //刷新图
      ganttInstance.updateOption(option)
    })
    ganttElement.prepend(newElement)
  }
})
</script>
<style scoped lang="less">
.gantt-container {
    padding: 10px;
    position: absolute;
    width: 100%;
    height: 100%;
  ::v-deep(.custom-button) {
    position: absolute;
    top: 50%;
    border: none;
    font-size: 15px;
    color: #a19595;
    padding: 5px;
    border-top-right-radius: 5px;
    border-bottom-right-radius: 5px;
  }
}
</style>
