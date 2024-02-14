Return-Path: <linux-pwm+bounces-1455-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D9B85461A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BF51F2E115
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1DB1865C;
	Wed, 14 Feb 2024 09:34:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA911B95F
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903292; cv=none; b=VqoLHidgnUPjZ6FoHBSB8yLiivBT01cGQkdSeUxLsI7rCh01Y8IajJMyMachwxArNduneO6wTRfJt5EXErB7G4AY5rVMHKaHrS6qpbJTcBO4keyExTyT3tWQ+aehVePGVURgs8lGr6Kea0fEGS+PLvnjFL4BNVqvqmOwrubGnp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903292; c=relaxed/simple;
	bh=zmx6CkVyMRZ+p9Z6W0mBI5mv/cFop1w4pDDSWZ11gWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xl4nHg0LPSPoDJKr8IOGdK8OCnyw+QxYatCCH0Tdu9+Ym1CTfJhZNUXkJ9cQOleTIVqHonx+GUMmmdr8k+MJOvyyLOQdnmDjfs79qEUVjlub8lGDXykXJfaOcrshyqLm8wbh/95Nbf1oGz9Z+b/2YEfYHA85pOpq+JN2+wbxXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBfB-0006Gj-G2; Wed, 14 Feb 2024 10:34:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-000fIY-Uj; Wed, 14 Feb 2024 10:34:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-004YAR-2o;
	Wed, 14 Feb 2024 10:34:41 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v6 157/164] staging: greybus: pwm: Rely on pwm framework to pass a valid hwpwm
Date: Wed, 14 Feb 2024 10:33:24 +0100
Message-ID:  <e003bc5e8e66f27f2b8fdc525a536d865888cffe.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2196; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=zmx6CkVyMRZ+p9Z6W0mBI5mv/cFop1w4pDDSWZ11gWI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIj/K5x27b1JT1+7ha6RrUnUhsqs7V/tFHq3F uO1YdG9M6CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI/wAKCRCPgPtYfRL+ Tr4ECACmI77mrM25FdkwU4WlydO2QYJQT3v0OVmTkzL+mvUMcykMpV7/hXITxx64TwFEEtBYgby Z2qQhXjLOpzYVPlz7GTjf1EE8bWY3o7p5F6z+Ft+R2bGi53q0i5Pnz45mNCXUBI8KOhA1r9k5i8 9j0ZYhj1ROE+G08hgQresOJkGXAHhuOIlDfm66lMCB4DRzeEdWjpOXnJwgnNtzFcmsYKqYL4mxR SsLsh5DwhAnqAbjDLGauaMOElIJmRJPVjhjhvyFDRwAtGB6S8fJ69sMZe7q30BBQ5Du+1pTwZ64 eW8kWpJPYNwlRQFIb8z3xEUBWpGUiPx7mU6XtePzJCRK7ip2
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The pwm framework already asserts to only pass a hwpwm value (= which)
less than npwm (= pwmc->pwm_max + 1). So there is no need to recheck
this condition. Drop the respective checks.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/greybus/pwm.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 0cd1dab2d888..3099c2a3611c 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -46,9 +46,6 @@ static int gb_pwm_activate_operation(struct pwm_chip *chip, u8 which)
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 
 	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
@@ -71,9 +68,6 @@ static int gb_pwm_deactivate_operation(struct pwm_chip *chip, u8 which)
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 
 	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
@@ -97,9 +91,6 @@ static int gb_pwm_config_operation(struct pwm_chip *chip,
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 	request.duty = cpu_to_le32(duty);
 	request.period = cpu_to_le32(period);
@@ -125,9 +116,6 @@ static int gb_pwm_set_polarity_operation(struct pwm_chip *chip,
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 	request.polarity = polarity;
 
@@ -151,9 +139,6 @@ static int gb_pwm_enable_operation(struct pwm_chip *chip, u8 which)
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 
 	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
@@ -176,9 +161,6 @@ static int gb_pwm_disable_operation(struct pwm_chip *chip, u8 which)
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 
 	ret = gb_operation_sync(pwmc->connection, GB_PWM_TYPE_DISABLE,
-- 
2.43.0


