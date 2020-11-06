package jobs

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/lisijie/webcron/app/models"
	"os/exec"
	"time"
)

func InitJobs() {
	list, _ := models.TaskGetList(1, 1000000, "status", 1)
	for _, task := range list {
		job, err := NewJobFromTask(task)
		if err != nil {
			beego.Error("InitJobs:", err.Error())
			continue
		}
		AddJob(task.CronSpec, job)
	}
}

func runCmdWithTimeout(cmd *exec.Cmd, timeout time.Duration) (error, bool) {
	done := make(chan error)
	go func() {
		done <- cmd.Wait()
	}()

	var err error
	select {
	case <-time.After(timeout):
		beego.Warn(fmt.Sprintf("任務執行時間超過%d秒，進程將被強制殺掉:%d", int(timeout/time.Second), cmd.Process.Pid))
		go func() {
			<-done // 讀出上面的goroutine數據，避免阻塞導致無法退出
		}()
		if err = cmd.Process.Kill(); err != nil {
			beego.Error(fmt.Sprintf("進程無法殺掉: %d, 錯誤信息: %s", cmd.Process.Pid, err))
		}
		return err, true
	case err = <-done:
		return err, false
	}
}
