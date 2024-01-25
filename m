Return-Path: <linux-pwm+bounces-953-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7311083C1BA
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B958290607
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14047376E1;
	Thu, 25 Jan 2024 12:10:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D74374F5
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184647; cv=none; b=sxzoy9M2UwFGtJ3zmQLLCipzlMPeXDwMUAL+BCzTD5Kl96XPTcsOSQOb1t34Ri9KDssLSBUcT1bCwMOEurAeHRkFdkGR70LTmgyX1vQ6zSn4S5huKHgSytuDIo83pTRAG+z3/VCzAJFVMtgEFiDb0ovTeFkwg18datMalIxRsP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184647; c=relaxed/simple;
	bh=AKHPXfrakT+rp2/6Km/DLaOtX+PIsbVG0x1EpdplZtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTGtbZV7VowN2nj7D0hJ6m1rMv+HyGT9wSFWBykpVf6lHrItJINUR/r7OBgpSFcF6htXeWrt0XnH4M3KwGnvpkQkXa+FNcPYVz8KYmTDxPD5JRVrxR/eDnheNxrOi4RS3ypyLMZoXG8DObl2AXspISMhWtgAgf2lTL8V0R99cSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-0003Zu-0x; Thu, 25 Jan 2024 13:10:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ7-002HP8-6q; Thu, 25 Jan 2024 13:10:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ7-007myW-0R;
	Thu, 25 Jan 2024 13:10:41 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pwm@vger.kernel.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	kernel@pengutronix.de
Subject: [PATCH v5 007/111] pwm: bcm-kona: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:29 +0100
Message-ID:  <fb6613ad319901160fdea3fa6dbb917cb3d54015.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=AKHPXfrakT+rp2/6Km/DLaOtX+PIsbVG0x1EpdplZtk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9B4xD0YvrVvdbb7wL9mbu5EmtKNGdf0Lm03 ymfPBWMzKOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPQQAKCRCPgPtYfRL+ TgU4B/0RW0N0dR+zYyVW8/dgNen6vOOsuAoIcv3FvdsBXNvh3MXlNBx9bHHZiqCYuCSZF6dj9zh hHDOGuPh9SNm/K+XPEJKhmT6+qS6KGozv4WJer43m3MAaOGFoKEnOxAMcVeFEI3ksrUIBwYUtsr VapI3n2fs/YWdtEMHz9MHsE4+Xd+FEVXOKL+UXKxr695uH6/BRRhIPMYYfGi69KX9fkvATl9U9P 2kkIkf+1CUw/zj9qrwXy6ojnO2Sn/kno3Lm/RdHqRKx15Ao1Z5+w58mkEI3jGa4Aow99Jut1s/K bqJG0tQbcDnPINoNAHf67BbGyqOgzJnKi2D0wVX22pG5PO8T
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
 drivers/pwm/pwm-bcm-kona.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 45046a5c20a5..47acae8d7478 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -164,7 +164,7 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = clk_prepare_enable(kp->clk);
 	if (ret < 0) {
-		dev_err(chip->dev, "failed to enable clock: %d\n", ret);
+		dev_err(pwmchip_parent(chip), "failed to enable clock: %d\n", ret);
 		return ret;
 	}
 
@@ -193,7 +193,7 @@ static int kona_pwmc_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = clk_prepare_enable(kp->clk);
 	if (ret < 0) {
-		dev_err(chip->dev, "failed to enable clock: %d\n", ret);
+		dev_err(pwmchip_parent(chip), "failed to enable clock: %d\n", ret);
 		return ret;
 	}
 
-- 
2.43.0


