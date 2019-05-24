Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7633F28E6C
	for <lists+linux-pwm@lfdr.de>; Fri, 24 May 2019 02:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbfEXA4h (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 May 2019 20:56:37 -0400
Received: from www3345.sakura.ne.jp ([49.212.235.55]:14298 "EHLO
        www3345.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbfEXA4h (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 May 2019 20:56:37 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4O0uXti091715;
        Fri, 24 May 2019 09:56:33 +0900 (JST)
        (envelope-from cv-dong@jinso.co.jp)
Received: from www3345.sakura.ne.jp (49.212.235.55)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Fri, 24 May 2019 09:56:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from localhost (p14010-ipadfx41marunouchi.tokyo.ocn.ne.jp [61.118.107.10])
        (authenticated bits=0)
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4O0uUSZ091687
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 09:56:33 +0900 (JST)
        (envelope-from cv-dong@jinso.co.jp)
From:   Cao Van Dong <cv-dong@jinso.co.jp>
To:     linux-renesas-soc@vger.kernel.org, thierry.reding@gmail.com,
        horms+renesas@verge.net.au, geert+renesas@glider.be,
        broonie@kernel.org, linux-pwm@vger.kernel.org
Cc:     yoshihiro.shimoda.uh@renesas.com, kuninori.morimoto.gx@renesas.com,
        h-inayoshi@jinso.co.jp, na-hoan@jinso.co.jp, cv-dong@jinso.co.jp
Subject: [PATCH v3] pwm: renesas-tpu: Add suspend/resume function
Date:   Fri, 24 May 2019 09:56:29 +0900
Message-Id: <1558659389-4397-1-git-send-email-cv-dong@jinso.co.jp>
X-Mailer: git-send-email 2.7.4
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds suspend/resume function support for Renesas the 16-Bit Timer
Pulse Unit (TPU) driver. This has been tested on the Salvator-XS board 
with R-Car M3-N and H3 at renesas-drivers-2019-05-21-v5.2-rc1 tag.
I expect this to work on other SoCs.

Test procedure:
  - Enable TPU and pin control in DTS.
  - Make sure switches { SW29-[1-2] are switched off or 
    SW31-[1-4] are switched off(only for Salvator-xs) }.
  - Exercise userspace PWM control for pwm[2,3] 
    of /sys/class/pwm/pwmchip1/ .
  - Inspect PWM signals on the input side of { CN29-[58,60] 
    or SW31-[1,2] (only for Salvator-xs) }
    before and after suspend/resume using an oscilloscope. 

Signed-off-by: Cao Van Dong <cv-dong@jinso.co.jp>
Tested-by: Cao Van Dong <cv-dong@jinso.co.jp>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
Changes v2 -> v3:
  - Changes '3' -> TPU_CHANNEL_MAX in loop.
  - Remove pm_runtime_put() function in tpu_pwm_suspend() function.
---
Changes v1 -> v2:
  - Repair the handling code to cover case of using multiple timers.
---
 drivers/pwm/pwm-renesas-tpu.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 4a855a2..cb97252 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -366,6 +366,58 @@ static void tpu_pwm_disable(struct pwm_chip *chip, struct pwm_device *_pwm)
 	tpu_pwm_timer_stop(pwm);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int tpu_pwm_restart_timer(struct pwm_device *pwm)
+{
+	if (!test_bit(PWMF_REQUESTED, &pwm->flags))
+		return 0;
+
+	/* Restart timer */
+	tpu_pwm_disable(pwm->chip,pwm);
+	tpu_pwm_enable(pwm->chip,pwm);
+
+	return 0;
+}
+
+static int tpu_pwm_suspend(struct device *dev)
+{
+	struct tpu_device *tpu = dev_get_drvdata(dev);
+	struct pwm_chip *chip = &tpu->chip;
+	struct pwm_device *pwm;
+	int i;
+
+	for (i = 0; i < TPU_CHANNEL_MAX; i++) {
+		if ((pwm_get_chip_data(&chip->pwms[i])) != NULL) {
+			pwm = &chip->pwms[i];
+			if (!test_bit(PWMF_REQUESTED, &pwm->flags))
+				return 0;
+		}
+	}
+
+	return 0;
+}
+
+static int tpu_pwm_resume(struct device *dev)
+{
+	struct tpu_device *tpu = dev_get_drvdata(dev);
+	struct pwm_chip *chip = &tpu->chip;
+	struct pwm_device *pwm;
+	int i;
+
+	pm_runtime_get_sync(dev);
+
+	for (i = 0; i < TPU_CHANNEL_MAX; i++) {
+		if ((pwm_get_chip_data(&chip->pwms[i])) != NULL) {
+			pwm = &chip->pwms[i];
+			tpu_pwm_restart_timer(pwm);
+		}
+	}
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+static SIMPLE_DEV_PM_OPS(tpu_pwm_pm_ops, tpu_pwm_suspend, tpu_pwm_resume);
+
 static const struct pwm_ops tpu_pwm_ops = {
 	.request = tpu_pwm_request,
 	.free = tpu_pwm_free,
@@ -459,6 +511,7 @@ static struct platform_driver tpu_driver = {
 	.remove		= tpu_remove,
 	.driver		= {
 		.name	= "renesas-tpu-pwm",
+		.pm	= &tpu_pwm_pm_ops,
 		.of_match_table = of_match_ptr(tpu_of_table),
 	}
 };
-- 
2.7.4

