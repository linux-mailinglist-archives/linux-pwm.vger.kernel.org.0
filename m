Return-Path: <linux-pwm+bounces-2212-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106C68CB470
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 21:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340881C21F32
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 19:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E591494D6;
	Tue, 21 May 2024 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sBmPlD3F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F65A1494A0
	for <linux-pwm@vger.kernel.org>; Tue, 21 May 2024 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320963; cv=none; b=ds71z44Kky0jPx4KFtjaehsh3hZEISq5j/w1XMPtMRQK3MTGgYOSJbWaECuQ4NDTQDwwkLDtZ4jN/Eox09VIxqi3TpMLPEEybtUqrfYOmal8ABS9Plmv795fe/8VlBUco43TBY09Rc0wql5HEdj7M5v5jmvH5iYIy5G+FeJPo0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320963; c=relaxed/simple;
	bh=Tooj6Y95pxQ5NpSlmeomxmuNcm9R63NtHWlrO8VM0ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEIUwbBHzjB7CIm3IcOjX55obtKlNyZ6kLh3uHP4CVVxh0VLDG30p4GPGTjerWdEFfcQyPAtGcSw0Y7IYsQnBDe67pcpRM23bm2WZNV3re6b2R5mvzz0T6jDBXZDA3taeNpFpHDjsSLVh7eSsLAi8FSw+ZUbN7yqZUbXskOc8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sBmPlD3F; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-22ed075a629so2291128fac.3
        for <linux-pwm@vger.kernel.org>; Tue, 21 May 2024 12:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716320961; x=1716925761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZqjqst6IA8s4Y0Tix3Y2ed1HRW8o5RgtxqsUgjpfM8=;
        b=sBmPlD3FiShGzMSRE1qIn4c9t6NoypMiypCaiqR/LsouXj3cQjHZINdoIk5XI5nX5C
         q4m51xRNFallri6Rpq5lTREUd7gdYfB9IsW+f+sF/puAI7AYWsePCnaog9akR5VIBcfi
         E0lHo0iCHjR8x210+ZmNs4MFAi5lAubWHFPfBqeLGwCqpZNmvWmCkK3J/WeEg3CIxVGk
         pBBn41wXJOsdFipOpLwAofMJzl3EQ2hyYYUFAgbTEABBKqo/JopyDB55/W1kvFJma4if
         yTL4iBz9+Lf449qBxvG9V2EmVkNgF8Li0b+d97cVsVnoOZ7B0lqv+bXQyWabEmBtejzY
         5I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716320961; x=1716925761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZqjqst6IA8s4Y0Tix3Y2ed1HRW8o5RgtxqsUgjpfM8=;
        b=LOhXc1dxHHQ6L0W/f3Qu50SOWc86i/t9iqoqtT8XaxHRuDhcpOZIyLKpUTTRTpd4w8
         NWgKy+xbcRzkT/cMKNJq8+i93TrOgUtkWJjUC5lBtnuaCtcC1lCU5go71rF1m4sg0xnw
         7xcFzN9kf6NFQNuch/sEX530ude3cjw4+GTynQ3PAVzdwQbLQmBgtGICXe33sm8Ik7Kv
         4mbqyodwuLfda4goL7pXx2kfubLYUWhaRPhlMRdslmX2VX8u4Htliv00w0rHlKw1bmtR
         fcxQI4Vp6PkXetTITMLY9ppXcjyKuW0RIaXr/+WfElfOwQOyL5RXsra4zWrWn+RWHBZt
         s/Vw==
X-Gm-Message-State: AOJu0YzuRugkwbwLEkG6+ipmUmSHnNstUHGfFhmyjfZt94WMLodyTaOe
	SjQNoHUL+wZKvzenqSmLVWearmxh3SvW0x+GaL7P3MvvQuEGp3dErYkFoWvSmLIwM1yuj9eidZ+
	a
X-Google-Smtp-Source: AGHT+IEXbAcssGSEqg2FFDiVusT4NNfPEryqOcuyeXi3Pw+DSNm9s1FRNgKW5xThmneBDiVA2Juu/A==
X-Received: by 2002:a05:6871:712:b0:23d:c09b:e5eb with SMTP id 586e51a60fabf-24c68ddeb4emr106959fac.36.1716320960765;
        Tue, 21 May 2024 12:49:20 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54d85a0sm161723611cf.23.2024.05.21.12.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:49:20 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [PATCH 2/2 v3] pwm: axi-pwmgen: add duty offset support
Date: Tue, 21 May 2024 15:49:16 -0400
Message-ID: <20240521194916.1897909-3-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240521194916.1897909-1-tgamblin@baylibre.com>
References: <20240521194916.1897909-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable duty_offset feature now that it is supported in the pwm
subsystem. Related macros and struct fields related to duty_offset are
renamed to be consistent.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
v3 changes:
* rebased on top of latest pwm/for-next

v2 changes:
* Address feedback for driver in v1:
  * Remove line setting supports_offset flag in pwm_chip, since that has
    been removed from the struct in core.c.
---
 drivers/pwm/pwm-axi-pwmgen.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index e0bf90cc2ba3..9ae06b105d07 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -56,7 +56,7 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
 	unsigned int ch = pwm->hwpwm;
 	struct regmap *regmap = ddata->regmap;
-	u64 period_cnt, duty_cnt;
+	u64 period_cnt, duty_cnt, duty_offset_cnt;
 	int ret;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
@@ -81,6 +81,14 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
 		if (ret)
 			return ret;
+
+		duty_offset_cnt = mul_u64_u64_div_u64(state->duty_offset, ddata->clk_rate_hz, NSEC_PER_SEC);
+		if (duty_offset_cnt > UINT_MAX)
+			duty_offset_cnt = UINT_MAX;
+
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_OFFSET(ch), duty_offset_cnt);
+		if (ret)
+			return ret;
 	} else {
 		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), 0);
 		if (ret)
@@ -89,6 +97,10 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), 0);
 		if (ret)
 			return ret;
+
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_OFFSET(ch), 0);
+		if (ret)
+			return ret;
 	}
 
 	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
@@ -117,6 +129,12 @@ static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	state->duty_cycle = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
 
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_OFFSET(ch), &cnt);
+	if (ret)
+		return ret;
+
+	state->duty_offset = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
+
 	state->polarity = PWM_POLARITY_NORMAL;
 
 	return 0;
-- 
2.45.1


