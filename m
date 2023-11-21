Return-Path: <linux-pwm+bounces-97-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBE37F2FC0
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C93AB20FA6
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894B453800;
	Tue, 21 Nov 2023 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827C4170E
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAe-0006hr-QE; Tue, 21 Nov 2023 14:52:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAd-00Ab37-MV; Tue, 21 Nov 2023 14:52:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAd-004xi7-D5; Tue, 21 Nov 2023 14:52:07 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 105/108] pwm: Ensure a struct pwm has the same lifetime as its pwm_chip
Date: Tue, 21 Nov 2023 14:50:47 +0100
Message-ID: <20231121134901.208535-106-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3262; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mh6ITzsRD3RkVkVT8gUF5pS8AMxnoINsaKWoVc1Pq9s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLXANhzRqcpujMCSfuZz0RwsPWRwJ5DVXgyAr KoWM/4XJVeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1wAAKCRCPgPtYfRL+ TlbOCACej8rg//TMkbHZiljncXwHbdBaKPjUwzU+pwwPfxju/i0lcQ44f/JQAh2RYODOOYSnzuJ gR+6uPenXJWGVjYeSb45FMrZZ60+O/U9B5YTsyv8lN4OqbQoeaaij5ll1/WO1v8lYy/NbFKEEwf yh2SUzsxrn2W17hX0bVsYAswAnwVOos71hwMjtvVPxEZ3/MCsRVjFgvV2mfj9bUsa1yJxN1tDDP GnYWFevHh9PKiWqg7pOQC6wlDvEN8eP31leL34MtktV4OhVTLQ9uJffbuGqGnwRpkzO8Ve53ll7 aNsKPaf9cmRGJ4eTv0i9z91IWLI4oASmN0CchjjZR24Q4gq3
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

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 26 ++++++++++----------------
 include/linux/pwm.h |  2 +-
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 15942210aa08..029aa1c69591 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -198,7 +198,7 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 
 void *pwmchip_priv(struct pwm_chip *chip)
 {
-	return (void *)chip + sizeof(*chip);
+	return (void *)chip + struct_size(chip, pwms, chip->npwm);
 }
 EXPORT_SYMBOL_GPL(pwmchip_priv);
 
@@ -206,8 +206,9 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
 {
 	struct pwm_chip *chip;
 	size_t alloc_size;
+	unsigned int i;
 
-	alloc_size = size_add(sizeof(*chip), sizeof_priv);
+	alloc_size = size_add(struct_size(chip, pwms, npwm), sizeof_priv);
 
 	chip = devm_kzalloc(parent, alloc_size, GFP_KERNEL);
 	if (!chip)
@@ -217,6 +218,13 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
 	chip->npwm = npwm;
 	chip->uses_pwmchip_alloc = true;
 
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+
+		pwm->chip = chip;
+		pwm->hwpwm = i;
+	}
+
 	return chip;
 }
 EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
@@ -234,7 +242,6 @@ EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
 int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 {
 	int ret;
-	unsigned i;
 
 	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
 		return -EINVAL;
@@ -253,26 +260,15 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	chip->owner = owner;
 
-	chip->pwms = kcalloc(chip->npwm, sizeof(*chip->pwms), GFP_KERNEL);
-	if (!chip->pwms)
-		return -ENOMEM;
-
 	mutex_lock(&pwm_lock);
 
 	ret = idr_alloc(&pwmchip_idr, chip, 0, 0, GFP_KERNEL);
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
 
 	mutex_unlock(&pwm_lock);
 
@@ -303,8 +299,6 @@ void pwmchip_remove(struct pwm_chip *chip)
 	idr_remove(&pwmchip_idr, chip->id);
 
 	mutex_unlock(&pwm_lock);
-
-	kfree(chip->pwms);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index b8e70ee01d31..a7294ef1495d 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -302,7 +302,7 @@ struct pwm_chip {
 
 	/* only used internally by the PWM framework */
 	bool uses_pwmchip_alloc;
-	struct pwm_device *pwms;
+	struct pwm_device pwms[] __counted_by(npwm);
 };
 
 static inline struct device *pwmchip_parent(struct pwm_chip *chip)
-- 
2.42.0


