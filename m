Return-Path: <linux-pwm+bounces-3134-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAF296F889
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 17:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4A6285931
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D001D31A9;
	Fri,  6 Sep 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GgCAENK2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45E41D2F7D
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637424; cv=none; b=ZtbudbOZrxC0OtUXGIbW52JlX16N3xOzq9h/TVr+pCe+r6noN+whhlR7pe1piMgWenyfMRneJrL+1QW4JPutEVPRQM/w1DlHhgq33aqaGhIGKf3appmL27tNnkITlrG9ErME+4pWPU9ImQrUFdkmb6D57bVPmjUyZLjy645vJCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637424; c=relaxed/simple;
	bh=X6uBbk6t+pJADxDxo0CW44vNQ7+l8ZXJy9k3jI910PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJj6XW6TXz7umj9/82UWMjrDNwNa19fW9RpGJvltPKVVb0yy3/hlvZ6DeBfbVZ397XSvV5Z5nZALRpXywLjMJWDJE+sh9aHTr3eFUKdpNPPlyflCpH8SaeZdOFQZpsAugUpYfOW7rAs0OBbDXw62ozYNSFn43jsgJtRJgYFElwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GgCAENK2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so297127966b.0
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725637420; x=1726242220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8PSwzEQf2y6+BxVfm/joke/wjsTnZDKoIRAhDAw11A=;
        b=GgCAENK2iyAP8mH1T1eXiAJ3WambctjyfJdi/UqYpF9mxmDhaH80gxs0FfNA1+U5Wp
         aPDq2L01F4/TPjBLtC+iwmNrpOzLYLoDNFDnUU/X+c76vOC+m7AQdwXgJKtFjBvVGG4t
         NcHDqlc5acSVKaxAQM97ePy02JeqHaR0zxCh7KX5+OXc8/gvX/XmcE0H0Q/h6euhx3kG
         iNbkD8T2Y+nZkZN8G77R3jWpCOLf2npcAe1LxZ04EYMb5N3g/qv6gm0vZv+rLjBv8bBq
         mTLPkTBYmVN0qpRBVHrzo4y+5YTWibrE2YknsmhOKeO7D00PMdCVTaK5hxUVrXsEO/UI
         AoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725637420; x=1726242220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8PSwzEQf2y6+BxVfm/joke/wjsTnZDKoIRAhDAw11A=;
        b=APJZ3/gGhLrI/QQ9KiHKdJJqh8KDHXsQGZYZ+Rs1hCJoBJqq3ALPuLeyNMVuEphRxm
         ZrQd+i+dcCeJW3IpQoc/5JE8cb0QARIa96RU7FDvwFTXusyHhZPc8VVyophv2rMnt6U1
         phmT+XNTb7VKYdg+tVyYsdb52VI/JvZJm6hXcbj6uEE8gK0HOxI5XWB0uLYDvDgIn3Hp
         +UJ+gnJc3vBdlML4Fb4MhzqaP8NFz7pJJ3NeM56DntMofRN7ej3MGtS+TFxWwJeQlEXe
         PfxUMx0zhazvHVuyNfNeGzSDPlHQr1u6lTXXd95tiehEn7yg5204zSFa37j/b0jqUoxD
         COBw==
X-Gm-Message-State: AOJu0YzqAtJ1sRQv89HxUx07vKoZtjv3GqWZFM7fCj9iZfI/VSuvF6JX
	+p2sRAv59BhjQP7UQI2Eq9ShbGBPh1rwvKkjJtxHiLLzeEhq5w1nNCim+HjnoERbPJ4RWutqSRq
	C
X-Google-Smtp-Source: AGHT+IFhimgnlppZVYH4uW3vcgYPd4VUeTAzrIDIe13VRQsQp9xt/l4pZdPiBHmc9AYOTawt2ddMew==
X-Received: by 2002:a17:907:3f83:b0:a86:91a5:4d09 with SMTP id a640c23a62f3a-a8a863f2ea5mr362725466b.26.1725637419837;
        Fri, 06 Sep 2024 08:43:39 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d0c776239sm44535766b.64.2024.09.06.08.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:43:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Kent Gibson <warthog618@gmail.com>,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH v4 6/7] pwm: axi-pwmgen: Implementation of the waveform callbacks
Date: Fri,  6 Sep 2024 17:43:02 +0200
Message-ID:  <3b0a91f10da46caf5ef24b943b3cf6f056b9776c.1725635013.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6869; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=X6uBbk6t+pJADxDxo0CW44vNQ7+l8ZXJy9k3jI910PU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm2yMQPdi3jW3DeHNl0MN5KuCGyXwm6XfKYvcHE pkZN5EHj5OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZtsjEAAKCRCPgPtYfRL+ TryPB/9IFN0xS2O0r9SLU6h8Dc3T9HG4C6kAv6bQZXzo/s+fnqDDd6MmlyDZj7cpLrOrygx7zkU UdMjsJv3fDaCzHDmQs6sVWicZ95Awu4FZhIP1/eedW4nympDwY2ePAFtJhqM/BWG+erquoK14MK PeW4WwL8DlCHklGO2Pe7Go1emZx7dJpBqcY+QfZnW7wINLd4r8gRxb/iMwLG9FeyGLJs8IiKfRr H6tS4eBBr5nXSyBWGdjYl0NwIPCWYGdLSFor/bAOfTyltT7ymrELUuOgrEX0yAFu0aVNjdVTOCg JN2ypeuT/GLK+tYL5GBOUDKSly2K80QxZH5BB2L9bb0WDnXE
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Convert the axi-pwmgen driver to use the new callbacks for hardware
programming.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 154 ++++++++++++++++++++++++-----------
 1 file changed, 108 insertions(+), 46 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index 3ad60edf20a5..14c3274b551b 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -23,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/fpga/adi-axi-common.h>
 #include <linux/io.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
@@ -54,81 +55,142 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
 	.max_register = 0xFC,
 };
 
-static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			    const struct pwm_state *state)
+/* This represents a hardware configuration for one channel */
+struct axi_pwmgen_waveform {
+	u32 period_cnt;
+	u32 duty_cycle_cnt;
+	u32 duty_offset_cnt;
+};
+
+static int axi_pwmgen_round_waveform_tohw(struct pwm_chip *chip,
+					  struct pwm_device *pwm,
+					  const struct pwm_waveform *wf,
+					  void *_wfhw)
 {
+	struct axi_pwmgen_waveform *wfhw = _wfhw;
+	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
+
+	if (wf->period_length_ns == 0) {
+		*wfhw = (struct axi_pwmgen_waveform){
+			.period_cnt = 0,
+			.duty_cycle_cnt = 0,
+			.duty_offset_cnt = 0,
+		};
+	} else {
+		/* With ddata->clk_rate_hz < NSEC_PER_SEC this won't overflow. */
+		wfhw->period_cnt = min_t(u64,
+					 mul_u64_u32_div(wf->period_length_ns, ddata->clk_rate_hz, NSEC_PER_SEC),
+					 U32_MAX);
+
+		if (wfhw->period_cnt == 0) {
+			/*
+			 * The specified period is too short for the hardware.
+			 * Let's round .duty_cycle down to 0 to get a (somewhat)
+			 * valid result.
+			 */
+			wfhw->period_cnt = 1;
+			wfhw->duty_cycle_cnt = 0;
+			wfhw->duty_offset_cnt = 0;
+		} else {
+			wfhw->duty_cycle_cnt = min_t(u64,
+						     mul_u64_u32_div(wf->duty_length_ns, ddata->clk_rate_hz, NSEC_PER_SEC),
+						     U32_MAX);
+			wfhw->duty_offset_cnt = min_t(u64,
+						      mul_u64_u32_div(wf->duty_offset_ns, ddata->clk_rate_hz, NSEC_PER_SEC),
+						      U32_MAX);
+		}
+	}
+
+	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld [+%lld] @%lu -> PERIOD: %08x, DUTY: %08x, OFFSET: %08x\n",
+		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
+		ddata->clk_rate_hz, wfhw->period_cnt, wfhw->duty_cycle_cnt, wfhw->duty_offset_cnt);
+
+	return 0;
+}
+
+static int axi_pwmgen_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
+					     const void *_wfhw, struct pwm_waveform *wf)
+{
+	const struct axi_pwmgen_waveform *wfhw = _wfhw;
+	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
+
+	wf->period_length_ns = DIV64_U64_ROUND_UP((u64)wfhw->period_cnt * NSEC_PER_SEC,
+					ddata->clk_rate_hz);
+
+	wf->duty_length_ns = DIV64_U64_ROUND_UP((u64)wfhw->duty_cycle_cnt * NSEC_PER_SEC,
+					    ddata->clk_rate_hz);
+
+	wf->duty_offset_ns = DIV64_U64_ROUND_UP((u64)wfhw->duty_offset_cnt * NSEC_PER_SEC,
+					     ddata->clk_rate_hz);
+
+	return 0;
+}
+
+static int axi_pwmgen_write_waveform(struct pwm_chip *chip,
+				     struct pwm_device *pwm,
+				     const void *_wfhw)
+{
+	const struct axi_pwmgen_waveform *wfhw = _wfhw;
 	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
-	unsigned int ch = pwm->hwpwm;
 	struct regmap *regmap = ddata->regmap;
-	u64 period_cnt, duty_cnt;
+	unsigned int ch = pwm->hwpwm;
 	int ret;
 
-	if (state->polarity != PWM_POLARITY_NORMAL)
-		return -EINVAL;
+	ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), wfhw->period_cnt);
+	if (ret)
+		return ret;
 
-	if (state->enabled) {
-		period_cnt = mul_u64_u64_div_u64(state->period, ddata->clk_rate_hz, NSEC_PER_SEC);
-		if (period_cnt > UINT_MAX)
-			period_cnt = UINT_MAX;
+	ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), wfhw->duty_cycle_cnt);
+	if (ret)
+		return ret;
 
-		if (period_cnt == 0)
-			return -EINVAL;
-
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), period_cnt);
-		if (ret)
-			return ret;
-
-		duty_cnt = mul_u64_u64_div_u64(state->duty_cycle, ddata->clk_rate_hz, NSEC_PER_SEC);
-		if (duty_cnt > UINT_MAX)
-			duty_cnt = UINT_MAX;
-
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
-		if (ret)
-			return ret;
-	} else {
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), 0);
-		if (ret)
-			return ret;
-
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), 0);
-		if (ret)
-			return ret;
-	}
+	ret = regmap_write(regmap, AXI_PWMGEN_CHX_OFFSET(ch), wfhw->duty_offset_cnt);
+	if (ret)
+		return ret;
 
 	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
 }
 
-static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
-				struct pwm_state *state)
+static int axi_pwmgen_read_waveform(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    void *_wfhw)
 {
+	struct axi_pwmgen_waveform *wfhw = _wfhw;
 	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
 	struct regmap *regmap = ddata->regmap;
 	unsigned int ch = pwm->hwpwm;
-	u32 cnt;
 	int ret;
 
-	ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &wfhw->period_cnt);
 	if (ret)
 		return ret;
 
-	state->enabled = cnt != 0;
-
-	state->period = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
-
-	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &cnt);
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &wfhw->duty_cycle_cnt);
 	if (ret)
 		return ret;
 
-	state->duty_cycle = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_OFFSET(ch), &wfhw->duty_offset_cnt);
+	if (ret)
+		return ret;
 
-	state->polarity = PWM_POLARITY_NORMAL;
+	if (wfhw->duty_cycle_cnt > wfhw->period_cnt)
+		wfhw->duty_cycle_cnt = wfhw->period_cnt;
+
+	/* XXX: is this the actual behaviour of the hardware? */
+	if (wfhw->duty_offset_cnt >= wfhw->period_cnt) {
+		wfhw->duty_cycle_cnt = 0;
+		wfhw->duty_offset_cnt = 0;
+	}
 
 	return 0;
 }
 
 static const struct pwm_ops axi_pwmgen_pwm_ops = {
-	.apply = axi_pwmgen_apply,
-	.get_state = axi_pwmgen_get_state,
+	.sizeof_wfhw = sizeof(struct axi_pwmgen_waveform),
+	.round_waveform_tohw = axi_pwmgen_round_waveform_tohw,
+	.round_waveform_fromhw = axi_pwmgen_round_waveform_fromhw,
+	.read_waveform = axi_pwmgen_read_waveform,
+	.write_waveform = axi_pwmgen_write_waveform,
 };
 
 static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
-- 
2.45.2


