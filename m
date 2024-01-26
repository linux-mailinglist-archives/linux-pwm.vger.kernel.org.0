Return-Path: <linux-pwm+bounces-1093-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7643183D9E7
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 13:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3378E2819BA
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 12:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4A17732;
	Fri, 26 Jan 2024 12:04:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED8D30B
	for <linux-pwm@vger.kernel.org>; Fri, 26 Jan 2024 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270689; cv=none; b=RBvPGJ5jX/4v53dLF6m9ITVZBWcOcYipr9co5/bYG3g75cIFm4dIL2BXeJb26nbFZew1AzuTuevpitk0dVBwIuSMkn3TTtzCeJJwZOx4IzEmxJ/KDfSe0vNkAhRedG6kFa8H5WroVYidMK9f3RV2grsmIXv4UdfrSJx4A2UlhaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270689; c=relaxed/simple;
	bh=JUnIChirLdCLHWjsB+QMMWcuTHzRnV7WTt208dkKvsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLZyItwr6BKzm0VV+mrT1JUXxiqfDzD0mV9/tFMsqmcLZL3GQnyER6lrfmeiZ6is4aRB8UIlMmXT0YYQzJqUqDdIfFl4Ez/di7a2FNfF0kOaKhVcXGDtxL7wMw8LYqaPAPmaz97ruLUM3tHgiH+P2ftMsa3qkH8ZbLjlX/mAStE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTKwr-00022S-IE; Fri, 26 Jan 2024 13:04:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTKwr-002VPR-1b; Fri, 26 Jan 2024 13:04:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTKwq-008bQa-36;
	Fri, 26 Jan 2024 13:04:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Boris Brezillon <bbrezillon@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 2/2] pwm: atmel-hlcdc: Don't use pwm consumer API
Date: Fri, 26 Jan 2024 13:04:34 +0100
Message-ID:  <6e34607828b290cd64ca9f82df40872853069f07.1706269232.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706269232.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706269232.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JUnIChirLdCLHWjsB+QMMWcuTHzRnV7WTt208dkKvsc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBls5/TPmzaYgow8gVcVYOnDjVNcFv8bLvO2rqo/ Ci08y9Pw3aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbOf0wAKCRCPgPtYfRL+ TsxfB/9D/w0IM4R5kygm71vmPMnFGOpjMFUqPKM0P6+C1hXWx8TXt8ANFiHlU4V4jUIqX30ry8z 2NavNRnGYTtenc3yAE/5KRpBxph1EWROt6MHtKp1dCEy5XhKv9hGdzRJnz9wCQrjFQuYNqh2h4k JyJZ2sFcWyjoQHHfl/TNQdyJrnoeyk7L1tbAs5ldEjSQ1PiJzXTunhGIO6vvQ2JiOy7UJAzqodq BfhrksuJ/HSiYnqVfn6UomAxV50FDAPZtUUKe4wKhXEAC7hrgRgiIS8Bsn2XXmeYBQmPsmVDtf/ qotzSpg3BjBVWf09lPLvmD7wS1qhZPYOnng0Cgg9HG+G54Px
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Lowlevel driver callbacks are not supposed to use the consumer API
functions. Currently this works, but with the upcoming locking changes
this probably results in dead locks.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 1f6fc9a9fcf3..2d64af045fc5 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -183,9 +183,10 @@ static const struct atmel_hlcdc_pwm_errata atmel_hlcdc_pwm_sama5d3_errata = {
 static int atmel_hlcdc_pwm_suspend(struct device *dev)
 {
 	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
+	struct pwm_device *pwm = &atmel->chip.pwms[0];
 
 	/* Keep the periph clock enabled if the PWM is still running. */
-	if (!pwm_is_enabled(&atmel->chip.pwms[0]))
+	if (!pwm->state.enabled)
 		clk_disable_unprepare(atmel->hlcdc->periph_clk);
 
 	return 0;
@@ -194,20 +195,17 @@ static int atmel_hlcdc_pwm_suspend(struct device *dev)
 static int atmel_hlcdc_pwm_resume(struct device *dev)
 {
 	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
-	struct pwm_state state;
+	struct pwm_device *pwm = &atmel->chip.pwms[0];
 	int ret;
 
-	pwm_get_state(&atmel->chip.pwms[0], &state);
-
 	/* Re-enable the periph clock it was stopped during suspend. */
-	if (!state.enabled) {
+	if (!pwm->state.enabled) {
 		ret = clk_prepare_enable(atmel->hlcdc->periph_clk);
 		if (ret)
 			return ret;
 	}
 
-	return atmel_hlcdc_pwm_apply(&atmel->chip, &atmel->chip.pwms[0],
-				     &state);
+	return atmel_hlcdc_pwm_apply(&atmel->chip, pwm, &pwm->state);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(atmel_hlcdc_pwm_pm_ops,
-- 
2.43.0


