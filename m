Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47EB9F4274
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Nov 2019 09:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfKHIpt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Nov 2019 03:45:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39056 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730692AbfKHIpd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Nov 2019 03:45:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so5299727wmi.4;
        Fri, 08 Nov 2019 00:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0fXA0HzdVYuMz+Yhj3TQjNmtcRgY2Ng0Cfj0PwkXk0=;
        b=D1qm1SPDt8A+Vradbdz+NjuzHC3n4lBb5MQIo2TILRUGKh3ZesXy/5dY+ojmZZlJMA
         HEC7oYdHVO5tzy9/xg3R/T8rNfSdAE0gsnMXQ0RRXbVfyCv2ndh5STSSlPaQnPVpB8RD
         L6RCBuhRtjIC8SY8CrI7BoeSjlUS8EY9z0wDzYBNe0fTVqQpOPNZkmHsNuGIUTrdvPED
         IlHnB++2WeruWNFQHdwtEI90y55KjFmKidqYkPeBMtFdDgbm2WInoaioHeK8KAPPXVYz
         eCHENLiXN1Bj9ASqFoUtAZ7OjxSgbUd9QE756mC6/LRhS2FdfuqqlP7sfUjgF3Gi484j
         H7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0fXA0HzdVYuMz+Yhj3TQjNmtcRgY2Ng0Cfj0PwkXk0=;
        b=r5bWf09c3SdJhoZTd4vatE/j4ACWyL+FV/dVjRfG4KJ6/QY2WMWWFntFpCkmMAGcat
         4qZhbMlbd5JQ28SbE0NNA/nWzO8d0xJG/7Nj1xSAf/hMGC87IBLk78jjLuVbuOxjB2Hz
         jSn/XjW9+OMt8BUpd8oPbNjAzHOKOERUHuH8v4+MzXoMF4m0A4QTos1NxCpOCeI7kAS3
         SIjf9hXkEE1KIfyvM9kbi5JbKK1UvsfVwvg0gQ7eh46uvextC+7X80L5bP73X/w+xLSX
         +cUdY/GzWOwRycAQXYGJDjxNAJv3flUk18tu0yh+XexJM3hW4TdhCl2uU1cezmH7TgPv
         I9OQ==
X-Gm-Message-State: APjAAAUKAg8K7xMUww6NMC40ztX36wUD6unZ8XzbMiWnu5C7BMyymC2o
        B2uN3REg/NfK8xFFb0jhUsU=
X-Google-Smtp-Source: APXvYqw6E/M1y7UeZTduVCL8358877o3jME7J6MDaZJII3rFx5yNJyEOeWFuDlIotS5YQXzjenELiw==
X-Received: by 2002:a1c:ab0a:: with SMTP id u10mr7503819wme.0.1573202731003;
        Fri, 08 Nov 2019 00:45:31 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id q25sm6662665wra.3.2019.11.08.00.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 00:45:30 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 6/7] arm64: dts: allwinner: h6: Add PWM node
Date:   Fri,  8 Nov 2019 09:45:16 +0100
Message-Id: <20191108084517.21617-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108084517.21617-1-peron.clem@gmail.com>
References: <20191108084517.21617-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

Allwinner H6 PWM is similar to that in A20 except that it has additional
bus clock and reset line.

Note that first PWM channel is connected to output pin and second
channel is used internally, as a clock source to AC200 co-packaged chip.
This means that any combination of these two channels can be used and
thus it doesn't make sense to add pinctrl nodes at this point.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 0d5ea19336a1..b0d9ee1ead13 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -222,6 +222,16 @@
 			status = "disabled";
 		};
 
+		pwm: pwm@300a000 {
+			compatible = "allwinner,sun50i-h6-pwm";
+			reg = <0x0300a000 0x400>;
+			clocks = <&osc24M>, <&ccu CLK_BUS_PWM>;
+			clock-names = "mod", "bus";
+			resets = <&ccu RST_BUS_PWM>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-h6-pinctrl";
 			reg = <0x0300b000 0x400>;
-- 
2.20.1

