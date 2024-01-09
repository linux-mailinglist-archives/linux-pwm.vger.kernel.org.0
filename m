Return-Path: <linux-pwm+bounces-703-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6130F828EED
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jan 2024 22:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129B21F26012
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jan 2024 21:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560C03DB9C;
	Tue,  9 Jan 2024 21:34:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9360C3DB87
	for <linux-pwm@vger.kernel.org>; Tue,  9 Jan 2024 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJkC-0006d7-LL; Tue, 09 Jan 2024 22:34:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJkC-001Z2J-1I; Tue, 09 Jan 2024 22:34:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJkB-006684-36;
	Tue, 09 Jan 2024 22:34:43 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexander Shiyan <shc_work@mail.ru>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 4/5] pwm: clps711x: Drop custom .of_xlate() callback
Date: Tue,  9 Jan 2024 22:34:34 +0100
Message-ID:  <f58336c298d536107de5cab6a57e19f957ab326c.1704835845.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704835845.git.u.kleine-koenig@pengutronix.de>
References: <cover.1704835845.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=MRf9JAs8zCjPUJzbSQFNiSB8gbAELLop2Pk86mvT/YI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlnbvtCkegZGK8b4lOH4ObugUAivVjxHTc/xweO GSp5klUCMyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZZ277QAKCRCPgPtYfRL+ TvNjB/0SJdDG80i+BMkqUniB/tNuDFlHVBxzovEJ1nmIb2CpaynXJSpXcx6VpD20/osduQrTIzA 9+WDo5XCvm+XLhyUPAbjJkpUNo0O+pDi7W1dWVveCfyrnrh6EN/9K4N+fh2kDbjr5X+AUg9i8M9 TdeBKU1eK/RqLnhxbCkk0l/YX/jU4WE0imE+bEdgeeTh1XCmC9olO9eEs1rVmgkxCp31AGSOc7K cbbSBC66yFsbGUYFY4kx9D4S4xXfGF7TUcfSr1k5OnbmlFSFEzhJpFGet29XT4qlJeaq7S/PCfM crHLProsjMM/UzoD5jo4La4pKROn7UlPik49IIFVFNA/f52E
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The default of_xlate callback (of_pwm_xlate_with_flags()) does
everything the drivers expects from its .of_xlate() callback. So drop
the custom implementation.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-clps711x.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 06562d4bb963..f3b4af7963be 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -74,15 +74,6 @@ static const struct pwm_ops clps711x_pwm_ops = {
 	.apply = clps711x_pwm_apply,
 };
 
-static struct pwm_device *clps711x_pwm_xlate(struct pwm_chip *chip,
-					     const struct of_phandle_args *args)
-{
-	if (args->args[0] >= chip->npwm)
-		return ERR_PTR(-EINVAL);
-
-	return pwm_request_from_chip(chip, args->args[0], NULL);
-}
-
 static int clps711x_pwm_probe(struct platform_device *pdev)
 {
 	struct clps711x_chip *priv;
@@ -102,7 +93,6 @@ static int clps711x_pwm_probe(struct platform_device *pdev)
 	priv->chip.ops = &clps711x_pwm_ops;
 	priv->chip.dev = &pdev->dev;
 	priv->chip.npwm = 2;
-	priv->chip.of_xlate = clps711x_pwm_xlate;
 
 	spin_lock_init(&priv->lock);
 
-- 
2.43.0


