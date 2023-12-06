Return-Path: <linux-pwm+bounces-310-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE02806E52
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C131C20A58
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C163F34572;
	Wed,  6 Dec 2023 11:48:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD1A18F
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:24 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00062k-1w; Wed, 06 Dec 2023 12:48:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-00Dws4-L3; Wed, 06 Dec 2023 12:48:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-00FQxD-CC; Wed, 06 Dec 2023 12:48:22 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 012/115] pwm: crc: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:26 +0100
Message-ID:  <de2d8ef5008e1b1c0540f51a1ea91de68f10dd34.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=/xwRDMObpCl55i/aNC5PsnqHtr5XFtNl3Dm7VkI9iUI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF5fabdyK23lcj/HAUozKePMRUz9ncDjixfwY LU/p5RCDQmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeXwAKCRCPgPtYfRL+ Tr3fB/9BUreBV9gyGdJjMdSdOQNkaFO7nRSrYufKI7vTjgPYnN7pP0UFixBawDQDrxv2Af9WsKo hGuYPS8z3uux1kFwleu7qQSD/0VvYj/OuUJbxI4iIor39KcSPQHoyzHoaCTzjCFlyaYG6sM10v2 lxxsb/kQH3ht6SiumoWY7Ot//ZeKDw0ehd3oAL9oD6lQBdODGXcsus80OufPMFDc3bTE45rYkbS C0EzzLu++p90ygDdAKxoLUcaBAw63aarO6NiUzxT1KIQSRf7MR62vDfhp1aMhJCIsD8esatdenC jMiY06/Il8jqOrBBYa5ZbPb8zA3PeQQU4U3R+NL3FggQedSK
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
index e09358901ab5..c8a852345a97 100644
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


