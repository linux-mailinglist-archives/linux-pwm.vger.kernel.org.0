Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673DC44FA97
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhKNTkE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbhKNTjf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:35 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF408C06120B;
        Sun, 14 Nov 2021 11:36:34 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id n12so27934588lfe.1;
        Sun, 14 Nov 2021 11:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+jxEVcQtZ3tt3q/wwMe8WgzAKwAHr0b1+CvBDSsdZHw=;
        b=Ys7aR6ppVnZpBUCUTTWoqNaohuZCtuGaQiIlTR0VtNQDlpjap/QEWB/E4Ct4mDB52Z
         f7sVAqrpSFlqh1nykq1VI/+9ggO/MJn5ORxO0UwlFzZRwA6jfmFYIEhORtgUCVgw0MQJ
         iDgkVi5j37e7gTewjVHAppe0KasYw6+xck6ysSSwwFaXEt0uhpT3EHqbQ8xL1xx0zO5c
         TUGiS9pIEGS7h02MrdbE06DgHHx4BeXCwjJRYSchW6WtiQhdwBihqskrouS/lSg71qQL
         OPZ9flqHMK0hNv2Sk/2efzxICUJLZdPOiIO6nAfbJk+RzWGHE5WHYL2TE/lvD/6BqGxp
         Jqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+jxEVcQtZ3tt3q/wwMe8WgzAKwAHr0b1+CvBDSsdZHw=;
        b=Ojm4XmiZ7HQvFUgaJKUf2JyJD5KD9/foX39oOh83JCBVYwZB7IdMZ8DTeoZsDwO/S/
         oqCbywEhY0VKTSKVk9IWD4k4HGyzWGezPHb7P7lVp9UF8LaPTFf8zXfOQNJzIud+M+TJ
         GmN5yKyDUMfyUC+/DqnLXBUhHkH6cq9nC1ahVOhW9/3X2Ud1cemdp9U8a0dk7tyT5GUm
         ccrYRP+c81GgYDqYTxyip/qcIqCsa0YWGKk4wdbc40qGAq+pxlNCf84djsatTmPEBupM
         /4s/P3oy44p70JDlP9M5fYU7uR+s9rcpblMfcUhAQAkovBxqgp8KJcEHiPrufH6c8cPm
         M4qw==
X-Gm-Message-State: AOAM531uqtZQOBlMFmv6htANkr5k3b+HtQziTucRq47mRkxqrYNWpXIN
        XSTEV+3h9fT0Z9u2W7pa1h0=
X-Google-Smtp-Source: ABdhPJx/STPXnl9ymA9pFwddIGLtOhVmwggtSNvxh8KGgR9bGlQd7uy9yE2t4dYQNAxmz7v/mfb6qA==
X-Received: by 2002:a05:6512:3f28:: with SMTP id y40mr30369544lfa.499.1636918592764;
        Sun, 14 Nov 2021 11:36:32 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:32 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v15 38/39] ARM: tegra: Add Memory Client resets to Tegra30 GR2D, GR3D and Host1x
Date:   Sun, 14 Nov 2021 22:34:34 +0300
Message-Id: <20211114193435.7705-39-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Memory access must be blocked before hardware reset is asserted and before
power is gated, otherwise a serious hardware fault is inevitable. Add
reset for memory clients to the GR2D, GR3D and Host1x nodes.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index e40d5563778b..c1be136aac7d 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -123,8 +123,8 @@ host1x@50000000 {
 		interrupt-names = "syncpt", "host1x";
 		clocks = <&tegra_car TEGRA30_CLK_HOST1X>;
 		clock-names = "host1x";
-		resets = <&tegra_car 28>;
-		reset-names = "host1x";
+		resets = <&tegra_car 28>, <&mc TEGRA30_MC_RESET_HC>;
+		reset-names = "host1x", "mc";
 		iommus = <&mc TEGRA_SWGROUP_HC>;
 		power-domains = <&pd_heg>;
 		operating-points-v2 = <&host1x_dvfs_opp_table>;
@@ -190,8 +190,8 @@ gr2d@54140000 {
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_GR2D>;
-			resets = <&tegra_car 21>;
-			reset-names = "2d";
+			resets = <&tegra_car 21>, <&mc TEGRA30_MC_RESET_2D>;
+			reset-names = "2d", "mc";
 			power-domains = <&pd_heg>;
 			operating-points-v2 = <&gr2d_dvfs_opp_table>;
 
@@ -205,8 +205,10 @@ gr3d@54180000 {
 				 <&tegra_car TEGRA30_CLK_GR3D2>;
 			clock-names = "3d", "3d2";
 			resets = <&tegra_car 24>,
-				 <&tegra_car 98>;
-			reset-names = "3d", "3d2";
+				 <&tegra_car 98>,
+				 <&mc TEGRA30_MC_RESET_3D>,
+				 <&mc TEGRA30_MC_RESET_3D2>;
+			reset-names = "3d", "3d2", "mc", "mc2";
 			power-domains = <&pd_3d0>, <&pd_3d1>;
 			power-domain-names = "3d0", "3d1";
 			operating-points-v2 = <&gr3d_dvfs_opp_table>;
-- 
2.33.1

