Return-Path: <linux-pwm+bounces-11-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 374977F2F52
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661711C21712
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE64F524CD;
	Tue, 21 Nov 2023 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ABBD6A
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAI-0004wN-Rz; Tue, 21 Nov 2023 14:51:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAI-00Aawl-1d; Tue, 21 Nov 2023 14:51:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAH-004xau-Oh; Tue, 21 Nov 2023 14:51:45 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 006/108] pwm: bcm-kona: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:08 +0100
Message-ID: <20231121134901.208535-7-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=a6rdmbZKU11BMNMtNYdQhs2WfPNB8F0MjUDfYmBxZiI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVUXEm9MHfbrkRBNCwCvgiAbbpbymYTz+9Un lMk9iqgyEKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1VAAKCRCPgPtYfRL+ Tso+B/45xEFuBm+QYlj44Fmj5qi9Gr44JyFx44AM6oKbzzODbfZ6dXbenG30kNEQED9VbBOYN17 s7lIMlExdrCu/UmuoS+7f2IQKw796DM2kX5FEL2DiRME2YWT01JO7ozI+7XchA+Vy+TKFxPC5lw De89ttgyP8/TXTNnMzcGWYo5FzrMSxUZV9H+1rfVq/VlSwF/cXYI4g/pPnjivXxH2qWsTXYN5vk 75ET9hXyX0qPcUsGJIbRnma5VtYJxe3HExepT+gFg8sLmv4RuqIc6etXs+b6oCtMC5t8bIxqxh3 zOcIiiS3UkOLJ6vQ6LbRmVH2DySm+EAwSByNMNk/4au4avIJ
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
index 15d6ed03c3ce..53bb52c9da08 100644
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
2.42.0


