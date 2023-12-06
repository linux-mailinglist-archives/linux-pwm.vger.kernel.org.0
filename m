Return-Path: <linux-pwm+bounces-324-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4D3806E71
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06779B20DC3
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A2B34CFD;
	Wed,  6 Dec 2023 11:48:37 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A64918D
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO9-0006Jy-RD; Wed, 06 Dec 2023 12:48:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO9-00Dwt6-9e; Wed, 06 Dec 2023 12:48:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO9-00FQyG-0g; Wed, 06 Dec 2023 12:48:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 028/115] pwm: rcar: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:42 +0100
Message-ID:  <b890eb8edbd96cb52bde21e103d56828fa5d3496.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=u7VyIWqdVHbmuZe1jcG6zXrm7SUTQzA8yhVAYBguXFI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6B3NrOCnsMLvi6pBDmJUQp7Atm8lYwUJoNJ M0Ha1A/9LeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBegQAKCRCPgPtYfRL+ TjvNB/0VE7X5bNIiIe7ZzUSTFKNFSfBZ8IWkUXdioNElgmP3pIMvcMYpXCsFSGcrqRzP1eb1nJp YL4eD8uaI353xpzROpevmqNkjJN7gK14b3I51LT85Kl2abAslrwPZsFT6szrYcWoEES1v6445SX 2VuAzqk2B2N0BcvD3tUtWBR5hqOb21d1y1zENsALnj756du2knu8+dwENLQ/IqWrdXLKehV6Q3J jDToPDME/jJ//WJ+g49s196JkF68Pu5KoT5Ja9bdG+PSw1jbjAqkrx/QU/3D/3zLNvq6leGnhOE Vdc01/BybHVlaOfvOrE26FiuIg1g5a3ApyNX2ax7jcE6NdkW
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
 drivers/pwm/pwm-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 13269f55fccf..4838762137d1 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -132,12 +132,12 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
 
 static int rcar_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	return pm_runtime_get_sync(chip->dev);
+	return pm_runtime_get_sync(pwmchip_parent(chip));
 }
 
 static void rcar_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	pm_runtime_put(chip->dev);
+	pm_runtime_put(pwmchip_parent(chip));
 }
 
 static int rcar_pwm_enable(struct rcar_pwm_chip *rp)
-- 
2.42.0


