Return-Path: <linux-pwm+bounces-1370-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5E38545B9
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9F81C2256C
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FB11804E;
	Wed, 14 Feb 2024 09:34:35 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021C168BC
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903275; cv=none; b=ZQ7guomT2UDJFjcIoGGlsSfC92qk2off+PqoxOxQdfuHNE7j8xLHWOtzHa8bW7zzYbTPVycxY2vF9zld6SbPFXNzWpTP18VFOKLmLkcr/Y5C0TmAiigZlFeVvxzEWoaoaYKQBWA6n63uL6UtnPMVRINK3B2MjwCnxSfRY2T4C4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903275; c=relaxed/simple;
	bh=+bU0R7GzLyDnXaxxwxDrWA+el/qKWufFtdcDxFbKLdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIsursXS5E/4DAy6HnHKWt3ShIPskspfz5W83sG+S0IW3IE3I1TaJiJsXmeEO1e+eumh5KVpnCSbMvXzfz1aTzQz0BbiZ6kMVxBK9jBLbBDwnv06RZaJXkt31TTlnNm/2DJKl+1kKRbn2XR/cp4x6NwmU9e779WPaTFfD9q2dNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBev-0004wV-0K; Wed, 14 Feb 2024 10:34:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBet-000fCZ-AB; Wed, 14 Feb 2024 10:34:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBet-004Y3l-0l;
	Wed, 14 Feb 2024 10:34:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 061/164] pwm: lpc18xx-sct: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:31:48 +0100
Message-ID:  <e4fb330c8dbf8fecd365afe3f8b33f8c7952eb38.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+bU0R7GzLyDnXaxxwxDrWA+el/qKWufFtdcDxFbKLdM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiQx7bvzJLGCmTglV2Tklq0yjzqAK/QCCh3R Lo2SDnKYuaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIkAAKCRCPgPtYfRL+ TgyKCACXbucjr3qoqaKV+QgrkfnarjjPe03jgVt8KNVxDU9OukyI4k3zWl8xf/BFtoildVIITav mn6FsZmlnh5jS7O6NPmr1vmuC/pwqD8kodI5SMEuvAqZBplI1FdGfkX9izbipczgvGih2pHNlTf TyysdxD10rclBmOMiMf6xbN/uqS4jWiL2+p4Eo++Jr6QRleB82jeCLwpcbkXBA81VqVAaZurpMf gfrxVh18V7VJA3Gf78UbKsolHF44MiViH6WftA5Y+K2rbWo9diSuDhp6NNMQoVMKKSlpVRog8DA Q5AzSmVyv1DScdG0vBhB6wOeb6geqkfl+jwegZmg5hnyzjNA
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
 drivers/pwm/pwm-lpc18xx-sct.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 754ea2c3f49b..46eeca27d9ab 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -197,7 +197,7 @@ static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (period_ns < lpc18xx_pwm->min_period_ns ||
 	    period_ns > lpc18xx_pwm->max_period_ns) {
-		dev_err(chip->dev, "period %d not in range\n", period_ns);
+		dev_err(pwmchip_parent(chip), "period %d not in range\n", period_ns);
 		return -ERANGE;
 	}
 
@@ -213,7 +213,7 @@ static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	if (requested_events > 2 && lpc18xx_pwm->period_ns != period_ns &&
 	    lpc18xx_pwm->period_ns) {
-		dev_err(chip->dev, "conflicting period requested for PWM %u\n",
+		dev_err(pwmchip_parent(chip), "conflicting period requested for PWM %u\n",
 			pwm->hwpwm);
 		mutex_unlock(&lpc18xx_pwm->period_lock);
 		return -EBUSY;
@@ -288,7 +288,7 @@ static int lpc18xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 				    LPC18XX_PWM_EVENT_MAX);
 
 	if (event >= LPC18XX_PWM_EVENT_MAX) {
-		dev_err(chip->dev,
+		dev_err(pwmchip_parent(chip),
 			"maximum number of simultaneous channels reached\n");
 		return -EBUSY;
 	}
-- 
2.43.0


