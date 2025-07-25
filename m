Return-Path: <linux-pwm+bounces-6891-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF92B12132
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 17:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B763B83A7
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DFE2EE5FD;
	Fri, 25 Jul 2025 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o1eUN59t"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE92EE97B
	for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458354; cv=none; b=jWUGxj+2+DliPja2tOhse0i4us3g6AEdf19QeqRBLcYIPPDNDkZvBA0xRvrjPm2ssbtg97i58l798O+H5mVHXi9awPt4+CKByZ8QWtmPst1WLkZ1dbdIT4Z7DVqayUMdrDyz1x6oMGqVZgxDeO2kvHnSh9wiK48atkMHE4OcoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458354; c=relaxed/simple;
	bh=VqojZhR/PzLVgvBcCgghwQQVCj6ocUYU241i7wcw1i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k67yltVnAOgAS7XWMMfR4HgSd5xt7oxutQb8MzaUMmw9R4bcNlWi3/fTd5Vtp5Hl/JqABchnsSxAfX2jkQC3M0/PaMJBTnol/akXaSBwEebxqW8u95cMbrQMr5Nxk/EAtWxz9Ipsp01qZ2C/WM9RKbMxltgJraXiylOKflHLHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o1eUN59t; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so1952452f8f.2
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753458351; x=1754063151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoJ4LgN2a4tZpj/ymfAQmbnXKEu39rNsuUXJ9Xuh1ro=;
        b=o1eUN59tsZrs4h719ph5xxw6gjdiFyn6A43hbHgI7pvdG3OL9AID78z60OWwj8OiGy
         7+r6lkk35SDTX56EA3Kof1vOaRjVFUyHyQzK+9VM29U1VS8gYTPcIYhA+Mwwhtd18e3b
         5WdySXlozdoVxDw9J/ZTlRnecDPcFDdokHPy2pfwJJqmQmmkWJ7h2WKqd6FiqEXDTNVI
         6sGeS17QZV76lXHyb3b3jbmkpPSLH6zRnDFWrlGrBEoml9HGIMWpbDd27QyRUIPc3z3v
         Hdwiy2o8ohbjBxtc6GNvIBmPIQBbExHAK6ELK4duG43nII6GCJZooPTNO3veJOeiIj07
         g3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753458351; x=1754063151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoJ4LgN2a4tZpj/ymfAQmbnXKEu39rNsuUXJ9Xuh1ro=;
        b=j4acgZC0dLQzMxzuDFP7Qv8uBBXog47j9MmcG0XdUEqZG/6NljYvUKMf/I3SY6vEZR
         V3xrQCI67m20kbwaFhIqCrG/Wp9IJkk2/8xLq9NrZu9TCbLKXkAE8JL2xZbjLZaEWIAn
         dEkHwfrOsuOuqJGNJc6oaUFEPMsyxMM2f8gUHPP+dCtlUSXN7ds2GnKE1v9xc6nmG93B
         FYqsZlI/fGbyCi7H05Ev10AOxcEzEgluGl/PPXPEPSro+Mq0MpWBcxx5KWGM6u6ahvjr
         alkCu+FvONBxg74RMakrtcVK3kVqFpys2tbKHyRRskZUw34wIqmNnzw9BARYz/rMOc67
         xl6w==
X-Gm-Message-State: AOJu0Ywk25drQyyQ1F6b4WKUUxvd6GtShZPu2tVgOnuKl46AbUveRmii
	6AfHEnqSDF2oymKdk2ldPdLu0Rc+mH8755I6sy3yNzIVIq6FsC1J4G+VnI8dlvdupt0=
X-Gm-Gg: ASbGnct9fonPWAaQCGOaxjBjHXOX3zZlkG8VZ7AvJ0OelWxZrwqs8Gan9OYIVVYKwBU
	Aq5hOdpMwGUMBtgvz99xEQR/Syk03EAAqAmBTeok62nSyBaU4eiTwao8NipGLbCj+Rdecn0zrWP
	M/km8Md9ssbwJnDSk4yjtfHBGmTeupDXhznHpTGDwRhHl/uLWkbYsP1j3/EutnyOcmW753o3/dw
	fF94QS3psyq1dVCAL8NyFwAptOytXhOyUQa7WW+hu0lOMVPdx6OD4z4ZYN1e0YDv6yGMDRY3ILd
	CI5mdb6mkLrhlNIlyjJnEYJt3VfxDxOc7/Cf6mTQ31NLSsDRjbu7qw8zBrZN+p0SKFwGf+Re7+3
	djMDyV14J1iznTpeBnPIGFqtzpDgI3EE+gwHvE8N84ez8/kY81hkS8ORlSArAE4Vv
X-Google-Smtp-Source: AGHT+IE9bNRiB3Qxy0KHeqE8qrwywnivjPUMoNFq3RkfbqAUqcT6tNnlxh22WNu3gjYRsqktjTx6xw==
X-Received: by 2002:a5d:5d84:0:b0:3a0:b940:d479 with SMTP id ffacd0b85a97d-3b776799dfamr2803849f8f.53.1753458350705;
        Fri, 25 Jul 2025 08:45:50 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458705d42b0sm57302245e9.33.2025.07.25.08.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:45:49 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 7/8] pwm: mediatek: Lock and cache clock rate
Date: Fri, 25 Jul 2025 17:45:11 +0200
Message-ID: <20250725154506.2610172-17-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5399; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=VqojZhR/PzLVgvBcCgghwQQVCj6ocUYU241i7wcw1i4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBog6aW7vIUc3dJRNMbN6JVqt2HKRuR0Bl64bZoB kVT2403OSWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIOmlgAKCRCPgPtYfRL+ TrrTB/0bKtUrqzjAmrjYN3up2a4GaQRAq8QAsWp17Ih+an/kOlLngokHze5TuTJMOk8jw0jgkoc X49aw7CWPSF0/BuhH6yt5PJ2D218i9GiAma9qENepszp59WPn5zx2OPZJ+YjrXVEEh5Rspbc5XX tt9fbRBwHvtcePKz0S4/pFFkWrbyGb4CmUpcdEIzw3YGsWDW8tt9DV7zQ0Jt1J6AvA1qbrE/Soo PzJ7efEG6mKEDsOT2bhIOqYWGvcwOFPt56R2ArY77crlHn4PtZ9+Tf9LlmXDcDbVBJS188CzzNK WHup8FXYxKmwhvYhuVca0aXqnYbxrDyBqi27M4+vJ8ldK/Eh
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
index c0a97d18e673..e3db54995f7b 100644
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
@@ -150,15 +169,7 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
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
@@ -217,7 +228,6 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		pwm_mediatek_disable(chip, pwm);
 	}
 
-out:
 	pwm_mediatek_clk_disable(pc, pwm->hwpwm);
 
 	return ret;
@@ -280,11 +290,7 @@ static int pwm_mediatek_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
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
@@ -309,7 +315,6 @@ static int pwm_mediatek_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		state->enabled = false;
 	}
 
-out:
 	pwm_mediatek_clk_disable(pc, pwm->hwpwm);
 
 	return ret;
@@ -373,7 +378,8 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 
 	soc = of_device_get_match_data(&pdev->dev);
 
-	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_pwms, sizeof(*pc));
+	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_pwms,
+				  sizeof(*pc) + soc->num_pwms * sizeof(*pc->clk_pwms));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	pc = to_pwm_mediatek_chip(chip);
@@ -384,11 +390,6 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
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
@@ -404,10 +405,15 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 
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
2.50.0


