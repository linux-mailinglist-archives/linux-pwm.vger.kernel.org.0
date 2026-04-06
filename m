Return-Path: <linux-pwm+bounces-8497-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADg2LX7W02nUnAcAu9opvQ
	(envelope-from <linux-pwm+bounces-8497-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 17:51:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E67F3A4E7E
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 17:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 822AF30143DA
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 15:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F332D594F;
	Mon,  6 Apr 2026 15:51:09 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75B288C81;
	Mon,  6 Apr 2026 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490669; cv=none; b=KBXoCyXPRBH4z7daLNAsYx5bXpIaaSD+o/0kzerON8nn6E8aMV9c8nxdTpfZ+9VRf0y4i0lnXKlYBxMg6/GpH6D5NxuPCmptqozvWrR+yCxsabQOSw6+IJGS7L/OsnAtOfgTyR9P/k/DrJ3q+iJy0JyggqxrBHvb5AcDkpRK6r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490669; c=relaxed/simple;
	bh=UBTu/kKo70Jh0+IVyBq78WBUn6kXsLDznnaFIyQAqI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/wT/45RQghYHfCqhTZYwwxJcHy1e/I/y0HOEI1AWSxzwvHvmyJVlDvxyApNg9rZkbCoc3Iln1NMzHVEBDNp8JUJueUOR6FkKGcb2Q7WHbdbQaZccE7noL+C93WzIpADMXtWTaVzxH5UeaZ104Z7/F6w+H4nLWCQEYuxqkskFzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpsz5t1775490614t2a71ab47
X-QQ-Originating-IP: +bci2OFNhnZPPCdhCYxE7IGxHtXRITc9jF3kaO8N6T4=
Received: from [192.168.30.32] ( [116.234.14.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 06 Apr 2026 23:50:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7770315344713574114
EX-QQ-RecipientCnt: 10
From: Xilin Wu <sophon@radxa.com>
Date: Mon, 06 Apr 2026 23:50:02 +0800
Subject: [PATCH 2/2] pwm: clk-pwm: add GPIO and pinctrl support for
 constant output levels
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-clk-pwm-gpio-v1-2-40d2f3a20aff@radxa.com>
References: <20260406-clk-pwm-gpio-v1-0-40d2f3a20aff@radxa.com>
In-Reply-To: <20260406-clk-pwm-gpio-v1-0-40d2f3a20aff@radxa.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4950; i=sophon@radxa.com;
 h=from:subject:message-id; bh=UBTu/kKo70Jh0+IVyBq78WBUn6kXsLDznnaFIyQAqI8=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDJmXr+lNF2Lb4XthzqHvhh9Mf5VMU/7i73nvH1eTV/SmX
 x+4Eg6e6ihlYRDjYpAVU2RRiGeYy16Ze+2pWKkezBxWJpAhDFycAjCRzGJGhj1z9/yXs5d5kSh4
 PCo8+l3Bh2mVqr2vlbxN+pZelroe48vwT1na4oy9VcPOnyJpb9h2iFSxXS73n7mn+MWvV/tnSTR
 P4gQA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OCBj5Amv9vLxNlhcrkcEq3PDWYL5zw8G+iXyAhx/HJ4uEV9oDi50Ayno
	WBCbJhiRUG6/dr4eq9I+15/6WpibUrzFzm7lKgKaNnDFTmVGeVUQVgxwyOHP3sMuWqsjZ/N
	aF5D6ZecEwngi8l8ecZkK4eN94zP/0cs/RvETlrLFcxQkH2aI9I5OHlqfxzeEUOYiatYrp5
	CKHGaWvmaS5RmG/GdAIpLKdCwU8sawJ9NEHFqjwlPoUwlCP4dWzeYzL1fmWpuF3DnyhnByp
	Y6q/4kZj9BLBUPa9EYuxqoovBXW64aE9WD3FK3O8TYLGaVXbaJ88gCeRQnjbOR/9Yf+FgOa
	1FfUkXNkHYj04RKxF2+EYT35jvL1d40IWCVyC+y8Mjrr5Kvv1cw/IsodE99UtSFCQ/O4/Zq
	aJIwR9zu404Co0JGZzxtLUSmCH5oaybnvbH7yIcigUnRoctUPYQAScMg0JamhTljX3F9rJ9
	JE+z+X/EfF3H1SbNWY+mT4xdNtBO2GHH16sbwNxovPTaVJo37R7+GR3o4SOkSYnd2JpgjD2
	l/MTdaW0QZJZ3HDY8DmSt8/PluRaYX6D8uG71Bhv/UGXYwEw8mbmXFFQevJpVteSxjM8x7A
	T9mOGqrhkYV3l+p2HztTSQ1dkRvFZPkvljpBPXzHjzIXRikaLnlp7RP/MKYTzLaYhL1TYlN
	tJ3ZRa3W3PZp3I8tl4hgru5nbCdiF02Jt0sF+Y6jZilT5q+3tGR+rt6jmECfNVrfj5bAywX
	Jn2nPWZmTqrffVxkgJmL+tphZXI4B5LmNJHQBpV1PIUuLYSCRJz8UNLUHwEfXDu1GM/ERbI
	/TXpviH+t2Td98hiPcfO0lgHNt1Knx7XL6k3LTmskbNZGIzckrkubpxBi2m0xazBR75OR7E
	JZ4++PxXPlvHAkO8G631V3P/pYBj3aQ0WJD/AT57wccXj8gWXgfDVH9tAv183q4+ULSSdNn
	oWxkBTg2TqLo9ZgTNEiCylUZZ3Kut5vPAA2rOY/0jRqqC4xeucDJ022oUJcqEDM50jpbGbm
	Ugf8CbokTaj7CTZIABooAQY6yTpql0OXmTPSi5p8q0mV7ykrC4fiqUBvRw8oIHUKKyVsIRs
	N02p75wCzDDGvUPpl578hc=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[radxa.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8497-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sophon@radxa.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.846];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E67F3A4E7E
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
 drivers/pwm/pwm-clk.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
index f8f5af57acba..99821fae54e7 100644
--- a/drivers/pwm/pwm-clk.c
+++ b/drivers/pwm/pwm-clk.c
@@ -10,12 +10,15 @@
  * Limitations:
  * - Due to the fact that exact behavior depends on the underlying
  *   clock driver, various limitations are possible.
- * - Underlying clock may not be able to give 0% or 100% duty cycle
- *   (constant off or on), exact behavior will depend on the clock.
- * - When the PWM is disabled, the clock will be disabled as well,
- *   line state will depend on the clock.
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
@@ -25,11 +28,17 @@
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
@@ -45,14 +54,36 @@ static int pwm_clk_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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
+			pinctrl_select_state(pcchip->pinctrl, pcchip->pins_gpio);
+			gpiod_direction_output(pcchip->gpiod, gpio_value);
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
@@ -97,6 +128,35 @@ static int pwm_clk_probe(struct platform_device *pdev)
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
 	chip->ops = &pwm_clk_ops;
 
 	ret = pwmchip_add(chip);

-- 
2.53.0


