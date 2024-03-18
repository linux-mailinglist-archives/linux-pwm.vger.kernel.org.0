Return-Path: <linux-pwm+bounces-1797-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF55487ED87
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Mar 2024 17:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8021C2089C
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Mar 2024 16:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9FA52F79;
	Mon, 18 Mar 2024 16:28:26 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBFE535A3
	for <linux-pwm@vger.kernel.org>; Mon, 18 Mar 2024 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779306; cv=none; b=RZqKGsjVxEcDTgsTInLmUlPgBc6FzYs0pK9J8f3XuUYl0GyRdz+PojD1XrMge9+mo9s8/55EgNyThzdmHAdgWdXHMChRUZzfPsAp1C1AtsoHkAobTFL7qqnpVwYjlyRzYu9IO3xnKsEC8pQ7XskrVs8TdrBe7PDCQccdNekTf94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779306; c=relaxed/simple;
	bh=0kwrQdVB9fHadW0zcs/zefkApf0unD8BGUorM1zzxmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FavlTKWtrhSzYsv96ut9E4LP7UgEPYQ4PGoWyJUIpQnqPJoBX6Nux4raNfgFY1NPvB25Cb+iIl1pO/dioXL41fQZIY058Ojli4xLjUfY9Pt953OrWZtHem7L9PJgLSuidCrgu8nq20rB1cF7zsQdVcRekQ5Nz87Bm0Mh4dg3HPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmFqA-0007vm-3z; Mon, 18 Mar 2024 17:27:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmFq7-00771K-3i; Mon, 18 Mar 2024 17:27:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmFq7-0084aB-04;
	Mon, 18 Mar 2024 17:27:55 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/2] hwmon: (aspeed-g6-pwm-tacho): Make use of pwmchip_parent() accessor
Date: Mon, 18 Mar 2024 17:09:49 +0100
Message-ID:  <5c6a11dd10cd29e0f7bfaa1fdef145523347cb58.1710777536.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=0kwrQdVB9fHadW0zcs/zefkApf0unD8BGUorM1zzxmk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl+GdO3EeEUQ6nZ6pNdoQlPypXol9wo4WBc8brb /motAhELkWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfhnTgAKCRCPgPtYfRL+ TsW1B/4z18EWUeJw8wanzvuSJt/qMpj2oBXKwiEzs+LtnrnJley6qeMoySlIeJ5WW0nVSbG/J8x 49nH5bAVvuR/5lnNT5RxR95dy5lfuYeos4aUzW7/SpMgWmMOAu7XewYt5nl1EYdwFA2YweSM0l8 0VbVlsQubVnIUeb9ab19Y8u9SfvoQRQ2lGD2Ps6hFhPwRSalSVHme23YyDL3zsC0hpO7spSow/b qjCr/BoWYZ1bN8xRYQXqlhjUZF8OGinn2haV7XU7N0DIOlWl1foIDVJk94eO7ucCLQzgCqkhudF y8x+4Sd55CZSPS04U8/MZetP0J/uGr9gzp33ojHyNxVCLjJD
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the accessor
function provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/hwmon/aspeed-g6-pwm-tach.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
index 597b3b019d49..64def5e4cdf6 100644
--- a/drivers/hwmon/aspeed-g6-pwm-tach.c
+++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
@@ -195,7 +195,7 @@ static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	expect_period = div64_u64(ULLONG_MAX, (u64)priv->clk_rate);
 	expect_period = min(expect_period, state->period);
-	dev_dbg(chip->dev, "expect period: %lldns, duty_cycle: %lldns",
+	dev_dbg(pwmchip_parent(chip), "expect period: %lldns, duty_cycle: %lldns",
 		expect_period, state->duty_cycle);
 	/*
 	 * Pick the smallest value for div_h so that div_l can be the biggest
@@ -218,12 +218,12 @@ static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (div_l > 255)
 		div_l = 255;
 
-	dev_dbg(chip->dev, "clk source: %ld div_h %lld, div_l : %lld\n",
+	dev_dbg(pwmchip_parent(chip), "clk source: %ld div_h %lld, div_l : %lld\n",
 		priv->clk_rate, div_h, div_l);
 	/* duty_pt = duty_cycle * (PERIOD + 1) / period */
 	duty_pt = div64_u64(state->duty_cycle * priv->clk_rate,
 			    (u64)NSEC_PER_SEC * (div_l + 1) << div_h);
-	dev_dbg(chip->dev, "duty_cycle = %lld, duty_pt = %d\n",
+	dev_dbg(pwmchip_parent(chip), "duty_cycle = %lld, duty_pt = %d\n",
 		state->duty_cycle, duty_pt);
 
 	/*
-- 
2.43.0


