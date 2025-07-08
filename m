Return-Path: <linux-pwm+bounces-6786-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0E4AFD52A
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD82B480F22
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39F02DD5EF;
	Tue,  8 Jul 2025 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oDzsHBOG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07D62E1722
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995156; cv=none; b=hMND2rucZXHRC4fo/5bhrNv6/IFNMqNZLR3aZiPEb4Rv9DmYZmZovmFJ/K1ClDtpo7TlsyhV3dVZ8kCPCYdPeUboOqiEHny9SP1A1RvwN3JrYdAF+JszY72kSnu7bpmcBBK+wAdzHY6diJdpjzUBPWieEfw0Vdmic7/QlRWmqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995156; c=relaxed/simple;
	bh=Io0EKeB0lpsfngcJKqLCyAVcz95XvCycJ3iO9TgYbfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4u+83qJjBg2YKA9DKvdPegLLCv3i+u3RhhV+a1EIV8CbbSI1D6qawJ2pvWRtkoB+3G6nW5UZBJ55sY0Wkfykf9N7OcYPvPfyHuLriXNU4HJUJ4W4kTXqdRmxHn7gCMD1UoquZLjazNpu2cfHe9FNOaAm1G/C5Wx2hKhhaYgTEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oDzsHBOG; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0b6532345so19665866b.1
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995153; x=1752599953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZvQMgr27oYexeTp9Zzz8EXxWgUKt5vomHna8W5DPtg=;
        b=oDzsHBOGLwrr/wQRDb1N3VoSPfLfZT9pTYHNrQwMSePxAqgn1M3jp3JSzKRjsSYByf
         ExOzX7mlt7dkZwnrSFcnD7QxX5cyK0tUu77SvRhlHU3eKnMnmYDgMHvRdDdv9oc2eT93
         zUndXWphIy+3v5ABr24CHkJDElt//vlXVWL2ifIdNWPEn43dQ+I9B0+6x/hunv6S+1QS
         eL15uwL9ImtWfvqmRq7VaemTbvBoChy1DQlwrzmeKZYRIVrMzTkXj1d9eevsQBFGOdy2
         vU0UFSOHfJVSZB00lDIe5b0xCIJ4HYb76iEMJeDiX9kz6SG6T/UqpV35y3kDXOQL6wcB
         l/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995153; x=1752599953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZvQMgr27oYexeTp9Zzz8EXxWgUKt5vomHna8W5DPtg=;
        b=X0ryEUcFZbdhL6NcA5JzPZOFVWGO4rmxAO5AE+Ts7hdwfKQACDYW8XjEk3FAXWZtGm
         XnHM2LxfaTBioKOCM0m1c05/1q/RnMAhndy+ey7I/MT+btoL2qBmTfF+tBxBb1zG0+hH
         zTxGynKkLPdyz6lUPRVPB34L22m3QAoUstQjLDpserELJu4vRjhHrq/nAiTZiD5xKJDq
         AmqjQ8xsNK45Kzii4IhB21FTOG1sy9uR7K37eQYlzZB8NimCDlJ6bWSceYDOFkuXxu2T
         omZXcK71hH0VSYv+sA3dRRuLAasFfeCHl2AenR9OUfRS47qn9COdmxtD53xNeaduzMpK
         vvVA==
X-Gm-Message-State: AOJu0YzfYUXmPF+psvW7du72bZFS7mY2w86n2sa79K81f3b6aS8l9s/d
	ovD5J04GY8r+/RCMFzMkde9o2pUEbq+FGzDJnWhHKqLrpF6BGIAQhrHzL7EQd3wjALk=
X-Gm-Gg: ASbGncuSq9bqA344NViW2DkBEGaacMwOPPQgUpRA8gZmbey7eZkXuGLVeSS0ddJh2Ne
	PWh+nEuXj7Ghurt2rgQc3rb9sOr3c8d69LTuBBd5kBYu2+ORC+UjyirLIM+9bj0miU5ETtLBEGX
	CCMFYR29QsYIcXS7rrSu1TILip/xK/QC8HOd1RJmff1EmGsDp6P2r2OPvPtKjlyQ5OiBIJ8s7CK
	mBlou5DPhz/6YU++bgm4wDgRKnubJzUErfqHpO84AjH9I3GSWXR8W5mBEN8XXlJVHD0T+lYFC18
	PgiFJ29bKf2foo6AoCo5T4B1kvsCH1N+02ByQOLB2XTzVoOgDjCU3/k+2L2j/gj7kv5ToZODz8x
	qe+Kn3uDx5CPaVpiV4D8Weo5+/bNZ
X-Google-Smtp-Source: AGHT+IGZ+K1pCuPEayZnFWGSN9yqttQ6jjfQTfQ8iw0G3/mWnEpYr+4MB2ym0NC1DtSHzl9Md0DtGg==
X-Received: by 2002:a17:907:2da9:b0:ad2:e08:e9e2 with SMTP id a640c23a62f3a-ae6b2b38bedmr368790266b.27.1751995153065;
        Tue, 08 Jul 2025 10:19:13 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae3f66d920asm935799966b.12.2025.07.08.10.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:19:12 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 7/8] pwm: mediatek: Lock and cache clock rate
Date: Tue,  8 Jul 2025 19:18:37 +0200
Message-ID:  <087a968c4a444c91d2845c47ad19b67d74b76769.1751994509.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751994509.git.u.kleine-koenig@baylibre.com>
References: <cover.1751994509.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5481; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Io0EKeB0lpsfngcJKqLCyAVcz95XvCycJ3iO9TgYbfs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVL7lTJ58f6EVjYr2LNUdDZHYgPwXAhqRSNtJ st8kaSRFmGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1S+wAKCRCPgPtYfRL+ TuklCAC5nKWvv0OZrIF43FGcTpxy2DJXR3LA6Bu4yGFNJT8ar4BIROO5P21ny5KAE8xe2FjVk+K UplmkW6BrsfEFBhp7kSqNnTlL/S06gjeGjO5NGATcSf0B5+AWeQJPnH7bO+nvOTlbs9q4eNDzyY DZH2msg6g2SGqxBEfTR2ldGGn2+nKHzX0ckx0NeoogyXRs2iacZ63q2skBAF6AxmdcOpI+cPfvF 4m+uCZsGUrKdOsMZbe9EDJIW3W/4qWQk1a/4odlObrexLLlxM7/i/hIlTlNrj8JeW6hI6EmkWkG XpTVJBuLoNvPwtwn8A+IeRnuHDj6YiPWh8p+hRO37HWkst6f
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This simplifies error handling and reduces the amount of clk_get_rate()
calls.

While touching the clk handling also allocate the clock array as part of
driver data and lock the clock rate to ensure that the output doesn't
change unexpectedly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 64 +++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index d7801e6df6ba..c48d46124059 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -49,15 +49,18 @@ struct pwm_mediatek_of_data {
  * @regs: base address of PWM chip
  * @clk_top: the top clock generator
  * @clk_main: the clock used by PWM core
- * @clk_pwms: the clock used by each PWM channel
  * @soc: pointer to chip's platform data
+ * @clk_pwms: the clock and clkrate used by each PWM channel
  */
 struct pwm_mediatek_chip {
 	void __iomem *regs;
 	struct clk *clk_top;
 	struct clk *clk_main;
-	struct clk **clk_pwms;
 	const struct pwm_mediatek_of_data *soc;
+	struct {
+		struct clk *clk;
+		unsigned long rate;
+	} clk_pwms[];
 };
 
 static inline struct pwm_mediatek_chip *
@@ -79,12 +82,28 @@ static int pwm_mediatek_clk_enable(struct pwm_mediatek_chip *pc,
 	if (ret < 0)
 		goto disable_clk_top;
 
-	ret = clk_prepare_enable(pc->clk_pwms[hwpwm]);
+	ret = clk_prepare_enable(pc->clk_pwms[hwpwm].clk);
 	if (ret < 0)
 		goto disable_clk_main;
 
+	if (!pc->clk_pwms[hwpwm].rate) {
+		pc->clk_pwms[hwpwm].rate = clk_get_rate(pc->clk_pwms[hwpwm].clk);
+
+		/*
+		 * With the clk running with not more than 1 GHz the
+		 * calculations in .apply() won't overflow.
+		 */
+		if (!pc->clk_pwms[hwpwm].rate ||
+		    pc->clk_pwms[hwpwm].rate > 1000000000) {
+			ret = -EINVAL;
+			goto disable_clk_hwpwm;
+		}
+	}
+
 	return 0;
 
+disable_clk_hwpwm:
+	clk_disable_unprepare(pc->clk_pwms[hwpwm].clk);
 disable_clk_main:
 	clk_disable_unprepare(pc->clk_main);
 disable_clk_top:
@@ -96,7 +115,7 @@ static int pwm_mediatek_clk_enable(struct pwm_mediatek_chip *pc,
 static void pwm_mediatek_clk_disable(struct pwm_mediatek_chip *pc,
 				     unsigned int hwpwm)
 {
-	clk_disable_unprepare(pc->clk_pwms[hwpwm]);
+	clk_disable_unprepare(pc->clk_pwms[hwpwm].clk);
 	clk_disable_unprepare(pc->clk_main);
 	clk_disable_unprepare(pc->clk_top);
 }
@@ -130,15 +149,7 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (ret < 0)
 		return ret;
 
-	clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
-	/*
-	 * With the clk running with not more than 1 GHz the calculations below
-	 * won't overflow
-	 */
-	if (!clk_rate || clk_rate > 1000000000) {
-		ret = -EINVAL;
-		goto out;
-	}
+	clk_rate = pc->clk_pwms[pwm->hwpwm].rate;
 
 	/* Make sure we use the bus clock and not the 26MHz clock */
 	if (pc->soc->pwm_ck_26m_sel_reg)
@@ -180,7 +191,6 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
 
-out:
 	pwm_mediatek_clk_disable(pc, pwm->hwpwm);
 
 	return ret;
@@ -266,11 +276,7 @@ static int pwm_mediatek_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		u32 clkdiv, cnt_period, cnt_duty;
 		unsigned long clk_rate;
 
-		clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
-		if (!clk_rate) {
-			ret = -EINVAL;
-			goto out;
-		}
+		clk_rate = pc->clk_pwms[pwm->hwpwm].rate;
 
 		state->enabled = true;
 		state->polarity = PWM_POLARITY_NORMAL;
@@ -295,7 +301,6 @@ static int pwm_mediatek_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		state->enabled = false;
 	}
 
-out:
 	pwm_mediatek_clk_disable(pc, pwm->hwpwm);
 
 	return ret;
@@ -359,7 +364,8 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 
 	soc = of_device_get_match_data(&pdev->dev);
 
-	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_pwms, sizeof(*pc));
+	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_pwms,
+				  sizeof(*pc) + soc->num_pwms * sizeof(*pc->clk_pwms));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	pc = to_pwm_mediatek_chip(chip);
@@ -370,11 +376,6 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	pc->clk_pwms = devm_kmalloc_array(&pdev->dev, soc->num_pwms,
-				    sizeof(*pc->clk_pwms), GFP_KERNEL);
-	if (!pc->clk_pwms)
-		return -ENOMEM;
-
 	pc->clk_top = devm_clk_get(&pdev->dev, "top");
 	if (IS_ERR(pc->clk_top))
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_top),
@@ -390,10 +391,15 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 
 		snprintf(name, sizeof(name), "pwm%d", i + 1);
 
-		pc->clk_pwms[i] = devm_clk_get(&pdev->dev, name);
-		if (IS_ERR(pc->clk_pwms[i]))
-			return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_pwms[i]),
+		pc->clk_pwms[i].clk = devm_clk_get(&pdev->dev, name);
+		if (IS_ERR(pc->clk_pwms[i].clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_pwms[i].clk),
 					     "Failed to get %s clock\n", name);
+
+		ret = devm_clk_rate_exclusive_get(&pdev->dev, pc->clk_pwms[i].clk);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to lock clock rate for %s\n", name);
 	}
 
 	ret = pwm_mediatek_init_used_clks(pc);
-- 
2.49.0


