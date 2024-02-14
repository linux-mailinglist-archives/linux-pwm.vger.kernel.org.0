Return-Path: <linux-pwm+bounces-1354-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CADE8545A6
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383DC288446
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E193918EA5;
	Wed, 14 Feb 2024 09:34:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4D1427F
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903270; cv=none; b=fIr89Ld7M8dDPdGEJ4S3qFD26gF5REcZYgHo/rFXCHYnHtzMkkRlmI7uNzk6SjoKFRL14vs08skId9ZAeqU2WRKUEOQFebRzTl2P6YeEYAGO3d2MOs8LX5eJQGLYJsvv3pd0q9Y/6hXxLSYDAI4Rsw8SI4P7k1zcp9cnUF0+Ft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903270; c=relaxed/simple;
	bh=4ZI5XtHa1Kau5D+m1e8jHgMkCmDO+Pq7rNhbnoNObs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBoKBl3SlkPjXFpkUTq2Iq/zx/tiv9WN4CvGvGA2WinrYWWzEz5Le6EzaXzHE8Tisbr6AYdaEGa90ngFI9dZg91geQhYO9bVwZ6tapO86sLA6tgm9q1vAxYrJLGepr5k0pcVqhLp6LWPIjCmT7mUhjav5Bu7kKhM+yeyn3qt9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-0004dR-UD; Wed, 14 Feb 2024 10:34:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-000fAu-BP; Wed, 14 Feb 2024 10:34:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-004Y25-0u;
	Wed, 14 Feb 2024 10:34:23 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 035/164] pwm: ep93xx: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:31:22 +0100
Message-ID:  <3bf56f20bc7f749e5a353cdcfad11dd1ba573381.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=4ZI5XtHa1Kau5D+m1e8jHgMkCmDO+Pq7rNhbnoNObs8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhy0ax8DzAvTI2d/SqYVM9bAGyBNaZuPImWY wQlaxrvH9iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIcgAKCRCPgPtYfRL+ Tl/eB/wL6CCliTLtLLHHJV5Di0zlSPYL690M27DzxeoYQMmzSREhk1aiCiIYvxVD0id1Rlsk4MA fyx6qQwwdbQ+WN1fs6LirK3893K1wZZl8RAgLHxlj58m9bvv27xMFYrHI2b+dk9QFRmskDoVbRl zjFgJ/OaDIKOVSMTuM9AL59e0poA3Fo1W7Yt84jCj58dmJfOzL9tsNEnr97wesCQS92PUN8vYIJ WoKLSvYw53NmM06330SoW+Rtpp8djO4mn8PakORRhIJNXCmFS/cp1uRRFH2cG3OWl6raLleXmbN SZyF21aGOKzOJpCqgwm+wKdXxMlXT46SbtGj0eVBNlV9qAHi
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
 drivers/pwm/pwm-ep93xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 51e072572a87..e4c3546a61c8 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -46,14 +46,14 @@ static inline struct ep93xx_pwm *to_ep93xx_pwm(struct pwm_chip *chip)
 
 static int ep93xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct platform_device *pdev = to_platform_device(chip->dev);
+	struct platform_device *pdev = to_platform_device(pwmchip_parent(chip));
 
 	return ep93xx_pwm_acquire_gpio(pdev);
 }
 
 static void ep93xx_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct platform_device *pdev = to_platform_device(chip->dev);
+	struct platform_device *pdev = to_platform_device(pwmchip_parent(chip));
 
 	ep93xx_pwm_release_gpio(pdev);
 }
-- 
2.43.0


