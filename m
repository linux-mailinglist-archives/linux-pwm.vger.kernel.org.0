Return-Path: <linux-pwm+bounces-1366-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E738545B4
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A421C26BA1
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE81212E6F;
	Wed, 14 Feb 2024 09:34:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D652F12B9E
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903274; cv=none; b=qyn1XJEYJLqWZ/XEMZHfYdJPjxmuj72a8pMP3Ya5l9cz4ZJXykyaKC4h4T3BsVYNt0nlKajJZs28QJYFjJOaUf/Vc4wOTvQKQ1vxXH0ArhrcKIBiWn+H64wBstuUyLcfTlSAmNhcC0JyND3ihCqlKnePU9Ols/t15EbkdNZdIdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903274; c=relaxed/simple;
	bh=hvXjpEfnDtDcWHAg8B0mWQO54uVeEUqkd7sE0aWa+L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgTJxLOUkK/1Cu3tD9T9mB25yauwZaU5EY58mKwqaDGYV8UU46OSslOWC74ehnoinkfbViGJf1rVSZJ6NuU3Cee0qI/U+PayblCkOJiEoPG/qMynnGmaxTTKMdgpo9B1rszN7KCncRvsBSy+ibEpU/pXcBse9CJDmD+jx1L15IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-0004rG-KR; Wed, 14 Feb 2024 10:34:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBes-000fCG-C8; Wed, 14 Feb 2024 10:34:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBes-004Y3N-0x;
	Wed, 14 Feb 2024 10:34:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Paul Cercueil <paul@crapouillou.net>,
	linux-pwm@vger.kernel.org
Cc: linux-mips@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 055/164] pwm: jz4740: Change prototype of a helper to prepare further changes
Date: Wed, 14 Feb 2024 10:31:42 +0100
Message-ID:  <83b826f0bf58b93f26d3bc30b1a957f84eedf41a.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=hvXjpEfnDtDcWHAg8B0mWQO54uVeEUqkd7sE0aWa+L4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiJJHsFdv9n8NuIaz/rZZXQwgvvtG/pKbUhV BNyMU4cEf+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIiQAKCRCPgPtYfRL+ TpVHB/92rItrRc15chKRr76azIzhqKA0t3IIf929fLtdo+deMrWthbfy36+ZvsKkJktJoszQNiR Vx3g41/FvvMjyGsh0aNTlYr6GbQHclDcgAAZp7HuaFhsCGTH2jEldpydXp3n/uKls1g48+76503 7jW1m5npzT1Y07poUPCLGTscQo6nDR7HKiK1o4o5MKIdJhqgfnrf3imSYvUkPG3CnWKRwnzixFo WjGrPmQth/VxiSCYblDGe6iroBEcsgQXtJattTwHL9x6RiUc7oYZ2o9xbYSoEYMm4t6qPe2kbnC DYO1ObmnkimY5tXw8S1M/PdEU7suRJvVM3QHCHElxp333188
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will make it harder to
determine the pwm_chip from a given jz4740_pwm_chip. To just not have to
do that, rework jz4740_pwm_can_use_chn() to take a pwm_chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-jz4740.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 3933418e551b..de9e66065e48 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -35,13 +35,12 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 	return container_of(chip, struct jz4740_pwm_chip, chip);
 }
 
-static bool jz4740_pwm_can_use_chn(struct jz4740_pwm_chip *jz,
-				   unsigned int channel)
+static bool jz4740_pwm_can_use_chn(struct pwm_chip *chip, unsigned int channel)
 {
 	/* Enable all TCU channels for PWM use by default except channels 0/1 */
-	u32 pwm_channels_mask = GENMASK(jz->chip.npwm - 1, 2);
+	u32 pwm_channels_mask = GENMASK(chip->npwm - 1, 2);
 
-	device_property_read_u32(jz->chip.dev->parent,
+	device_property_read_u32(chip->dev->parent,
 				 "ingenic,pwm-channels-mask",
 				 &pwm_channels_mask);
 
@@ -55,7 +54,7 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	char name[16];
 	int err;
 
-	if (!jz4740_pwm_can_use_chn(jz, pwm->hwpwm))
+	if (!jz4740_pwm_can_use_chn(chip, pwm->hwpwm))
 		return -EBUSY;
 
 	snprintf(name, sizeof(name), "timer%u", pwm->hwpwm);
-- 
2.43.0


