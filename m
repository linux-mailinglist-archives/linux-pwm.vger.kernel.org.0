Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D5F35B48B
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Apr 2021 15:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbhDKNKl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Apr 2021 09:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbhDKNKf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 11 Apr 2021 09:10:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D84C06138E;
        Sun, 11 Apr 2021 06:10:19 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e7so11775605edu.10;
        Sun, 11 Apr 2021 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2ujtYj1V+AzSvPoFMu6+U6S2xLSiGrGvBvjS2h7YGhQ=;
        b=nImbimFUrsZmgsKFZjLsGwM6DbETh5PDM8dpv9N1/pjZ5jribSOb5m3H+tIrqkcZzG
         XLj2bDC3+FO4WjEzer1MS7z8jj+Z06o7Us00Cel+KKrMmcwZiHPtC/I/cnivEWz/ihJ+
         Y4n0W5HzatImaABA7JyqlP0I4tnKTldLiTzYBbiyah6N4wOg74N6LE7q56Gt+gEnZ9ZF
         2PTgbWWas+8CkuAwkCEbHCF1CuxpM4C09zqvMqmgpbGzMAaCG/zbG7mzK+nxxBptpGhV
         hq9M8in+ERChD9JuqPdproppFenwxK8sk9LTGQNTpCVOPNQZQCjvoj9Z2xJyji1/5x/C
         E9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2ujtYj1V+AzSvPoFMu6+U6S2xLSiGrGvBvjS2h7YGhQ=;
        b=NRc5YFAqKg9Z90ya0pqD3TYERB1NfXSvFumZRUn25zU9CU9bnHHOGiIe1mf/gGmGM/
         OvgZLIgrV1fqbZrPVch66h6tlA6W+ULB8IDSWemDuOoei4KHYwHJkDEJXvaeMmXT9Mvi
         9+eCR4RbjzXcFfudzOirGoOLOVPkzKyptGVrP0cHmbn0aRJdcT8XyC+RBd8in6GkgDnJ
         3BKR/6/iklIwOjkBt5LvgnBAiSvt2voL+faMfNPbpCNI1xptuQItZOO3KoVnQXHhs8Ej
         Wb5Ig6fU+BrvnxFr1x99pnElF+zShltothGos3jTsSTuW84vYIdBBSDk6/DuCH+6KoVt
         +oBA==
X-Gm-Message-State: AOAM532rIipLl47Emu3weuXXne+GTg4u4KGg3B9Qg+xkZH3S4HrkMTtI
        SOi9wrqKvm3rH2Uf4qSa0Zk=
X-Google-Smtp-Source: ABdhPJybujYIcdFXWYyDboQF1+JnkfO3gG/0WV5MpwmcEsYfCSs1sYZQbZ9gaxClONr4PJm+vFQUcg==
X-Received: by 2002:aa7:cc98:: with SMTP id p24mr25331641edt.187.1618146617918;
        Sun, 11 Apr 2021 06:10:17 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w2sm3983520eju.71.2021.04.11.06.10.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 06:10:17 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: dts: rockchip: remove interrupts properties from pwm nodes rk3328.dtsi
Date:   Sun, 11 Apr 2021 15:10:06 +0200
Message-Id: <20210411131007.21757-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210411131007.21757-1-jbx6244@gmail.com>
References: <20210411131007.21757-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

A test with the command below gives this error:

/arch/arm64/boot/dts/rockchip/rk3328-a1.dt.yaml: pwm@ff1b0030:
'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'

"interrupts" is an undocumented property, so remove them
from pwm nodes in rk3328.dtsi.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index c2ca358c7..5c968b3cd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -480,7 +480,6 @@
 	pwm3: pwm@ff1b0030 {
 		compatible = "rockchip,rk3328-pwm";
 		reg = <0x0 0xff1b0030 0x0 0x10>;
-		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
-- 
2.11.0

