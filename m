Return-Path: <linux-pwm+bounces-946-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA0C83C1AF
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA7628FBD0
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C33405F9;
	Thu, 25 Jan 2024 12:10:45 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A26335EF1
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184645; cv=none; b=YamF3/Q2uGgYvVUYnP0iNAgVxHkJ5z71WLCPXNM78d1XK/bDJUHAGNlO2EIzL3DlN9CHbu8oPxtuyKwl3gvXMeu5Vx6hAHkBRLEyp/aquNuOaCeEjIzo/Nqy1gcLm7U1oNKsttXY300CIk7dzzFO1QMctTo7p47YUZ204x+nufg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184645; c=relaxed/simple;
	bh=1YeYYbTxvbqb1XWxBCxf+7wREZ7l4DZtVpKnKutJ1+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzPfh96VXosGT/RVTx/aw0DsJZSHksZeZ9s/V4Q6SlN+FLH2QLolxqX3GVMfmbLzi/CHbeTHreITAH506oRR5/e84t6ox5Uq9TYH8IuhLYNp9gKpEJItWjqFLYyFsEx6UJq2rZgIk367/vl3vYEjQFeRGtIhWYsHtm1h8zx3Ses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ6-0003ZI-EW; Thu, 25 Jan 2024 13:10:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ6-002HOl-1u; Thu, 25 Jan 2024 13:10:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ5-007my8-3A;
	Thu, 25 Jan 2024 13:10:39 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 001/111] pwm: Reorder symbols in core.c
Date: Thu, 25 Jan 2024 13:08:23 +0100
Message-ID:  <eed83de07bdfb69b5ceba0b9aed757ee612dea8f.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=17068; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1YeYYbTxvbqb1XWxBCxf+7wREZ7l4DZtVpKnKutJ1+M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk86ZOyp84J7Q4AWsuWtmNn/JkUHyRes5dcvv Mw4VKQzTF6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPOgAKCRCPgPtYfRL+ Tux4B/4xsnKUwDu+41hUmtgDW1L/bfs1J9Rwh84AHG5Z65Bg4b4+q1m6v229v46ZWLyV/6EUfNU zQ2kATKzbJjOGRnotg2LdZgLtcORgtpdU1NGZVtX8Pyzg9D4qnywzEn65Qk1a+D5/xUBa45tO/s +UoOVb/gQprd16/+JlD/JkTla3XNC3CM5JAf8yNcr1YnkbJzOOheTXml0ht7Cqf/yg/yZhcte/2 8KIAhnXtpdnp+PEa7SauA4A8T3gLpPuQ398aKWP9dMGR6FzxmVQpI+7EVFncdpIo92Kt0u3+aqP jgJxm+juq4brh0ieyUF2SA1DmLQ+Z4/KKsMtqY3cXyWMXNRe
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This moves the functions called by pwm consumers above the functions
called by pwm providers. When character device support is added later
this is hooked into the chip registration functions. As the needed
callbacks are a kind of consumer and make use of the consumer functions,
having this order is more natural and prevents having to add
declarations for static functions.

Also move the global variables for pwm tables to the respective
functions to have them properly grouped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 619 +++++++++++++++++++++++----------------------
 1 file changed, 310 insertions(+), 309 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index b025d90e201c..1b4c3d0caa82 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -24,289 +24,11 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/pwm.h>
 
-static DEFINE_MUTEX(pwm_lookup_lock);
-static LIST_HEAD(pwm_lookup_list);
-
 /* protects access to pwm_chips */
 static DEFINE_MUTEX(pwm_lock);
 
 static DEFINE_IDR(pwm_chips);
 
-static struct pwm_chip *pwmchip_find_by_name(const char *name)
-{
-	struct pwm_chip *chip;
-	unsigned long id, tmp;
-
-	if (!name)
-		return NULL;
-
-	mutex_lock(&pwm_lock);
-
-	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id) {
-		const char *chip_name = dev_name(chip->dev);
-
-		if (chip_name && strcmp(chip_name, name) == 0) {
-			mutex_unlock(&pwm_lock);
-			return chip;
-		}
-	}
-
-	mutex_unlock(&pwm_lock);
-
-	return NULL;
-}
-
-static int pwm_device_request(struct pwm_device *pwm, const char *label)
-{
-	int err;
-	struct pwm_chip *chip = pwm->chip;
-	const struct pwm_ops *ops = chip->ops;
-
-	if (test_bit(PWMF_REQUESTED, &pwm->flags))
-		return -EBUSY;
-
-	if (!try_module_get(chip->owner))
-		return -ENODEV;
-
-	if (ops->request) {
-		err = ops->request(chip, pwm);
-		if (err) {
-			module_put(chip->owner);
-			return err;
-		}
-	}
-
-	if (ops->get_state) {
-		/*
-		 * Zero-initialize state because most drivers are unaware of
-		 * .usage_power. The other members of state are supposed to be
-		 * set by lowlevel drivers. We still initialize the whole
-		 * structure for simplicity even though this might paper over
-		 * faulty implementations of .get_state().
-		 */
-		struct pwm_state state = { 0, };
-
-		err = ops->get_state(chip, pwm, &state);
-		trace_pwm_get(pwm, &state, err);
-
-		if (!err)
-			pwm->state = state;
-
-		if (IS_ENABLED(CONFIG_PWM_DEBUG))
-			pwm->last = pwm->state;
-	}
-
-	set_bit(PWMF_REQUESTED, &pwm->flags);
-	pwm->label = label;
-
-	return 0;
-}
-
-struct pwm_device *
-of_pwm_xlate_with_flags(struct pwm_chip *chip, const struct of_phandle_args *args)
-{
-	struct pwm_device *pwm;
-
-	/* period in the second cell and flags in the third cell are optional */
-	if (args->args_count < 1)
-		return ERR_PTR(-EINVAL);
-
-	pwm = pwm_request_from_chip(chip, args->args[0], NULL);
-	if (IS_ERR(pwm))
-		return pwm;
-
-	if (args->args_count > 1)
-		pwm->args.period = args->args[1];
-
-	pwm->args.polarity = PWM_POLARITY_NORMAL;
-	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
-		pwm->args.polarity = PWM_POLARITY_INVERSED;
-
-	return pwm;
-}
-EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
-
-struct pwm_device *
-of_pwm_single_xlate(struct pwm_chip *chip, const struct of_phandle_args *args)
-{
-	struct pwm_device *pwm;
-
-	pwm = pwm_request_from_chip(chip, 0, NULL);
-	if (IS_ERR(pwm))
-		return pwm;
-
-	if (args->args_count > 1)
-		pwm->args.period = args->args[0];
-
-	pwm->args.polarity = PWM_POLARITY_NORMAL;
-	if (args->args_count > 1 && args->args[1] & PWM_POLARITY_INVERTED)
-		pwm->args.polarity = PWM_POLARITY_INVERSED;
-
-	return pwm;
-}
-EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
-
-static void of_pwmchip_add(struct pwm_chip *chip)
-{
-	if (!chip->dev || !chip->dev->of_node)
-		return;
-
-	if (!chip->of_xlate)
-		chip->of_xlate = of_pwm_xlate_with_flags;
-
-	of_node_get(chip->dev->of_node);
-}
-
-static void of_pwmchip_remove(struct pwm_chip *chip)
-{
-	if (chip->dev)
-		of_node_put(chip->dev->of_node);
-}
-
-static bool pwm_ops_check(const struct pwm_chip *chip)
-{
-	const struct pwm_ops *ops = chip->ops;
-
-	if (!ops->apply)
-		return false;
-
-	if (IS_ENABLED(CONFIG_PWM_DEBUG) && !ops->get_state)
-		dev_warn(chip->dev,
-			 "Please implement the .get_state() callback\n");
-
-	return true;
-}
-
-/**
- * __pwmchip_add() - register a new PWM chip
- * @chip: the PWM chip to add
- * @owner: reference to the module providing the chip.
- *
- * Register a new PWM chip. @owner is supposed to be THIS_MODULE, use the
- * pwmchip_add wrapper to do this right.
- *
- * Returns: 0 on success or a negative error code on failure.
- */
-int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
-{
-	unsigned int i;
-	int ret;
-
-	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
-		return -EINVAL;
-
-	if (!pwm_ops_check(chip))
-		return -EINVAL;
-
-	chip->owner = owner;
-
-	chip->pwms = kcalloc(chip->npwm, sizeof(*chip->pwms), GFP_KERNEL);
-	if (!chip->pwms)
-		return -ENOMEM;
-
-	mutex_lock(&pwm_lock);
-
-	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
-	if (ret < 0) {
-		mutex_unlock(&pwm_lock);
-		kfree(chip->pwms);
-		return ret;
-	}
-
-	chip->id = ret;
-
-	for (i = 0; i < chip->npwm; i++) {
-		struct pwm_device *pwm = &chip->pwms[i];
-
-		pwm->chip = chip;
-		pwm->hwpwm = i;
-	}
-
-	mutex_unlock(&pwm_lock);
-
-	if (IS_ENABLED(CONFIG_OF))
-		of_pwmchip_add(chip);
-
-	pwmchip_sysfs_export(chip);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(__pwmchip_add);
-
-/**
- * pwmchip_remove() - remove a PWM chip
- * @chip: the PWM chip to remove
- *
- * Removes a PWM chip.
- */
-void pwmchip_remove(struct pwm_chip *chip)
-{
-	pwmchip_sysfs_unexport(chip);
-
-	if (IS_ENABLED(CONFIG_OF))
-		of_pwmchip_remove(chip);
-
-	mutex_lock(&pwm_lock);
-
-	idr_remove(&pwm_chips, chip->id);
-
-	mutex_unlock(&pwm_lock);
-
-	kfree(chip->pwms);
-}
-EXPORT_SYMBOL_GPL(pwmchip_remove);
-
-static void devm_pwmchip_remove(void *data)
-{
-	struct pwm_chip *chip = data;
-
-	pwmchip_remove(chip);
-}
-
-int __devm_pwmchip_add(struct device *dev, struct pwm_chip *chip, struct module *owner)
-{
-	int ret;
-
-	ret = __pwmchip_add(chip, owner);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, devm_pwmchip_remove, chip);
-}
-EXPORT_SYMBOL_GPL(__devm_pwmchip_add);
-
-/**
- * pwm_request_from_chip() - request a PWM device relative to a PWM chip
- * @chip: PWM chip
- * @index: per-chip index of the PWM to request
- * @label: a literal description string of this PWM
- *
- * Returns: A pointer to the PWM device at the given index of the given PWM
- * chip. A negative error code is returned if the index is not valid for the
- * specified PWM chip or if the PWM device cannot be requested.
- */
-struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
-					 unsigned int index,
-					 const char *label)
-{
-	struct pwm_device *pwm;
-	int err;
-
-	if (!chip || index >= chip->npwm)
-		return ERR_PTR(-EINVAL);
-
-	mutex_lock(&pwm_lock);
-	pwm = &chip->pwms[index];
-
-	err = pwm_device_request(pwm, label);
-	if (err < 0)
-		pwm = ERR_PTR(err);
-
-	mutex_unlock(&pwm_lock);
-	return pwm;
-}
-EXPORT_SYMBOL_GPL(pwm_request_from_chip);
-
 static void pwm_apply_debug(struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
@@ -502,33 +224,6 @@ int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
 }
 EXPORT_SYMBOL_GPL(pwm_apply_atomic);
 
-/**
- * pwm_capture() - capture and report a PWM signal
- * @pwm: PWM device
- * @result: structure to fill with capture result
- * @timeout: time to wait, in milliseconds, before giving up on capture
- *
- * Returns: 0 on success or a negative error code on failure.
- */
-int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
-		unsigned long timeout)
-{
-	int err;
-
-	if (!pwm || !pwm->chip->ops)
-		return -EINVAL;
-
-	if (!pwm->chip->ops->capture)
-		return -ENOSYS;
-
-	mutex_lock(&pwm_lock);
-	err = pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
-	mutex_unlock(&pwm_lock);
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(pwm_capture);
-
 /**
  * pwm_adjust_config() - adjust the current PWM config to the PWM arguments
  * @pwm: PWM device
@@ -585,24 +280,309 @@ int pwm_adjust_config(struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(pwm_adjust_config);
 
-static struct pwm_chip *fwnode_to_pwmchip(struct fwnode_handle *fwnode)
+/**
+ * pwm_capture() - capture and report a PWM signal
+ * @pwm: PWM device
+ * @result: structure to fill with capture result
+ * @timeout: time to wait, in milliseconds, before giving up on capture
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
+		unsigned long timeout)
+{
+	int err;
+
+	if (!pwm || !pwm->chip->ops)
+		return -EINVAL;
+
+	if (!pwm->chip->ops->capture)
+		return -ENOSYS;
+
+	mutex_lock(&pwm_lock);
+	err = pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
+	mutex_unlock(&pwm_lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(pwm_capture);
+
+static struct pwm_chip *pwmchip_find_by_name(const char *name)
 {
 	struct pwm_chip *chip;
 	unsigned long id, tmp;
 
+	if (!name)
+		return NULL;
+
 	mutex_lock(&pwm_lock);
 
-	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id)
-		if (chip->dev && device_match_fwnode(chip->dev, fwnode)) {
+	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id) {
+		const char *chip_name = dev_name(chip->dev);
+
+		if (chip_name && strcmp(chip_name, name) == 0) {
 			mutex_unlock(&pwm_lock);
 			return chip;
 		}
+	}
 
 	mutex_unlock(&pwm_lock);
 
-	return ERR_PTR(-EPROBE_DEFER);
+	return NULL;
 }
 
+static int pwm_device_request(struct pwm_device *pwm, const char *label)
+{
+	int err;
+	struct pwm_chip *chip = pwm->chip;
+	const struct pwm_ops *ops = chip->ops;
+
+	if (test_bit(PWMF_REQUESTED, &pwm->flags))
+		return -EBUSY;
+
+	if (!try_module_get(chip->owner))
+		return -ENODEV;
+
+	if (ops->request) {
+		err = ops->request(chip, pwm);
+		if (err) {
+			module_put(chip->owner);
+			return err;
+		}
+	}
+
+	if (ops->get_state) {
+		/*
+		 * Zero-initialize state because most drivers are unaware of
+		 * .usage_power. The other members of state are supposed to be
+		 * set by lowlevel drivers. We still initialize the whole
+		 * structure for simplicity even though this might paper over
+		 * faulty implementations of .get_state().
+		 */
+		struct pwm_state state = { 0, };
+
+		err = ops->get_state(chip, pwm, &state);
+		trace_pwm_get(pwm, &state, err);
+
+		if (!err)
+			pwm->state = state;
+
+		if (IS_ENABLED(CONFIG_PWM_DEBUG))
+			pwm->last = pwm->state;
+	}
+
+	set_bit(PWMF_REQUESTED, &pwm->flags);
+	pwm->label = label;
+
+	return 0;
+}
+
+/**
+ * pwm_request_from_chip() - request a PWM device relative to a PWM chip
+ * @chip: PWM chip
+ * @index: per-chip index of the PWM to request
+ * @label: a literal description string of this PWM
+ *
+ * Returns: A pointer to the PWM device at the given index of the given PWM
+ * chip. A negative error code is returned if the index is not valid for the
+ * specified PWM chip or if the PWM device cannot be requested.
+ */
+struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
+					 unsigned int index,
+					 const char *label)
+{
+	struct pwm_device *pwm;
+	int err;
+
+	if (!chip || index >= chip->npwm)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&pwm_lock);
+	pwm = &chip->pwms[index];
+
+	err = pwm_device_request(pwm, label);
+	if (err < 0)
+		pwm = ERR_PTR(err);
+
+	mutex_unlock(&pwm_lock);
+	return pwm;
+}
+EXPORT_SYMBOL_GPL(pwm_request_from_chip);
+
+
+struct pwm_device *
+of_pwm_xlate_with_flags(struct pwm_chip *chip, const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
+
+	/* period in the second cell and flags in the third cell are optional */
+	if (args->args_count < 1)
+		return ERR_PTR(-EINVAL);
+
+	pwm = pwm_request_from_chip(chip, args->args[0], NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	if (args->args_count > 1)
+		pwm->args.period = args->args[1];
+
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
+	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
+		pwm->args.polarity = PWM_POLARITY_INVERSED;
+
+	return pwm;
+}
+EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
+
+struct pwm_device *
+of_pwm_single_xlate(struct pwm_chip *chip, const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
+
+	pwm = pwm_request_from_chip(chip, 0, NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	if (args->args_count > 1)
+		pwm->args.period = args->args[0];
+
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
+	if (args->args_count > 1 && args->args[1] & PWM_POLARITY_INVERTED)
+		pwm->args.polarity = PWM_POLARITY_INVERSED;
+
+	return pwm;
+}
+EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
+
+static void of_pwmchip_add(struct pwm_chip *chip)
+{
+	if (!chip->dev || !chip->dev->of_node)
+		return;
+
+	if (!chip->of_xlate)
+		chip->of_xlate = of_pwm_xlate_with_flags;
+
+	of_node_get(chip->dev->of_node);
+}
+
+static void of_pwmchip_remove(struct pwm_chip *chip)
+{
+	if (chip->dev)
+		of_node_put(chip->dev->of_node);
+}
+
+static bool pwm_ops_check(const struct pwm_chip *chip)
+{
+	const struct pwm_ops *ops = chip->ops;
+
+	if (!ops->apply)
+		return false;
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && !ops->get_state)
+		dev_warn(chip->dev,
+			 "Please implement the .get_state() callback\n");
+
+	return true;
+}
+
+/**
+ * __pwmchip_add() - register a new PWM chip
+ * @chip: the PWM chip to add
+ * @owner: reference to the module providing the chip.
+ *
+ * Register a new PWM chip. @owner is supposed to be THIS_MODULE, use the
+ * pwmchip_add wrapper to do this right.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
+{
+	unsigned int i;
+	int ret;
+
+	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
+		return -EINVAL;
+
+	if (!pwm_ops_check(chip))
+		return -EINVAL;
+
+	chip->owner = owner;
+
+	chip->pwms = kcalloc(chip->npwm, sizeof(*chip->pwms), GFP_KERNEL);
+	if (!chip->pwms)
+		return -ENOMEM;
+
+	mutex_lock(&pwm_lock);
+
+	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
+	if (ret < 0) {
+		mutex_unlock(&pwm_lock);
+		kfree(chip->pwms);
+		return ret;
+	}
+
+	chip->id = ret;
+
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+
+		pwm->chip = chip;
+		pwm->hwpwm = i;
+	}
+
+	mutex_unlock(&pwm_lock);
+
+	if (IS_ENABLED(CONFIG_OF))
+		of_pwmchip_add(chip);
+
+	pwmchip_sysfs_export(chip);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__pwmchip_add);
+
+/**
+ * pwmchip_remove() - remove a PWM chip
+ * @chip: the PWM chip to remove
+ *
+ * Removes a PWM chip.
+ */
+void pwmchip_remove(struct pwm_chip *chip)
+{
+	pwmchip_sysfs_unexport(chip);
+
+	if (IS_ENABLED(CONFIG_OF))
+		of_pwmchip_remove(chip);
+
+	mutex_lock(&pwm_lock);
+
+	idr_remove(&pwm_chips, chip->id);
+
+	mutex_unlock(&pwm_lock);
+
+	kfree(chip->pwms);
+}
+EXPORT_SYMBOL_GPL(pwmchip_remove);
+
+static void devm_pwmchip_remove(void *data)
+{
+	struct pwm_chip *chip = data;
+
+	pwmchip_remove(chip);
+}
+
+int __devm_pwmchip_add(struct device *dev, struct pwm_chip *chip, struct module *owner)
+{
+	int ret;
+
+	ret = __pwmchip_add(chip, owner);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_pwmchip_remove, chip);
+}
+EXPORT_SYMBOL_GPL(__devm_pwmchip_add);
+
 static struct device_link *pwm_device_link_add(struct device *dev,
 					       struct pwm_device *pwm)
 {
@@ -629,6 +609,24 @@ static struct device_link *pwm_device_link_add(struct device *dev,
 	return dl;
 }
 
+static struct pwm_chip *fwnode_to_pwmchip(struct fwnode_handle *fwnode)
+{
+	struct pwm_chip *chip;
+	unsigned long id, tmp;
+
+	mutex_lock(&pwm_lock);
+
+	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id)
+		if (chip->dev && device_match_fwnode(chip->dev, fwnode)) {
+			mutex_unlock(&pwm_lock);
+			return chip;
+		}
+
+	mutex_unlock(&pwm_lock);
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
 /**
  * of_pwm_get() - request a PWM via the PWM framework
  * @dev: device for PWM consumer
@@ -763,6 +761,9 @@ static struct pwm_device *acpi_pwm_get(const struct fwnode_handle *fwnode)
 	return pwm;
 }
 
+static DEFINE_MUTEX(pwm_lookup_lock);
+static LIST_HEAD(pwm_lookup_list);
+
 /**
  * pwm_add_table() - register PWM device consumers
  * @table: array of consumers to register
-- 
2.43.0


