Return-Path: <linux-pwm+bounces-36-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EEF7F2F6C
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0419C1C214A2
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FD353815;
	Tue, 21 Nov 2023 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162F810EA
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-0005LG-Qt; Tue, 21 Nov 2023 14:51:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-00Aay7-BH; Tue, 21 Nov 2023 14:51:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-004xcR-2F; Tue, 21 Nov 2023 14:51:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 027/108] pwm: stm32-lp: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:29 +0100
Message-ID: <20231121134901.208535-28-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=8GTUfYbqD+5GD5mrEVpFS9bTtV3cMkLFhtuMi1iJw5k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVqCdR4MHUAwEdwtXCyGdPb2KG0/fg4CZSj4 KIIrBuSMCCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1agAKCRCPgPtYfRL+ Tgv9B/4lnhRwPvUW/Ot+lFZLK+Bc51iXwT8QsTWtGrJMyb9p5iy1VIs+5gPBfgWGD7LkCk6dN74 mP5qF43la7ui+QHx3SYcDB8t2LrVVGnxApN93LVA8c3vaTRoUe2xZLt5uToOsjFFFBa5/j7TOzo qMpYKHvXhP8BfEMCecIoNBTJSMqOMBzHQ5HCDtHNHNHUrKXMfbW/1VMS6g9eiTMf4qXil7tA0j2 k2yqrbbBUseTLwtvSQNP8rnrmtHmR5XWoWvMOcD80jlyH5FmhkNVsvA+t2Ony4eSdDLVVaQLtWQ /8vhA2Odv04LZ9K1agqTTAVX9nD7wgnvfX4xQFauveKa5mJQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32-lp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 439068f3eca1..3754faeca838 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -61,7 +61,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(div, NSEC_PER_SEC);
 	if (!div) {
 		/* Clock is too slow to achieve requested period. */
-		dev_dbg(priv->chip.dev, "Can't reach %llu ns\n", state->period);
+		dev_dbg(pwmchip_parent(chip), "Can't reach %llu ns\n", state->period);
 		return -EINVAL;
 	}
 
@@ -69,7 +69,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	while (div > STM32_LPTIM_MAX_ARR) {
 		presc++;
 		if ((1 << presc) > STM32_LPTIM_MAX_PRESCALER) {
-			dev_err(priv->chip.dev, "max prescaler exceeded\n");
+			dev_err(pwmchip_parent(chip), "max prescaler exceeded\n");
 			return -EINVAL;
 		}
 		div = prd >> presc;
@@ -130,7 +130,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				       (val & STM32_LPTIM_CMPOK_ARROK) == STM32_LPTIM_CMPOK_ARROK,
 				       100, 1000);
 	if (ret) {
-		dev_err(priv->chip.dev, "ARR/CMP registers write issue\n");
+		dev_err(pwmchip_parent(chip), "ARR/CMP registers write issue\n");
 		goto err;
 	}
 	ret = regmap_write(priv->regmap, STM32_LPTIM_ICR,
-- 
2.42.0


