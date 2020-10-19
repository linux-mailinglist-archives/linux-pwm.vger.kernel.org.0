Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CBF2928E3
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Oct 2020 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgJSOHV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Oct 2020 10:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgJSOHS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Oct 2020 10:07:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA348C0613D0
        for <linux-pwm@vger.kernel.org>; Mon, 19 Oct 2020 07:07:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e23so10441213wme.2
        for <linux-pwm@vger.kernel.org>; Mon, 19 Oct 2020 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/BDpR1YjUQuY5B8x3jMFdrl3UVJs1R891gJ2IPtuaQ0=;
        b=0lEqMP1OyKzxt7fV7571VcjYQLxRQ2VNoXPJESQG7F42ZYRvzihHztjGqNMIQ+eYI/
         jH7adWvQ9zLvDy+UAT0b9PwZQceZ+VgC/fEDuiKTKKzFj7lhZP7rCJA2eE1yP3ZZEqfk
         sy2APczlrHlQLe+BovWVdn+dkeC5/RiHaySlG0gvCdDLfnnHYSPuIHd2YETKXxoxvbCH
         Q93gK4uPgY00NcAW0ByjB2+W+y9mxNf2WpwDTHZyrifDi/chi9vWsvNvr6hLxW8CZdTX
         f0gVHbsdSn5SoBil1b0Z1/RYlLu0LpwyzMS6KDDfCCTZX8/d4yx24Uj0tDB69iOf+EWu
         ka+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/BDpR1YjUQuY5B8x3jMFdrl3UVJs1R891gJ2IPtuaQ0=;
        b=LDXYUeuC+apUTtAfZ9BU4WUy2QD009EsvGUyURT02Emw2e0aL7juJ0kTcCP5ZvDBQc
         jO9939etSQ8TgoXqskR1sdfAde9HTLD46oii3u0l7IBFkb9nepWhfz856tZdnPigoGIa
         uEl8jsIVX53AAzmt9rYIO4lvb/HWiqIpgGNz4KsINqFzEKz5g9nx91fwDjlwx55OIBbq
         ponw+TUSlyMFRndotWBl1hxi5kuW8fgwED//WO48fcG7LWrkSTAMuG4Yluw6vGijI+wu
         gfxTsY05idN0IZdjrVU2k8uRX5as8Ldp7P8YUhCdiL+kRIt5xhvEZu5yAkaH52gGDhf2
         IDQQ==
X-Gm-Message-State: AOAM531Nrci4krHdpPQMIeVEJyvhpOQThIAUHjI5bfncHifquRFN1Fdy
        zIExDXobPPnPP+Hin0bqZTnuuA==
X-Google-Smtp-Source: ABdhPJyOozw+yL0LyWF9Z/iMPXXfzuXa/dhpJm3XAGEMIK3TXLDZAceOfnhXl9WQi/FFmA+HB0P8Mw==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr10922769wmk.127.1603116436493;
        Mon, 19 Oct 2020 07:07:16 -0700 (PDT)
Received: from localhost.localdomain (26.167.185.81.rev.sfr.net. [81.185.167.26])
        by smtp.gmail.com with ESMTPSA id a3sm114182wmb.46.2020.10.19.07.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 07:07:15 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 4/5] arm64: dts: mediatek: mt8183: add pwm node
Date:   Mon, 19 Oct 2020 16:07:04 +0200
Message-Id: <20201019140705.1518822-5-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019140705.1518822-1-fparent@baylibre.com>
References: <20201019140705.1518822-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

MT8183 SoC has 4 PWMs. Add the pwm node in order to support them.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 9a3cf95676e1..290d15dd9490 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -709,6 +709,20 @@ mmc1: mmc@11240000 {
 			status = "disabled";
 		};
 
+		pwm0: pwm@11006000 {
+			compatible = "mediatek,mt8183-pwm";
+			reg = <0 0x11006000 0 0x1000>;
+			#pwm-cells = <2>;
+			clocks = <&infracfg CLK_INFRA_PWM>,
+				 <&infracfg CLK_INFRA_PWM_HCLK>,
+				 <&infracfg CLK_INFRA_PWM1>,
+				 <&infracfg CLK_INFRA_PWM2>,
+				 <&infracfg CLK_INFRA_PWM3>,
+				 <&infracfg CLK_INFRA_PWM4>;
+			clock-names = "top", "main", "pwm1", "pwm2", "pwm3",
+				      "pwm4";
+		};
+
 		efuse: efuse@11f10000 {
 			compatible = "mediatek,mt8183-efuse",
 				     "mediatek,efuse";
-- 
2.28.0

