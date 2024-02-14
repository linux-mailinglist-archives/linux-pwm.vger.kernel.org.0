Return-Path: <linux-pwm+bounces-1335-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C69685458E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCAA1C25816
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2E21862B;
	Wed, 14 Feb 2024 09:34:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7FE179BD
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903268; cv=none; b=UEJ659vclLxYbG+jDwF8ET0jVQ8fTY+KDwveJjNRg8WsI9t3dUtq8O1ZnNG+oxl3VLOrWwenWSfxI+o7qzGH/Kaz6cC4xTTRXeku8aHHjcobOKJOlLcIPM+VRmaGYG6nBHqUvV4mcpYu5eoUAC37EevGwNh9fYDYgQYDt6NMlpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903268; c=relaxed/simple;
	bh=FG70ilHAq0NBbomYC4TGbc4gUhB/LxSNheIAJhvfua0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IK6UmTwuXbB9G9q3LZKY8iZl1jgqtOP+eBHJjOtl51KMEYk1Pg8ISfluB8mAm0KfGd4S/P2Mu4hdEN5/6D9GTLZb9rxZ3SP6BvBMFSWV0hOCVqZv89ncs5B2bNZA49f6GiOVWboDvSBbUb5XNlO95R1C6d7GizTJ1+T3oFnhIMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-0004b7-Au; Wed, 14 Feb 2024 10:34:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeo-000fAE-Hi; Wed, 14 Feb 2024 10:34:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeo-004Y1b-1U;
	Wed, 14 Feb 2024 10:34:22 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Benson Leung <bleung@chromium.org>,
	linux-pwm@vger.kernel.org
Cc: Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v6 030/164] pwm: cros-ec: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:31:17 +0100
Message-ID:  <486c40609bd9e339d7e5576e2501f63111b59b8b.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=FG70ilHAq0NBbomYC4TGbc4gUhB/LxSNheIAJhvfua0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhtO9EyHqMDX6V68DhKKkEPTA0bpLn8Zx7/u UDHAEZMK5iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIbQAKCRCPgPtYfRL+ TiqbB/9IUoxFj4bF4xL559HwAea12a/bMEE6PqO5BddvMtXGeNiOzx6IZrpi8sZ8FmHdv9pE0gh XDxvlZDQEYO2SxDb77vpyf3JYcUpVWj2Jg2Afm+bUeU1lKCOnrnT/OaG6LMqXJWGroeLx5yKXUF FuJLtoIxFnqSx2gc/7Tc5pjxP8bHSarfG3lxsg66PQgrkiNhiwP+MpN+ZxDm+Jfzne1A5ueaGKK Wp6mzokiXi6g/WPWUuclUg3QWd2cTSahft6lrBheGCtz84cjBtTMxXXQ4iAB3avXsBhXJas/Q9w Kct5MnDMgvMGU8uN3Aw+5iHfx8QuCP2fH9m49DUC+4KyNe64
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
 drivers/pwm/pwm-cros-ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index e556f6218dd7..968e300e9f06 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -172,7 +172,7 @@ static int cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = cros_ec_pwm_get_duty(ec_pwm->ec, ec_pwm->use_pwm_type, pwm->hwpwm);
 	if (ret < 0) {
-		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
+		dev_err(pwmchip_parent(chip), "error getting initial duty: %d\n", ret);
 		return ret;
 	}
 
-- 
2.43.0


