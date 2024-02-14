Return-Path: <linux-pwm+bounces-1429-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04F48545F2
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53DE1C22530
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703E11B81A;
	Wed, 14 Feb 2024 09:34:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57191A58B
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903288; cv=none; b=CI4yuUSMOUM2SoG4mymowp5V2in0tE3JUC1MDoxNul4dBYuHV/9PfdFMNSoLfxcfRMinN/6Z85aaOSO656XHpD9VKMQ3x8FoVP11iMrCLYRztn3dGUDRKA63YcjMitR+/4fVegL4jYWPO2y0BzOwxsuwTesHj2lZp6Kx7RUPWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903288; c=relaxed/simple;
	bh=DbWu18VlLTpi0TLDV4zCUYQI0ftmQeIBVlncJAGjvIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHowwAD37MP6PWSRcKOlvQoB0h8RAPYqVFzPjd6zKC8L0ovDJGfB2qwt7ETTtVNELaKU51sfcAXcDLk2ijDkBrunNqcWDvWFDAIDhuEOmpwkLSFd9rvGmfvAiLUouAzQZL4JWDgD+Atcwuc1+iTxTRgNWuicN7TO3CcRv9WBUJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-0005wy-R9; Wed, 14 Feb 2024 10:34:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-000fGj-Mq; Wed, 14 Feb 2024 10:34:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-004Y8T-20;
	Wed, 14 Feb 2024 10:34:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pwm@vger.kernel.org
Cc: linux-tegra@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 129/164] pwm: tegra: Drop duplicated tracking of the parent device
Date: Wed, 14 Feb 2024 10:32:56 +0100
Message-ID:  <225f4bfcb15fb69eb818ddb71d623157c447180a.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2876; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=DbWu18VlLTpi0TLDV4zCUYQI0ftmQeIBVlncJAGjvIc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjf+bHY9Rh4V/toVOTJkaXKpT/7Mep24Er3n 5lLD9yz+16JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI3wAKCRCPgPtYfRL+ Tvz6CACw9W3C2IdUWvecr3u+vMws3swoG3qHUb+hKAwJ2nm0iOKF20vO0n0suCe3hxFkh/pghM2 V4s+qRZaD9WlmJTivcex6+t33MIuLWj7Cp4QvwyNmC3FDudXDfeEL/6u3UvhS9ENA9CjJAnb6+S ooAZ4W7axleSW8MmiNNVWUpxG6oHa9+rUdYDruQTu4o8Ac300kIAUHzr9/943NlbEbuOIIjBhzw WdBxGpetIxPzwgxBszFQHF2uHCJ70scr9Wa8l2UywsTTL25kXS15+Je7b4Cqd2xQo7hHUl2hNMR OcXGvnb/4JZiOov49M8fGIkqnuYctBvPnhrXbU515NvPOipi
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The pwmchip stores a pointer to the parent device, so there is no need
to store another copy in driver private data. Drop struct
tegra_pwm_chip::dev and use the pwm_chip's parent pointer instead.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tegra.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 82ee2f0754f9..0d5f57c9ee26 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -66,7 +66,6 @@ struct tegra_pwm_soc {
 
 struct tegra_pwm_chip {
 	struct pwm_chip chip;
-	struct device *dev;
 
 	struct clk *clk;
 	struct reset_control*rst;
@@ -158,7 +157,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			 */
 			required_clk_rate *= 2;
 
-		err = dev_pm_opp_set_rate(pc->dev, required_clk_rate);
+		err = dev_pm_opp_set_rate(pwmchip_parent(chip), required_clk_rate);
 		if (err < 0)
 			return -EINVAL;
 
@@ -194,7 +193,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * before writing the register. Otherwise, keep it enabled.
 	 */
 	if (!pwm_is_enabled(pwm)) {
-		err = pm_runtime_resume_and_get(pc->dev);
+		err = pm_runtime_resume_and_get(pwmchip_parent(chip));
 		if (err)
 			return err;
 	} else
@@ -206,7 +205,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * If the PWM is not enabled, turn the clock off again to save power.
 	 */
 	if (!pwm_is_enabled(pwm))
-		pm_runtime_put(pc->dev);
+		pm_runtime_put(pwmchip_parent(chip));
 
 	return 0;
 }
@@ -217,7 +216,7 @@ static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	int rc = 0;
 	u32 val;
 
-	rc = pm_runtime_resume_and_get(pc->dev);
+	rc = pm_runtime_resume_and_get(pwmchip_parent(chip));
 	if (rc)
 		return rc;
 
@@ -237,7 +236,7 @@ static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	val &= ~PWM_ENABLE;
 	pwm_writel(pc, pwm->hwpwm, val);
 
-	pm_runtime_put_sync(pc->dev);
+	pm_runtime_put_sync(pwmchip_parent(chip));
 }
 
 static int tegra_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -280,7 +279,6 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pc->soc = of_device_get_match_data(&pdev->dev);
-	pc->dev = &pdev->dev;
 
 	pc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->regs))
@@ -302,7 +300,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Set maximum frequency of the IP */
-	ret = dev_pm_opp_set_rate(pc->dev, pc->soc->max_frequency);
+	ret = dev_pm_opp_set_rate(&pdev->dev, pc->soc->max_frequency);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
 		goto put_pm;
-- 
2.43.0


