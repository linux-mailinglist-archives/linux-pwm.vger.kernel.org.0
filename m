Return-Path: <linux-pwm+bounces-333-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F24E4806E6E
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2F71F213EB
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946C1358A0;
	Wed,  6 Dec 2023 11:48:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9AAD59
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOA-0006LZ-7J; Wed, 06 Dec 2023 12:48:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO9-00DwtI-Pj; Wed, 06 Dec 2023 12:48:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO9-00FQyR-Gj; Wed, 06 Dec 2023 12:48:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 031/115] pwm: sifive: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:45 +0100
Message-ID:  <97729fa5438d05626c8b83c13892c63da7bd7e50.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ItlQpYUXEstYhNFNdEVbRgED9w4SaS6zldtNLGor7lI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6FJQLDT/6RotOS62rWjUkJHmBKasIU3XRRu MtA7PSz+peJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBehQAKCRCPgPtYfRL+ TpS7B/9m+lrgfd9N31AhuVTEOY1WjeK1XWnl4oXV17GcP+WUquky5UjPBuuz4FvAivRzv6fdqOW AdbR/PDFpHb3j1Ny06ZQdhYxT4uhFhsYSrkVWSiybDXuYluHk/XPFIzfSMeyFjTHJPywxIvY/yf 4nnhfKslKXjHun/RYH9J12j7EP66jlHSEEXcN7TGu33KziTBf6YMWtLiGG0kaHbPnIZ4wE4//m5 OupzhCXPNrE/p9Nhe2+/M6vIf9WkHz6Je2yftMOba0mQCH/DARRgAyX7tAHzGG5A1EdqUGhJhhW 5EvCTxc6pYwzliDvTLk6l8Ee5jomZSSaAvZIayeTRKFnYmwK
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
 drivers/pwm/pwm-sifive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 089e50bdbbf0..c1b412905d9e 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -102,7 +102,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
 	/* As scale <= 15 the shift operation cannot overflow. */
 	num = (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scale);
 	ddata->real_period = div64_ul(num, rate);
-	dev_dbg(ddata->chip.dev,
+	dev_dbg(pwmchip_parent(&ddata->chip),
 		"New real_period = %u ns\n", ddata->real_period);
 }
 
@@ -185,7 +185,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!enabled) {
 		ret = clk_enable(ddata->clk);
 		if (ret) {
-			dev_err(ddata->chip.dev, "Enable clk failed\n");
+			dev_err(pwmchip_parent(chip), "Enable clk failed\n");
 			return ret;
 		}
 	}
-- 
2.42.0


