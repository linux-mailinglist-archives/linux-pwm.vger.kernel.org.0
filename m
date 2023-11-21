Return-Path: <linux-pwm+bounces-26-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C157F2F64
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020EC1C21132
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD754F80;
	Tue, 21 Nov 2023 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FD8D6D
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-0005LZ-Tw; Tue, 21 Nov 2023 14:51:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-00AayA-GY; Tue, 21 Nov 2023 14:51:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-004xcV-7Q; Tue, 21 Nov 2023 14:51:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 028/108] pwm: stm32: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:30 +0100
Message-ID: <20231121134901.208535-29-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=BiIJD0Tq83cq7moryfFH9gyYiLGEDBNRcTCtX9A+nHI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVrKamzo059IDn9Bz0ICE63cZQkJbSdbJPvs yBcg3j/30iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1awAKCRCPgPtYfRL+ TjAJB/sEKV1EpNt9BVuq0M74NChKDcJS2AD2S0xSI1tKjbP1mG4RXX4a/x0f2OAC98RQ/B9/t6+ SrJa35PDIU+CLPk9fM73iS5OWNh/n6eeSmfUWg5sXB9wRvd9/zQIAakFnao8+54TifdA3MR/cPn fr49yQRRaoZ/4wR/obNsm/ii9HugQAlF+bYCupfX/8twL7JlxwjqD5Tvt4bv2Pbq4g/AcnrRDkM k82OiQ5OHnSprFH7RsvWJ39i4bVkseGunwBZ1SS4SHQNeZ+bPe2E+lYsasR9d5LSvFQB4WmXKlK /adoKsinmhoLebc7UPNEGfAoGw+9oogo9nKobXdC27bXNERK
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
 drivers/pwm/pwm-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 5f10cba492ec..d1dc9e3ca2a1 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -94,7 +94,7 @@ static int stm32_pwm_raw_capture(struct stm32_pwm *priv, struct pwm_device *pwm,
 				 unsigned long tmo_ms, u32 *raw_prd,
 				 u32 *raw_dty)
 {
-	struct device *parent = priv->chip.dev->parent;
+	struct device *parent = pwmchip_parent(&priv->chip)->parent;
 	enum stm32_timers_dmas dma_id;
 	u32 ccen, ccr;
 	int ret;
@@ -170,7 +170,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = clk_enable(priv->clk);
 	if (ret) {
-		dev_err(priv->chip.dev, "failed to enable counter clock\n");
+		dev_err(pwmchip_parent(chip), "failed to enable counter clock\n");
 		goto unlock;
 	}
 
-- 
2.42.0


