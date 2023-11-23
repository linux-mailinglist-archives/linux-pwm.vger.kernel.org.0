Return-Path: <linux-pwm+bounces-162-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6727F5A12
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 09:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 900FAB20E15
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 08:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31961CAAD;
	Thu, 23 Nov 2023 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE0DBC
	for <linux-pwm@vger.kernel.org>; Thu, 23 Nov 2023 00:33:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r659Q-0007pP-0n; Thu, 23 Nov 2023 09:33:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r659P-00B01A-Gn; Thu, 23 Nov 2023 09:33:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r659P-006Qq0-7V; Thu, 23 Nov 2023 09:33:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Paul Cercueil <paul@crapouillou.net>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: linux-mips@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] pwm: jz4740: Add trailing \n to error messages
Date: Thu, 23 Nov 2023 09:33:23 +0100
Message-ID: <20231123083322.405390-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1925; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=THRyMKHp7JLgNVD1ycT5PE40uFnSJw7kd0n82ahLMRk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXw5SOJV44BAZMVOWiqtcxKVelJ68Nq8P97sy7 jdzRWcLEZqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZV8OUgAKCRCPgPtYfRL+ TpBVB/9FQ/0KifIBlxl4aXUbTanJZuQHmcmdzOxqTib/+5Q4f7aiWyQNcQuVgF9HoVLZb3ZyPxI DwGRo25NeVyqTUv4+1x3LbKYSKPt9dR7YO/I/+39ZYJA5ammh6nHFXwV8CGV+tt6JDf/Oug/twt 9NvhBvfQ5zSmZ9LOhjy7N+W6VeQUCRCk2AepPXG9aDlo01sq/ksXSGqJCz+XhFB1IulfRf/ZHhz /1ED3KYdRqbaOEYJ7ZFDvo7zSbmVfVgwGldeofLlRHiz/qDzJK8qOhjuHPLyM+vUa/VxuCEjdX8 Z5krDq0RFjc4dCVzC8klMM/AmJzklT39TdvjPTBPaiLV5Ntz
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Error messages are supposed to end in \n. Add the line terminator to the
two error messages that lack this.

Suggested-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this was noticed by Paul in
https://lore.kernel.org/linux-pwm/ba21c20b20364a39d5ffff81dac8bd300a746dbb.camel@crapouillou.net.
Instead of sneaking this into a patch that probably won't get applied
quickly, make this explicit.

I based it on top of my PR that can be found at
https://lore.kernel.org/linux-pwm/20231121112029.gyv3gqirlycysyr4@pengutronix.de,
but applies just fine to v6.7-rc1.

If you want a fixes-line, that would be:

Fixes: 485b56f08f33 ("pwm: jz4740: Improve algorithm of clock calculation")

for the first hunk and

Fixes: ce1f9cece057 ("pwm: jz4740: Use clocks from TCU driver")

for the second. If this is backported to something before
v5.10-rc1~57^2~11, there is another instance with a missing \n.

Best regards
Uwe

 drivers/pwm/pwm-jz4740.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index e9375de60ad6..73f96cef1662 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -149,7 +149,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	rate = clk_round_rate(clk, tmp);
 	if (rate < 0) {
-		dev_err(chip->dev, "Unable to round rate: %ld", rate);
+		dev_err(chip->dev, "Unable to round rate: %ld\n", rate);
 		return rate;
 	}
 
@@ -170,7 +170,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	err = clk_set_rate(clk, rate);
 	if (err) {
-		dev_err(chip->dev, "Unable to set rate: %d", err);
+		dev_err(chip->dev, "Unable to set rate: %d\n", err);
 		return err;
 	}
 

base-commit: 869de350ff3834145273a6d39faedea878c6715a
-- 
2.42.0


