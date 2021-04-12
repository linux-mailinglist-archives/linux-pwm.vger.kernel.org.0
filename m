Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02BD35D1A5
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 22:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245426AbhDLUCc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 16:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245408AbhDLUC3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 16:02:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB173C061574;
        Mon, 12 Apr 2021 13:02:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g5so15611309ejx.0;
        Mon, 12 Apr 2021 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+xTKglaTtBBnIwb4sWoIFa19QpsHo2j4/zd4VoY1yJc=;
        b=qh59HB/hE/Y3AvIY5m10Mpyrf2atm3n/6KSctcZQ/2Z2aI8Pore38oGdJ+1w/B7tJQ
         wXUA5PsaIMlzN2cadddZ4YUAODXpafYVv9irLuvqV4xg1AeS3pTt/uZo9ryhtnvEtqxk
         xwTGiqSDmtbrvyymQqkSVs/0eQu5Y+qVs7kCs9KEtx4ll1FrpzNrqXK1xYjB2nXKkfQ5
         8pbkB3IREzs//DAE67l9ZtMB+bJ2jKc/YJiw+mE+vvf3NdtzhO49GqgsGXCfhQGEOyYi
         LoHq+HkOr8NOgBE/ImVdCU5iDomt5S9u7nDf2u2XtvqZLfyONTQiBGdR9wJtYbdWIHkt
         ZvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+xTKglaTtBBnIwb4sWoIFa19QpsHo2j4/zd4VoY1yJc=;
        b=MHnlukhWT28Shwt2zSbgxiGHSlGnttNnQUO2EfS7UKE7S2hMyvSL5SVf4N+dlLbB1u
         jzRd8/8ITZyMKw7h0K+/PbRVUvP7n25J+3pwWeyPeCzFe+Pg1dFSAFc0XbL+MzDLUygd
         JHbUm9GfANtCkd7fj34RvwMzkpsroX5VKmEQvTwvQeCOdwg0ZBJdqsV/RAHYnNKLwfyw
         io3sDbIhoK63HDSd0LVKlOemWunEnDbjqxd8wGZW6QPdEEnSpSdjZUvaTqUKf9FW9NZp
         1oUg/2IwN/sYw8jZP9azd/zCvobFj3ApZNs5SUm5uQTqTVxy46f4CCj6v073S+r1OmLy
         +bgQ==
X-Gm-Message-State: AOAM531vtZa+yRNhGdDJSWLPG/OFsHZwDV3WoOTzQVRY876AhGzodz0n
        JtiPCTdceN5izhpgf5ClRydGA0LQ8Pb0dg==
X-Google-Smtp-Source: ABdhPJxK1rEEbA5wGozTlAIcW69RHJgVqRiptIwmUce5/T0BP+VeY7DEnUHv/uZx5NPnilZcBolNyA==
X-Received: by 2002:a17:906:430f:: with SMTP id j15mr28964429ejm.543.1618257727215;
        Mon, 12 Apr 2021 13:02:07 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x9sm7514531edv.22.2021.04.12.13.02.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 13:02:06 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] ARM: dts: rockchip: remove clock-names from pwm nodes
Date:   Mon, 12 Apr 2021 22:01:54 +0200
Message-Id: <20210412200155.5316-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210412200155.5316-1-jbx6244@gmail.com>
References: <20210412200155.5316-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

A test with the command below gives this error:

/arch/arm/boot/dts/rk3036-evb.dt.yaml:
pwm@20050030: clock-names: ['pwm'] is too short

Devices with only one pwm clock use it to both
to derive the functional clock for the device
and as the bus clock. The driver does not need
"clock-names" to get a handle, so remove them all.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi | 4 ----
 arch/arm/boot/dts/rk3288.dtsi | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 47a787a12..e24230d50 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -355,7 +355,6 @@
 		reg = <0x20050000 0x10>;
 		#pwm-cells = <3>;
 		clocks = <&cru PCLK_PWM>;
-		clock-names = "pwm";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm0_pin>;
 		status = "disabled";
@@ -366,7 +365,6 @@
 		reg = <0x20050010 0x10>;
 		#pwm-cells = <3>;
 		clocks = <&cru PCLK_PWM>;
-		clock-names = "pwm";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm1_pin>;
 		status = "disabled";
@@ -377,7 +375,6 @@
 		reg = <0x20050020 0x10>;
 		#pwm-cells = <3>;
 		clocks = <&cru PCLK_PWM>;
-		clock-names = "pwm";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm2_pin>;
 		status = "disabled";
@@ -388,7 +385,6 @@
 		reg = <0x20050030 0x10>;
 		#pwm-cells = <2>;
 		clocks = <&cru PCLK_PWM>;
-		clock-names = "pwm";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm3_pin>;
 		status = "disabled";
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index ea7416c31..05557ad02 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -679,7 +679,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm0_pin>;
 		clocks = <&cru PCLK_RKPWM>;
-		clock-names = "pwm";
 		status = "disabled";
 	};
 
@@ -690,7 +689,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm1_pin>;
 		clocks = <&cru PCLK_RKPWM>;
-		clock-names = "pwm";
 		status = "disabled";
 	};
 
@@ -701,7 +699,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm2_pin>;
 		clocks = <&cru PCLK_RKPWM>;
-		clock-names = "pwm";
 		status = "disabled";
 	};
 
@@ -712,7 +709,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm3_pin>;
 		clocks = <&cru PCLK_RKPWM>;
-		clock-names = "pwm";
 		status = "disabled";
 	};
 
-- 
2.11.0

