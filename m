Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E36E4080E2
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Sep 2021 22:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbhILUNQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Sep 2021 16:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbhILUM7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Sep 2021 16:12:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527C1C0613BB;
        Sun, 12 Sep 2021 13:10:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso5119392wmi.5;
        Sun, 12 Sep 2021 13:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8kfkBlrzTLObPg24P503LDH7eVygGX8rkq8ngUO3/ss=;
        b=Ai962J8IqMCoO5KtuO7F8+qggmQUcMEMkYr1Pk+fs8Hj0P5fb/0AdGTLq/HM00yqpD
         iZfmxFPJ4fY1fGELPy7hJ4XkpQtEQEgNKAkJPNvBNHD58LTDbPamaXcaIA93NmFf1hTH
         C65NmBltdgWIuEemmKhfCDIfJzgJVzhv+my1fnZZTpQyXr9x2AoUdLEkyWqiNkJ1NtGK
         hZ9HPZVBygETN4AXgfx4r/4V4P5zDj7Fx/TxiAbymPw/qxvliqsjWDFqLWiu7VRAwLrC
         64QRZOa9J4UJbsCAw54c+MSEuBlcX4V/Z5xuolaEQjnzTiYcjaQ8PwKfB/M7je/Cmzwi
         nWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kfkBlrzTLObPg24P503LDH7eVygGX8rkq8ngUO3/ss=;
        b=DSUwZW+BZvIh0j9jt5HJpJenuIELAltBVNROrHWNgCES694MqV8xqI1tDCzgCcZ5u7
         FThYqNDl91ojD8wftc3CGYHDjQkn5uLNZ/zAIwboZNaZhipY6HY4/Ak7iphqgWDLD/Eo
         tPYtpkXzWvcKh6XDMhMBxfr3LEQUuPhBp/5ulv27Qe4zJ+MQEwmFeSt/3Xuo9BHYvPad
         V2rLZVLqzG/glqMB1UfraL8nNn86lTX1gULRF88f2If1RWb55WZDasG993PeY+oVDv/G
         mzoqVOkid6qvLeNoM8an9eMssYYpHREi55sIAnjsi4W6Q5Dey4EuXr4cRGIROWMGGjIu
         8BLQ==
X-Gm-Message-State: AOAM530I4Rb/PeSITjL6rSFJ9eOGj0gIYGeX4Ffl+GEEBwkQGuatWyAa
        UB0S5rxeWkBSvuXvR1aYiEM=
X-Google-Smtp-Source: ABdhPJz/0tOxxW/F1D4amSiUwyH2aqIo/MK0rJeFHz4qbaeNIsHJFTsOQ1ntSMVfoS0LMA0XxEkLBw==
X-Received: by 2002:a7b:ce02:: with SMTP id m2mr7921397wmc.132.1631477451954;
        Sun, 12 Sep 2021 13:10:51 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id v10sm5463476wrg.15.2021.09.12.13.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:10:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v11 32/34] ARM: tegra: Add Memory Client resets to Tegra20 GR2D, GR3D and Host1x
Date:   Sun, 12 Sep 2021 23:08:30 +0300
Message-Id: <20210912200832.12312-33-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912200832.12312-1-digetx@gmail.com>
References: <20210912200832.12312-1-digetx@gmail.com>
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
index 4abb6634e8ae..8ab77583846b 100644
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
 		operating-points-v2 = <&host1x_dvfs_opp_table>;
 		power-domains = <&pd_core>;
 
@@ -98,8 +98,8 @@ gr2d@54140000 {
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA20_CLK_GR2D>;
-			resets = <&tegra_car 21>;
-			reset-names = "2d";
+			resets = <&tegra_car 21>, <&mc TEGRA20_MC_RESET_2D>;
+			reset-names = "2d", "mc";
 			operating-points-v2 = <&gr2d_dvfs_opp_table>;
 			power-domains = <&pd_core>;
 		};
@@ -108,8 +108,8 @@ gr3d@54180000 {
 			compatible = "nvidia,tegra20-gr3d";
 			reg = <0x54180000 0x00040000>;
 			clocks = <&tegra_car TEGRA20_CLK_GR3D>;
-			resets = <&tegra_car 24>;
-			reset-names = "3d";
+			resets = <&tegra_car 24>, <&mc TEGRA20_MC_RESET_3D>;
+			reset-names = "3d", "mc";
 			operating-points-v2 = <&gr3d_dvfs_opp_table>;
 			power-domains = <&pd_3d>;
 		};
-- 
2.32.0

