Return-Path: <linux-pwm+bounces-1456-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D7F85461E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77090B230C4
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FBD168DF;
	Wed, 14 Feb 2024 09:34:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9381B95C
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903292; cv=none; b=sKieId56ihFT4w62H4k3L6tJXFTo26fC6yNgWWHbBe92PNVB7/q0UW88+meEEzJAELIhqw+BBX9IEr2oyJtx3dw+r9QlQACoco3qlaJmYjdIWpzYsUqonUHqZHgEIYyR283Y98z7mRC5M+y3LPhcOzeLKk3+JklcTP+PFcIJu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903292; c=relaxed/simple;
	bh=n81NJQFgvknH5WOHg3tblMVDa4/6WuVwCs2gZYFZrYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1FQYpeY2i2znaD+y0s6IKDKMGNlI+x7Ts0smU1QkbzTwEh/CBfkm/Hp7RCjkOnBmVGXSCxJ/I68bByXN2Vfz3eQ8VR9AUT0iXcJv2TUgGjvzwjsol5pRGDQLQIEhkQvymTakVTQQX25u6uFDrohjKchTwYx2cekM4jhTYkZ1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBfB-0006Jz-PY; Wed, 14 Feb 2024 10:34:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-000fIq-Gg; Wed, 14 Feb 2024 10:34:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-004YAg-1Q;
	Wed, 14 Feb 2024 10:34:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 161/164] pwm: Ensure that pwm_chips are allocated using pwmchip_alloc()
Date: Wed, 14 Feb 2024 10:33:28 +0100
Message-ID:  <35f5b229c98f78b2f6ce2397259a4a936be477c0.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2330; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=n81NJQFgvknH5WOHg3tblMVDa4/6WuVwCs2gZYFZrYQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIkDx7A7db1GJLSzYRgybA6mkhcXf8+Oh2NSi 4Bg1JOM55GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyJAwAKCRCPgPtYfRL+ TiBMCAC5IyBqVXJZEziJlAnUs4E6uan3ABoKbLBpJVS7uCGEjvydXOx3TiCoHN7siJ6nrfg8hiX VmNBJEeGLIi8SOAqtiJ15oRadcUzEiWpEE1DdZ7Naw6gJPnfBP1LEUHGWXP2UR+6Kp5JcYdq3fI 1Qa+NK9K+56/wf6wHztra9iR8A2i+yUOULe8JPpVqBdYBFnlE8ljeHvritRXcoQIP9R0HLHpi8a u/hMo5sLn/l0JO9X2iAhQmZgEu2BL+N9fNSUcf8VF5wud0Vk1q15YpVG6EH9QMTMQtkBQ6jQ5m9 nC2o4Yj/+AAJlxNy4UKrt4PDi8xyeZPDXN6I/AoSDA6XN4ZD
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Memory holding a struct device must not be freed before the reference
count drops to zero. So a struct pwm_chip must not live in memory
freed by a driver on unbind. All in-tree drivers were fixed accordingly,
but as out-of-tree drivers, that were not adapted, still compile fine,
catch these in pwmchip_add().

Link: https://lore.kernel.org/r/89afb1f6191aff726f537b5d450cc74f90236ea4.1706182805.git.u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 10 ++++++++++
 include/linux/pwm.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9fc6f4fa71d6..cae93ccc32ed 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -481,6 +481,7 @@ struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t
 
 	chip->dev = parent;
 	chip->npwm = npwm;
+	chip->uses_pwmchip_alloc = true;
 
 	pwmchip_set_drvdata(chip, pwmchip_priv(chip));
 
@@ -561,6 +562,15 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	if (!chip || !pwmchip_parent(chip) || !chip->ops || !chip->npwm)
 		return -EINVAL;
 
+	/*
+	 * a struct pwm_chip must be allocated using (devm_)pwmchip_alloc,
+	 * otherwise the embedded struct device might disappear too early
+	 * resulting in memory corruption.
+	 * Catch drivers that were not converted appropriately.
+	 */
+	if (!chip->uses_pwmchip_alloc)
+		return -EINVAL;
+
 	if (!pwm_ops_check(chip))
 		return -EINVAL;
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 4a6568dfdf3f..94a642a88817 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -272,6 +272,7 @@ struct pwm_ops {
  * @npwm: number of PWMs controlled by this chip
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @atomic: can the driver's ->apply() be called in atomic context
+ * @uses_pwmchip_alloc: signals if pwmchip_allow was used to allocate this chip
  * @driver_data: Private pointer for driver specific info
  * @pwms: array of PWM devices allocated by the framework
  */
@@ -287,6 +288,7 @@ struct pwm_chip {
 	bool atomic;
 
 	/* only used internally by the PWM framework */
+	bool uses_pwmchip_alloc;
 	void *driver_data;
 	struct pwm_device *pwms;
 };
-- 
2.43.0


