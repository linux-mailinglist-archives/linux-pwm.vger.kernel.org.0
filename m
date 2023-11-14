Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CBF7EAEBF
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 12:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjKNLUg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 06:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjKNLUe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 06:20:34 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885D318C
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 03:20:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rT3-0002us-11; Tue, 14 Nov 2023 12:20:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rT2-008yr4-KW; Tue, 14 Nov 2023 12:20:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rT2-001JwJ-BU; Tue, 14 Nov 2023 12:20:28 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/3] pwm: Replace PWM chip unique base by unique ID
Date:   Tue, 14 Nov 2023 12:20:12 +0100
Message-ID: <20231114112009.340168-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231114112009.340168-1-u.kleine-koenig@pengutronix.de>
References: <20231114112009.340168-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6133; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0wG0DaCl23Lz1WfBhyOqzwA46w/GnlhADCnP8c7kCRI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlU1frdixFcjZnmhUM6+zvInPgp3OR9yuZQBss7 aK2dbQLi+iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVNX6wAKCRCPgPtYfRL+ TuVBB/9DPsTRaGYjzF52wFcNQFv8yGryxA1H6wgEVn31Bgjg/Dm+WdcvAOKbPGVdxTgGdSNEWZa 5eT5SGD/Ic+TXruxUlFSPUMt0eCxduSWiRDZCbZA7hek1g/srv2zTZBKhzGKB4K9dsvWEtHk2Yd n3UUFPBFgNePVNJOEEq3YamJ8ALqXdWGP3RU79Rtov7KDdFAEAaX0NKvPYSf3wQUAhzZYzz15Wy djMO8YK13JxgA+3G9pcMrtwubLoPcn3u3QvvY4Y8+Pnd8ta49OEYb6gWOB5UZmb5F2h25czgygi ecHyNo1sxHwec8hq+aOXRuH8ktgN7D3bwxO26NnmgUwVn1vO
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Traditionally each PWM device had a unique ID stored in the "pwm" member
of struct pwm_device. However this number was hardly used and dropped
in the previous commit. To identify a certain PWM you're supposed to use
the chip's ID and the hwpwm of the PWM device now.

With the PWM chip base gone PWM chips can get their IDs better and
simpler using an idr.

This is expected to change the numbering of PWM chips, but nothing
should rely on the numbering anyhow.

Other than that the side effects are:

 - The PWM chip IDs are smaller and in most cases consecutive.
 - The ordering in /sys/kernel/debug/pwm is ordered by ascending PWM
   chip ID.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 67 +++++++++++++++++----------------------------
 drivers/pwm/sysfs.c |  2 +-
 include/linux/pwm.h |  3 +-
 3 files changed, 27 insertions(+), 45 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 24bb796d15f6..586277c3eee4 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -8,6 +8,7 @@
 
 #include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/idr.h>
 #include <linux/of.h>
 #include <linux/pwm.h>
 #include <linux/list.h>
@@ -23,52 +24,25 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/pwm.h>
 
-#define MAX_PWMS 1024
-
 static DEFINE_MUTEX(pwm_lookup_lock);
 static LIST_HEAD(pwm_lookup_list);
 
-/* protects access to pwm_chips and allocated_pwms */
+/* protects access to pwmchip_idr */
 static DEFINE_MUTEX(pwm_lock);
 
-static LIST_HEAD(pwm_chips);
-static DECLARE_BITMAP(allocated_pwms, MAX_PWMS);
-
-/* Called with pwm_lock held */
-static int alloc_pwms(unsigned int count)
-{
-	unsigned int start;
-
-	start = bitmap_find_next_zero_area(allocated_pwms, MAX_PWMS, 0,
-					   count, 0);
-
-	if (start + count > MAX_PWMS)
-		return -ENOSPC;
-
-	bitmap_set(allocated_pwms, start, count);
-
-	return start;
-}
-
-/* Called with pwm_lock held */
-static void free_pwms(struct pwm_chip *chip)
-{
-	bitmap_clear(allocated_pwms, chip->base, chip->npwm);
-
-	kfree(chip->pwms);
-	chip->pwms = NULL;
-}
+static DEFINE_IDR(pwmchip_idr);
 
 static struct pwm_chip *pwmchip_find_by_name(const char *name)
 {
 	struct pwm_chip *chip;
+	unsigned long id, tmp;
 
 	if (!name)
 		return NULL;
 
 	mutex_lock(&pwm_lock);
 
-	list_for_each_entry(chip, &pwm_chips, list) {
+	idr_for_each_entry_ul(&pwmchip_idr, chip, tmp, id) {
 		const char *chip_name = dev_name(chip->dev);
 
 		if (chip_name && strcmp(chip_name, name) == 0) {
@@ -252,14 +226,14 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	mutex_lock(&pwm_lock);
 
-	ret = alloc_pwms(chip->npwm);
+	ret = idr_alloc(&pwmchip_idr, chip, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		mutex_unlock(&pwm_lock);
 		kfree(chip->pwms);
 		return ret;
 	}
 
-	chip->base = ret;
+	chip->id = ret;
 
 	for (i = 0; i < chip->npwm; i++) {
 		pwm = &chip->pwms[i];
@@ -268,8 +242,6 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 		pwm->hwpwm = i;
 	}
 
-	list_add(&chip->list, &pwm_chips);
-
 	mutex_unlock(&pwm_lock);
 
 	if (IS_ENABLED(CONFIG_OF))
@@ -296,11 +268,11 @@ void pwmchip_remove(struct pwm_chip *chip)
 
 	mutex_lock(&pwm_lock);
 
-	list_del_init(&chip->list);
-
-	free_pwms(chip);
+	idr_remove(&pwmchip_idr, chip->id);
 
 	mutex_unlock(&pwm_lock);
+
+	kfree(chip->pwms);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
@@ -596,10 +568,11 @@ EXPORT_SYMBOL_GPL(pwm_adjust_config);
 static struct pwm_chip *fwnode_to_pwmchip(struct fwnode_handle *fwnode)
 {
 	struct pwm_chip *chip;
+	unsigned long id, tmp;
 
 	mutex_lock(&pwm_lock);
 
-	list_for_each_entry(chip, &pwm_chips, list)
+	idr_for_each_entry_ul(&pwmchip_idr, chip, tmp, id)
 		if (chip->dev && device_match_fwnode(chip->dev, fwnode)) {
 			mutex_unlock(&pwm_lock);
 			return chip;
@@ -1057,17 +1030,27 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 
 static void *pwm_seq_start(struct seq_file *s, loff_t *pos)
 {
+	unsigned long id = *pos;
+	void *ret;
+
 	mutex_lock(&pwm_lock);
 	s->private = "";
 
-	return seq_list_start(&pwm_chips, *pos);
+	ret = idr_get_next_ul(&pwmchip_idr, &id);
+	*pos = id;
+	return ret;
 }
 
 static void *pwm_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
+	unsigned long id = *pos + 1;
+	void *ret;
+
 	s->private = "\n";
 
-	return seq_list_next(v, &pwm_chips, pos);
+	ret = idr_get_next_ul(&pwmchip_idr, &id);
+	*pos = id;
+	return ret;
 }
 
 static void pwm_seq_stop(struct seq_file *s, void *v)
@@ -1077,7 +1060,7 @@ static void pwm_seq_stop(struct seq_file *s, void *v)
 
 static int pwm_seq_show(struct seq_file *s, void *v)
 {
-	struct pwm_chip *chip = list_entry(v, struct pwm_chip, list);
+	struct pwm_chip *chip = v;
 
 	seq_printf(s, "%s%s/%s, %d PWM device%s\n", (char *)s->private,
 		   chip->dev->bus ? chip->dev->bus->name : "no-bus",
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 8d1254761e4d..4edb994fa2e1 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -510,7 +510,7 @@ void pwmchip_sysfs_export(struct pwm_chip *chip)
 	 * the kernel it's just not exported.
 	 */
 	parent = device_create(&pwm_class, chip->dev, MKDEV(0, 0), chip,
-			       "pwmchip%d", chip->base);
+			       "pwmchip%d", chip->id);
 	if (IS_ERR(parent)) {
 		dev_warn(chip->dev,
 			 "device_create failed for pwm_chip sysfs export\n");
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 8cadf9ee8d26..c27a4bb76012 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -292,7 +292,7 @@ struct pwm_chip {
 	struct device *dev;
 	const struct pwm_ops *ops;
 	struct module *owner;
-	int base;
+	unsigned int id;
 	unsigned int npwm;
 
 	struct pwm_device * (*of_xlate)(struct pwm_chip *chip,
@@ -300,7 +300,6 @@ struct pwm_chip {
 	unsigned int of_pwm_n_cells;
 
 	/* only used internally by the PWM framework */
-	struct list_head list;
 	struct pwm_device *pwms;
 };
 
-- 
2.42.0

