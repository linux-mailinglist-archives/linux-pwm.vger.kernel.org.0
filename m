Return-Path: <linux-pwm+bounces-9301-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TRrQBLQwMWpvdgUAu9opvQ
	(envelope-from <linux-pwm+bounces-9301-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jun 2026 13:17:08 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6A468EB8E
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jun 2026 13:17:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=idG1LDRr;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9301-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9301-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28C283073242
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jun 2026 11:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7608043901C;
	Tue, 16 Jun 2026 11:13:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5177F436374;
	Tue, 16 Jun 2026 11:13:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608409; cv=none; b=GMFC93LAJlcgvShzo9VKU7axqJ4wDLU3GhteZ6W8KgvZw9DL9Wi1WtSnTaQyVSG7PQqfV9r/L7b+UgAe8hE4vhL1ziqhwLRwkQcuOv7sTwfLCSXNrWi8zPV/FkTMzrZuSX440xRlt+6HMuYZbF8CXcshbKKrlzH/8GvFW/QNbw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608409; c=relaxed/simple;
	bh=uUspXCLbKpdDYKkmfIBTt1l3QQzhIkW3FCN9SeUkhVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BItgINFYAyjaym6SHTvObpxW4nRJaSSew07HViD9u8SeaPI1PotQCVaLnIVm/HPvQDUOcQGgc4nLGlN5uW2ZoGzvb6izIJpFkmTF551Xnry2hxJyXn1o6+jFfQt8GhWp5T5jcWd9GSUuo1YRom44f54EgEytokmxT7WHXNqy7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idG1LDRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03DD2C2BCC7;
	Tue, 16 Jun 2026 11:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781608409;
	bh=uUspXCLbKpdDYKkmfIBTt1l3QQzhIkW3FCN9SeUkhVs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=idG1LDRr0lRO8AInsEr9Bc10/kpt5+vPGuP5g1n8q4vR+QTlfqQ9ktBnVJSA+KTo1
	 iI+0BCHDPQpNQu+0LE5X6u9HgUpHcN7tZV3Webm3DNvJDokGnonYahNDJJ4gDvRiIZ
	 B1AVuDdo+q37L7MZ7JDh682aqd5oaEF2oBFQyqaB6tzsuKa1mCdTzidbJgv8CuE/+Y
	 Wt0OvMpbYT2A1MKS4iN3nBS2RKv4bjcc147hVoxF3UKzUkOygVvYwuvPhhX6Xi0WzW
	 0wZMj4kOlZ4zaHFt+d1e0oCVCMG3tzxhWJe7Rrzg3yGcqvjJMsZMM1v98kH/xuXAsq
	 pSt1l3pXVFiOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2781CD98DA;
	Tue, 16 Jun 2026 11:13:28 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Tue, 16 Jun 2026 19:13:17 +0800
Subject: [PATCH 1/2] pwm: loongson: Fix low pulse buffer register handling
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-pwm-loongson-fix-v1-1-491dbf260a7f@gmail.com>
References: <20260616-pwm-loongson-fix-v1-0-491dbf260a7f@gmail.com>
In-Reply-To: <20260616-pwm-loongson-fix-v1-0-491dbf260a7f@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781608406; l=3888;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=DNMp7Yft9qmQudEtetNcd8RiwL5OJSFdiB2+KDs/znE=;
 b=b0vsrenpdusZYMR2eyHeWpFQEswnVwkLurESOF81tgOwBsDkeB2eHPZ8YNScWtm76r8nUR1U1
 a+HtFXXXbsjCX+LN249Zs9Xe8Vpcy2fsQkFhp1sFLh25hmahL3YlKzV
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9301-lists,linux-pwm=lfdr.de,keguang.zhang.gmail.com];
	FORGED_RECIPIENTS(0.00)[m:zhoubinbin@loongson.cn,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:keguang.zhang@gmail.com,m:keguangzhang@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[keguang.zhang@gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A6A468EB8E

From: Keguang Zhang <keguang.zhang@gmail.com>

The Loongson PWM register at offset 0x4 is documented as the Low
Pulse Buffer Register, which stores the low pulse width rather than
the duty cycle.

However, this register was incorrectly defined and treated as a
duty-cycle register. As a result, the duty cycle and low pulse cycle
are swapped in the generated PWM waveform.

Program the low pulse (period - duty) into the register and
adjust pwm_loongson_get_state() accordingly when reconstructing the
duty cycle.

Also return -ERANGE when the requested period exceeds the hardware
32-bit limit instead of silently truncating the value.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/pwm/pwm-loongson.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
index 31a57edecfd0..dc77f82fd888 100644
--- a/drivers/pwm/pwm-loongson.c
+++ b/drivers/pwm/pwm-loongson.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -33,10 +34,12 @@
 #include <linux/units.h>
 
 /* Loongson PWM registers */
-#define LOONGSON_PWM_REG_DUTY		0x4 /* Low Pulse Buffer Register */
+#define LOONGSON_PWM_REG_LOW		0x4 /* Low Pulse Buffer Register */
 #define LOONGSON_PWM_REG_PERIOD		0x8 /* Pulse Period Buffer Register */
 #define LOONGSON_PWM_REG_CTRL		0xc /* Control Register */
 
+#define LOONGSON_PWM_MAX_PERIOD		GENMASK(31, 0)
+
 /* Control register bits */
 #define LOONGSON_PWM_CTRL_REG_EN	BIT(0)  /* Counter Enable Bit */
 #define LOONGSON_PWM_CTRL_REG_OE	BIT(3)  /* Pulse Output Enable Control Bit, Valid Low */
@@ -118,20 +121,16 @@ static int pwm_loongson_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       u64 duty_ns, u64 period_ns)
 {
-	u64 duty, period;
+	u64 low, period;
 	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
 
-	/* duty = duty_ns * ddata->clk_rate / NSEC_PER_SEC */
-	duty = mul_u64_u64_div_u64(duty_ns, ddata->clk_rate, NSEC_PER_SEC);
-	if (duty > U32_MAX)
-		duty = U32_MAX;
-
-	/* period = period_ns * ddata->clk_rate / NSEC_PER_SEC */
 	period = mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_PER_SEC);
-	if (period > U32_MAX)
-		period = U32_MAX;
+	if ((!FIELD_FIT(LOONGSON_PWM_MAX_PERIOD, period)))
+		return -ERANGE;
+
+	low = mul_u64_u64_div_u64(period_ns - duty_ns, ddata->clk_rate, NSEC_PER_SEC);
 
-	pwm_loongson_writel(ddata, duty, LOONGSON_PWM_REG_DUTY);
+	pwm_loongson_writel(ddata, low, LOONGSON_PWM_REG_LOW);
 	pwm_loongson_writel(ddata, period, LOONGSON_PWM_REG_PERIOD);
 
 	return 0;
@@ -166,15 +165,15 @@ static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 static int pwm_loongson_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				  struct pwm_state *state)
 {
-	u32 duty, period, ctrl;
+	u32 low, period, ctrl;
 	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
 
-	duty = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_DUTY);
+	low = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_LOW);
 	period = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_PERIOD);
 	ctrl = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
 
-	/* duty & period have a max of 2^32, so we can't overflow */
-	state->duty_cycle = DIV64_U64_ROUND_UP((u64)duty * NSEC_PER_SEC, ddata->clk_rate);
+	/* low & period have a max of 2^32, so we can't overflow */
+	state->duty_cycle = DIV64_U64_ROUND_UP((u64)(period - low) * NSEC_PER_SEC, ddata->clk_rate);
 	state->period = DIV64_U64_ROUND_UP((u64)period * NSEC_PER_SEC, ddata->clk_rate);
 	state->polarity = (ctrl & LOONGSON_PWM_CTRL_REG_INVERT) ? PWM_POLARITY_INVERSED :
 			  PWM_POLARITY_NORMAL;

-- 
2.43.0



