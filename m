Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6592D701
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2019 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfE2Hw4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 May 2019 03:52:56 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:7651 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbfE2Hw4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 May 2019 03:52:56 -0400
X-IronPort-AV: E=Sophos;i="5.60,526,1549897200"; 
   d="scan'208";a="17060850"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 May 2019 16:52:52 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9BD334001DCA;
        Wed, 29 May 2019 16:52:52 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     thierry.reding@gmail.com
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 3/4] pwm: sysfs: Add suspend/resume support
Date:   Wed, 29 May 2019 16:48:01 +0900
Message-Id: <1559116082-9851-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

According to the Documentation/pwm.txt, all PWM consumers should have
power management. Since this sysfs interface is one of consumers so that
this patch adds suspend/resume support.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/sysfs.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 7eb4a13..72dafdd 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -18,6 +18,7 @@ struct pwm_export {
 	struct device child;
 	struct pwm_device *pwm;
 	struct mutex lock;
+	bool enabled_in_suspend;
 };
 
 static struct pwm_export *child_to_pwm_export(struct device *child)
@@ -372,10 +373,73 @@ static struct attribute *pwm_chip_attrs[] = {
 };
 ATTRIBUTE_GROUPS(pwm_chip);
 
+static int pwm_class_suspend_resume(struct device *parent, bool suspend)
+{
+	struct pwm_chip *chip = dev_get_drvdata(parent);
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+		struct device *child;
+		struct pwm_export *export;
+		struct pwm_state state;
+
+		if (!test_bit(PWMF_EXPORTED, &pwm->flags))
+			continue;
+
+		child = device_find_child(parent, pwm, pwm_unexport_match);
+		if (!child)
+			goto rollback;
+
+		export = child_to_pwm_export(child);
+		put_device(child);	/* for device_find_child() */
+		if (!export)
+			goto rollback;
+
+		mutex_lock(&export->lock);
+		pwm_get_state(pwm, &state);
+		if (suspend) {
+			if (state.enabled)
+				export->enabled_in_suspend = true;
+			state.enabled = false;
+		} else if (export->enabled_in_suspend) {
+			state.enabled = true;
+			export->enabled_in_suspend = false;
+		}
+		ret = pwm_apply_state(pwm, &state);
+		mutex_unlock(&export->lock);
+		if (ret < 0)
+			goto rollback;
+	}
+
+	return ret;
+
+rollback:
+	/* roll back only when suspend */
+	if (suspend)
+		pwm_class_suspend_resume(parent, false);
+
+	return ret;
+}
+
+static int pwm_class_suspend(struct device *parent)
+{
+	return pwm_class_suspend_resume(parent, true);
+}
+
+static int pwm_class_resume(struct device *parent)
+{
+	return pwm_class_suspend_resume(parent, false);
+}
+
+static SIMPLE_DEV_PM_OPS(pwm_class_pm_ops, pwm_class_suspend, pwm_class_resume);
+
 static struct class pwm_class = {
 	.name = "pwm",
 	.owner = THIS_MODULE,
 	.dev_groups = pwm_chip_groups,
+	.pm = &pwm_class_pm_ops,
 };
 
 static int pwmchip_sysfs_match(struct device *parent, const void *data)
-- 
2.7.4

