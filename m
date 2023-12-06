Return-Path: <linux-pwm+bounces-328-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475F1806E76
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF9CBB20E17
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ABD3588F;
	Wed,  6 Dec 2023 11:48:39 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE96C9
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO8-00069j-9Y; Wed, 06 Dec 2023 12:48:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00DwsT-LQ; Wed, 06 Dec 2023 12:48:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00FQxb-CR; Wed, 06 Dec 2023 12:48:23 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 018/115] pwm: imx27: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:32 +0100
Message-ID:  <5e8f73d0742507f4e7ddad050d2e79812a1cd62f.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=21gVfHE440/T65WsIsIoIm1SwOOZ2P7hANAjmVXXXN4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF5rDa/KaXKZb0ymZqUkNMlwSUb3IEXUaV5oG Taafl8zC/2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeawAKCRCPgPtYfRL+ TssSB/sHh+RrIESyXwRdBPXdhvRwnfneE5DVDTV+o2xuLEnePwDaEjBS3J5EFP6UVIwjtS1Qi0G cYaJGsJl0oP7ysaElMmn1S2yzu3q5kpzq4Bd/kDOpN93GRk7FNQvoOBoI/buoEWWg4rnh0/SiPQ LYdX9BxcLaPuSpBQID2Tr1/KTpPUeKT1aeqlUDoHRVwuY4Mtacl3iuYO3jf/ka1JdVCO3eIA0qb yqwD+AAUcWal2bu/i1nxhT9fy6PZ3EgdKZhf8JCerEczyL9bj/h/Ij3A7X+BNtQCAGrxYWIXoQN SgeWlxVjqED0nTJ62wrauWKExhm6Sgz371LQdE9njkx8BJaE
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
 drivers/pwm/pwm-imx27.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 7d9bc43f12b0..5d796453519a 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -145,7 +145,7 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 		state->polarity = PWM_POLARITY_INVERSED;
 		break;
 	default:
-		dev_warn(chip->dev, "can't set polarity, output disconnected");
+		dev_warn(pwmchip_parent(chip), "can't set polarity, output disconnected");
 	}
 
 	prescaler = MX3_PWMCR_PRESCALER_GET(val);
@@ -177,7 +177,7 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 static void pwm_imx27_sw_reset(struct pwm_chip *chip)
 {
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	int wait_count = 0;
 	u32 cr;
 
@@ -196,7 +196,7 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 				     struct pwm_device *pwm)
 {
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	unsigned int period_ms;
 	int fifoav;
 	u32 sr;
-- 
2.42.0


