Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0E135B48D
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Apr 2021 15:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhDKNKm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Apr 2021 09:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbhDKNKg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 11 Apr 2021 09:10:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FB6C06138B;
        Sun, 11 Apr 2021 06:10:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g17so13025257ejp.8;
        Sun, 11 Apr 2021 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dP6M+sgZMuzTEGYj0l4EYUpeVr19klo1MRRCTxVz25w=;
        b=Rg+cSuaVmSjmTDibRXA8sdjDBMrmUwzphxaFPKrw1KrQju6roHl6S0t7yrl1ggfoim
         pk9SaOEmOJFDha66VLsFbuSLCehvUNxNnL9K1c5zu58KcNDHwLwpkkm7V2b4MUc0punt
         ME5rm32kVABTRbJ9wP/07zWYQhbe/G/ctzn+E8ZdDJhXnly5j1dvxgY2aVaAP6ZM2yq7
         so/h8ZGUhOEPL5Ov8NznDUVaWa7EV7qeR+wYrVPazpvpEBBWEWoCXaZNK84zoJ6QM3Gs
         GlBwoP5grqECVRTUTygT3Dq3OBIwYBaFDCztrJZocFQNygNDCuQMaRsuDOsZkFA8/zTQ
         +cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dP6M+sgZMuzTEGYj0l4EYUpeVr19klo1MRRCTxVz25w=;
        b=Ayw00pZZ/5zj+TLZwowJwQxNcX30Aybkl2SHJYfM9vULU37xMBM2lxbv08slYe0X4G
         Pft7xngTiNYnMgvUZThSYfbow7O0vl1eAvalpyP1Wj9l7nXLdaFCZUPrzUcMzVzbD5nx
         7YuAk8+BZq+jckMch/16yXfctifJYd4WnIEBjaEHvmJ8qfV5oCOi26kqqVYiIwm6HO/z
         URgibcqyNjMQxDw8lU8VHVo+yAwjqBts7NQr9905mONIzT+j3jC/145NjdgegcgvQv9+
         wSXbD3c9rPHq2iHGGZ9ZL91PCyh7cdjeS8EWaidWNDeEyBEOzjqlieqiea9Ddkm+KJjg
         yddA==
X-Gm-Message-State: AOAM532wvIU2Yw+tP8SsqhKw0oSlHaukN66bsuqBY0W4OJp18yr4w29V
        OkerHFWqrGAE99ZX95d7WkI=
X-Google-Smtp-Source: ABdhPJzMrep/dqtmFqleBVmWlFLT358vORL48eeH9EjXxNOm5BPPYolk9ikhMRMe573T7MhPljHSFw==
X-Received: by 2002:a17:906:b7ce:: with SMTP id fy14mr4002248ejb.261.1618146618908;
        Sun, 11 Apr 2021 06:10:18 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w2sm3983520eju.71.2021.04.11.06.10.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 06:10:18 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] arm64: dts: rockchip: remove clock-names from pwm nodes
Date:   Sun, 11 Apr 2021 15:10:07 +0200
Message-Id: <20210411131007.21757-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210411131007.21757-1-jbx6244@gmail.com>
References: <20210411131007.21757-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

A test with the command below gives this error:

/arch/arm64/boot/dts/rockchip/rk3368-evb-act8846.dt.yaml:
pwm@ff680030: clock-names: ['pwm'] is too short

Devices with only one pwm clock use it to both
to derive the functional clock for the device
and as the bus clock. The driver does not need
"clock-names" to get a handle, so remove them all.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 4 ----
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 61b0a2a90..7832e26a3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -561,7 +561,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm0_pin>;
 		clocks = <&cru PCLK_PWM1>;
-		clock-names = "pwm";
 		status = "disabled";
 	};
 
@@ -572,7 +571,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm1_pin>;
 		clocks = <&cru PCLK_PWM1>;
-		clock-names = "pwm";
 		status = "disabled";
 	};
 
@@ -581,7 +579,6 @@
 		reg = <0x0 0xff680020 0x0 0x10>;
 		#pwm-cells = <3>;
 		clocks = <&cru PCLK_PWM1>;
-		clock-names = "pwm";
 		status = "disabled";
 	};
 
@@ -592,7 +589,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm3_pin>;
 		clocks = <&cru PCLK_PWM1>;
-		clock-names = "pwm";
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e93a5f320..6221b027e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1185,7 +1185,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm0_pin>;
 		clocks = <&pmucru PCLK_RKPWM_PMU>;
-		clock-names = "pwm";
 		status = "disabled";
 	};
 
@@ -1196,7 +1195,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm1_pin>;
 		clocks = <&pmucru PCLK_RKPWM_PMU>;
-		clock-names = "pwm";
 		status = "disabled";
 	};
 
@@ -1207,7 +1205,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm2_pin>;
 		clocks = <&pmucru PCLK_RKPWM_PMU>;
-		clock-names = "pwm";
 		status = "disabled";
 	};
 
@@ -1218,7 +1215,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm3a_pin>;
 		clocks = <&pmucru PCLK_RKPWM_PMU>;
-		clock-names = "pwm";
 		status = "disabled";
 	};
 
-- 
2.11.0

