Return-Path: <linux-pwm+bounces-964-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F2783C1F0
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6C3B225D5
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C840C3B19D;
	Thu, 25 Jan 2024 12:10:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908C3A27E
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184648; cv=none; b=ULRsnx/G8vzWUls8akAqPtSteWdNsz+dEDbepXmGacLy6pptT66HrEn1VPkKBVByBYSpz7smiSNUmumWpWgX3MLugyEJ964rLL0zolpPDxd805ADNgZo4zmCC1HpygYbokuxFla916yV99RfvdBciIN6kTXHUd77iU64Ak5K8qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184648; c=relaxed/simple;
	bh=GRLB8CL90BALkefgvjtAJKC8I9k77SWGZxDnOamHqv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dcz9d5v9UMVFegc7fTfj6o2OSaL47D2oIDxEeca4AUhUTVKKso5Kl69cUX1bfI4hLk6DaBKcJ93JdrjJV5di8iy/xzwA3ZHchK9jCPucmEjiSqHmKpO4H6or5YaZBUDfrUpgdOsF+jJDXIluJIamVoeNfT60nlp1aTv/DwvIVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-0003eO-GH; Thu, 25 Jan 2024 13:10:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-002HPL-00; Thu, 25 Jan 2024 13:10:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ7-007myr-2x;
	Thu, 25 Jan 2024 13:10:41 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 011/111] pwm: ep93xx: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:33 +0100
Message-ID:  <44fc43ab8f58342648d0b9e54810fc6727e50d81.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=GRLB8CL90BALkefgvjtAJKC8I9k77SWGZxDnOamHqv4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9GjpXCUe9qQWC7OR5cr1jQrQMbLeAlbbWn2 L7oUVgxM92JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPRgAKCRCPgPtYfRL+ Tt8eB/9hFGLBx2AiZ7ryb0PPcOOZKFZ+Q+ghAT9G8Zqp2Qv3e/a02lW5PfD577Fo4zm1wanVyRh wwdTkw1X35tYY8sDQjakxdAujPK3mDD413la8C6zErHPK8H8nJNCCi0KGKRNSRwZjHJR1vto4df OsN4TTN15Vx6DIiarytbVg+sX3nu8rLgTQ85srCLMdMTEGTvSIhRj/Svx/+ca3P3Mu1VgODqI6p rob+UssrhuF5bCZ4//hRglu5KvY8f5eGTh4nBCDhIXYvuTf7wyxwqoW/hos3DcsjROGyaTbEZlm ZecMgoTx1nXM2QA4TvvNaoPPxNkEuQZaAxbNsY/ihXcb9oKx
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


