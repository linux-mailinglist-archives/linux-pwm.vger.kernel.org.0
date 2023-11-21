Return-Path: <linux-pwm+bounces-8-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B7B7F2F54
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B73B20F5F
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379935380E;
	Tue, 21 Nov 2023 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3FBD7C
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAI-0004xT-LM; Tue, 21 Nov 2023 14:51:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAI-00Aawp-82; Tue, 21 Nov 2023 14:51:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAH-004xaz-VA; Tue, 21 Nov 2023 14:51:45 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 007/108] pwm: crc: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:09 +0100
Message-ID: <20231121134901.208535-8-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=d/ra39KIKxXZ/vtsejNkP2bftpXRV5M+I9nichP4Fbo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVVSufAOUmqsfF5wlr99hBu1/Mz1mkCkMPho 6L+O4BupvSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1VQAKCRCPgPtYfRL+ TjCWB/wJO2SFA8UCimmGl7RNhyS266Q8snN1u6J0K4lw/RO3RZGd2JLcJ334MTV8zuWvrA9Iy2/ X4c+vM5EHQ0aBFTQAplvCqb5vnPZKD5yw/mHdvPtLAPA+r5tHLovTUY1InXHu0CKAAt21bGYx/z yhtkW449v2TdjoMjaUpwYFXXaj0vIc9hFFVFN1Bb19KqHyNnniFnxuEStld7ruG3IPOsA1/7Zt8 oCfZaiyaEplweIaVWek+05ajY/IqM3Rfw4UveSRnKSdpf0rboQDA5T1XgZ8Y6/xh9MLIIIrdlCr qencioyhf9r8Dt2HQ8Swd+Rr3mYQkyZoi6pXu8ASTSOhemwT
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
 drivers/pwm/pwm-crc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 2b0b659eee97..d08c3112aaba 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -55,7 +55,7 @@ static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
-	struct device *dev = crc_pwm->chip.dev;
+	struct device *dev = pwmchip_parent(chip);
 	int err;
 
 	if (state->period > PWM_MAX_PERIOD_NS) {
@@ -125,7 +125,7 @@ static int crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 			     struct pwm_state *state)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
-	struct device *dev = crc_pwm->chip.dev;
+	struct device *dev = pwmchip_parent(chip);
 	unsigned int clk_div, clk_div_reg, duty_cycle_reg;
 	int error;
 
-- 
2.42.0


