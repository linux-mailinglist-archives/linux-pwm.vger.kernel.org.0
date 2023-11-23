Return-Path: <linux-pwm+bounces-166-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A93277F5BBE
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 10:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6549E281873
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 09:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2B922307;
	Thu, 23 Nov 2023 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F3DCB
	for <linux-pwm@vger.kernel.org>; Thu, 23 Nov 2023 01:56:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r66Re-0004EO-Ve; Thu, 23 Nov 2023 10:56:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r66Re-00B0gU-Gi; Thu, 23 Nov 2023 10:56:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r66Re-006Xi1-7X; Thu, 23 Nov 2023 10:56:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] pwm: core: Narrow scope of struct pwm_device pointer
Date: Thu, 23 Nov 2023 10:56:20 +0100
Message-ID: <20231123095619.424895-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YLmHh976wION6+Y3UOOUa5+0u32If9TCsyxNNY/zpK4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXyHDVeuDj5U0z+KfDB610E9AJ6LD1sKQ+PZiA zBYSObwI8yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZV8hwwAKCRCPgPtYfRL+ TtaFB/0YSyN9qnZ9HJLE08jfhYqgU1p+VXELNFBfiN7vUV+cy7tOXb+8R1VBQQgi18f9TL7n0gW a0zNxdQ7bvFelWzPJt1t29ShvCDv0sW9wmeQ0ktelIKRwA1xZCRmEiwcqJHgpRoMglyafNNIYgo 3lYv/HkCkwwPkUwV+jf2CB6+N2+MSOqIrftyuh5djXlcNgbR5eR0JbHa5h1wjT5ER0J7JkDSLGu ST+DmaVec9Cel/r//jSsYtNa6ySfsqI5OUmFxBq3ZiBsrr65dwW6mz8ja7JATVolk1bkEJupoFf kQiKgiTB8RnitkHwFE+DfyrvK79t3R1pPdubUMelu0hHivQG
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

In the expression determining the size of the allocation for chip->pwms
it's more natural to use sizeof(*chip->pwms) than sizeof(*pwm). With
that changed, the variable pwm is only used in a for loop and its scope
can be reduced accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this improvement was contained as unrelated changes without mentioning
it in my pwm-lifetime series. I think doing that is fine independent of
this series, so here it comes split out.

Best regards
Uwe

 drivers/pwm/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 58a9d3df73a1..f60b715abe62 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -208,7 +208,6 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
  */
 int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 {
-	struct pwm_device *pwm;
 	unsigned int i;
 	int ret;
 
@@ -220,7 +219,7 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	chip->owner = owner;
 
-	chip->pwms = kcalloc(chip->npwm, sizeof(*pwm), GFP_KERNEL);
+	chip->pwms = kcalloc(chip->npwm, sizeof(*chip->pwms), GFP_KERNEL);
 	if (!chip->pwms)
 		return -ENOMEM;
 
@@ -236,7 +235,7 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	chip->id = ret;
 
 	for (i = 0; i < chip->npwm; i++) {
-		pwm = &chip->pwms[i];
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		pwm->chip = chip;
 		pwm->hwpwm = i;

base-commit: 869de350ff3834145273a6d39faedea878c6715a
-- 
2.42.0


