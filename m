Return-Path: <linux-pwm+bounces-4765-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A96A27AA8
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Feb 2025 19:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF4F3A3239
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Feb 2025 18:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74208218ABD;
	Tue,  4 Feb 2025 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9f3wKDu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD9F218AC8;
	Tue,  4 Feb 2025 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738695369; cv=none; b=Co0sYVOxKdUTofTOJrsEAotoraJ8vjG6ef1J22uyBDbeJGQusmCfGSuCMDgT6HPo5qYsjPw+MuW0BQv2vL8j81Bpk+sQEHE479LWNob3eOPWwvailHL4RNQlnJXFNhawm7ShOmo4ETOeSVvW1Hnduqk1L7JONYVETVVx3LHz/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738695369; c=relaxed/simple;
	bh=QeGXJi76YbZL+qgEdYz8n6FtI5h0bhyXK/wQx2mueh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pO0rPW11y5Jcy4eIK2AnZjwzjfSYuWbkws5WueGj43chkDxKgiiMoXceB6f86Azx4JP4eajnQcSL498PMik5YFR9wq+dgpBXvX8EpiCovGv8YTFPcWYc8/nlDhkWRjF95nEqD/37D97L2HytlRjfGaXquCs+dtu5vJETddDfoEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9f3wKDu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2161eb95317so105970235ad.1;
        Tue, 04 Feb 2025 10:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738695367; x=1739300167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2bGsWJVaiSr30++/0esPSuZbt+BULYNK6t+g3c3C64=;
        b=j9f3wKDu/DS1tmrO05bl/mImaHgIgcPYL+NCocWCiDFd8S/O6RqRqeu/up8wqj6wK8
         t9XQ/OLqmyEtt32U7C2gKBpr7FjywZn+GMPtmveB61z7kvDinfBNGPT6kTsChtNSbUD1
         qpvWie17ENWjqvFDEAEn+4DepgAmsHZkC2u3QuB21RuhWV5FN+24luDoz0nDqeYbyIhM
         bk/i/pST4O9Zav82SpIhMQSImUmH1i+yjjsGGcfMNUgVQhFNCxXkmyrS0T/Wv6lzVdwL
         bavH6pIeueFGEA8T7YTAZspV+fhO18SUdzp4bcuwirPHJkcn60Z4UcFiV2dpjSbHgAsj
         YIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738695367; x=1739300167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2bGsWJVaiSr30++/0esPSuZbt+BULYNK6t+g3c3C64=;
        b=NCuLzmWz2aCQ8coWsq3J6mjbw3I2mLkuAYKvXd7+nEyFuZKZfGGY2FcppaACyhHd9m
         LsPSIsUWrbNslWHh79KRLEShrJID2fpS7tEA0VXKjqNWeMDnrS1kJDdLetx04noaTj4G
         MaLHqfJrWGgK0pluiBLcmFmqja7XQwbgPQA2mjNqH+uWxRiRGY5sWWI1aRIe5W5tmOo7
         sHtVHmkvFV4i1dkDgZdT47Nw4wr43CtwmYQO9Q7SiDjhnL1I25DwtpyqRjzpuFkBMj6m
         bJ7gZs7WPXpfutQm/gtez+ArQ1SE4+cdDug3vVA43REJNusj6HygHN0rm21+lsKkBYBY
         uc0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwmu9/OlIlaRIQuvncKEQqnfylp+aObhRLAvICaRo+P2rMbf7iIQrqsPbB+bCxW7dy057B+x0F0VuIQho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB4fsMzL4OGNnvdPnFJa6ipEtGU220zQPRdI5vJMg4XUwAF+7C
	y/nZhkjxk2OcmPTLWdxMttHXPmjkGwCP1ZO6ATVxZi45Mk87GKCbyky13yp1
X-Gm-Gg: ASbGnct23yYRyETxdpt7ej57QGahl3S9DI+LXZhFPR6zewhqTgO9sXoIIjBn3MV56hv
	JIwFVL0Y6TGz4BY4cvx6ilScglv0lFRzzfgXYPpWn0DTRe2PvQ/z49SOjnn4TPF+acPDpnBG6MR
	54Z8Ro2w+LWBPgn9YAYJa3sjmZX57JojdeS+AUvxzY3fgHDniHrYvFkToBGxHKw5YFi1LIc6uqV
	3kTLC1Mz081wxnzSEpuN7RND1XrZFBiejwU3QAjgPjesmJnUyXHJB71IWhYB56ucQ8TvsukEhYH
	BUQzZhcyPC5mAxxtDNKdzMcqKtT67xmsoXM=
X-Google-Smtp-Source: AGHT+IHekIIDU3hAEwReZxd5PGAerEWvLHH6zd7FCmqVXU2/ygzTXeimP1M5tLEfZhUoKO4wopLmqw==
X-Received: by 2002:a17:903:2281:b0:21b:d2b6:ca7f with SMTP id d9443c01a7336-21dd7deefa0mr457027895ad.32.1738695366780;
        Tue, 04 Feb 2025 10:56:06 -0800 (PST)
Received: from localhost.localdomain ([177.10.12.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de330326dsm99284095ad.164.2025.02.04.10.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:56:06 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Subject: [PATCH] pwm: tiehrpwm: ensures that state.enabled is synchronized in .probe()
Date: Tue,  4 Feb 2025 15:55:40 -0300
Message-Id: <20250204185540.52233-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes potential desynchronization of state.enabled in the .probe()
method by suggesting proper handling of hardware state initialization.
Adds considerations for implementing .get_hw_state() to check the
current state of the module by checking physical registers.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 151 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 150 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 0125e73b98df..5de213bc3ef5 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -91,6 +91,20 @@
 #define AQCSFRC_CSFA_FRCHIGH	BIT(1)
 #define AQCSFRC_CSFA_DISSWFRC	(BIT(1) | BIT(0))
 
+#define AQCTLA_CAU_MASK   (BIT(5) | BIT(4))
+#define AQCTLA_CAU_SHIFT  4
+#define AQCTLA_CAD_MASK   (BIT(9) | BIT(8))
+#define AQCTLA_CAD_SHIFT  8
+
+/* The ePWM hardware encodes compare actions with two bits each:
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
@@ -353,6 +367,118 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	return 0;
 }
 
+static bool ehrpwm_is_enabled(struct pwm_chip *chip)
+{
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+	bool ret;
+	u16 aqcsfrc_reg;
+	u8 csfa_bits;
+	u16 aqctla_reg;
+
+	if(chip == NULL) {
+		return -EINVAL;
+	}
+
+	aqcsfrc_reg	= readw(pc->mmio_base + AQCSFRC);
+	csfa_bits	= (u8)(aqcsfrc_reg & AQCSFRC_CSFA_MASK);
+	
+	aqctla_reg	= readw(pc->mmio_base + AQCTLA);
+
+	ret = (csfa_bits != 0u)	 ? false :
+	      (aqctla_reg == 0u) ? false : true;
+
+	return ret;
+}
+
+static u64 ehrpwm_read_period(struct pwm_chip *chip)
+{
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+	u64 ret;
+	unsigned long tbclk_rate;
+	u16 tbprd_reg;
+	u64 period_cycles;
+	u64 period_ns;
+
+	if(chip == NULL) {
+		return -EINVAL;
+	}
+
+	tbprd_reg = readw(pc->mmio_base + TBPRD);
+	tbclk_rate = clk_get_rate(pc->tbclk);
+	period_cycles = tbprd_reg + 1u;
+	
+	/* period_ns = (period_cycles * 1e9) / tblck_rate */
+	period_ns = DIV_ROUND_UP_ULL(period_cycles * NSEC_PER_SEC, tbclk_rate);
+	
+	ret = period_ns;
+	return ret;
+}
+
+static u64 ehrpwm_read_duty_cycle(struct pwm_chip *chip)
+{
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+	u64 ret;
+	u16 cmpa_reg;
+	u64 duty_cycles;
+	u64 duty_ns;
+	unsigned long tbclk_rate;
+
+	if(chip == NULL) {
+		return -EINVAL;
+	}
+
+	cmpa_reg = readw(pc->mmio_base + CMPA);
+	tbclk_rate = clk_get_rate(pc->tbclk);
+	duty_cycles = cmpa_reg;
+	duty_ns = DIV_ROUND_UP_ULL(duty_cycles * NSEC_PER_SEC, tbclk_rate);
+	ret = duty_ns;
+
+	return ret;
+}
+
+static enum pwm_polarity ehrpwm_read_polarity(struct pwm_chip *chip)
+{
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+	enum pwm_polarity ret;
+	u16 aqctla_reg;
+	u8 cau_action;
+	u8 cad_action;
+
+	if(chip == NULL) {
+		return -EINVAL;
+	}
+
+	aqctla_reg	= readw(pc->mmio_base + AQCTLA);
+	cau_action = (aqctla_reg & AQCTLA_CAU_MASK) >> AQCTLA_CAU_SHIFT;
+	cad_action = (aqctla_reg & AQCTLA_CAD_MASK) >> AQCTLA_CAD_SHIFT;
+	
+	if (cau_action == AQ_SET && cad_action == AQ_CLEAR) {
+		ret = PWM_POLARITY_NORMAL;
+	}
+	else if (cau_action == AQ_CLEAR && cad_action == AQ_SET) {
+		ret = PWM_POLARITY_INVERSED;
+	}
+
+	return ret;
+}
+
+static int ehrpwm_get_hw_state(struct pwm_chip *chip, struct pwm_device *pwm, 
+								struct pwm_state *state)
+{
+	int ret;
+
+	if(chip == NULL || pwm == NULL || state == NULL){
+		return -EINVAL;
+	}
+
+	state->enabled = ehrpwm_is_enabled(chip);
+	state->period = ehrpwm_read_period(chip);
+    state->duty_cycle = ehrpwm_read_duty_cycle(chip);
+    state->polarity = ehrpwm_read_polarity(chip);
+
+	return ret;
+}
+
 static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
@@ -449,8 +575,10 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct ehrpwm_pwm_chip *pc;
+	struct pwm_state state;
 	struct pwm_chip *chip;
 	struct clk *clk;
+	bool tbclk_enabled;
 	int ret;
 
 	chip = devm_pwmchip_alloc(&pdev->dev, NUM_PWM_CHANNEL, sizeof(*pc));
@@ -501,10 +629,31 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, chip);
 	pm_runtime_enable(&pdev->dev);
 
+	ehrpwm_get_hw_state(chip, &chip->pwms[0], &state);
+	if(state.enabled == true) {
+		ret = clk_prepare_enable(pc->tbclk);
+		if (ret) {     
+			dev_err(&pdev->dev, "clk_prepare_enable() failed: %d\n", ret);
+			goto err_pwmchip_remove;
+		}
+            
+		tbclk_enabled = true;
+		ret = pm_runtime_get_sync(&pdev->dev);
+		if(ret < 0) {
+			dev_err(&pdev->dev, "pm_runtime_get_sync() failed: %d\n", ret);
+			clk_disable_unprepare(pc->tbclk);
+ 			goto err_pwmchip_remove;
+		}
+ 	}
+
 	return 0;
 
+err_pwmchip_remove:
+	pwmchip_remove(chip);
+
 err_clk_unprepare:
-	clk_unprepare(pc->tbclk);
+	if(tbclk_enabled)
+		clk_unprepare(pc->tbclk);
 
 	return ret;
 }
-- 
2.25.1


