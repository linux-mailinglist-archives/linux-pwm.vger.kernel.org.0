Return-Path: <linux-pwm+bounces-3305-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D037D97D336
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 11:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7A01F26416
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 09:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E0813E02B;
	Fri, 20 Sep 2024 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="08swwj1R"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC72E13C810
	for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822733; cv=none; b=FFLDGJHzi7YfsUvpkV3+duv4RHxhI9foH8/7FRf+5OmNU5HMojCo4UWTuQGsETg0INIj7Nur5TeJAhahB2EfCBHgr/eUclSSGu3O5xz/08/xf/h8GrgoxmkXJp5Hy7uzxPsFBLZZLdD70jlKJDEknz/oTXi3tb73I2JxdS981ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822733; c=relaxed/simple;
	bh=u1lBSyY6qYK+SxoNMoz1RD+fsFtj7+ZFHuzaV93Ce24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H118HiEtV642UjH3H0Ll+HVywZa/b9+6VyiSIa98jSjif/ee53vtivkr1QaYYfWaxepP0fG5+3opu6hHxVsPA1PXGqZukhZowrkP6yliVJbj/WQZcUdswPWSRZutPVaXWLHuZ4+ze4x0CgblH0WXaAIfLUFs3MpFNKeHEs6yrwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=08swwj1R; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cafda818aso16198005e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 01:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726822730; x=1727427530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qZNEW7jIV2Looori87SEdf/xGTsIl5IUfGCSmv77mw=;
        b=08swwj1RA/BdIuZu4FNmdvMIAW2JfbSrHSiqcdWqPCMRTUydytdpPgkUzu1Vi7ln8p
         Z7NTKolkoaZl5CnJfuugVm5nUsEuz89fbPXqmKzzvOxdzNdepW9EdMUIfcadFd8vAIlO
         HVwq4G+cOQYoR5ct0uf9ZhbgUv+iLC+1j1nNFEhRehM4wKNLe6VaFRw4t47bVlrD4nxf
         pQrrwUaYRmzYLlOMjpj9icyBUw/LcHl0I3pL080HEBUg5QlwaSWSiYAYGjiOG2JCeuzK
         OwnljLJG7DEd0TQRoSoo8LBaPsoMm6w8zvxW/sC4yKpra1wRXELE6FxxsaEOHV3Ix0bO
         Ly6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726822730; x=1727427530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qZNEW7jIV2Looori87SEdf/xGTsIl5IUfGCSmv77mw=;
        b=w8HLbWb9y2V1HL+m7eIXQHNCLL6tPto1uJgK6cUoyuHFO6Vp5rv1nUzA/DDevH/RqH
         +OxRiZay7gXUceAdRzAnFSb9GaVwHSFqZdbcuseY9mlWRBcqEL63kxUdN39Iz/nBfJuU
         FUAdfptwrZMNmSS35zr5lkMd3ac3TRxTMZDZjSsa7AgozsD75/ZeP1gV1A9EfPIQ0bfX
         5YeH/OtSqKVJWCk0RE4ZJnOnQZ0Q6UNn3dB/l7Vpw+gpZRZRg3NnmX2jfyFJ39gmj94v
         SgUezHWBqIkdqLh2uuxO8w19k7LBmDImJxfHjJ7zNYM6JnKbsjKNWX38FBLAsYM7+y7i
         a1aQ==
X-Gm-Message-State: AOJu0YyfvHcGNLynhtJqax5f4vexiF9v59z6kM7tmooaLuGgWhF25m+3
	H+AG+kePkOsA82byRjAVPu2aC5/vsWZuyrRF35QVEnhn+5IoAmAIK9XmUdLwxtV36UxDB2frqdQ
	J
X-Google-Smtp-Source: AGHT+IF55LuUzSxMhyIFaFbrMCMTjVyZvCC4hx/7yzr1qmDt0FUtDGz2wOYMslizPyvVR8roYpO/CA==
X-Received: by 2002:a05:600c:8718:b0:42c:b4f2:7c30 with SMTP id 5b1f17b1804b1-42e7c1a2e78mr11881865e9.23.1726822729815;
        Fri, 20 Sep 2024 01:58:49 -0700 (PDT)
Received: from localhost (p200300f65f01db004d6a46a6454a1385.dip0.t-ipconnect.de. [2003:f6:5f01:db00:4d6a:46a6:454a:1385])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754a6379sm43416545e9.35.2024.09.20.01.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:58:49 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v5 7/8] pwm: Reorder symbols in core.c
Date: Fri, 20 Sep 2024 10:58:03 +0200
Message-ID:  <193b3d933294da34e020650bff93b778de46b1c5.1726819463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8872; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=u1lBSyY6qYK+SxoNMoz1RD+fsFtj7+ZFHuzaV93Ce24=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm7TknaHQg2Lhk52KXKNo1rq6kCrrKxw3agU7vg LmPJ41ZOWiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZu05JwAKCRCPgPtYfRL+ Tt0cCACqfef4j6lanqubIi3MqQacVryZfFOk/JA11n8hQf+q95WcAgVYY+saCQE/wzQ4B64aNHg aPKQozUrzJQpZzGJ91iDwHmOF2QQbLQ4VWsVEH8877z+TU17tT7bH0lQo6c/XFgie07DMZYb+S+ RwOc5Pd4S3ysKu9YvrKqe+oWHopTkX9wD5st7UDC89WVfTuP9StPC6x0UJ/GZlpM5izNgeTu3I3 pLcZLjE1u+eg0vdpbe8Zo0FNpGy++ycmQqVRp/JX/O7vdt5v5FAP9rKAYuWPYCQbd6OCbyLub96 1rIedV1lC2jrmwMKH8FgxUM5QlNBTdaXaH2wwfExDm7+e8Xm
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This moves pwm_get() and friends above the functions handling
registration of pwmchips. The motivation is that character device
support needs pwm_get() and pwm_put() and so ideally is defined below
these and when a pwmchip is registered this registers the character
device. So the natural order is

	pwm_get() and friend
	pwm character device symbols
	pwm_chip functions

. The advantage of having these in their natural order is that static
functions don't need to be forward declared.

Note that the diff that git produces for this change some functions are
moved down instead. This is technically equivalent, but not how this
change was created.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 312 ++++++++++++++++++++++-----------------------
 1 file changed, 156 insertions(+), 156 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index b688c72aba1f..ed620e35db61 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1615,132 +1615,6 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 	return true;
 }
 
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
-	int ret;
-
-	if (!chip || !pwmchip_parent(chip) || !chip->ops || !chip->npwm)
-		return -EINVAL;
-
-	/*
-	 * a struct pwm_chip must be allocated using (devm_)pwmchip_alloc,
-	 * otherwise the embedded struct device might disappear too early
-	 * resulting in memory corruption.
-	 * Catch drivers that were not converted appropriately.
-	 */
-	if (!chip->uses_pwmchip_alloc)
-		return -EINVAL;
-
-	if (!pwm_ops_check(chip))
-		return -EINVAL;
-
-	chip->owner = owner;
-
-	if (chip->atomic)
-		spin_lock_init(&chip->atomic_lock);
-	else
-		mutex_init(&chip->nonatomic_lock);
-
-	guard(mutex)(&pwm_lock);
-
-	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
-	if (ret < 0)
-		return ret;
-
-	chip->id = ret;
-
-	dev_set_name(&chip->dev, "pwmchip%u", chip->id);
-
-	if (IS_ENABLED(CONFIG_OF))
-		of_pwmchip_add(chip);
-
-	scoped_guard(pwmchip, chip)
-		chip->operational = true;
-
-	ret = device_add(&chip->dev);
-	if (ret)
-		goto err_device_add;
-
-	return 0;
-
-err_device_add:
-	scoped_guard(pwmchip, chip)
-		chip->operational = false;
-
-	if (IS_ENABLED(CONFIG_OF))
-		of_pwmchip_remove(chip);
-
-	idr_remove(&pwm_chips, chip->id);
-
-	return ret;
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
-	scoped_guard(mutex, &pwm_lock) {
-		unsigned int i;
-
-		scoped_guard(pwmchip, chip)
-			chip->operational = false;
-
-		for (i = 0; i < chip->npwm; ++i) {
-			struct pwm_device *pwm = &chip->pwms[i];
-
-			if (test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
-				dev_warn(&chip->dev, "Freeing requested PWM #%u\n", i);
-				if (pwm->chip->ops->free)
-					pwm->chip->ops->free(pwm->chip, pwm);
-			}
-		}
-
-		if (IS_ENABLED(CONFIG_OF))
-			of_pwmchip_remove(chip);
-
-		idr_remove(&pwm_chips, chip->id);
-	}
-
-	device_del(&chip->dev);
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
 static struct device_link *pwm_device_link_add(struct device *dev,
 					       struct pwm_device *pwm)
 {
@@ -1918,36 +1792,6 @@ static struct pwm_device *acpi_pwm_get(const struct fwnode_handle *fwnode)
 static DEFINE_MUTEX(pwm_lookup_lock);
 static LIST_HEAD(pwm_lookup_list);
 
-/**
- * pwm_add_table() - register PWM device consumers
- * @table: array of consumers to register
- * @num: number of consumers in table
- */
-void pwm_add_table(struct pwm_lookup *table, size_t num)
-{
-	guard(mutex)(&pwm_lookup_lock);
-
-	while (num--) {
-		list_add_tail(&table->list, &pwm_lookup_list);
-		table++;
-	}
-}
-
-/**
- * pwm_remove_table() - unregister PWM device consumers
- * @table: array of consumers to unregister
- * @num: number of consumers in table
- */
-void pwm_remove_table(struct pwm_lookup *table, size_t num)
-{
-	guard(mutex)(&pwm_lookup_lock);
-
-	while (num--) {
-		list_del(&table->list);
-		table++;
-	}
-}
-
 /**
  * pwm_get() - look up and request a PWM device
  * @dev: device for PWM consumer
@@ -2174,6 +2018,162 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_fwnode_pwm_get);
 
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
+	int ret;
+
+	if (!chip || !pwmchip_parent(chip) || !chip->ops || !chip->npwm)
+		return -EINVAL;
+
+	/*
+	 * a struct pwm_chip must be allocated using (devm_)pwmchip_alloc,
+	 * otherwise the embedded struct device might disappear too early
+	 * resulting in memory corruption.
+	 * Catch drivers that were not converted appropriately.
+	 */
+	if (!chip->uses_pwmchip_alloc)
+		return -EINVAL;
+
+	if (!pwm_ops_check(chip))
+		return -EINVAL;
+
+	chip->owner = owner;
+
+	if (chip->atomic)
+		spin_lock_init(&chip->atomic_lock);
+	else
+		mutex_init(&chip->nonatomic_lock);
+
+	guard(mutex)(&pwm_lock);
+
+	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	chip->id = ret;
+
+	dev_set_name(&chip->dev, "pwmchip%u", chip->id);
+
+	if (IS_ENABLED(CONFIG_OF))
+		of_pwmchip_add(chip);
+
+	scoped_guard(pwmchip, chip)
+		chip->operational = true;
+
+	ret = device_add(&chip->dev);
+	if (ret)
+		goto err_device_add;
+
+	return 0;
+
+err_device_add:
+	scoped_guard(pwmchip, chip)
+		chip->operational = false;
+
+	if (IS_ENABLED(CONFIG_OF))
+		of_pwmchip_remove(chip);
+
+	idr_remove(&pwm_chips, chip->id);
+
+	return ret;
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
+	scoped_guard(mutex, &pwm_lock) {
+		unsigned int i;
+
+		scoped_guard(pwmchip, chip)
+			chip->operational = false;
+
+		for (i = 0; i < chip->npwm; ++i) {
+			struct pwm_device *pwm = &chip->pwms[i];
+
+			if (test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
+				dev_warn(&chip->dev, "Freeing requested PWM #%u\n", i);
+				if (pwm->chip->ops->free)
+					pwm->chip->ops->free(pwm->chip, pwm);
+			}
+		}
+
+		if (IS_ENABLED(CONFIG_OF))
+			of_pwmchip_remove(chip);
+
+		idr_remove(&pwm_chips, chip->id);
+	}
+
+	device_del(&chip->dev);
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
+/**
+ * pwm_add_table() - register PWM device consumers
+ * @table: array of consumers to register
+ * @num: number of consumers in table
+ */
+void pwm_add_table(struct pwm_lookup *table, size_t num)
+{
+	guard(mutex)(&pwm_lookup_lock);
+
+	while (num--) {
+		list_add_tail(&table->list, &pwm_lookup_list);
+		table++;
+	}
+}
+
+/**
+ * pwm_remove_table() - unregister PWM device consumers
+ * @table: array of consumers to unregister
+ * @num: number of consumers in table
+ */
+void pwm_remove_table(struct pwm_lookup *table, size_t num)
+{
+	guard(mutex)(&pwm_lookup_lock);
+
+	while (num--) {
+		list_del(&table->list);
+		table++;
+	}
+}
+
 static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 {
 	unsigned int i;
-- 
2.45.2


