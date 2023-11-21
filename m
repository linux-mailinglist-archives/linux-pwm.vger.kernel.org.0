Return-Path: <linux-pwm+bounces-50-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5807E7F2F82
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7071F24403
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EE653805;
	Tue, 21 Nov 2023 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03D3D7E
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-0005KJ-UI; Tue, 21 Nov 2023 14:51:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAL-00Aaxx-UK; Tue, 21 Nov 2023 14:51:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAL-004xcJ-LC; Tue, 21 Nov 2023 14:51:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 025/108] pwm: samsung: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:27 +0100
Message-ID: <20231121134901.208535-26-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3577; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YI45MGg8M9zwqLaT36AYGl6F6OyAEfc/1qu6ZaMBZmA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVomsDFiLOfsA/45bt6C/1nyDIDffMKmbuE5 xlXK8YcoVyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1aAAKCRCPgPtYfRL+ TrvtB/0RP2pK7jtaMH0UksDqZu8M4wGQ0wkvxv21cRMBuVp99Lz9RyjuUeI60Pm2L5T6aMjP5Nb H6ronZlGBXOoDysMVyB/7JQnAmd/1G+InYKQbWIBgfAgOxlQEUjPkLi4A7MvnFv/HJaDiFTBw3c XDmXchUx4FrwibbF6Xy7gR3ExrgVhgfDpSX91hl7BShW6yFvta5NThrBK+xk6EqDkjy0d2VRE8q IYA8r2RrRT7vpQqndPwxvAf9f7k5BAmyYgD1XUap8aN4htyx/CXuSCEQ6JsZVOYK70BFK0bK14m z3z5amwZvWFmiSfzBKx/ljKxCih/hqNItm3crdhKDB2G2svz
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
 drivers/pwm/pwm-samsung.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 6e77302f7368..a97cae49406e 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -197,12 +197,12 @@ static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *our_chip,
 				return rate;
 		}
 
-		dev_warn(our_chip->chip.dev,
+		dev_warn(pwmchip_parent(&our_chip->chip),
 			"tclk of PWM %d is inoperational, using tdiv\n", chan);
 	}
 
 	rate = pwm_samsung_get_tin_rate(our_chip, chan);
-	dev_dbg(our_chip->chip.dev, "tin parent at %lu\n", rate);
+	dev_dbg(pwmchip_parent(&our_chip->chip), "tin parent at %lu\n", rate);
 
 	/*
 	 * Compare minimum PWM frequency that can be achieved with possible
@@ -232,7 +232,7 @@ static int pwm_samsung_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 
 	if (!(our_chip->variant.output_mask & BIT(pwm->hwpwm))) {
-		dev_warn(chip->dev,
+		dev_warn(pwmchip_parent(chip),
 			"tried to request PWM channel %d without output\n",
 			pwm->hwpwm);
 		return -EINVAL;
@@ -326,12 +326,12 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		period = NSEC_PER_SEC / period_ns;
 
-		dev_dbg(our_chip->chip.dev, "duty_ns=%d, period_ns=%d (%u)\n",
+		dev_dbg(pwmchip_parent(chip), "duty_ns=%d, period_ns=%d (%u)\n",
 						duty_ns, period_ns, period);
 
 		tin_rate = pwm_samsung_calc_tin(our_chip, pwm->hwpwm, period);
 
-		dev_dbg(our_chip->chip.dev, "tin_rate=%lu\n", tin_rate);
+		dev_dbg(pwmchip_parent(chip), "tin_rate=%lu\n", tin_rate);
 
 		tin_ns = NSEC_PER_SEC / tin_rate;
 		tcnt = period_ns / tin_ns;
@@ -355,8 +355,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* -1UL will give 100% duty. */
 	--tcmp;
 
-	dev_dbg(our_chip->chip.dev,
-				"tin_ns=%u, tcmp=%u/%u\n", tin_ns, tcmp, tcnt);
+	dev_dbg(pwmchip_parent(chip), "tin_ns=%u, tcmp=%u/%u\n", tin_ns, tcmp, tcnt);
 
 	/* Update PWM registers. */
 	writel(tcnt, our_chip->base + REG_TCNTB(pwm->hwpwm));
@@ -368,7 +367,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * shortly afer this update (before it autoreloaded the new values).
 	 */
 	if (oldtcmp == (u32) -1) {
-		dev_dbg(our_chip->chip.dev, "Forcing manual update");
+		dev_dbg(pwmchip_parent(chip), "Forcing manual update");
 		pwm_samsung_manual_update(our_chip, pwm);
 	}
 
@@ -509,7 +508,7 @@ MODULE_DEVICE_TABLE(of, samsung_pwm_matches);
 
 static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 {
-	struct device_node *np = our_chip->chip.dev->of_node;
+	struct device_node *np = pwmchip_parent(&our_chip->chip)->of_node;
 	const struct of_device_id *match;
 	struct property *prop;
 	const __be32 *cur;
@@ -523,7 +522,7 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 
 	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
 		if (val >= SAMSUNG_PWM_NUM) {
-			dev_err(our_chip->chip.dev,
+			dev_err(pwmchip_parent(&our_chip->chip),
 				"%s: invalid channel index in samsung,pwm-outputs property\n",
 								__func__);
 			continue;
-- 
2.42.0


