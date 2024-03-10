Return-Path: <linux-pwm+bounces-1735-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4FC877629
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 12:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE281C209F1
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 11:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9351EB46;
	Sun, 10 Mar 2024 11:01:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16861EB42
	for <linux-pwm@vger.kernel.org>; Sun, 10 Mar 2024 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710068475; cv=none; b=u/Tjggn264boANdWOYPhWVLsl9I0wX1HXiKQhUQU1sNnbQ+fst7sWxysseQbR+mo2dO7tDjK/wNcWgRgK02Yk0yOD7RArgMjktXTPL5ohauTS2fsgIeBvuTUw5hE0WT+wkEtMtemDRyeBAkKKPYuXO3ZdBiknD2pE2hpvAUWn+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710068475; c=relaxed/simple;
	bh=9mIlvGviyi3ENAg2Dsi14QSLiDZgNdJfeHx4f2916OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XymcPoi+O1yJe2aRESGxZdO5YwOovOuniNaqAEK63EoJGtH1JbEgCn/8I9G2DPZrPjhm1zwm+ovKDgYnGJkAJQmG0r+v26JPLb8i/4b81asRw68f95fuEIwuIx9+KNUI9e6axPt3FP8OqV9My1pqAdROtB2Qp618HGM/AZjzeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvW-0000tC-Qy; Sun, 10 Mar 2024 12:01:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvW-005V12-Bv; Sun, 10 Mar 2024 12:01:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvW-003OFq-0v;
	Sun, 10 Mar 2024 12:01:10 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: Ajit Pal Singh <ajitpal.singh@st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Lee Jones <lee@kernel.org>,
	kernel@pengutronix.de
Subject: [PATCH 6/6] pwm: sti: Prefer local variable over pointer dereference
Date: Sun, 10 Mar 2024 12:00:59 +0100
Message-ID:  <a7a81f3838f7ed7f4d6dbee3d646989cc265f676.1710068192.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710068192.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710068192.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1985; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=9mIlvGviyi3ENAg2Dsi14QSLiDZgNdJfeHx4f2916OY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7ZLuILVdlePs6NuG6tu0Wi6Jfd894UpKmMOEJ hVntMQsOmCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe2S7gAKCRCPgPtYfRL+ Tr11B/9ZKlxfX5uQMTJWs5FaFpNgq87eyjQgZJb9ksuT3hdGvaIELN7jvOQTZFk1IyOkv0Us8dt lyEpwjytt6Yj5NaLNAvATgyrzdq71nJgtsOR4uQyBMtp0Vcd5vw4xMcfvP+kjx5HyrAHZA1Ox3K pvBUHeHSjWUnGq0bZUvaz+GIEx+fJ0O4sFac+m3xzIkT0CmiiwxDQUkD/icaDagcA0PEKGH2lhj CO8GGQ/U7FbCFYZ0/vIjG50ttIyEM4FYnExPW+K6PAyoWnmMXIUhPnUNNMcwLj1hSeju3GkXdoU /f2QEqkPlJvcSLdY0swT9jmlaYER7fIg2QmRlXoN+cT2XprH
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

While the compiler probably optimizes out the pointer dereference, using
the local variable holding the same value also benefits the human
reader. So simplify accordingly. Also move a loop over all capture lines
into the capture if block to group the operations related to capturing
in .probe().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sti.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 7a7d1c622a17..396b52672ce0 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -600,34 +600,34 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to initialize regmap fields\n");
 
-	if (pc->pwm_num_devs) {
+	if (pwm_num_devs) {
 		pc->pwm_clk = devm_clk_get_prepared(dev, "pwm");
 		if (IS_ERR(pc->pwm_clk))
 			return dev_err_probe(dev, PTR_ERR(pc->pwm_clk),
 					     "failed to get PWM clock\n");
 	}
 
-	if (pc->cpt_num_devs) {
+	if (cpt_num_devs) {
 		pc->cpt_clk = devm_clk_get_prepared(dev, "capture");
 		if (IS_ERR(pc->cpt_clk))
 			return dev_err_probe(dev, PTR_ERR(pc->cpt_clk),
 					     "failed to get PWM capture clock\n");
 
-		pc->ddata = devm_kcalloc(dev, pc->cpt_num_devs,
+		pc->ddata = devm_kcalloc(dev, cpt_num_devs,
 					 sizeof(*pc->ddata), GFP_KERNEL);
 		if (!pc->ddata)
 			return -ENOMEM;
+
+		for (i = 0; i < cpt_num_devs; i++) {
+			struct sti_cpt_ddata *ddata = &pc->ddata[i];
+
+			init_waitqueue_head(&ddata->wait);
+			mutex_init(&ddata->lock);
+		}
 	}
 
 	chip->ops = &sti_pwm_ops;
 
-	for (i = 0; i < pc->cpt_num_devs; i++) {
-		struct sti_cpt_ddata *ddata = &pc->ddata[i];
-
-		init_waitqueue_head(&ddata->wait);
-		mutex_init(&ddata->lock);
-	}
-
 	ret = devm_pwmchip_add(dev, chip);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to register pwm chip\n");
-- 
2.43.0


