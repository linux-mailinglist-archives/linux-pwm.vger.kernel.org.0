Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF50943A7DC
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhJYWv7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbhJYWui (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:50:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2E4C0432CC;
        Mon, 25 Oct 2021 15:46:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bp15so15178556lfb.4;
        Mon, 25 Oct 2021 15:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+jxEVcQtZ3tt3q/wwMe8WgzAKwAHr0b1+CvBDSsdZHw=;
        b=nKilEZyg92NbWrWgqmsDfFJ32XScS5VMh+ZEIYORsMz2y67e27hricxwxxSqLCzB+B
         r9cB2aqSw67ZAZ/N2E9oWPvLjsCYJSlHzzC6X5qt4sxs6KAPyF3O3X5RjAHYuDG/2WYX
         jjokeDi1qh8BhtZkLTdnT2ceJoenhzogfYQnYGLnQPA3w+LnjmNwkbIV+FG2fRA3dSjI
         QYUXC98osVUf5R/5ZYDxJUT4Duocy7tEoCLI7Dm+vgCAPU9MLK0AeGtxa3H2KJQfuWej
         11v6qT6X3LCYhUwH/hJmTvhO64nnuSfATa3vnIu8GTaywxpPHlwTlviTYx6rR/1oTZdJ
         tkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+jxEVcQtZ3tt3q/wwMe8WgzAKwAHr0b1+CvBDSsdZHw=;
        b=LrOxuOInczg5mDJfZFBFhpyCb09n2m0Q5h0yG9MuvZXExaNGofF5vY30/SddtZXz5z
         FilmeGlnpRhFCqadRO1yi1Kl5ccJrY5YJemNSRRy60BUV+NiAEvaZT3oVyxrDY4njhY5
         LWOerIWOCrInE+Hlul7qYX+HoLW0zCFd+Kf4BsSoyfU7tdk/pkVy9/RWzr+5TVy+hmDh
         RufgK44BRm34COo3fABnNc/7Ql/wp7MbD2aOEvzowJvhIa/KduE5GOW68gN7bWJ/Izw7
         4sbwFzZRZpFrXanz7xjHOIhpMfn1gqFbK3JPK/WO1unCS4iDTB4TIFIua/o37khP3Mm0
         Sahg==
X-Gm-Message-State: AOAM533SubCm5iqqZaKvmQ83cZa8bVbavnVEXb7lYlExFxyzvLxUwxx9
        aWwI0J7CUnoZzeOT5R9P7Qk=
X-Google-Smtp-Source: ABdhPJwIqWTCtIZUvwhjyjmr1zhRYr9aIO/xrwQvYeOizbd1AGCTNEfr2W2E9bY8RgQyE113Q4PpwQ==
X-Received: by 2002:a05:6512:32c9:: with SMTP id f9mr19217607lfg.113.1635201981193;
        Mon, 25 Oct 2021 15:46:21 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.46.20
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
Subject: [PATCH v14 38/39] ARM: tegra: Add Memory Client resets to Tegra30 GR2D, GR3D and Host1x
Date:   Tue, 26 Oct 2021 01:40:31 +0300
Message-Id: <20211025224032.21012-39-digetx@gmail.com>
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

