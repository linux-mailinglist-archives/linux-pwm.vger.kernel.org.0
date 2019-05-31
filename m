Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49D4130C3C
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2019 11:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEaJ75 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 May 2019 05:59:57 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:52446 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbfEaJ75 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 May 2019 05:59:57 -0400
X-IronPort-AV: E=Sophos;i="5.60,534,1549897200"; 
   d="scan'208";a="17478806"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 May 2019 18:59:54 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 53B494218D59;
        Fri, 31 May 2019 18:59:54 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     thierry.reding@gmail.com
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3 3/4] pwm: sysfs: Add suspend/resume support
Date:   Fri, 31 May 2019 18:55:00 +0900
Message-Id: <1559296501-30620-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559296501-30620-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1559296501-30620-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

According to the Documentation/pwm.txt, all PWM consumers should have
power management. Since this sysfs interface is one of consumers so that
this patch adds suspend/resume support.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pwm/sysfs.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 7eb4a13..a0618780 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -18,6 +18,7 @@ struct pwm_export {
 	struct device child;
 	struct pwm_device *pwm;
 	struct mutex lock;
+	struct pwm_state suspend;
 };
 
 static struct pwm_export *child_to_pwm_export(struct device *child)
@@ -372,10 +373,111 @@ static struct attribute *pwm_chip_attrs[] = {
 };
 ATTRIBUTE_GROUPS(pwm_chip);
 
+/* takes export->lock on success */
+static struct pwm_export *pwm_class_get_state(struct device *parent,
+					      struct pwm_device *pwm,
+					      struct pwm_state *state)
+{
+	struct device *child;
+	struct pwm_export *export;
+
+	if (!test_bit(PWMF_EXPORTED, &pwm->flags))
+		return NULL;
+
+	child = device_find_child(parent, pwm, pwm_unexport_match);
+	if (!child)
+		return NULL;
+
+	export = child_to_pwm_export(child);
+	put_device(child);	/* for device_find_child() */
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, state);
+
+	return export;
+}
+
+static int pwm_class_apply_state(struct pwm_export *export,
+				 struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	int ret = pwm_apply_state(pwm, state);
+
+	/* release lock taken in pwm_class_get_state */
+	mutex_unlock(&export->lock);
+
+	return ret;
+}
+
+static int pwm_class_resume_npwm(struct device *parent, unsigned int npwm)
+{
+	struct pwm_chip *chip = dev_get_drvdata(parent);
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+		struct pwm_state state;
+		struct pwm_export *export;
+
+		export = pwm_class_get_state(parent, pwm, &state);
+		if (!export)
+			continue;
+
+		state.enabled = export->suspend.enabled;
+		ret = pwm_class_apply_state(export, pwm, &state);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
+}
+
+static int pwm_class_resume(struct device *parent)
+{
+	struct pwm_chip *chip = dev_get_drvdata(parent);
+
+	return pwm_class_resume_npwm(parent, chip->npwm);
+}
+
+static int pwm_class_suspend(struct device *parent)
+{
+	struct pwm_chip *chip = dev_get_drvdata(parent);
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+		struct pwm_state state;
+		struct pwm_export *export;
+
+		export = pwm_class_get_state(parent, pwm, &state);
+		if (!export)
+			continue;
+
+		export->suspend = state;
+		state.enabled = false;
+		ret = pwm_class_apply_state(export, pwm, &state);
+		if (ret < 0) {
+			/*
+			 * roll back the PWM devices that were disabled by
+			 * this suspend function.
+			 */
+			pwm_class_resume_npwm(parent, i);
+			break;
+		}
+	}
+
+	return ret;
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

