Return-Path: <linux-pwm+bounces-3235-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EC7978389
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3E6BB20D92
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692616BFA3;
	Fri, 13 Sep 2024 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0DslaXe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9475B69E;
	Fri, 13 Sep 2024 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240099; cv=none; b=nHwisYDTyBmdoODHY2FL3OnR48LB0dFNXX8/YDNpfj7DUM95d9qzWermEvCXq26RLm8hmkFenwZbu6B5p0Ddy58y0b3oJjWuDwPfluIzZXXsp2R+U94Gfof/3xp3IPPYtS8KI1HAjQ55BPAysuXyO0Mcf26Yyv+BO9VsqE1gQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240099; c=relaxed/simple;
	bh=F7p2yDZX6Sya67BXEAuRzruxuOCCYpvbHrlwx0Qk5Xw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cOKQIa5PG4nz1zITHl5Tf6+SqjiX+zKf07A07xoBg0RZqHsSyA7igQ1F3y6YQFf8qiH5faVkU29fBwrRu1bKabghCFMKN38+keR4m0OdH7Ex3UqHM5yHZ5iJyq4/FCw2lbikW6r9V70MxZ2XK3hUJRHCKAXXIEiN5TnclJuVgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0DslaXe; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5becd359800so1944194a12.0;
        Fri, 13 Sep 2024 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240095; x=1726844895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17HIqgHEbThobLns0AtRzm3Gh6YORVy/AgMlLUCbkoU=;
        b=M0DslaXepV17r2KAgB92KeDltP8dD459gsRAlZV6WWmebH50sQlVlNvTCevEwE4gyh
         Fraw7guQcaSne57t/EfFy/rEdFOHn7NKTrR77SxPva91D6+wfL24bJE/1ARkByrJh1EJ
         3D8XGZkC22m38tyGCH24I6qv1AHY27xta2dTouXmvWfBb2qngN//4hpu5It8bJzn1H6S
         QMOooK0WPnej4PsBWN8UE5FXqbVQHmWlmmaZw1PCt4u+FQUYQ/oOavbFvu2h5+db9oou
         Y2xVl0jMPPznFynQoA64dP/taYDRVYOmjuvPMuIXZ94QyNTOJcIQMDxEKr/2vY4OzNPg
         o1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240095; x=1726844895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17HIqgHEbThobLns0AtRzm3Gh6YORVy/AgMlLUCbkoU=;
        b=Mx0A5taw5E0htGlGrOHZ+udXsKbq3cODo/nTmx7cPQPM5ZQBO8lKtwU6NZURsZykKN
         /pmY+FgEMtqBng9BKlkVZq0aWb8EPZgo8Fw7n59xhlrmoAAHrZIWl45hn4WsXPqs7ZiP
         2TiPNe75lAB8UQTcqRR4ezP0UfyU8F8jrnqdvts8Dy1sqvEm5Er4PrxZ53qaciDOczE9
         JcsFH53aGBeGdq2mTiFa/1278bFOKSZA1FkGAtFp7bUOmN/Ycf6jgYD8CNeQV02sdLRI
         Zwx4BhgInyXRYdespMu2I9OOmuxmYrMeEvCaYtaACtUl5P0Ud0qCFSGnUYDNA1KLGKs9
         SPxw==
X-Forwarded-Encrypted: i=1; AJvYcCUF7ctIV4sLAz9IYot+03NkdJwJ9IF3IKi+bcTkx1w9+EJKqg21eknHLBvunYiM0p2ypUrGMVybDH4cI+I5@vger.kernel.org, AJvYcCVzYqlntyEoLClPhUot7aHD/iNF+b9M3YARySuYfNSpucAx56iPgNZC7e23scirTKz60SzUBit40Y03D51itg==@vger.kernel.org, AJvYcCWHEYgmmt5vy7W/RHDrlcGf50xo6Yf+WTGTN7WC8cteEGycUb9agnjKUWW5V8Ig2lh/NrJ5NnoYaaqNPGU/Ufs2Lzg=@vger.kernel.org, AJvYcCWURu5xoTWJhKX5bkCWV53UOAelfgusmO8oK3Sj6p1+aYTunAId9yHnkrgXQeVGDhD5cQNBUc0javEc@vger.kernel.org, AJvYcCWYm9dhWSGc18ZESWqHW2SVCLzGbOUsO1LVUOjFW1mKz9LJuMVrD8ZoqnV2rpqGXUfvVrqM88ugM++D@vger.kernel.org, AJvYcCWfYehgntY8p7n+LT7lf2vI6fO2RNU7/uTxehdd+aTUBRsVya+xlMCndc9bDvr3Yty8MYIzzTUNEQGzIQ==@vger.kernel.org, AJvYcCXIMVyoNGUEirNU8RE+Js9UAcotk+m97DoMCWMuYHfPeZvlLAJ6W/ZhwyJFmeDmoUeDjRUnJtub7t1D@vger.kernel.org, AJvYcCXyn0Dk0E+J9QQd59odY/qh9fMHi6NGp5T76T60qcMhEN3Kx3LQ0A4q+H7lrb15LRoCdUMjv0FVtMbFYIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUUxN8cR7opfzdIVU+TNVAUQkmRc6zwepwrFrEx9M9wjEXWpHc
	63rihyv7khQOLO2nu2irxhrzPSJA4UbgTAFAZsj8wHVAWKB9UcwA+b8Qyw==
X-Google-Smtp-Source: AGHT+IFDbC8+nUawUMDJPpP2JLghGCONKzB2EfXKphKzb7uTXnNY8L/6PXyI8AxG1Fm4mo7AugZ4Sw==
X-Received: by 2002:a05:6402:321c:b0:5c2:7699:fb6f with SMTP id 4fb4d7f45d1cf-5c413e1fd66mr5471806a12.15.1726240095178;
        Fri, 13 Sep 2024 08:08:15 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:08:14 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:07:45 +0300
Subject: [PATCH v4 02/27] clk: qcom: clk-rcg2: name refactoring
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-2-2d2efd5c5877@gmail.com>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
 Simona Vetter <simona@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=5100;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=F7p2yDZX6Sya67BXEAuRzruxuOCCYpvbHrlwx0Qk5Xw=;
 b=H2NvLNTPj7u92aGj5k/qH9fs4vwopERJbMgTGRwgJ7VcGSb9+DZpGWgBeVZEvfQyJmUe/SAq0
 RNfeeA23vU6Bl7I5B+F13MmTD7sKXj57kJp1Kabm5UJBCEfzvlNmWF0
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

clk-rcg2.c uses 2 variable names for pre divisor register value:
pre_div and hid_div.

Replace hid_div with pre_div. Update calc_rate docs to reflect, that
pre_div is not pure divisor, but a register value, and requires conversion.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/clk/qcom/clk-rcg2.c | 51 ++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index bf26c5448f00..df491540ef39 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -153,13 +153,20 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
  *
  *          parent_rate     m
  *   rate = ----------- x  ---
- *            hid_div       n
+ *          pre_div_pure    n
+ *
+ * @param rate - Parent rate.
+ * @param m - Multiplier.
+ * @param n - Divisor.
+ * @param mode - Use zero to ignore m/n calculation.
+ * @param pre_div - Pre divisor register value. Pure pre divisor value
+ *                  related to pre_div as pre_div_pure = (pre_div + 1) / 2
  */
 static unsigned long
-calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 hid_div)
+calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 pre_div)
 {
-	if (hid_div)
-		rate = mult_frac(rate, 2, hid_div + 1);
+	if (pre_div)
+		rate = mult_frac(rate, 2, pre_div + 1);
 
 	if (mode)
 		rate = mult_frac(rate, m, n);
@@ -171,7 +178,7 @@ static unsigned long
 __clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate, u32 cfg)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
-	u32 hid_div, m = 0, n = 0, mode = 0, mask;
+	u32 pre_div, m = 0, n = 0, mode = 0, mask;
 
 	if (rcg->mnd_width) {
 		mask = BIT(rcg->mnd_width) - 1;
@@ -186,10 +193,10 @@ __clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate, u32 cfg)
 	}
 
 	mask = BIT(rcg->hid_width) - 1;
-	hid_div = cfg >> CFG_SRC_DIV_SHIFT;
-	hid_div &= mask;
+	pre_div = cfg >> CFG_SRC_DIV_SHIFT;
+	pre_div &= mask;
 
-	return calc_rate(parent_rate, m, n, mode, hid_div);
+	return calc_rate(parent_rate, m, n, mode, pre_div);
 }
 
 static unsigned long
@@ -715,7 +722,7 @@ static int clk_edp_pixel_set_rate(struct clk_hw *hw, unsigned long rate,
 	s64 src_rate = parent_rate;
 	s64 request;
 	u32 mask = BIT(rcg->hid_width) - 1;
-	u32 hid_div;
+	u32 pre_div;
 
 	if (src_rate == 810000000)
 		frac = frac_table_810m;
@@ -731,8 +738,8 @@ static int clk_edp_pixel_set_rate(struct clk_hw *hw, unsigned long rate,
 			continue;
 
 		regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
-				&hid_div);
-		f.pre_div = hid_div;
+				&pre_div);
+		f.pre_div = pre_div;
 		f.pre_div >>= CFG_SRC_DIV_SHIFT;
 		f.pre_div &= mask;
 		f.m = frac->num;
@@ -760,7 +767,7 @@ static int clk_edp_pixel_determine_rate(struct clk_hw *hw,
 	int delta = 100000;
 	s64 request;
 	u32 mask = BIT(rcg->hid_width) - 1;
-	u32 hid_div;
+	u32 pre_div;
 	int index = qcom_find_src_index(hw, rcg->parent_map, f->src);
 
 	/* Force the correct parent */
@@ -781,13 +788,13 @@ static int clk_edp_pixel_determine_rate(struct clk_hw *hw,
 			continue;
 
 		regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
-				&hid_div);
-		hid_div >>= CFG_SRC_DIV_SHIFT;
-		hid_div &= mask;
+				&pre_div);
+		pre_div >>= CFG_SRC_DIV_SHIFT;
+		pre_div &= mask;
 
 		req->rate = calc_rate(req->best_parent_rate,
 				      frac->num, frac->den,
-				      !!frac->den, hid_div);
+				      !!frac->den, pre_div);
 		return 0;
 	}
 
@@ -974,7 +981,7 @@ static int clk_pixel_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long request;
 	int delta = 100000;
 	u32 mask = BIT(rcg->hid_width) - 1;
-	u32 hid_div, cfg;
+	u32 pre_div, cfg;
 	int i, num_parents = clk_hw_get_num_parents(hw);
 
 	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
@@ -995,8 +1002,8 @@ static int clk_pixel_set_rate(struct clk_hw *hw, unsigned long rate,
 			continue;
 
 		regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
-				&hid_div);
-		f.pre_div = hid_div;
+				&pre_div);
+		f.pre_div = pre_div;
 		f.pre_div >>= CFG_SRC_DIV_SHIFT;
 		f.pre_div &= mask;
 		f.m = frac->num;
@@ -1564,7 +1571,7 @@ static int clk_rcg2_dp_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	struct freq_tbl f = { 0 };
 	u32 mask = BIT(rcg->hid_width) - 1;
-	u32 hid_div, cfg;
+	u32 pre_div, cfg;
 	int i, num_parents = clk_hw_get_num_parents(hw);
 	unsigned long num, den;
 
@@ -1576,7 +1583,7 @@ static int clk_rcg2_dp_set_rate(struct clk_hw *hw, unsigned long rate,
 		return -EINVAL;
 
 	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
-	hid_div = cfg;
+	pre_div = cfg;
 	cfg &= CFG_SRC_SEL_MASK;
 	cfg >>= CFG_SRC_SEL_SHIFT;
 
@@ -1587,7 +1594,7 @@ static int clk_rcg2_dp_set_rate(struct clk_hw *hw, unsigned long rate,
 		}
 	}
 
-	f.pre_div = hid_div;
+	f.pre_div = pre_div;
 	f.pre_div >>= CFG_SRC_DIV_SHIFT;
 	f.pre_div &= mask;
 

-- 
2.39.2


