Return-Path: <linux-pwm+bounces-1469-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13946854680
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7DE4B209C0
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768301C13;
	Wed, 14 Feb 2024 09:52:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0993A13ADB
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904364; cv=none; b=JGwkqHNq+taovvfCX9zyhxcNU/2Uu9mNr0To1apszB5xIcC7WfAS3LmrttBgn6SRkcR3AhpO2EYdSgUdq22pS4kL+tgQ84NL32VLzu35IEgKjfWsWU4WJBimoxsD0yZ4WP60pkpRkmm8sCM2j4t3W/7MEMO9ZkrV2cQkCdWFO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904364; c=relaxed/simple;
	bh=/nMtWKkN3qCIvGLEogB5Ej7KlTrZUM3d3AJyRbMVd30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLSa4jMmu47BziCgU/YlDGjWLdxrH2/ugus1Vy0fnzV668L4vqoXuxiv/5bervX6Ay7PljqbTpeuM/ddz9SBALTjnAFNiwsJT1tcEqgLrHdA1XR0G4JtpDY7bI9nLCyZKFbBBNFFk9qC/auyNtA8pbCGpRhiRt+jAoBeXDcVdhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBfB-0006Dk-MP; Wed, 14 Feb 2024 10:34:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-000fIJ-AC; Wed, 14 Feb 2024 10:34:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-004YAA-0i;
	Wed, 14 Feb 2024 10:34:41 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-pwm@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	dri-devel@lists.freedesktop.org,
	kernel@pengutronix.de
Subject: [PATCH v6 153/164] drm/bridge: ti-sn65dsi86: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:33:20 +0100
Message-ID:  <a56cbaf049f5f23c0e0fe36b0799dd20189675e0.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2336; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=/nMtWKkN3qCIvGLEogB5Ej7KlTrZUM3d3AJyRbMVd30=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIj613yl5acAQHFD2Kl+1IoprukdeiYNPAY7G WZaADmgkXOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI+gAKCRCPgPtYfRL+ TtrwB/46pXhdKDsQWiG/+5MGM4dVovdfgWgm/NIrZgITS5sxkdtNfotK6blGWxL1PZXDh8fJ7bg YIn8l6/5Isph6XxIrMpZSemctdaBCsTynkz4RV9rDJUxoVryCGcA4THc00JGCh8Rg2F8Tbi6HMX 2r4unB+qG0JGqvUGyUhKrDn6mJymtiE0oH1QdNlLKkwS7cA9BtEYevAnfl+8elSCInWhNmbqAB5 FjlUtsB88eor/K2uG7Wdhqjas4ssWillrBtxrQHS3yzCiPGECKVRu2TzoU7PcZTh5vRKMPq3DhC k7QZsVDi/vJXWCo17AmuWzhgdxlZFrYTKNRKY0jwh3yAUjQ3
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm driver of the ti-sn65dsi86 to further changes of
the pwm core outlined in the commit introducing devm_pwmchip_alloc().
There is no intended semantical change and the driver should behave as
before.

Acked-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index f1fffbef3324..7fbc307cc025 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -197,7 +197,7 @@ struct ti_sn65dsi86 {
 	DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
 #endif
 #if defined(CONFIG_PWM)
-	struct pwm_chip			pchip;
+	struct pwm_chip			*pchip;
 	bool				pwm_enabled;
 	atomic_t			pwm_pin_busy;
 #endif
@@ -1374,7 +1374,7 @@ static void ti_sn_pwm_pin_release(struct ti_sn65dsi86 *pdata)
 
 static struct ti_sn65dsi86 *pwm_chip_to_ti_sn_bridge(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ti_sn65dsi86, pchip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int ti_sn_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -1585,23 +1585,28 @@ static const struct pwm_ops ti_sn_pwm_ops = {
 static int ti_sn_pwm_probe(struct auxiliary_device *adev,
 			   const struct auxiliary_device_id *id)
 {
+	struct pwm_chip *chip;
 	struct ti_sn65dsi86 *pdata = dev_get_drvdata(adev->dev.parent);
 
-	pdata->pchip.dev = &adev->dev;
-	pdata->pchip.ops = &ti_sn_pwm_ops;
-	pdata->pchip.npwm = 1;
-	pdata->pchip.of_xlate = of_pwm_single_xlate;
+	pdata->pchip = chip = devm_pwmchip_alloc(&adev->dev, 1, 0);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	pwmchip_set_drvdata(chip, pdata);
+
+	chip->ops = &ti_sn_pwm_ops;
+	chip->of_xlate = of_pwm_single_xlate;
 
 	devm_pm_runtime_enable(&adev->dev);
 
-	return pwmchip_add(&pdata->pchip);
+	return pwmchip_add(chip);
 }
 
 static void ti_sn_pwm_remove(struct auxiliary_device *adev)
 {
 	struct ti_sn65dsi86 *pdata = dev_get_drvdata(adev->dev.parent);
 
-	pwmchip_remove(&pdata->pchip);
+	pwmchip_remove(pdata->pchip);
 
 	if (pdata->pwm_enabled)
 		pm_runtime_put_sync(&adev->dev);
-- 
2.43.0


