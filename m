Return-Path: <linux-pwm+bounces-406-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 680D2806ED2
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135D01F21115
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E5B35883;
	Wed,  6 Dec 2023 11:49:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C20D4D
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOQ-0007lD-At; Wed, 06 Dec 2023 12:48:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOO-00DwyO-Bd; Wed, 06 Dec 2023 12:48:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOO-00FR3r-2h; Wed, 06 Dec 2023 12:48:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-pwm@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 111/115] pwm: Ensure a struct pwm has the same lifetime as its pwm_chip
Date: Wed,  6 Dec 2023 12:45:05 +0100
Message-ID:  <0ad4ff6c893412c7490decf188bafb4041e450c0.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3372; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=zRXBPiuGDTSmT2iDUQspb6FQDRG35gXstVqIOwq/bQI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF9loLszRsTIzoPcAEu4EyiogWYnYwoc+ksJM Bm2Nmb2KXmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfZQAKCRCPgPtYfRL+ TgzpCACN0r3FBZSAmr5YeK6eMPWGuIIC95TXRnC7vM3spQzoUlQhx5X13L5RYM/5ozmoekzLiqM 1QzZyPskoVPsLX7LbdWWJfR04FMYpo54DDg79iftgUgAIaCfdGEkaZxtA+EUOmScycOxs97GgJn LgD/yhdlquuQyaOx05YFFcW7Ji1vTzQu6VubkPJWYKHDLgY3DL7HLQvj/Dyb4k/NlUvEdzCQkDf K7yc1eqfcMtylrovMMuvTv58rLBqwhgdFLrRsyH6sAObyUwGU6z3YgyhE5oBW50lNkeTzK78+5x ZwMqu30qwMILj9OdDtlHfXCEEYg5jrKKudkOf1f8x94SeAcr
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
index ce6f4b397468..b3ba08aa0b14 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -200,15 +200,16 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 
 static void *pwmchip_priv(struct pwm_chip *chip)
 {
-	return (void *)chip + sizeof(*chip);
+	return (void *)chip + struct_size(chip, pwms, chip->npwm);
 }
 
 struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv)
 {
 	struct pwm_chip *chip;
 	size_t alloc_size;
+	unsigned int i;
 
-	alloc_size = size_add(sizeof(*chip), sizeof_priv);
+	alloc_size = size_add(struct_size(chip, pwms, npwm), sizeof_priv);
 
 	chip = devm_kzalloc(parent, alloc_size, GFP_KERNEL);
 	if (!chip)
@@ -220,6 +221,13 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
 
 	pwmchip_set_drvdata(chip, pwmchip_priv(chip));
 
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
@@ -236,7 +244,6 @@ EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
  */
 int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 {
-	unsigned int i;
 	int ret;
 
 	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
@@ -256,28 +263,16 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
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
-
 	mutex_unlock(&pwm_lock);
 
 	if (IS_ENABLED(CONFIG_OF))
@@ -307,8 +302,6 @@ void pwmchip_remove(struct pwm_chip *chip)
 	idr_remove(&pwmchip_idr, chip->id);
 
 	mutex_unlock(&pwm_lock);
-
-	kfree(chip->pwms);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 6a5b245e8951..eb91306ba28e 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -301,8 +301,8 @@ struct pwm_chip {
 
 	/* only used internally by the PWM framework */
 	bool uses_pwmchip_alloc;
-	struct pwm_device *pwms;
 	void *driver_data;
+	struct pwm_device pwms[] __counted_by(npwm);
 };
 
 static inline struct device *pwmchip_parent(struct pwm_chip *chip)
-- 
2.42.0


