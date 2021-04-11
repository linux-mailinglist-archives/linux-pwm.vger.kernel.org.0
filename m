Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA24135B487
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Apr 2021 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhDKNKk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Apr 2021 09:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbhDKNKf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 11 Apr 2021 09:10:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF56FC06138C;
        Sun, 11 Apr 2021 06:10:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r12so15817789ejr.5;
        Sun, 11 Apr 2021 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=260yFFsBhy1Ilpe0300ltWfnIm5n5zeKQOx10STsmU8=;
        b=MoFzvhZVUkEPuCEA0RmK+MGnNHtcZeWyBRzaY8mE1paReKX2UZJJJuZn7AzsEo/yIs
         CG1qxuvJn0SHIfE8HbftaKCXX3ArfgKF2d5uKv04Aq1ngczayEz2iP6Yjqgczcm4hv9r
         zn1/x4pHg3w66ZJuXmPoE70QSGkYShDYr5rctFomtj8YhD4mLGijJCTaVcZ4b4p66tnq
         hQ5zyX2lCne65evuOOd6YWX2v/EXhm1HWsxA9hrImr5amG2fdivDsoDX0x3DieaUVhHR
         yXEyzBYKpI2PVpSCE2FZoYdqKaWGB4GqoaNuQk9TMaKRNopTZZtPl8c20iip1gGAiaIg
         /YTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=260yFFsBhy1Ilpe0300ltWfnIm5n5zeKQOx10STsmU8=;
        b=R87YzIOHNUdf/MTBIb3ZNrJX9S7Gcn780lYMzF4WAbcOwtrvNSocicaMlm5hS77l+9
         5oVyZuvh9wH/SvUreKWh4zCGeLApeATXUtpy1lmHgpSrMm5X94w3RSlyoDBj07jK+TVj
         jP9OpTGHDUtMf4aRo2KK3U9JQgd+yBGL9w6ooz4LaUfr7HderEq49fUGETGEfi+tdnYn
         uZ6l466fmCE+fObJCaiPQfYVdh5RLZRn+gwbHD1trRZeqYucqmzHGVOW1Mi/1dCTkjMq
         f4jms2MMYWK+E57+AV1fvWQw/Vcgj8OjMn0RU7/BFfUF+/QGyGDWLAASd5j/nUvk6Vze
         nLgw==
X-Gm-Message-State: AOAM530uyNVb7cDJ2eDP5QBMhPgvYL6ATuf8/s5G0+XoCdJYo2iaoJLm
        EVLiMUX9ztNXPyIEnxTNG2X/Sa46HTAJfA==
X-Google-Smtp-Source: ABdhPJxnzLORRtr14fNC0okpdSRW1K8t7cG9PtsMq8H+5ronSRoXAchufD5QnPG23kZvaaeuN5ldUQ==
X-Received: by 2002:a17:906:d9ca:: with SMTP id qk10mr22621742ejb.436.1618146616156;
        Sun, 11 Apr 2021 06:10:16 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w2sm3983520eju.71.2021.04.11.06.10.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 06:10:15 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] ARM: dts: rockchip: remove interrupts properties from pwm nodes rv1108.dtsi
Date:   Sun, 11 Apr 2021 15:10:04 +0200
Message-Id: <20210411131007.21757-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210411131007.21757-1-jbx6244@gmail.com>
References: <20210411131007.21757-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

A test with the command below gives this error:

/arch/arm/boot/dts/rv1108-evb.dt.yaml:
pwm@10280000: 'interrupts' does not match any of the regexes:
'pinctrl-[0-9]+'

"interrupts" is an undocumented property, so remove them
from pwm nodes in rv1108.dtsi.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rv1108.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 68e2282f7..af033d4c9 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -217,7 +217,6 @@
 	pwm4: pwm@10280000 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x10280000 0x10>;
-		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
@@ -229,7 +228,6 @@
 	pwm5: pwm@10280010 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x10280010 0x10>;
-		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
@@ -241,7 +239,6 @@
 	pwm6: pwm@10280020 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x10280020 0x10>;
-		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
@@ -253,7 +250,6 @@
 	pwm7: pwm@10280030 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x10280030 0x10>;
-		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
@@ -391,7 +387,6 @@
 	pwm0: pwm@20040000 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x20040000 0x10>;
-		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM0_PMU>, <&cru PCLK_PWM0_PMU>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
@@ -403,7 +398,6 @@
 	pwm1: pwm@20040010 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x20040010 0x10>;
-		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM0_PMU>, <&cru PCLK_PWM0_PMU>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
@@ -415,7 +409,6 @@
 	pwm2: pwm@20040020 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x20040020 0x10>;
-		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM0_PMU>, <&cru PCLK_PWM0_PMU>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
@@ -427,7 +420,6 @@
 	pwm3: pwm@20040030 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x20040030 0x10>;
-		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM0_PMU>, <&cru PCLK_PWM0_PMU>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
-- 
2.11.0

