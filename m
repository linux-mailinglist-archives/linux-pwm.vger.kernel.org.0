Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3319E2A7240
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbgKDXq3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733168AbgKDXpi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:38 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E74C0613D2;
        Wed,  4 Nov 2020 15:45:37 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id i6so197369lfd.1;
        Wed, 04 Nov 2020 15:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JWa430PVIqmJIbeD7KBt0TZCN2r4IZvUOeKukZUULSM=;
        b=eN4h8wmKVmc98I8VpVQD05mgPsSKIV8roZRuvQUi3EOcizAEVMxhK4XcKenNODUP57
         Rxze2zWAWjLCIfL2dNIRIGywZvC28Gu+MslIDgcQBiINpAIgA8ayEvdgAWeaNJS/UoUw
         AF/ln6R+1zf+7IT8b1pPX6qDWo8FajvGF+vv4uuipo2sXIA3JUzx7p8u+ktEcwm1o1pg
         8EzDhwuYDylAakt40bWirCp8sipi2Klh9G/IBYON5H8zDXGqS29eR/JqRCTc9dW4pVKR
         y1mExIRa9//FQnuJ5e8gfTLqClqNg3UUpnvkCzqL0KLmGCs6gxB1ftFcHku0KNIwUxDo
         VvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JWa430PVIqmJIbeD7KBt0TZCN2r4IZvUOeKukZUULSM=;
        b=NJUutTGgR8RwypVHJLcSm5Y2Y48RPau6LXgiYq/Ov51mJ4IJYtz9/YMLf2bMebokUA
         2+mE2hV6OOicjPedvV2xs/eMwzwkZGOhx9bRkhKVIX3skdvIQ6FB1wotTag11JeMI4Dh
         n6b1YHYZaCkxe711w16iIcNt3K2nfkIHPPxRq2MNbnjlyPVZJ8lu4kFRZipHVjJgwLaS
         I/3le7b7/2P5BtsA7FrUurg0OPkh35yi0iPBw5MI0JJDm+iJ+XyTRQpbzHHHa4f+Oxv+
         5BKal+Due1LhQu2pxuZxGjyLaZV6V8JqVRCBlp8BcBvuHobq0WBa/z6iqqnVXnw5zy7N
         pU6g==
X-Gm-Message-State: AOAM5330L8GlKNXjfEpg8LfUsK6IuKAFJhdmbhP560/qqiA+n1koXEcR
        7enXq0BOSzQ4nwcIcK8Pz2U=
X-Google-Smtp-Source: ABdhPJz6df+Ge/OfH/yyY6XjwgEffIPjNRxtB5oKKiqUFuVW6jG9sorT54nuDmLv0xSqhkTx9fOGHg==
X-Received: by 2002:a05:6512:3388:: with SMTP id h8mr60396lfg.318.1604533536417;
        Wed, 04 Nov 2020 15:45:36 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:35 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 29/30] ARM: tegra: cardhu-a04: Add voltage supplies to DVFS-capable devices
Date:   Thu,  5 Nov 2020 02:44:26 +0300
Message-Id: <20201104234427.26477-30-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add voltage supplies to DVFS-capable devices in order to enable
system-wide voltage scaling.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-cardhu-a04.dts | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
index c1c0ca628af1..7149e5594537 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a04.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
@@ -93,6 +93,34 @@ vdd_bl2_reg: regulator@106 {
 		gpio = <&gpio TEGRA_GPIO(DD, 0) GPIO_ACTIVE_HIGH>;
 	};
 
+	host1x@50000000 {
+		core-supply = <&vddcore_reg>;
+
+		gr2d@54140000 {
+			core-supply = <&vddcore_reg>;
+		};
+
+		gr3d@54180000 {
+			core-supply = <&vddcore_reg>;
+		};
+
+		dc@54200000 {
+			core-supply = <&vddcore_reg>;
+		};
+
+		dc@54240000 {
+			core-supply = <&vddcore_reg>;
+		};
+	};
+
+	vde@6001a000 {
+		core-supply = <&vddcore_reg>;
+	};
+
+	pwm: pwm@7000a000 {
+		core-supply = <&vddcore_reg>;
+	};
+
 	i2c@7000d000 {
 		pmic: tps65911@2d {
 			regulators {
@@ -117,6 +145,22 @@ vddcore_reg: tps62361@60 {
 		};
 	};
 
+	memory-controller@7000f400 {
+		core-supply = <&vddcore_reg>;
+	};
+
+	mmc@78000000 {
+		core-supply = <&vddcore_reg>;
+	};
+
+	mmc@78000600 {
+		core-supply = <&vddcore_reg>;
+	};
+
+	usb@7d008000 {
+		core-supply = <&vddcore_reg>;
+	};
+
 	cpus {
 		cpu0: cpu@0 {
 			cpu-supply = <&vddctrl_reg>;
-- 
2.27.0

