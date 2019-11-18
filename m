Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAC6110033E
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 12:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKRLBF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 06:01:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40091 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfKRLAr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 06:00:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id f3so18227816wmc.5;
        Mon, 18 Nov 2019 03:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q0mPzKXAC37oXp0wVkV8/ys9/u7aTcSnLuWMUuY5ccw=;
        b=Wr086HtETOZcOmc4iZyEckCSVl84N673n+TidoSKWx/tsWUykTFSEw0lVTE7A7/cHq
         kA7CelwmTaEk9vXiH9I1UTDGMbeEpKPDtbkQoE6O6NZRUvxhWYWhqBOclnS3PO9m07eB
         zx8MqwgyY4bVZQu56j63cjjRkWfFs5kT8tb7UDkSRRZvSVmKcF5l8cCzOEs6uSXoVg11
         iqD6LL1eN8v2B8nwluCKWahNwl4Ub1aQ243SZJsjjw7ABqgyOELMD5fpBUcHNYD0UR8r
         cXwfS9aqlqMINWywAgBUHeQAvgYHEgqt8YeMXd6eYuRiZFB7IjVtuzawScSxmdHCAtKw
         xQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0mPzKXAC37oXp0wVkV8/ys9/u7aTcSnLuWMUuY5ccw=;
        b=CtPdsPTAeTdTKOKEMFr/UtRlsPKWgVT1ohIApWI4nZFCQrME89b58YEOTb49KqukQF
         jNu5Sa0cPP4Z/Qh70rwNx0rAFQ7bnOxRji9pLRk+9N52/88HhRT+ppzwnXaD2/QtHdY4
         jwr1DkQdR/lnLnO5TWmuhIq2VJHlJ3dzBfddWA0AI2GzTeiQJCvZk//erBJU/SxMvo/k
         ZKrikg5bxbIZgtNxhNj4q4Ula5SWI9cFQNhIq5qMd0FN/NXQr4787OHSwLrFoH92ZSNu
         TNOjL5jpfqACxC/IvhDtGHUtb0QQwTIGBhUhMh5bE6IOxd/xEz5AwS7I2dlDkyhrojIL
         UmrA==
X-Gm-Message-State: APjAAAUPnqJe7bOL79Krs+wIjfBQDcKBS+vf+hoP6yXrJd2LBk0T9+Tg
        bJUVtjGQV0dQwqveleigS8s=
X-Google-Smtp-Source: APXvYqwJPN1Zn8wdFBpSu4h4FnkR4VySti7UEN2KiwGGp1NrFrPsGy/qRfs1nyJMt6qg4QbJ2U7YXg==
X-Received: by 2002:a1c:1fcc:: with SMTP id f195mr28211273wmf.137.1574074844581;
        Mon, 18 Nov 2019 03:00:44 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f67sm19873313wme.16.2019.11.18.03.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:00:44 -0800 (PST)
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
Subject: [PATCH v6 7/8] arm64: dts: allwinner: h6: Add PWM node
Date:   Mon, 18 Nov 2019 12:00:33 +0100
Message-Id: <20191118110034.19444-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118110034.19444-1-peron.clem@gmail.com>
References: <20191118110034.19444-1-peron.clem@gmail.com>
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
index 29824081b43b..6d4bde488f15 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -245,6 +245,16 @@
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

