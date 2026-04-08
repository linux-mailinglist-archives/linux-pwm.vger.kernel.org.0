Return-Path: <linux-pwm+bounces-8519-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIfxOBEs1mkUBggAu9opvQ
	(envelope-from <linux-pwm+bounces-8519-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Apr 2026 12:21:05 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 697D13BA720
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Apr 2026 12:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E20EA310A49C
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Apr 2026 10:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4DA3BA246;
	Wed,  8 Apr 2026 10:08:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728193B7B9D;
	Wed,  8 Apr 2026 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642909; cv=none; b=MGd5x8PR5CAlE1y1r+s4EtUrxS7p7YgdS6DoLmhoAj+FhpQd/KwKXNKmMv94Yea1jXj2BgLovRu5s+R5CFPaJyLxrFVZMlMK9lc6AD6MkLc/jP7Hb+Y/Z7RPM6MohB1vOszuA+Dj5sxVdq3KuXy4vo2/h57LoWsIFjd379uEdrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642909; c=relaxed/simple;
	bh=bf7ZoBSpgft9/08PUygckkjtp3WdMH5q0ySBEpu7Pkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mft04QAuTT76c5avaXuTyEwa4egr7EWL/yKdb1OQySHHrCc1lsbsQXc18WaYzhvcFI4uPzZFAnd8L0OzLXHduTD4yfXVxvUdTM7OrAal/LdH4tK6rfuMnCGY0H/wVcLkpE69BBc/3txokoW6mrUKWiaa2LgWGtiPEQv44iCe5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpsz5t1775642869tf0c51b98
X-QQ-Originating-IP: 8YUueAQUunnoETQUxQJHdFGBSMHHBpmko3OfnVz9bH0=
Received: from [192.168.30.32] ( [116.234.85.158])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Apr 2026 18:07:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3240142203164254093
EX-QQ-RecipientCnt: 10
From: Xilin Wu <sophon@radxa.com>
Date: Wed, 08 Apr 2026 18:07:33 +0800
Subject: [PATCH v2 2/2] pwm: clk-pwm: add GPIO and pinctrl support for
 constant output levels
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-clk-pwm-gpio-v2-2-d22f1f3498a0@radxa.com>
References: <20260408-clk-pwm-gpio-v2-0-d22f1f3498a0@radxa.com>
In-Reply-To: <20260408-clk-pwm-gpio-v2-0-d22f1f3498a0@radxa.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5507; i=sophon@radxa.com;
 h=from:subject:message-id; bh=bf7ZoBSpgft9/08PUygckkjtp3WdMH5q0ySBEpu7Pkg=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDJnXNN6V50ctMuv9s/lFrcgOK7stb2fcmL0y8cn9ojIv2
 evLTmv96ChlYRDjYpAVU2RRiGeYy16Ze+2pWKkezBxWJpAhDFycAjARy3UM/+sDdfzD8rcldrlG
 q/TKsMmL/65jvGR1uO/X8rvLqg6+u8bwP4UjPd4t0PrL66bYGttZE35adu09v9fp642LDGXCcs7
 FPAA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NhFh/C1ssL5whRx5PRA2G5KKtSOqvbdhRjfO88Q5NbtuB862ylDshZEc
	HPwzV3AIB2okbWyF8wYXy8xtEP1dxV0IdkHxWnOOL5slZOsiArw0XoRTBc+xmpT1atMAXz1
	2wse9D7qAvP673tuyp0I0OMrtLAEtWhvBXR+g0CiRp8ihj/l9HYW1++0zA+A2f5h6WyAezT
	GNBwcoDG1wNhnKpFylq56fk0gFSt0Q/3eae+YdY0OoL7XqLs2weAMmUDiAOHxVc0CwMavtl
	8LOSeSZFCakvm1bCNmrzASHbfxJcDgefo8hVN+8z8V9ioxA3SrlGI3GRUIgrbaJioSYDfRP
	Koy1zYFDFYXCtSlAZ/K5Wztv/EP7ojiVxgCR1xdBY73fHP/fLJCu5gBCtYRrfzdnwFttnE2
	2vfo14HNlolJp79fzbBLwvv6R9emRidUDkN0WGJSETFKQIoRe03ue6ow7da21CKw81cS4So
	u94aYcrMlDz0nibf2/gXoo9txhI6QgzLJRQ1TCjH82MoysmTIXFXZYRKaaxyeLJuUN0AzAr
	5YutVFgZp7kx4civJXTojgABFTLGkqDyXD/JONjLsy+HscVZlcWdEBzDfZ0YpFXsiSuCIMR
	0tm1avyf1ZpJTZ7V/sQWjyyv1g1W9rwplgbnDTo8m29A9bRTuJ3aFl4xXSSRT6rAzm5mkmR
	wMQzDBeYzU7OmKPP+2ffuvXsZtvzh0DF7j5uGaCOOF28R83lLpN+hh1cPSvfr/+DiXbGy+V
	dr5/lchwus/Gf4e9FXqNCrjydvMIPRTBjzyNYgc/wwSuQO8iFBMfITWUqdDJWezEIRcmSGy
	9DYmTAAxy49jy6AzbxN/ii93xw2wlaf4ST+4KWWH2x9Oly8I0MGmX+Wky0UorZ836kwOtw/
	Fq07/IwSNx4762l9DI5E3nS0ZpC9cRd5PZWhwV0pWTGTenOeD9zikzRgTczqqknQrOavhT2
	3p4f2+7S7vTrfUeB+rHjTcB8jDm3TmWH4/tdN8T/vpDxVmFlhW1O61/YMhls8FgI5XOkdkm
	7blRN3oBROd+28Jk0SEx7nBvfslIha4oK3lqG0e9ysOsMKEj4tUj0aJqugCGr8t2/JxV3rD
	ENznNBxrgWv
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[radxa.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8519-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sophon@radxa.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.251];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,radxa.com:email,radxa.com:mid]
X-Rspamd-Queue-Id: 697D13BA720
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The clk-pwm driver cannot guarantee a defined output level when the
PWM is disabled or when 0%/100% duty cycle is requested, because the
pin state when the clock is stopped is hardware-dependent.

Add optional GPIO and pinctrl support: when a GPIO descriptor and
pinctrl states ("default" for clock mux, "gpio" for GPIO mode) are
provided in the device tree, the driver switches the pin to GPIO mode
and drives the appropriate level for disabled/0%/100% states. For
normal PWM output, the pin is switched back to its clock function mux.

If no GPIO is provided, the driver falls back to the original
clock-only behavior.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/pwm/pwm-clk.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
index f8f5af57acba..d7d8d2c2dd0f 100644
--- a/drivers/pwm/pwm-clk.c
+++ b/drivers/pwm/pwm-clk.c
@@ -11,11 +11,20 @@
  * - Due to the fact that exact behavior depends on the underlying
  *   clock driver, various limitations are possible.
  * - Underlying clock may not be able to give 0% or 100% duty cycle
- *   (constant off or on), exact behavior will depend on the clock.
+ *   (constant off or on), exact behavior will depend on the clock,
+ *   unless a gpio pinctrl state is supplied.
  * - When the PWM is disabled, the clock will be disabled as well,
- *   line state will depend on the clock.
+ *   line state will depend on the clock, unless a gpio pinctrl
+ *   state is supplied.
  * - The clk API doesn't expose the necessary calls to implement
  *   .get_state().
+ *
+ * Optionally, a GPIO descriptor and pinctrl states ("default" and
+ * "gpio") can be provided. When a constant output level is needed
+ * (0% duty, 100% duty, or disabled), the driver switches the pin to
+ * GPIO mode and drives the appropriate level. For normal PWM output
+ * the pin is switched back to its clock function mux. If no GPIO is
+ * provided, the driver falls back to the original clock-only behavior.
  */
 
 #include <linux/kernel.h>
@@ -25,11 +34,17 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pwm.h>
 
 struct pwm_clk_chip {
 	struct clk *clk;
 	bool clk_enabled;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_default;  /* clock function mux */
+	struct pinctrl_state *pins_gpio;     /* GPIO mode */
+	struct gpio_desc *gpiod;
 };
 
 static inline struct pwm_clk_chip *to_pwm_clk_chip(struct pwm_chip *chip)
@@ -45,14 +60,36 @@ static int pwm_clk_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	u32 rate;
 	u64 period = state->period;
 	u64 duty_cycle = state->duty_cycle;
+	bool constant_level = false;
+	int gpio_value = 0;
 
 	if (!state->enabled) {
-		if (pwm->state.enabled) {
+		constant_level = true;
+		gpio_value = 0;
+	} else if (state->duty_cycle == 0) {
+		constant_level = true;
+		gpio_value = (state->polarity == PWM_POLARITY_INVERSED) ? 1 : 0;
+	} else if (state->duty_cycle >= state->period) {
+		constant_level = true;
+		gpio_value = (state->polarity == PWM_POLARITY_INVERSED) ? 0 : 1;
+	}
+
+	if (constant_level) {
+		if (pcchip->gpiod) {
+			gpiod_direction_output(pcchip->gpiod, gpio_value);
+			pinctrl_select_state(pcchip->pinctrl, pcchip->pins_gpio);
+		}
+		if (pcchip->clk_enabled) {
 			clk_disable(pcchip->clk);
 			pcchip->clk_enabled = false;
 		}
 		return 0;
-	} else if (!pwm->state.enabled) {
+	}
+
+	if (pcchip->gpiod)
+		pinctrl_select_state(pcchip->pinctrl, pcchip->pins_default);
+
+	if (!pcchip->clk_enabled) {
 		ret = clk_enable(pcchip->clk);
 		if (ret)
 			return ret;
@@ -97,6 +134,45 @@ static int pwm_clk_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->clk),
 				     "Failed to get clock\n");
 
+	pcchip->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(pcchip->pinctrl)) {
+		ret = PTR_ERR(pcchip->pinctrl);
+		pcchip->pinctrl = NULL;
+		if (ret == -EPROBE_DEFER)
+			return ret;
+	} else {
+		pcchip->pins_default = pinctrl_lookup_state(pcchip->pinctrl,
+							    PINCTRL_STATE_DEFAULT);
+		pcchip->pins_gpio = pinctrl_lookup_state(pcchip->pinctrl,
+							 "gpio");
+		if (IS_ERR(pcchip->pins_default) || IS_ERR(pcchip->pins_gpio))
+			pcchip->pinctrl = NULL;
+	}
+
+	/*
+	 * Switch to GPIO pinctrl state before requesting the GPIO.
+	 * The driver core has already applied the "default" state, which
+	 * muxes the pin to the clock function and claims it.  We must
+	 * release that claim first so that gpiolib can request the pin.
+	 */
+	if (pcchip->pinctrl)
+		pinctrl_select_state(pcchip->pinctrl, pcchip->pins_gpio);
+
+	pcchip->gpiod = devm_gpiod_get_optional(&pdev->dev, NULL, GPIOD_ASIS);
+	if (IS_ERR(pcchip->gpiod))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->gpiod),
+				     "Failed to get gpio\n");
+
+	/*
+	 * If pinctrl states were found but no GPIO was provided, the pin is
+	 * stuck in GPIO mode from the switch above.  Restore the default
+	 * (clock-function) mux and fall back to clock-only operation.
+	 */
+	if (pcchip->pinctrl && !pcchip->gpiod) {
+		pinctrl_select_state(pcchip->pinctrl, pcchip->pins_default);
+		pcchip->pinctrl = NULL;
+	}
+
 	chip->ops = &pwm_clk_ops;
 
 	ret = pwmchip_add(chip);

-- 
2.53.0


