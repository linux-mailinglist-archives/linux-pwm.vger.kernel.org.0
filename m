Return-Path: <linux-pwm+bounces-4796-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06C0A29F53
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 04:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E5B188971B
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 03:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E143E156F39;
	Thu,  6 Feb 2025 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qrhl3NL4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222E9BA33;
	Thu,  6 Feb 2025 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738811997; cv=none; b=LwzEoxIip/83drOvgA9tmy/SH6PrM6jeti76sL3ZZxYZDpWKDN48pnyWC6VaPQ43lxMkSBtMfOJCpfGFcgW3KrRNQSYU0WtsAISImlGiXDmoLOTqGar7ReA3cteJyK1FneoUUH9lWjTJrIVnfizY9T3Z24jhQAoVZtx2h28v9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738811997; c=relaxed/simple;
	bh=GzzwjW8y+Ts0r7k7KsZLemEE8E7P4VvTIcwgD1ja3QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LMxdN1ZVO83P1cBOtPgIY7QFnWvQ3sjHL85UWYzSLxdLawjPocekENBkNQ34adYQjK4hSi9JslE4rR/MYNAm5EP0VfXWfF8SOdNdm3ziEkz6Cdcmi1enH5a5uQ1jJGsk6XO2AY6N/fjHwlwUnje0RvgQCvl8UgA44mGqGPuxftQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qrhl3NL4; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f9d5f6df4cso544779a91.1;
        Wed, 05 Feb 2025 19:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738811995; x=1739416795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp95GCP+NaQWAeObvarJZqC4kwCYxxhJzxD02YD3RDI=;
        b=Qrhl3NL4hIXAiEwrOBpaPC4LBQL1u6WOhQ8auBujuCq7W0vz4w1jY1Izq5buw4uLTT
         ePQl9ielFw/Z1JApeqOYDDh0IS1XhlP+GkuhnE5a5svjea4DcOQOE0I1hkS1LXnlN5Sy
         oUFASgitM5f24OXTTaZNPP4htP0HluNlBBs2UYMv0yFSueGq+4Sxl7OKHcPv4mJdt6Pi
         f/Q51DapPsPMWZ1p08wfdLL4yciiiMhY3hvRnExoFtYxGYkNzblvmTCTSjKa7/wF+phr
         1AHX7w30I/UhCl7AJGRB6mdyTyfJFVOLGDYPkJUzqdNjJn5TCidBagw0C6Uy34y8Fb4z
         3MCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738811995; x=1739416795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mp95GCP+NaQWAeObvarJZqC4kwCYxxhJzxD02YD3RDI=;
        b=Rs5vJx2bjf+hiUF4XMJrH+Q9eF9u1Ai7e/Lhx9gZMwXCZ1OiSTco+3r7qfysiUsUAl
         dHSalMLMCHJa7jwEcY6HO2LrspuEmMFqP6+hXB8j6qkNCJj++A7zGLcD06LvBulR5fI+
         R7VoiLQYaJHrRCTRSAhp5m7rH6Ny8dOVxT877x2qZ5pcylq4RYkpLlUuVcZx8KIbB7ZQ
         MH/OoixyYdnldRtKb3AqcM+k7uu2pJCj6x6u1qLB695Ke25TPlt/nVSDvgECNye6spse
         6rmG9jbfk6fG14CuhSrTyEIydAqpnvi/HdlB+98UsfN3np2YV4OFhoi45K9mj3KC+N7p
         43Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXKQdt6ish4wKzAcaTuOp73Hcwxl2HbsfkNxBUr409ilgC0bliOSTQoESmB4moyiLZHBfwyYWoeF0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+nfdX1exBd6a+6IGAehPJh2js3HL9eGa/0QebF4Ta04HSMqB
	rF9hc4ftXXdTeub8tmgI2KGlJLeQgRowm0Z6eSuNrZ/TDkNe81Jo+Hp/qGWP
X-Gm-Gg: ASbGncsiCBeANpams5bY/XWfjmGJBcXDVib1DsTvDRb4hrbk2OmL92hMh6Mx1bn4Z2I
	ZcpcS7rhL7/rboxtlK/Sr+lPGSMfoNqoVyfdvTr5IIL/vUv29eywIQ4BPgNHe3l8Rts+rQFZXos
	kvfs8tz3YpZ92YOagKRTf1DicAsgZPpSJF9uELc7n+vdOLHyOvViEQrKTHMF0gkthvalPGuiTAY
	lgvB3k/M2UYCQ9/xEAkOXQ9xxJ7R+lnaAsV42hnePWRg1IjjgJXWZXIxSZNE5SdGL/xxv6tZiip
	iiGPwYS7AZDGIGVODP9PEUyxwkAv2Q9g74ok
X-Google-Smtp-Source: AGHT+IGU3fywdeVpYaHba2lZogPzgUZDRWqAGSoyixqV36Kid/qjYa+KbySNiqFTSNi7WcKZPLeZmQ==
X-Received: by 2002:a17:90a:1508:b0:2fa:e9b:33ab with SMTP id 98e67ed59e1d1-2fa0e9b3724mr104288a91.16.1738811995205;
        Wed, 05 Feb 2025 19:19:55 -0800 (PST)
Received: from localhost.localdomain ([181.192.80.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653c9a2sm1587155ad.77.2025.02.05.19.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 19:19:54 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v2 1/1] pwm: tiehrpwm: ensures that state.enabled is synchronized in .probe()
Date: Thu,  6 Feb 2025 00:18:52 -0300
Message-Id: <20250206031852.64853-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206031347.63700-1-rafael.v.volkmer@gmail.com>
References: <20250206031347.63700-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the hardware is already active during probe, it's not asserted
that the clock is enabled. To address this, added ehrpwm_get_state()
to verify the enable bit and update the pwm_state struct with the
correct hardware parameters.

In ehrpwm_pwm_probe(), the function checks if the enable bit is set
and calls clk_enable() and pm_runtime_get_sync() if needed.

Additionally, ehrpwm_get_state() was integrated as .get_state in
the ehrpwm_pwm_ops struct, incorporating it into the driver's pwm_ops
for consistent state management.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 202 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 201 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 0125e73b98df..cbddbbd48a75 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/bitfield.h>
 
 /* EHRPWM registers and bits definitions */
 
@@ -91,6 +92,19 @@
 #define AQCSFRC_CSFA_FRCHIGH	BIT(1)
 #define AQCSFRC_CSFA_DISSWFRC	(BIT(1) | BIT(0))
 
+#define AQCTLA_CAU      GENMASK(5, 4)
+#define AQCTLA_CAD      GENMASK(9, 8)
+
+/**
+ * The ePWM hardware encodes compare actions with two bits each:
+ *   00 = Do nothing
+ *   01 = Clear
+ *   10 = Set
+ *   11 = Toggle
+ */
+#define AQ_CLEAR  1
+#define AQ_SET    2
+
 #define NUM_PWM_CHANNEL		2	/* EHRPWM channels */
 
 struct ehrpwm_context {
@@ -353,6 +367,165 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	return 0;
 }
 
+/**
+ * ehrpwm_is_enabled - Checks if the eHRPWM channel is enabled
+ * @chip:	pointer to the PWM chip structure
+ *
+ * @return:	true if the channel is enabled, false otherwise
+ */
+static bool ehrpwm_is_enabled(struct pwm_chip *chip)
+{
+	bool ret = false;
+
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+
+	u16 aqcsfrc_reg = 0u;
+	u8 csfa_bits = 0u;
+	u16 aqctla_reg = 0u;
+
+	aqcsfrc_reg	= readw(pc->mmio_base + AQCSFRC);
+	csfa_bits = (u8)(aqcsfrc_reg & AQCSFRC_CSFA_MASK);
+	aqctla_reg = readw(pc->mmio_base + AQCTLA);
+	/*
+	 * If the CSFA value is non-zero,
+	 * it means channel A is being forced via software
+	 * (override), so we consider the PWM "disabled".
+	 */
+	if (csfa_bits)
+		ret = false;
+
+	/*
+	 * If the control register (AQCTLA) is configured
+	 * (non-zero), it means channel A has qualified actions
+	 * and is therefore enabled to generate PWM.
+	 */
+	if (aqctla_reg)
+		ret = true;
+
+	return ret;
+}
+
+/**
+ * ehrpwm_read_period - Reads the period of the eHRPWM channel (in ns)
+ * @chip:		pointer to the PWM chip structure
+ * @tbclk_rate:	time-base clock rate in Hz
+ *
+ * @return:		period in nanoseconds
+ */
+static u64 ehrpwm_read_period(struct pwm_chip *chip, unsigned long tbclk_rate)
+{
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+
+	u16 tbprd_reg = 0u;
+	u64 period_cycles = 0u;
+	u64 period_ns = 0u;
+
+	tbprd_reg = readw(pc->mmio_base + TBPRD);
+	period_cycles = tbprd_reg + 1u;
+
+	/*
+	 * period_ns = (period_cycles * 1e9) / tbclk_rate
+	 * Using DIV_ROUND_UP_ULL to avoid floating-point operations.
+	 */
+	period_ns = DIV_ROUND_UP_ULL(period_cycles * NSEC_PER_SEC, tbclk_rate);
+
+	return period_ns;
+}
+
+/**
+ * ehrpwm_read_duty_cycle - Reads the duty cycle of the eHRPWM channel (in ns)
+ * @chip:		pointer to the PWM chip structure
+ * @tbclk_rate:	time-base clock rate in Hz
+ *
+ * @return:		duty cycle in nanoseconds
+ */
+static u64 ehrpwm_read_duty_cycle(struct pwm_chip *chip, unsigned long tbclk_rate)
+{
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+
+	u16 cmpa_reg = 0u;
+	u64 duty_cycles = 0u;
+	u64 duty_ns = 0u;
+
+	cmpa_reg = readw(pc->mmio_base + CMPA);
+
+	duty_cycles = cmpa_reg;
+
+	/*
+	 * duty_ns = (duty_cycles * 1e9) / tbclk_rate
+	 * Using DIV_ROUND_UP_ULL to avoid floating-point operations.
+	 */
+	duty_ns = DIV_ROUND_UP_ULL(duty_cycles * NSEC_PER_SEC, tbclk_rate);
+
+	return duty_ns;
+}
+
+/**
+ * ehrpwm_read_polarity - Reads the polarity of the eHRPWM channel
+ * @chip:	pointer to the PWM chip structure
+ *
+ * @return:	the polarity of the PWM (PWM_POLARITY_NORMAL or PWM_POLARITY_INVERSED)
+ */
+static enum pwm_polarity ehrpwm_read_polarity(struct pwm_chip *chip)
+{
+	enum pwm_polarity ret = PWM_POLARITY_NORMAL;
+
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+
+	u16 aqctla_reg = 0u;
+	u8 cau_action = 0u;
+	u8 cad_action = 0u;
+
+	aqctla_reg = readw(pc->mmio_base + AQCTLA);
+	cau_action = FIELD_GET(AQCTLA_CAU, aqctla_reg);
+	cad_action = FIELD_GET(AQCTLA_CAD, aqctla_reg);
+
+	/*
+	 * Evaluate the actions to determine the PWM polarity:
+	 *  - If an up-count event sets the output (AQ_SET) and a down-count
+	 *    event clears it (AQ_CLEAR), then polarity is NORMAL.
+	 *  - If an up-count event clears the output (AQ_CLEAR) and a down-count
+	 *    event sets it (AQ_SET), then polarity is INVERSED.
+	 */
+	if (cau_action == AQ_SET && cad_action == AQ_CLEAR)
+		ret = PWM_POLARITY_NORMAL;
+
+	else if (cau_action == AQ_CLEAR && cad_action == AQ_SET)
+		ret = PWM_POLARITY_INVERSED;
+
+	return ret;
+}
+
+/**
+ * ehrpwm_get_state - Retrieves the current state of the eHRPWM channel
+ * @chip:	pointer to the PWM chip structure
+ * @pwm:	pointer to the PWM device structure
+ * @state:	pointer to the pwm_state structure to be filled
+ *
+ * @return:	0 on success or a negative error code on failure
+ */
+static int ehrpwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+							struct pwm_state *state)
+{
+	int ret = 0u;
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+	unsigned long tbclk_rate = 0u;
+
+	if (chip == NULL || pwm == NULL || state == NULL)
+		return -EINVAL;
+
+	tbclk_rate = clk_get_rate(pc->tbclk);
+	if (tbclk_rate <= 0)
+		return -EINVAL;
+
+	state->enabled = ehrpwm_is_enabled(chip);
+	state->period = ehrpwm_read_period(chip, tbclk_rate);
+	state->duty_cycle = ehrpwm_read_duty_cycle(chip, tbclk_rate);
+	state->polarity = ehrpwm_read_polarity(chip);
+
+	return ret;
+}
+
 static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
@@ -436,6 +609,7 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 static const struct pwm_ops ehrpwm_pwm_ops = {
 	.free = ehrpwm_pwm_free,
 	.apply = ehrpwm_pwm_apply,
+	.get_state = ehrpwm_get_state,
 };
 
 static const struct of_device_id ehrpwm_of_match[] = {
@@ -449,8 +623,10 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct ehrpwm_pwm_chip *pc;
+	struct pwm_state state;
 	struct pwm_chip *chip;
 	struct clk *clk;
+	bool tbclk_enabled;
 	int ret;
 
 	chip = devm_pwmchip_alloc(&pdev->dev, NUM_PWM_CHANNEL, sizeof(*pc));
@@ -492,6 +668,18 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ehrpwm_get_state(chip, &chip->pwms[0], &state);
+
+	if (state.enabled == true) {
+		ret = clk_prepare_enable(pc->tbclk);
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret, "clk_prepare_enable() failed");
+			goto err_pwmchip_remove;
+		}
+
+		tbclk_enabled = true;
+	}
+
 	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
@@ -501,10 +689,22 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, chip);
 	pm_runtime_enable(&pdev->dev);
 
+	if (state.enabled == true) {
+		ret = pm_runtime_get_sync(&pdev->dev);
+		if (ret < 0) {
+			dev_err_probe(&pdev->dev, ret, "pm_runtime_get_sync() failed");
+			clk_disable_unprepare(pc->tbclk);
+			goto err_pwmchip_remove;
+		}
+	}
+
 	return 0;
 
+err_pwmchip_remove:
+	pwmchip_remove(chip);
 err_clk_unprepare:
-	clk_unprepare(pc->tbclk);
+	if (tbclk_enabled)
+		clk_unprepare(pc->tbclk);
 
 	return ret;
 }
-- 
2.25.1


