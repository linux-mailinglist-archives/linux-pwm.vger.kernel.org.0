Return-Path: <linux-pwm+bounces-412-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F39806ED9
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1534A1F21132
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401213589E;
	Wed,  6 Dec 2023 11:49:07 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C68FD6F
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOQ-0007mD-OI; Wed, 06 Dec 2023 12:48:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOO-00DwyR-IW; Wed, 06 Dec 2023 12:48:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOO-00FR3v-9K; Wed, 06 Dec 2023 12:48:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 112/115] pwm: Ensure the memory backing a PWM chip isn't freed while used
Date: Wed,  6 Dec 2023 12:45:06 +0100
Message-ID:  <80bb35a80318e2f23345fbbd473206cef8613582.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=16030; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=0WeSMMyfI+7D5mSeikjYxjDOsDX8b09OOWsKL0qfYfA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF9mS+aTADh5GHU53R+ihEw2KG6vqPaip4aFn 5k7+BOct/yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfZgAKCRCPgPtYfRL+ ToGWB/9ivymaqrcU3n9MAueHkILemLqqGRe32D9TTXiMTHSxOyXc/5K7B7aY/mww/kA5CFOi3JM VlxetTlYNl3O75RRKWoQVlH6qdMQxgMEPpzLNWq1mkWirf6Fc3wGo6TKfQafZ5Jo6pnpypIOgOH sUbsTXwdY1bRS+ynB1c7K1Ie1CmkpXXjFSBqeE1gpfsIB0Nb0OAJVlScKBqUDqf+HYfGqQntD1A 1J5FGBf/wHqxPzAaO3nd+9Ci6gXRxXnQnuh9LDoHQvlqMe7kVBV+n2wXAn0e+pp7IrDFAaLSs59 L/OAbiGGxg06wm52U/LBZKuikdx8tJgya1TgKXq5+dTcfhl8
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The memory allocated to hold a struct pwm_chip is tied now to the struct
device that is added to struct pwm_chip. This way it's only freed when
the last reference is dropped.

Currently this isn't required yet as device links make sure that a
consumer is gone before the PWM chip goes away. However there are plans
to introduce character device support for PWM chips and with that in
place it can happen that a reference to a pwm_chip is held with its
driver going away.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/Kconfig  |   4 --
 drivers/pwm/Makefile |   3 +-
 drivers/pwm/core.c   | 127 +++++++++++++++++++++++++++++++------------
 drivers/pwm/sysfs.c  |  45 +++------------
 include/linux/pwm.h  |  17 ++----
 5 files changed, 105 insertions(+), 91 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4b956d661755..1dd7921194f5 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -29,10 +29,6 @@ menuconfig PWM
 
 if PWM
 
-config PWM_SYSFS
-	bool
-	default y if SYSFS
-
 config PWM_DEBUG
 	bool "PWM lowlevel drivers additional checks and debug messages"
 	depends on DEBUG_KERNEL
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c5ec9e168ee7..2aaaf92a7035 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PWM)		+= core.o
-obj-$(CONFIG_PWM_SYSFS)		+= sysfs.o
+obj-$(CONFIG_PWM)		+= core.o sysfs.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
 obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index b3ba08aa0b14..4805ccff5970 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -43,7 +43,7 @@ static struct pwm_chip *pwmchip_find_by_name(const char *name)
 	mutex_lock(&pwm_lock);
 
 	idr_for_each_entry_ul(&pwmchip_idr, chip, tmp, id) {
-		const char *chip_name = dev_name(chip->dev);
+		const char *chip_name = dev_name(chip->dev.parent);
 
 		if (chip_name && strcmp(chip_name, name) == 0) {
 			mutex_unlock(&pwm_lock);
@@ -65,13 +65,13 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 	if (test_bit(PWMF_REQUESTED, &pwm->flags))
 		return -EBUSY;
 
-	if (!try_module_get(chip->owner))
+	if (!get_device(&chip->dev))
 		return -ENODEV;
 
 	if (ops->request) {
 		err = ops->request(chip, pwm);
 		if (err) {
-			module_put(chip->owner);
+			put_device(&chip->dev);
 			return err;
 		}
 	}
@@ -161,13 +161,13 @@ EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
 
 static void of_pwmchip_add(struct pwm_chip *chip)
 {
-	if (!chip->dev || !chip->dev->of_node)
+	if (!chip->dev.parent || !chip->dev.parent->of_node)
 		return;
 
 	if (!chip->of_xlate) {
 		u32 pwm_cells;
 
-		if (of_property_read_u32(chip->dev->of_node, "#pwm-cells",
+		if (of_property_read_u32(chip->dev.parent->of_node, "#pwm-cells",
 					 &pwm_cells))
 			pwm_cells = 2;
 
@@ -175,13 +175,13 @@ static void of_pwmchip_add(struct pwm_chip *chip)
 		chip->of_pwm_n_cells = pwm_cells;
 	}
 
-	of_node_get(chip->dev->of_node);
+	of_node_get(chip->dev.parent->of_node);
 }
 
 static void of_pwmchip_remove(struct pwm_chip *chip)
 {
-	if (chip->dev)
-		of_node_put(chip->dev->of_node);
+	if (chip->dev.parent)
+		of_node_put(chip->dev.parent->of_node);
 }
 
 static bool pwm_ops_check(const struct pwm_chip *chip)
@@ -192,7 +192,7 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 		return false;
 
 	if (IS_ENABLED(CONFIG_PWM_DEBUG) && !ops->get_state)
-		dev_warn(chip->dev,
+		dev_warn(chip->dev.parent,
 			 "Please implement the .get_state() callback\n");
 
 	return true;
@@ -203,19 +203,33 @@ static void *pwmchip_priv(struct pwm_chip *chip)
 	return (void *)chip + struct_size(chip, pwms, chip->npwm);
 }
 
-struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv)
+static void pwmchip_release(struct device *dev)
+{
+	struct pwm_chip *chip = container_of(dev, struct pwm_chip, dev);
+
+	kfree(chip);
+}
+
+static struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv)
 {
 	struct pwm_chip *chip;
+	struct device *dev;
 	size_t alloc_size;
 	unsigned int i;
 
 	alloc_size = size_add(struct_size(chip, pwms, npwm), sizeof_priv);
 
-	chip = devm_kzalloc(parent, alloc_size, GFP_KERNEL);
+	chip = kzalloc(alloc_size, GFP_KERNEL);
 	if (!chip)
 		return ERR_PTR(-ENOMEM);
 
-	chip->dev = parent;
+	dev = &chip->dev;
+
+	device_initialize(dev);
+	dev->class = &pwm_class;
+	dev->parent = parent;
+	dev->release = pwmchip_release;
+
 	chip->npwm = npwm;
 	chip->uses_pwmchip_alloc = true;
 
@@ -230,6 +244,29 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
 
 	return chip;
 }
+
+static void devm_pwmchip_put(void *_chip)
+{
+	struct pwm_chip *chip = _chip;
+
+	put_device(&chip->dev);
+}
+
+struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv)
+{
+	struct pwm_chip *chip;
+	int ret;
+
+	chip = pwmchip_alloc(parent, npwm, sizeof_priv);
+	if (IS_ERR(chip))
+		return chip;
+
+	ret = devm_add_action_or_reset(parent, devm_pwmchip_put, chip);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return chip;
+}
 EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
 
 /**
@@ -246,7 +283,7 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 {
 	int ret;
 
-	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
+	if (!chip || !chip->dev.parent || !chip->ops || !chip->npwm)
 		return -EINVAL;
 
 	/*
@@ -262,25 +299,41 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 		return -EINVAL;
 
 	chip->owner = owner;
+	if (!try_module_get(owner))
+		return -EINVAL;
 
 	mutex_lock(&pwm_lock);
 
 	ret = idr_alloc(&pwmchip_idr, chip, 0, 0, GFP_KERNEL);
-	if (ret < 0) {
-		mutex_unlock(&pwm_lock);
-		return ret;
-	}
+	if (ret < 0)
+		goto err_idr_alloc;
 
 	chip->id = ret;
-
-	mutex_unlock(&pwm_lock);
+	dev_set_name(&chip->dev, "pwmchip%u", chip->id);
 
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_add(chip);
 
-	pwmchip_sysfs_export(chip);
+	ret = device_add(&chip->dev);
+	if (ret)
+		goto err_device_add;
+
+	mutex_unlock(&pwm_lock);
 
 	return 0;
+
+err_device_add:
+
+	if (IS_ENABLED(CONFIG_OF))
+		of_pwmchip_remove(chip);
+
+	idr_remove(&pwmchip_idr, chip->id);
+err_idr_alloc:
+
+	mutex_unlock(&pwm_lock);
+	module_put(owner);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__pwmchip_add);
 
@@ -302,6 +355,10 @@ void pwmchip_remove(struct pwm_chip *chip)
 	idr_remove(&pwmchip_idr, chip->id);
 
 	mutex_unlock(&pwm_lock);
+
+	module_put(chip->owner);
+
+	device_del(&chip->dev);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
@@ -398,18 +455,18 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 
 	if (s2.polarity != state->polarity &&
 	    state->duty_cycle < state->period)
-		dev_warn(chip->dev, ".apply ignored .polarity\n");
+		dev_warn(chip->dev.parent, ".apply ignored .polarity\n");
 
 	if (state->enabled &&
 	    last->polarity == state->polarity &&
 	    last->period > s2.period &&
 	    last->period <= state->period)
-		dev_warn(chip->dev,
+		dev_warn(chip->dev.parent,
 			 ".apply didn't pick the best available period (requested: %llu, applied: %llu, possible: %llu)\n",
 			 state->period, s2.period, last->period);
 
 	if (state->enabled && state->period < s2.period)
-		dev_warn(chip->dev,
+		dev_warn(chip->dev.parent,
 			 ".apply is supposed to round down period (requested: %llu, applied: %llu)\n",
 			 state->period, s2.period);
 
@@ -418,20 +475,20 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 	    last->period == s2.period &&
 	    last->duty_cycle > s2.duty_cycle &&
 	    last->duty_cycle <= state->duty_cycle)
-		dev_warn(chip->dev,
+		dev_warn(chip->dev.parent,
 			 ".apply didn't pick the best available duty cycle (requested: %llu/%llu, applied: %llu/%llu, possible: %llu/%llu)\n",
 			 state->duty_cycle, state->period,
 			 s2.duty_cycle, s2.period,
 			 last->duty_cycle, last->period);
 
 	if (state->enabled && state->duty_cycle < s2.duty_cycle)
-		dev_warn(chip->dev,
+		dev_warn(chip->dev.parent,
 			 ".apply is supposed to round down duty_cycle (requested: %llu/%llu, applied: %llu/%llu)\n",
 			 state->duty_cycle, state->period,
 			 s2.duty_cycle, s2.period);
 
 	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
-		dev_warn(chip->dev,
+		dev_warn(chip->dev.parent,
 			 "requested disabled, but yielded enabled with duty > 0\n");
 
 	/* reapply the state that the driver reported being configured. */
@@ -439,7 +496,7 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 	trace_pwm_apply(pwm, &s1, err);
 	if (err) {
 		*last = s1;
-		dev_err(chip->dev, "failed to reapply current setting\n");
+		dev_err(&chip->dev, "failed to reapply current setting\n");
 		return;
 	}
 
@@ -454,7 +511,7 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 	    s1.polarity != last->polarity ||
 	    (s1.enabled && s1.period != last->period) ||
 	    (s1.enabled && s1.duty_cycle != last->duty_cycle)) {
-		dev_err(chip->dev,
+		dev_err(&chip->dev,
 			".apply is not idempotent (ena=%d pol=%d %llu/%llu) -> (ena=%d pol=%d %llu/%llu)\n",
 			s1.enabled, s1.polarity, s1.duty_cycle, s1.period,
 			last->enabled, last->polarity, last->duty_cycle,
@@ -602,7 +659,7 @@ static struct pwm_chip *fwnode_to_pwmchip(struct fwnode_handle *fwnode)
 	mutex_lock(&pwm_lock);
 
 	idr_for_each_entry_ul(&pwmchip_idr, chip, tmp, id)
-		if (chip->dev && device_match_fwnode(chip->dev, fwnode)) {
+		if (device_match_fwnode(chip->dev.parent, fwnode)) {
 			mutex_unlock(&pwm_lock);
 			return chip;
 		}
@@ -623,15 +680,15 @@ static struct device_link *pwm_device_link_add(struct device *dev,
 		 * impact the PM sequence ordering: the PWM supplier may get
 		 * suspended before the consumer.
 		 */
-		dev_warn(pwm->chip->dev,
+		dev_warn(&pwm->chip->dev,
 			 "No consumer device specified to create a link to\n");
 		return NULL;
 	}
 
-	dl = device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+	dl = device_link_add(dev, pwm->chip->dev.parent, DL_FLAG_AUTOREMOVE_CONSUMER);
 	if (!dl) {
 		dev_err(dev, "failed to create device link to %s\n",
-			dev_name(pwm->chip->dev));
+			dev_name(pwm->chip->dev.parent));
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -953,7 +1010,7 @@ void pwm_put(struct pwm_device *pwm)
 
 	pwm->label = NULL;
 
-	module_put(pwm->chip->owner);
+	put_device(&pwm->chip->dev);
 out:
 	mutex_unlock(&pwm_lock);
 }
@@ -1093,8 +1150,8 @@ static int pwm_seq_show(struct seq_file *s, void *v)
 
 	seq_printf(s, "%s%d: %s/%s, %d PWM device%s\n",
 		   (char *)s->private, chip->id,
-		   chip->dev->bus ? chip->dev->bus->name : "no-bus",
-		   dev_name(chip->dev), chip->npwm,
+		   chip->dev.parent->bus ? chip->dev.parent->bus->name : "no-bus",
+		   dev_name(chip->dev.parent), chip->npwm,
 		   (chip->npwm != 1) ? "s" : "");
 
 	pwm_dbg_show(chip, s);
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 4edb994fa2e1..3a438b29c777 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -311,7 +311,7 @@ static ssize_t export_store(struct device *parent,
 			    struct device_attribute *attr,
 			    const char *buf, size_t len)
 {
-	struct pwm_chip *chip = dev_get_drvdata(parent);
+	struct pwm_chip *chip = container_of(parent, struct pwm_chip, dev);
 	struct pwm_device *pwm;
 	unsigned int hwpwm;
 	int ret;
@@ -339,7 +339,7 @@ static ssize_t unexport_store(struct device *parent,
 			      struct device_attribute *attr,
 			      const char *buf, size_t len)
 {
-	struct pwm_chip *chip = dev_get_drvdata(parent);
+	struct pwm_chip *chip = container_of(parent, struct pwm_chip, dev);
 	unsigned int hwpwm;
 	int ret;
 
@@ -359,7 +359,7 @@ static DEVICE_ATTR_WO(unexport);
 static ssize_t npwm_show(struct device *parent, struct device_attribute *attr,
 			 char *buf)
 {
-	const struct pwm_chip *chip = dev_get_drvdata(parent);
+	const struct pwm_chip *chip = container_of(parent, struct pwm_chip, dev);
 
 	return sysfs_emit(buf, "%u\n", chip->npwm);
 }
@@ -411,7 +411,7 @@ static int pwm_class_apply_state(struct pwm_export *export,
 
 static int pwm_class_resume_npwm(struct device *parent, unsigned int npwm)
 {
-	struct pwm_chip *chip = dev_get_drvdata(parent);
+	struct pwm_chip *chip = container_of(parent, struct pwm_chip, dev);
 	unsigned int i;
 	int ret = 0;
 
@@ -442,7 +442,7 @@ static int pwm_class_resume_npwm(struct device *parent, unsigned int npwm)
 
 static int pwm_class_suspend(struct device *parent)
 {
-	struct pwm_chip *chip = dev_get_drvdata(parent);
+	struct pwm_chip *chip = container_of(parent, struct pwm_chip, dev);
 	unsigned int i;
 	int ret = 0;
 
@@ -483,59 +483,30 @@ static int pwm_class_suspend(struct device *parent)
 
 static int pwm_class_resume(struct device *parent)
 {
-	struct pwm_chip *chip = dev_get_drvdata(parent);
+	struct pwm_chip *chip = container_of(parent, struct pwm_chip, dev);
 
 	return pwm_class_resume_npwm(parent, chip->npwm);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(pwm_class_pm_ops, pwm_class_suspend, pwm_class_resume);
 
-static struct class pwm_class = {
+struct class pwm_class = {
 	.name = "pwm",
 	.dev_groups = pwm_chip_groups,
 	.pm = pm_sleep_ptr(&pwm_class_pm_ops),
 };
 
-static int pwmchip_sysfs_match(struct device *parent, const void *data)
-{
-	return dev_get_drvdata(parent) == data;
-}
-
-void pwmchip_sysfs_export(struct pwm_chip *chip)
-{
-	struct device *parent;
-
-	/*
-	 * If device_create() fails the pwm_chip is still usable by
-	 * the kernel it's just not exported.
-	 */
-	parent = device_create(&pwm_class, chip->dev, MKDEV(0, 0), chip,
-			       "pwmchip%d", chip->id);
-	if (IS_ERR(parent)) {
-		dev_warn(chip->dev,
-			 "device_create failed for pwm_chip sysfs export\n");
-	}
-}
-
 void pwmchip_sysfs_unexport(struct pwm_chip *chip)
 {
-	struct device *parent;
+	struct device *parent = &chip->dev;
 	unsigned int i;
 
-	parent = class_find_device(&pwm_class, NULL, chip,
-				   pwmchip_sysfs_match);
-	if (!parent)
-		return;
-
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (test_bit(PWMF_EXPORTED, &pwm->flags))
 			pwm_unexport_child(parent, pwm);
 	}
-
-	put_device(parent);
-	device_unregister(parent);
 }
 
 static int __init pwm_sysfs_init(void)
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index eb91306ba28e..8b4aca36c35f 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_PWM_H
 #define __LINUX_PWM_H
 
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
@@ -289,7 +290,7 @@ struct pwm_ops {
  * @pwms: array of PWM devices allocated by the framework
  */
 struct pwm_chip {
-	struct device *dev;
+	struct device dev;
 	const struct pwm_ops *ops;
 	struct module *owner;
 	unsigned int id;
@@ -307,7 +308,7 @@ struct pwm_chip {
 
 static inline struct device *pwmchip_parent(struct pwm_chip *chip)
 {
-	return chip->dev;
+	return chip->dev.parent;
 }
 
 static inline void *pwmchip_get_drvdata(struct pwm_chip *chip)
@@ -592,17 +593,7 @@ static inline void pwm_remove_table(struct pwm_lookup *table, size_t num)
 }
 #endif
 
-#ifdef CONFIG_PWM_SYSFS
-void pwmchip_sysfs_export(struct pwm_chip *chip);
+extern struct class pwm_class;
 void pwmchip_sysfs_unexport(struct pwm_chip *chip);
-#else
-static inline void pwmchip_sysfs_export(struct pwm_chip *chip)
-{
-}
-
-static inline void pwmchip_sysfs_unexport(struct pwm_chip *chip)
-{
-}
-#endif /* CONFIG_PWM_SYSFS */
 
 #endif /* __LINUX_PWM_H */
-- 
2.42.0


