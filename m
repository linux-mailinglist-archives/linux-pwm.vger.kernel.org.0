Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6A843A7DA
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhJYWv6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbhJYWua (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:50:30 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A2AC0432C9;
        Mon, 25 Oct 2021 15:46:21 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u5so15045395ljo.8;
        Mon, 25 Oct 2021 15:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EhlDIlIDsNVFTr5Q8VNTSCXABzQ4ZRHMvuz4cuElJaI=;
        b=oOPqrEGKYNutcaubvmsEXhxGuimvJ9t25Pk+x7xhcvm3mvXYjFn3x0ZkdMNtUEQC6l
         ThwF/GMApKyPH4nwift2xGS07LJXgzXwWC0dT4aCzVWtAsmLdL3609ARrVoV71u43/BA
         tfDQLn6ERBB5AREkaHo+APun226jr12U4iWk9WC4ch6SbXssIL22M+xuf1gfVR2iveZ2
         yCr2eb/ajlLwQw3/WBNgLC8VC3hEykG92rGqrrshSi+G0wpvIdmuqgV9YU+T+2kg5M14
         utpXA9fN7xvIX1BbYQ5VB1BH+CC2o6ITPZoYwo/rT/onRhzPEdhy0IaaKMjsVZypgqFr
         1p6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhlDIlIDsNVFTr5Q8VNTSCXABzQ4ZRHMvuz4cuElJaI=;
        b=MLPEjrcQm5z9AbC5ZGgz7jlanNxr5RO1cv5xNZlzJ4zecE8ccJM1kkWgxUbdgV9dsh
         aMfLiJ+VjUgXucoi5LVPtOzKePTctT0UvmPizjw+TXzHAS19jn5LEaa78aXcgK6nGfqs
         6w0gn5S+72egd7RsIvfRcICZYIxw66LeNj4loGmAANWcBeUVil4hbtGdRR/tcnHUwle4
         QvM0kL8UTiY+rbvwDILHKOiRtFDJM2hL1g+2YkjrMKhp7QaLUkw3MbZhCanhAXtOq1Hd
         IJK7Wp0VNDH65wPt43Ryl77uKcuHdgCPSkxXwKqlYEJfMV/onA4aNpc9GSDm/TtWQjvp
         g5+A==
X-Gm-Message-State: AOAM532XEstAMYPUwUaXi+LWBS5CnRcL6U5/IsQi8eQ1Mq8PFzt/lxGB
        KyIBrEdhzkI6c0/iQ9Z40tE=
X-Google-Smtp-Source: ABdhPJx/an+gf8sCFlGLe4M6ofK+44Uyd8wVN0HNBaH17jsKMbTymCMAhcXruEhxRSbTqtunBM/fDA==
X-Received: by 2002:a2e:8843:: with SMTP id z3mr22069820ljj.257.1635201980316;
        Mon, 25 Oct 2021 15:46:20 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:46:20 -0700 (PDT)
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
Subject: [PATCH v14 37/39] ARM: tegra: Add Memory Client resets to Tegra20 GR2D, GR3D and Host1x
Date:   Tue, 26 Oct 2021 01:40:30 +0300
Message-Id: <20211025224032.21012-38-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Memory access must be blocked before hardware reset is asserted and before
power is gated, otherwise a serious hardware fault is inevitable. Add
reset for memory clients to the GR2D, GR3D and Host1x nodes.

Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 1898351a099f..7b69ffc57abe 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -40,8 +40,8 @@ host1x@50000000 {
 		interrupt-names = "syncpt", "host1x";
 		clocks = <&tegra_car TEGRA20_CLK_HOST1X>;
 		clock-names = "host1x";
-		resets = <&tegra_car 28>;
-		reset-names = "host1x";
+		resets = <&tegra_car 28>, <&mc TEGRA20_MC_RESET_HC>;
+		reset-names = "host1x", "mc";
 		power-domains = <&pd_core>;
 		operating-points-v2 = <&host1x_dvfs_opp_table>;
 
@@ -98,8 +98,8 @@ gr2d@54140000 {
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA20_CLK_GR2D>;
-			resets = <&tegra_car 21>;
-			reset-names = "2d";
+			resets = <&tegra_car 21>, <&mc TEGRA20_MC_RESET_2D>;
+			reset-names = "2d", "mc";
 			power-domains = <&pd_core>;
 			operating-points-v2 = <&gr2d_dvfs_opp_table>;
 		};
@@ -108,8 +108,8 @@ gr3d@54180000 {
 			compatible = "nvidia,tegra20-gr3d";
 			reg = <0x54180000 0x00040000>;
 			clocks = <&tegra_car TEGRA20_CLK_GR3D>;
-			resets = <&tegra_car 24>;
-			reset-names = "3d";
+			resets = <&tegra_car 24>, <&mc TEGRA20_MC_RESET_3D>;
+			reset-names = "3d", "mc";
 			power-domains = <&pd_3d>;
 			operating-points-v2 = <&gr3d_dvfs_opp_table>;
 		};
-- 
2.33.1

