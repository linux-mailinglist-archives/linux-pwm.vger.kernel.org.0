Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EDA2812B9
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Oct 2020 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387757AbgJBMbV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Oct 2020 08:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387677AbgJBMbV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Oct 2020 08:31:21 -0400
Received: from smtp2-2.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C069C0613D0;
        Fri,  2 Oct 2020 05:31:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id AA89323F66A;
        Fri,  2 Oct 2020 14:31:17 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.997
X-Spam-Level: 
X-Spam-Status: No, score=-2.997 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.097, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hs9TwZSDOHnW; Fri,  2 Oct 2020 14:31:16 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPA id 219A423F3EA;
        Fri,  2 Oct 2020 14:31:16 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] pwm: sysfs: Set class on pwm devices
Date:   Fri,  2 Oct 2020 14:30:47 +0200
Message-Id: <20201002123048.3073128-1-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

This adds a class to exported pwm devices.
Exporting a pwm through sysfs did not yield udev events. The
dev_uevent_filter function does filter-out devices without a bus or
class.
This was already addressed in commit
commit 7e5d1fd75c3d ("pwm: Set class for exported channels in sysfs")
but this did cause problems and the commit got reverted with
commit c289d6625237 ("Revert "pwm: Set class for exported channels in
sysfs"")
Problem with the previous approach was, that there is a clash if we have
multiple pwmchips:
	echo 0 > pwmchip0/export
	echo 0 > pwmchip1/export
would both export /sys/class/pwm/pwm0 .

Now this patch changes the sysfs interface. We do include the pwmchip
number into the pwm directory that gets exported.
With the example above we get:
	/sys/class/pwm/pwm-0-0
	/sys/class/pwm/pwm-1-0
We maintain ABI backward compatibility through symlinks.
	/sys/class/pwm/pwmchip0/pwm0
	/sys/class/pwm/pwmchip1/pwm0
are now symbolic links to the new names.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/pwm/sysfs.c | 57 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 449dbc0f49ed..c708da17a857 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -240,8 +240,10 @@ static void pwm_export_release(struct device *child)
 
 static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 {
+	struct pwm_chip *chip = dev_get_drvdata(parent);
 	struct pwm_export *export;
 	char *pwm_prop[2];
+	char *link_name;
 	int ret;
 
 	if (test_and_set_bit(PWMF_EXPORTED, &pwm->flags))
@@ -256,25 +258,39 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 	export->pwm = pwm;
 	mutex_init(&export->lock);
 
+	export->child.class = parent->class;
 	export->child.release = pwm_export_release;
 	export->child.parent = parent;
 	export->child.devt = MKDEV(0, 0);
 	export->child.groups = pwm_groups;
-	dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
+	dev_set_name(&export->child, "pwm-%u-%u", chip->base, pwm->hwpwm);
 
 	ret = device_register(&export->child);
-	if (ret) {
-		clear_bit(PWMF_EXPORTED, &pwm->flags);
-		put_device(&export->child);
-		export = NULL;
-		return ret;
+	if (ret)
+		goto error;
+
+	link_name = kasprintf(GFP_KERNEL, "pwm%u", pwm->hwpwm);
+	if (link_name == NULL) {
+		ret = -ENOMEM;
+		goto dev_unregister;
 	}
-	pwm_prop[0] = kasprintf(GFP_KERNEL, "EXPORT=pwm%u", pwm->hwpwm);
+
+	pwm_prop[0] = kasprintf(GFP_KERNEL, "EXPORT=%s",
+			export->child.kobj.name);
 	pwm_prop[1] = NULL;
 	kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
 	kfree(pwm_prop[0]);
 
-	return 0;
+	ret = sysfs_create_link(&parent->kobj, &export->child.kobj, link_name);
+	return ret;
+
+dev_unregister:
+	device_unregister(&export->child);
+error:
+	clear_bit(PWMF_EXPORTED, &pwm->flags);
+	put_device(&export->child);
+	export = NULL;
+	return ret;
 }
 
 static int pwm_unexport_match(struct device *child, void *data)
@@ -286,6 +302,7 @@ static int pwm_unexport_child(struct device *parent, struct pwm_device *pwm)
 {
 	struct device *child;
 	char *pwm_prop[2];
+	char *link_name;
 
 	if (!test_and_clear_bit(PWMF_EXPORTED, &pwm->flags))
 		return -ENODEV;
@@ -294,7 +311,11 @@ static int pwm_unexport_child(struct device *parent, struct pwm_device *pwm)
 	if (!child)
 		return -ENODEV;
 
-	pwm_prop[0] = kasprintf(GFP_KERNEL, "UNEXPORT=pwm%u", pwm->hwpwm);
+	link_name = kasprintf(GFP_KERNEL, "pwm%u", pwm->hwpwm);
+	if (link_name)
+		sysfs_delete_link(&parent->kobj, &child->kobj, link_name);
+
+	pwm_prop[0] = kasprintf(GFP_KERNEL, "UNEXPORT=%s", child->kobj.name);
 	pwm_prop[1] = NULL;
 	kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
 	kfree(pwm_prop[0]);
@@ -365,13 +386,29 @@ static ssize_t npwm_show(struct device *parent, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(npwm);
 
+static umode_t pwm_is_visible(struct kobject *kobj, struct attribute *attr,
+			      int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+
+	if (dev->groups == pwm_groups)
+		return 0;
+
+	return attr->mode;
+}
+
 static struct attribute *pwm_chip_attrs[] = {
 	&dev_attr_export.attr,
 	&dev_attr_unexport.attr,
 	&dev_attr_npwm.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(pwm_chip);
+
+static const struct attribute_group pwm_chip_group = {
+	.attrs = pwm_chip_attrs,
+	.is_visible = pwm_is_visible,
+};
+__ATTRIBUTE_GROUPS(pwm_chip);
 
 /* takes export->lock on success */
 static struct pwm_export *pwm_class_get_state(struct device *parent,
-- 
2.28.0

