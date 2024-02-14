Return-Path: <linux-pwm+bounces-1420-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449078545ED
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777321C2714E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0891D1AAD9;
	Wed, 14 Feb 2024 09:34:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D351947D
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903286; cv=none; b=NDra6DhlaWqwupRzpipXbTxHO6wnjflCE9w5HYPGVKjxLSIPQgpO9/swny6gkUW47cQvFwYHOG/feYaT8wITWGSBHNR/lNpdbKFwUfhiBd6/MUtZ78Cj9fwwG65sFB9Yp9nkVN2GyVzunJWE6VmxMh3lyBZ5BiBtKoix02poqrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903286; c=relaxed/simple;
	bh=Nqj6FSyujOBi7wIfnBl8B3HIO7dDpveM2SltQZnDbWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QI1ylXMdxT+c6cn8AXv4WjLNmNRjGJuXnwMhaVP3z7AVmE3r1bVc0pd3E9v0CdpKeseJxrpb5Cq9f4rbX829b7YgCFeJ/kf3K0jPrBsC8n1HB3WldkScHoEIUoekkTB7k25lmlcBSKe49vll/u8UW+PjE8PhSg5ltjMp+VSbT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-0005l0-Rd; Wed, 14 Feb 2024 10:34:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-000fFw-Mb; Wed, 14 Feb 2024 10:34:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-004Y7d-21;
	Wed, 14 Feb 2024 10:34:35 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 116/164] pwm: stm32: Change prototype of helper that detects npwm to prepare further changes
Date: Wed, 14 Feb 2024 10:32:43 +0100
Message-ID:  <13d4d3e90a9ee1bcd04674dfdc16f242615b8320.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Nqj6FSyujOBi7wIfnBl8B3HIO7dDpveM2SltQZnDbWY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjQfHsVV8onHY9QV0koIOZtXKH407+kVXCpv bPYokUawpuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI0AAKCRCPgPtYfRL+ TvlHB/sHWYVJuTH7ezXErU582vAbPrpDDl5W6dOrHDLFuwaT9xqM7asOC9r7Ovhq4CdW+sHPqoi 9rMYMaleFh0HISRlCUl4vjEaFuhCXC+B16ZwHsI4yK3rOM+VW5ipjS79p5o05XbKkJG+3f5jAXQ STpCrsfrAobJpKJxEjPSWq9WF77fqLKCe4i22O8TFlXQGyCqbt7hSxgTHPGVZrfzE6DXuK2/sDP uiBp6BRmmacs7EepJcxnrOMRXEFWX3CWB3ZNcd17IyclfLlN2XVCLN9eqDLt4urnqiqrxpKlqua wPl+tUxAwX+OELn9wXXDidzZ2JxCVv/DDZ90XcSHAltkbO+9
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

When the stm32 pwm driver is converted to pwmchip_alloc(), the number of
available PWM lines must be known before the driver private data can be
allocated. So rework the helper function that determines this number to
not take the driver private data struct as input parameter.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 4d12f3d849cd..1440b706ee57 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -606,7 +606,7 @@ static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
 	priv->have_complementary_output = (ccer != 0);
 }
 
-static unsigned int stm32_pwm_detect_channels(struct stm32_pwm *priv,
+static unsigned int stm32_pwm_detect_channels(struct regmap *regmap,
 					      unsigned int *num_enabled)
 {
 	u32 ccer, ccer_backup;
@@ -615,10 +615,10 @@ static unsigned int stm32_pwm_detect_channels(struct stm32_pwm *priv,
 	 * If channels enable bits don't exist writing 1 will have no
 	 * effect so we can detect and count them.
 	 */
-	regmap_read(priv->regmap, TIM_CCER, &ccer_backup);
-	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
-	regmap_read(priv->regmap, TIM_CCER, &ccer);
-	regmap_write(priv->regmap, TIM_CCER, ccer_backup);
+	regmap_read(regmap, TIM_CCER, &ccer_backup);
+	regmap_set_bits(regmap, TIM_CCER, TIM_CCER_CCXE);
+	regmap_read(regmap, TIM_CCER, &ccer);
+	regmap_write(regmap, TIM_CCER, ccer_backup);
 
 	*num_enabled = hweight32(ccer_backup & TIM_CCER_CCXE);
 
@@ -657,7 +657,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 
 	chip->dev = dev;
 	chip->ops = &stm32pwm_ops;
-	chip->npwm = stm32_pwm_detect_channels(priv, &num_enabled);
+	chip->npwm = stm32_pwm_detect_channels(ddata->regmap, &num_enabled);
 
 	/* Initialize clock refcount to number of enabled PWM channels. */
 	for (i = 0; i < num_enabled; i++)
-- 
2.43.0


