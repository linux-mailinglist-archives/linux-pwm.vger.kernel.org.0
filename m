Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114CB35D1A8
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 22:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245435AbhDLUCd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 16:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245414AbhDLUC3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 16:02:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EC9C06174A;
        Mon, 12 Apr 2021 13:02:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ba6so16562072edb.1;
        Mon, 12 Apr 2021 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dP6M+sgZMuzTEGYj0l4EYUpeVr19klo1MRRCTxVz25w=;
        b=u7xk+nl1KEUVeTCXnBK+EUuKq7ZIT7kT4ApakFx+FprS8wqpnLfcWoaN9HPCDzobFT
         abKFSp76ypMAUKWnyMJ+UmLVmJuYuWx+kkh8jnfPTbnYFlo6HctZFZ2VoVdg1pbkgGx9
         uUyeW30+mCX0TeopvTOxDmsdkdNhS+hvhvOIbdUHu7chgveob+Jq5vI8FL625NxIvb98
         e8EI4U00Wqda97oLqNOvFBr0mh240t0PiUkGDa1+u/Uu2izJV9DgwXa3zsRH2h6lhNxt
         HoMFI4udgv9Gb6CWeQ7v+XfEZ1wyF/oQ2g7Z8dl6xtw4KtUNntKu37rbtVloISVbaMvs
         43Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dP6M+sgZMuzTEGYj0l4EYUpeVr19klo1MRRCTxVz25w=;
        b=aVuwObySAUyBN21D1cAUVzPjRXE8ZvUrd4oH8vEqJsoWPhF+0WpXqZOuu0dUwGKC6T
         aEnIUZEv6p2k+H+d4GB8BAxA5qj9/WIK+sPb00ePn7N7Rgq+RGzyASGByXyxo9K4aGVZ
         Ve0dS1SzIXmoJA8cV8lTJLSWfjRLOErpERofQb1anS0MQ821q/paL6dZnMfeAPgSdByI
         h/M7EbNovJ5hdtSaYTdsqiARLE0Wdcs3Y+4r6SYns88kZwMPc0RDXtBdjSv7iag2/wMH
         22Un/DLwU6vJq0J3ro0fVIwmrGlvFP1b8d4HSiRbzIa6jJBQNWMhREKIcfHPdfyD9+5k
         yNVg==
X-Gm-Message-State: AOAM531NiMCgsruihowxPsXFDjMy8KIodGL8LMM9U/g1ZeJHw1MHXtk3
        LVvmpiEofbbJUroIy+s2s+o=
X-Google-Smtp-Source: ABdhPJyNEd2rxoRrdqLZV5Jb3PKGn7UhfzB/HIGumD19hzyxr6q+egEj8aLvyyvxpZMxaG3cp3toKg==
X-Received: by 2002:a05:6402:440d:: with SMTP id y13mr31175013eda.316.1618257728178;
        Mon, 12 Apr 2021 13:02:08 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x9sm7514531edv.22.2021.04.12.13.02.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 13:02:07 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: dts: rockchip: remove clock-names from pwm nodes
Date:   Mon, 12 Apr 2021 22:01:55 +0200
Message-Id: <20210412200155.5316-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210412200155.5316-1-jbx6244@gmail.com>
References: <20210412200155.5316-1-jbx6244@gmail.com>
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

