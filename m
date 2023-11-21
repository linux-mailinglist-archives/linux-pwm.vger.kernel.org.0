Return-Path: <linux-pwm+bounces-35-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 970517F2F6B
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D461C21995
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD8C53810;
	Tue, 21 Nov 2023 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65D9D75
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-0005Kv-JO; Tue, 21 Nov 2023 14:51:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-00Aay1-4X; Tue, 21 Nov 2023 14:51:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAL-004xcN-Rl; Tue, 21 Nov 2023 14:51:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 026/108] pwm: sifive: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:28 +0100
Message-ID: <20231121134901.208535-27-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ItlQpYUXEstYhNFNdEVbRgED9w4SaS6zldtNLGor7lI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVpzS9AHqndKJ3b8keNfZ49PWB8VdxmjiZs4 qJGkoAPhPWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1aQAKCRCPgPtYfRL+ TgObCACi5wtfu2xxH2gzWPdAlas2i1mShyDm6JBpQwmJFEBQZUyX/GW3aUWvOboaW/AcU8YPUvs 9EtoP+//Drk7dUns+l2HMuxIKEIao8awYFjkPec1o8znxQeXME9f2h71iDmUuBaQH/+gpTGLfBc WCpwJBO1zA3432hhxApHk3RMzSKCSpL0Eh8FUPbgrT+b8Ibkrq3Ngb4D0w6d6ZUl50F2QTK53iB /zzPUunjLHwCkWTr6eGNnqN+0GuZ+IMv7NbYMXG+vwyixseT/yOzd/CFwrAatjN2+vGuNk99ksE vlDTO77mKp7NKoGdufKMGcWHRXd9wFGHshbY9OaNqTK1YsfM
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


