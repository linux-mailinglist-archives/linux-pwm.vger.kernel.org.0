Return-Path: <linux-pwm+bounces-1782-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1F387DCFA
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 11:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2075C1C20915
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 10:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD837182BB;
	Sun, 17 Mar 2024 10:40:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2B17BAF
	for <linux-pwm@vger.kernel.org>; Sun, 17 Mar 2024 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710672058; cv=none; b=LCdTBgBjSV7fV0mvnlbXkgCR/5xI2rNPXwvGBCWI7ofN7Lnh36nDIGKziO1GL6CPgyFqhFlt1Wbu/877oewaU2J0GdncQ1ZvPane1QJ1tKTUKKg7K1jLzKkfE3zK/aE4UvcRzCvrsgitPSVzpRhsuYuPhaMGJosiSv0RRtGRIb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710672058; c=relaxed/simple;
	bh=3iAzp1ws+1+KRud5kZGHie5Ypdb7+MOT5gVokChZ+ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJV+CPqHHkIB+DjDXvJTl+HIa3LvY376CIQ5E59bKeDPnmIHg4OMPlyKRQR3SXy8kx7wUo0qZn0dNsyY1K8yjQrOSReakKfVYLZ/gpLbGZMOYyEcRSJQVd0mD6p7ildz7eJBVOjEgOAMKQj9SZ3RA/jxLcjmqUv3MJ3dWImfeRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwe-0002A1-Cn; Sun, 17 Mar 2024 11:40:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwe-006rfu-09; Sun, 17 Mar 2024 11:40:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwd-007aDB-2z;
	Sun, 17 Mar 2024 11:40:47 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	kernel@pengutronix.de,
	linux-hardening@vger.kernel.org
Subject: [PATCH 4/8] pwm: Ensure a struct pwm has the same lifetime as its pwm_chip
Date: Sun, 17 Mar 2024 11:40:35 +0100
Message-ID:  <7e9e958841f049026c0023b309cc9deecf0ab61d.1710670958.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3539; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=3iAzp1ws+1+KRud5kZGHie5Ypdb7+MOT5gVokChZ+ak=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl9silpBrxn1YDcJGgxKm3zimSVOS/q1RjyN92m +i3EWaKWtuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfbIpQAKCRCPgPtYfRL+ TkJTB/96lbU/JRj/NFTUYhdqSYcI5fBZUt2AZ7odkhFI/dPJs5FCBi9nydUK6nvip1JWimDbLkR L9P1my5NqgOa5a4rkvxlkqeuvidit6w5a7kCakqqYHL7Yr2xl1h4BKb1tlduDfvX2YYDmMHJDxr 1rmjQntkubKX80l5fEBSD7XC3B+IvmSb/7GLgrduxb7NYSVWiqjrAP7FxNEvLPTj/IjXX69AlyR 0zMPpha9zXqR7rQz0j9jvW4k+khq/BBQARAtXAHIscOBMvDjPFJmCAV8nrO0NYSvBXoh6WWjG2A BBkbxJl36Sd8vjxzVZeT7n9u9+qn7Mqk95k4tyheB6qIREsV
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

It's required to not free the memory underlying a requested PWM
while a consumer still has a reference to it. While currently a pwm_chip
doesn't life long enough in all cases, linking the struct pwm to the
pwm_chip results in the right lifetime as soon as the pwmchip is living
long enough. This happens with the following commits.

Note this is a breaking change for all pwm drivers that don't use
pwmchip_alloc().

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org> # for struct_size() and __counted_by()
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 27 ++++++++++-----------------
 include/linux/pwm.h |  2 +-
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 69af8123455a..8ed4c93cd0ce 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -987,7 +987,7 @@ static void pwmchip_sysfs_unexport(struct pwm_chip *chip)
 
 static void *pwmchip_priv(struct pwm_chip *chip)
 {
-	return (void *)chip + ALIGN(sizeof(*chip), PWMCHIP_ALIGN);
+	return (void *)chip + ALIGN(struct_size(chip, pwms, chip->npwm), PWMCHIP_ALIGN);
 }
 
 /* This is the counterpart to pwmchip_alloc() */
@@ -1001,8 +1001,10 @@ struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t
 {
 	struct pwm_chip *chip;
 	size_t alloc_size;
+	unsigned int i;
 
-	alloc_size = size_add(ALIGN(sizeof(*chip), PWMCHIP_ALIGN), sizeof_priv);
+	alloc_size = size_add(ALIGN(struct_size(chip, pwms, npwm), PWMCHIP_ALIGN),
+			      sizeof_priv);
 
 	chip = kzalloc(alloc_size, GFP_KERNEL);
 	if (!chip)
@@ -1014,6 +1016,12 @@ struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t
 
 	pwmchip_set_drvdata(chip, pwmchip_priv(chip));
 
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+		pwm->chip = chip;
+		pwm->hwpwm = i;
+	}
+
 	return chip;
 }
 EXPORT_SYMBOL_GPL(pwmchip_alloc);
@@ -1085,7 +1093,6 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
  */
 int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 {
-	unsigned int i;
 	int ret;
 
 	if (!chip || !pwmchip_parent(chip) || !chip->ops || !chip->npwm)
@@ -1105,28 +1112,16 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	chip->owner = owner;
 
-	chip->pwms = kcalloc(chip->npwm, sizeof(*chip->pwms), GFP_KERNEL);
-	if (!chip->pwms)
-		return -ENOMEM;
-
 	mutex_lock(&pwm_lock);
 
 	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		mutex_unlock(&pwm_lock);
-		kfree(chip->pwms);
 		return ret;
 	}
 
 	chip->id = ret;
 
-	for (i = 0; i < chip->npwm; i++) {
-		struct pwm_device *pwm = &chip->pwms[i];
-
-		pwm->chip = chip;
-		pwm->hwpwm = i;
-	}
-
 	mutex_unlock(&pwm_lock);
 
 	if (IS_ENABLED(CONFIG_OF))
@@ -1156,8 +1151,6 @@ void pwmchip_remove(struct pwm_chip *chip)
 	idr_remove(&pwm_chips, chip->id);
 
 	mutex_unlock(&pwm_lock);
-
-	kfree(chip->pwms);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 17e45d8413ed..78b9061572ff 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -290,7 +290,7 @@ struct pwm_chip {
 	/* only used internally by the PWM framework */
 	bool uses_pwmchip_alloc;
 	void *driver_data;
-	struct pwm_device *pwms;
+	struct pwm_device pwms[] __counted_by(npwm);
 };
 
 static inline struct device *pwmchip_parent(const struct pwm_chip *chip)
-- 
2.43.0


