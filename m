Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0FE35B489
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Apr 2021 15:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhDKNKl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Apr 2021 09:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbhDKNKf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 11 Apr 2021 09:10:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A04CC06138D;
        Sun, 11 Apr 2021 06:10:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ba6so11803734edb.1;
        Sun, 11 Apr 2021 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+xTKglaTtBBnIwb4sWoIFa19QpsHo2j4/zd4VoY1yJc=;
        b=TujKURGt1FeHGz4K0iqBb/VqGehpedpe2hXzNLdrqyv+CTmBYZOGuVQ/MHjTiJtx2L
         WQ+Xr8qJxwXBLj6c/w5RqBSSzlLx5/nkwv4pzbojJ92hpa40mTx/tkvPidXov5qzIK3t
         OoO7XRM33sQG4v6KfCdWk9fB3jge7TFjMYhIt17lW2mOYpH4Z+EqSlCca+4pUU+2OF6u
         A24QMmTzndsdUyHnDrv9XV/1czyIf/V786efC3Ta1/wQmce8qof+54nPbkuV8a0z9Tre
         jdREJcvJFZ5hMJ+adrSbdL4rP67v5Up9y5U476RrRaw5yXMVmULtufZCHrNKX2JH6T36
         nhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+xTKglaTtBBnIwb4sWoIFa19QpsHo2j4/zd4VoY1yJc=;
        b=B2twOtAJvVYiPwxGECkZLjQ1S3Nx7hNg/zHjk8cYMboFPWRZzI0jF8wVWsWoSd67I9
         ds96Q86tic1TpKICaZeX+ffadULeL1th7VyQV2PWDuAP6eiqM5nODkuN/qSO4+uvFgiK
         dTcF0EuNy7qndipldb6GzGxcF5n7UZgqnmaBeV8h7Bj70aEk9Ke0AE59acfpK/CW1f29
         ZTNFj9vkDURneiRAZsq8QQObF6jDYbFvpIio3VvVikl2wQ2ReAXXEZwJmqhQUISpVXDw
         rA/BdzZck7jkCvuTzp09zRIcKbdaTRz6LA8ThIKzGaQF+Q7EkhwKO36R8Y5sshnlUyLQ
         ZKlg==
X-Gm-Message-State: AOAM532fm1ypPz+4fArmzpJ037Ll1X7AOcG9C78FhtoMpnCaD5nCG9tN
        Jw5sde9g95hH5n8JuLCHHqI=
X-Google-Smtp-Source: ABdhPJxpWbRylv8hRSWy+Dl3+JQE8MDXnNeIdWg+QZ0c0yqg5G6HGyew3HpL9IuIVzF4jA1UVB+ddA==
X-Received: by 2002:aa7:da46:: with SMTP id w6mr26215661eds.30.1618146617114;
        Sun, 11 Apr 2021 06:10:17 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w2sm3983520eju.71.2021.04.11.06.10.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 06:10:16 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] ARM: dts: rockchip: remove clock-names from pwm nodes
Date:   Sun, 11 Apr 2021 15:10:05 +0200
Message-Id: <20210411131007.21757-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210411131007.21757-1-jbx6244@gmail.com>
References: <20210411131007.21757-1-jbx6244@gmail.com>
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

