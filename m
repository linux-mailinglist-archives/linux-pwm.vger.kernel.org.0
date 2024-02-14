Return-Path: <linux-pwm+bounces-1474-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532A7854690
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E561C2120E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4141429C;
	Wed, 14 Feb 2024 09:53:37 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3F168A9
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904417; cv=none; b=K0vV8WCU0C+DjbV34sERJm52zS60FhNOO0PsfJXL2XH4Pc6jrSeQoFv4lPSTjsncJRaWbFtZPm7wDTVVJQz/dcmEJFXML3xlgs/vf17jcvPLB+TsDRDNV1Rs83ZULkes97U28cJ0VG4nq+dAN5Jeg5+TcXl+KX2BWpazw3ug7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904417; c=relaxed/simple;
	bh=Kw8zUn6zUlRDspKiD00c84AIO4QqNIF1NhJzUFD68Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7qYFMj3pox7517GFQI6AwdgznlBY/EJJfXoBBip+vKN20FdSLt4P+n01dNxNAkjxCktpTkhbu2nvCM4USNgdf8TYdnpwZaaw6klzw55yxJbMsNhl3RnFW8MHkQ3gIq8XGooog4IuFkCudWeMCCYGUYksO4E2VbTblEGUjOwzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBfB-0006Kf-Qk; Wed, 14 Feb 2024 10:34:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-000fIu-Lo; Wed, 14 Feb 2024 10:34:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-004YAl-1w;
	Wed, 14 Feb 2024 10:34:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Kees Cook <keescook@chromium.org>,
	linux-pwm@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	kernel@pengutronix.de,
	linux-hardening@vger.kernel.org
Subject: [PATCH v6 162/164] pwm: Ensure a struct pwm has the same lifetime as its pwm_chip
Date: Wed, 14 Feb 2024 10:33:29 +0100
Message-ID:  <3eb4ed957bf37faf67a978816c4bf619176d8545.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3500; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Kw8zUn6zUlRDspKiD00c84AIO4QqNIF1NhJzUFD68Ko=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQznSzm0wP+cvveVy+aJtnFm1Z+Ujlhxc83Huc29FbNe /81S6ypk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJbGXiYJhlEXhQ4b/YtJqE I3I2lrKqD0+I6SjMNj2kc0gpcGedmIF0PG8M15RPSqftjuiUy2rtmH8lcIu1w16lMoYdSjzcv/4 e0fOSXZGlz3Lswa/8y7y62V3J/VGfGFavOnt+nzLnVjXXzFyBINZVSZWF1Zl3BH5vtmvQDy332a Gp1nYraVpg0bwaA7sJvJwJdvxPFgg3PX/z0XruVGsVvZunZ5yKWqJ50qR1/uaroc26fAtebLD/0 hITM5MvoeP9hEqRf2J51zzkL84LNeFx+GBtN62xyynnQvj8HXqMgqEfn39Y/c6a5bT1YvuvH/vm 3G3bJO0Q8PFa8H4eSaFFDL9T5jPKJH9Zdt6x8FTYhx8PAA==
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
index cae93ccc32ed..c8303da06b62 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -458,7 +458,7 @@ EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
 
 static void *pwmchip_priv(struct pwm_chip *chip)
 {
-	return (void *)chip + ALIGN(sizeof(*chip), PWMCHIP_ALIGN);
+	return (void *)chip + ALIGN(struct_size(chip, pwms, chip->npwm), PWMCHIP_ALIGN);
 }
 
 /* This is the counterpart to pwmchip_alloc */
@@ -472,8 +472,9 @@ struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t
 {
 	struct pwm_chip *chip;
 	size_t alloc_size;
+	unsigned int i;
 
-	alloc_size = size_add(ALIGN(sizeof(*chip), PWMCHIP_ALIGN), sizeof_priv);
+	alloc_size = size_add(ALIGN(struct_size(chip, pwms, npwm), PWMCHIP_ALIGN), sizeof_priv);
 
 	chip = kzalloc(alloc_size, GFP_KERNEL);
 	if (!chip)
@@ -485,6 +486,13 @@ struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t
 
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
 EXPORT_SYMBOL_GPL(pwmchip_alloc);
@@ -556,7 +564,6 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
  */
 int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 {
-	unsigned int i;
 	int ret;
 
 	if (!chip || !pwmchip_parent(chip) || !chip->ops || !chip->npwm)
@@ -576,28 +583,16 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
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
@@ -627,8 +622,6 @@ void pwmchip_remove(struct pwm_chip *chip)
 	idr_remove(&pwm_chips, chip->id);
 
 	mutex_unlock(&pwm_lock);
-
-	kfree(chip->pwms);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 94a642a88817..fbd8f5db938a 100644
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


