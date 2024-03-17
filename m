Return-Path: <linux-pwm+bounces-1780-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A381187DCF8
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 11:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4EE1F20FE0
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8901804E;
	Sun, 17 Mar 2024 10:40:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C51DF5B
	for <linux-pwm@vger.kernel.org>; Sun, 17 Mar 2024 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710672058; cv=none; b=GvnI8Xcg2IkLvZ2GOdF8wZOipDNxaN9ikXk1r2G38qRJEnbNZ5roJSjKIRsxRvTJunmmr70fLBk3qR6cJy463KSoa6i2mMi+ot/UaDuOc7XhYz6hG0vD3ftuyu07bXIHMr+zpERdK9z2QqfskLDKEcjnHeUmoLDVg0AeaZ6ERm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710672058; c=relaxed/simple;
	bh=1+dwwwluqec+EU+XvgBPnmpIBMFGxA6nM8zZtTdAwFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOgvLQV9DJIq566kPaT25P0Q0au+EEpCuRyRWAjeI0gmTL4vRqq4Pno4CZvOxZvhmokbgTcq547acCtoubCFac32jnutvfMyL6TNSeve4PZiX9Au7h8oVLu4h3hu0iskgTFYpWmW2b6zD89E7n4DVLJG5KvQmYd2Jhjp+oKtCVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwd-00029R-HI; Sun, 17 Mar 2024 11:40:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwd-006rfi-2l; Sun, 17 Mar 2024 11:40:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwd-007aCz-01;
	Sun, 17 Mar 2024 11:40:47 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH 1/8] pwm: Ensure that pwm_chips are allocated using pwmchip_alloc()
Date: Sun, 17 Mar 2024 11:40:32 +0100
Message-ID:  <b2bf15914e7e064ed48832dbd9ba909584613a9b.1710670958.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2330; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1+dwwwluqec+EU+XvgBPnmpIBMFGxA6nM8zZtTdAwFA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl9sih/UHVuv8KVS93FKHHmYt8BBrL8oRqk6XHi ydPXucmRryJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfbIoQAKCRCPgPtYfRL+ TsH1CAChqdx/QAthUFBgN6pnwteRlMOkbdDh1ItTWgUn4RLQTu+FLDxOqHCjJ5GCDxlygjvkojT iF/KOB4alea6vugkZUrUBzl+MBSVorZJv5Bw3JKRheHxw85aR36cGSYWtioXBpwkDrpDwOm9HJ7 iFpKpkhHCreGlBtTa0pl0SuMDzmQY9jA2tPoj4C6nMm6mbBTsM3LibV1j+YRdPTKYv6t2Xregsw HRj8B4/ZxQBkVgRmvXmQE7uoWI36Ci6gZvsClq2rbIh17OsCCp60Enhm8TC4q4GNIEEOpYNq3yj jJpkaT2cbVglkTY1vkZsba4x1ifboaf7tzshWS5gBlRxip/I
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

Link: https://lore.kernel.org/r/35f5b229c98f78b2f6ce2397259a4a936be477c0.1707900770.git.u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 10 ++++++++++
 include/linux/pwm.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index d70f793ce4b3..fe83333c466a 100644
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


