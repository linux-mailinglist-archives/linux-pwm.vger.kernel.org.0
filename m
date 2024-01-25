Return-Path: <linux-pwm+bounces-1048-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714FB83C21C
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AB7290664
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635784439A;
	Thu, 25 Jan 2024 12:11:07 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68764374F5
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184667; cv=none; b=P8AEUG08Y7Nt9Wya1AvzwkPm+xsWvA9n7oX736BTOl5l9fUeXx3q1faVwszOIqyBwt0IDFqtH+hdEG9b1L8rntYaRu4QrC9yvpfZ0iksN02elAZvV7km58Rb0p3gfrsyUTL5FygJHmziSFFi4kOb88OMg5pUlwy6j1vyYoMoNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184667; c=relaxed/simple;
	bh=RFARFJlAlpRYrUAQzUAT2bIj2rzOdFoJcaeIlMiSCWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBJrrfPe0ghsZe3vDve93LApdhVB9ZHUSr9xb4BKtDys2lPbPKQ0P+eD+Cwmmd5b3YMkfvJPpTb2anQcRmOq9M0uE3EgDeA6hByAmF5tX7BTY4V1xgsbPW+OUpyIJ0eitEQX65QnB9mJQfPSCwcNWsHDLl8LeZZoYGhyPh8haUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZR-0004f2-WC; Thu, 25 Jan 2024 13:11:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZQ-002HVZ-Kg; Thu, 25 Jan 2024 13:11:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZQ-007n5L-1p;
	Thu, 25 Jan 2024 13:11:00 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 107/111] pwm: Ensure that pwm_chips are allocated using pwmchip_alloc()
Date: Thu, 25 Jan 2024 13:10:09 +0100
Message-ID:  <89afb1f6191aff726f537b5d450cc74f90236ea4.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=RFARFJlAlpRYrUAQzUAT2bIj2rzOdFoJcaeIlMiSCWs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+3p9h2xtcgZgefvR3Es+lhRqc2bc6VNp5wo v1/AQqk6KWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPtwAKCRCPgPtYfRL+ TssfCACXOsaJebKNQfExu644YlmBioZ3oIy/fx9yMf0oPf/2rG9JW+rSQHqOiUGBAR5oA4FSTC8 pTyExtYolEM6QwYb/18KECxUYwRmhRV0oJtosu/RxmxAbOvO5n67OyOQWq0JVX5fJ9AIQ9IJ2nF xHwoTs7DE1+fC14vySUhc5dAziJzSvkht717Pagh1cqoiVHNtgqDeRy9shG23gX5IJY3ud6snn1 ti5l5GjCQBRlr7DXCkoLnMoPM82VMgl2dNE9/x0hMkSjFsMXr3p5Dz2zVDdiS4wsfWmneN4bYXB PpilCYso9X2qwwfrOGRoI2ku1NeEtW2gnJMTzBGaWQNtA7ta
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

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 10 ++++++++++
 include/linux/pwm.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index b821a2b0b172..80acae5fed11 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -472,6 +472,7 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
 
 	chip->dev = parent;
 	chip->npwm = npwm;
+	chip->uses_pwmchip_alloc = true;
 
 	pwmchip_set_drvdata(chip, pwmchip_priv(chip));
 
@@ -528,6 +529,15 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
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
index 8bc7504aa7d4..1620a1eef165 100644
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


