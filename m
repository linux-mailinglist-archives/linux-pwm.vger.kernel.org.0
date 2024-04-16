Return-Path: <linux-pwm+bounces-1963-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E16C8A7094
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 17:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7547D1F258A2
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D105013AA31;
	Tue, 16 Apr 2024 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GgLrJh7i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D0513248D
	for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282824; cv=none; b=C15jmfe7+22YFLbM7oHXYKF/dEyYzRJNpZEOKWKYw8KkJxuR4RQup5A3uDN5R0sZ6iNz2mHK+/BXOHACWHMjmbtVPI7qJZUe9KzTa3PZmfJi8D5Vd0enfC4FRhILG9Jh4Y8PXPwSYcjVB6iYtxdLMdPNJ8G3z0BYi94aLibebTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282824; c=relaxed/simple;
	bh=3PSa4tH/zyI8rzr1s/aLzOhrBB2HeNT52fzU5eMeOeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQ7PHb/1GedYLuvyZEXxIvYiXH+ROYNyoqgV6v8i23/vAV6qBc0w4RMG8mbpDYsMKE/hTmCg5ZBktIjHXz/AKcWNCaC1wd6tHdUVRORPAiWTxYt5hJWYr7PzYr/Ghvv4/67PZ++I1d/TrDFZQFK3kv7jvN6K39737XlobuZO/eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GgLrJh7i; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5701dec0c0aso3296780a12.3
        for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713282821; x=1713887621; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMggw4eAIIMNoOqD82TuIffDCB4kGTedXkImx4hYDjA=;
        b=GgLrJh7irCUF0Fr8vFpnz/k/qeL1E9z+0zeDWJMxRqnXATHae9RQ7HlG7SVMQwgQrL
         Pq2NzVVaUyZfDOM7l6Y8Ictj/hqXtFS5YdHcUEd0Emwjpk6elsBMTt5K/pdZIynd8RjP
         rVoLOXIu+0DmRNuAgceuah15BWjEZc3QWcPp1qUy0OxXr7SDiTc1T11p5N/wI/F83hdW
         CG9eUpp6mJAJtLc2t0yNTuDYwu/9IFm7oj0fHyW8u/ChPas+xwWh7k1r/WMR0gUpFZL4
         xuX394LLE6fGJP87o4I1OOZc9NhBnLqnsJflKTMzxs8+rFi+P+Rl6YwKm+O/qqLtlEb8
         LIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282821; x=1713887621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMggw4eAIIMNoOqD82TuIffDCB4kGTedXkImx4hYDjA=;
        b=iyW4wliUOqcr7idzNwXRThphlat7JYcNT/POTX9bU9c0YOMdD9+59I9eSudxb5CmCn
         dAiOOKSUTJ5GatPssj89exOL7qI1qO3D/O/1SyhERrhz7pSeFW1xWpfzrft8GLSFhzDP
         W66aWflM6z1ieQDd3NJuZDtj1bDgbmKFI9CQjsSWpKcvZkCVniqxNlnQ28BkW3ozcSHL
         sUojVF+O2BuuNSdRZsgShRc5s2qLr3LrGs3eVepQ3AQEDQCmyLofUOm26INVWELyV2fN
         AUl52UBKBKpVrILmnXOzzlehiz1o4cCFw84fPNUiqDwaWQoru0TRF40e197qXSDGmJin
         vvRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrskM7URlIWuL8NZThmXu6gz+o22N6pj7H0JceeuOXFiJY+cOjlyiVSFskC6XDOYiOysQhrlzm5ggEBDDBOPtWCyFZLyly3MBb
X-Gm-Message-State: AOJu0Yy9VJiFrFDxpC0sfLXGKN194lwZq/hFZLxsNCkZIxe9Ky1Ifz4e
	jYQ0wvfCbuMqFCc+OB1uqL30ZmoMCgaZh2crs+3KmOTSu+mwgIpu95mZHXT38bE=
X-Google-Smtp-Source: AGHT+IG4kHPNppMzbZ+TqGer4WN/sT4qiIADE/xGhBqwrUJLC7I/hWwKiyTjJz3tShpT/DsfMFbnmg==
X-Received: by 2002:a17:906:f809:b0:a52:140c:5724 with SMTP id kh9-20020a170906f80900b00a52140c5724mr7675563ejb.14.1713282821426;
        Tue, 16 Apr 2024 08:53:41 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4156691eje.94.2024.04.16.08.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:40 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 16 Apr 2024 17:53:15 +0200
Subject: [PATCH v2 14/18] drm/mediatek: add mt8365 dpi support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v2-14-33ce8864b227@baylibre.com>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
In-Reply-To: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2579; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=3PSa4tH/zyI8rzr1s/aLzOhrBB2HeNT52fzU5eMeOeM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmHp7qMcxUGRm8N5OCd/Fk/xRizSuW+tNcwCsX+kwb
 hyW8FuWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh6e6gAKCRArRkmdfjHURVoZEA
 CFkEfMS2RbJUzeU6UYxk1MOpg5EO2+mBMtUQwYEm/fkmqVz8IMLq8JRBoeGwIrqDp52D3NZBrv4UC9
 zYr5HViOOH/XWzdzZRExf41VNixp1v7P+sFbq4KFTIZZAAQxFkRKOnTssfGv3neRvlmRVLK9UlVAwB
 NJWV/c5Q4XLE0uicMBKvujjV/6V5bTH9Ib7QW6PvjzHqsA4fRGsyHvalWdMaK9FcbPnxiL/h9ZhBpQ
 bcIkJ8YihSLmSsvoZ+QloMjK2kCnbpUx1jFvp2jOGkrvehOks0xj+9BretUNGKVXewIHeHl6DC90uV
 WEuoeK+eL4EXNQPWAgL3daPdSf2FhIEPleids+MByUqzmHUruYs6aNX5whxcptdbtITgjDmU9NGter
 4KnosCp4CmigOqdwDzfaFdNtvZQ/Kp05yWzz2axkq2PZoN0rucO1wLGmAiwNz7ysc1VYr4DGd3viwc
 Ct5qF/tfBu6PkETYife2PCGSSi3KyIfqCSEphmSHrnXcKqpyioJg+HPoS+NHUmz0jWWiArYahDd8Ad
 h2CD1UfpWXJ3lAeF3eYhI9Ek5Ija1G9DKMz0YHlS0TbBWuQAlbGFIk6HwzRZ1c/GhioWc90RkVERM3
 BYrWNdeIrcnO0zfoecsPlaOQQaR0Gp5bFu6C6PcQ3APMlvG4p2HnlvZTd+sQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

- Add compatibles and platform data into the Mediatek DPI driver.
- Fix the DPI0 parent clock to be consistent.

This SoC is compatible with the mt8183 calculate factor.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365-mm.c |  2 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c   | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8365-mm.c b/drivers/clk/mediatek/clk-mt8365-mm.c
index 01a2ef8f594e..3f62ec750733 100644
--- a/drivers/clk/mediatek/clk-mt8365-mm.c
+++ b/drivers/clk/mediatek/clk-mt8365-mm.c
@@ -53,7 +53,7 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_MM0(CLK_MM_MM_DSI0, "mm_dsi0", "mm_sel", 17),
 	GATE_MM0(CLK_MM_MM_DISP_RDMA1, "mm_disp_rdma1", "mm_sel", 18),
 	GATE_MM0(CLK_MM_MM_MDP_RDMA1, "mm_mdp_rdma1", "mm_sel", 19),
-	GATE_MM0(CLK_MM_DPI0_DPI0, "mm_dpi0_dpi0", "vpll_dpix", 20),
+	GATE_MM0(CLK_MM_DPI0_DPI0, "mm_dpi0_dpi0", "dpi0_sel", 20),
 	GATE_MM0(CLK_MM_MM_FAKE, "mm_fake", "mm_sel", 21),
 	GATE_MM0(CLK_MM_MM_SMI_COMMON, "mm_smi_common", "mm_sel", 22),
 	GATE_MM0(CLK_MM_MM_SMI_LARB0, "mm_smi_larb0", "mm_sel", 23),
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index beb7d9d08e97..a4f9376ee472 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -997,6 +997,23 @@ static const struct mtk_dpi_conf mt8195_dpintf_conf = {
 	.csc_enable_bit = DPINTF_CSC_ENABLE,
 };
 
+static const struct mtk_dpi_conf mt8365_conf = {
+	.cal_factor = mt8183_calculate_factor,
+	.reg_h_fre_con = 0xe0,
+	.max_clock_khz = 150000,
+	.output_fmts = mt8183_output_fmts,
+	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
+	.pixels_per_iter = 1,
+	.is_ck_de_pol = true,
+	.swap_input_support = true,
+	.support_direct_pin = true,
+	.dimension_mask = HPW_MASK,
+	.hvsize_mask = HSIZE_MASK,
+	.channel_swap_shift = CH_SWAP,
+	.yuv422_en_bit = YUV422_EN,
+	.csc_enable_bit = CSC_ENABLE,
+};
+
 static int mtk_dpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1092,6 +1109,7 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
 	{ .compatible = "mediatek,mt8188-dp-intf", .data = &mt8195_dpintf_conf },
 	{ .compatible = "mediatek,mt8192-dpi", .data = &mt8192_conf },
 	{ .compatible = "mediatek,mt8195-dp-intf", .data = &mt8195_dpintf_conf },
+	{ .compatible = "mediatek,mt8365-dpi", .data = &mt8365_conf },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mtk_dpi_of_ids);

-- 
2.25.1


