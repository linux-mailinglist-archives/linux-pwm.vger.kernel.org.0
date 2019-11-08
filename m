Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57298F4270
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Nov 2019 09:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfKHIpf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Nov 2019 03:45:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33192 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730743AbfKHIpe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Nov 2019 03:45:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id a17so6017714wmb.0;
        Fri, 08 Nov 2019 00:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9aSxRdpuFtWHR4fiaYF0NucipXPgTqmHceHSDmByEc8=;
        b=fewmUdz8Bc1voBvS9gkVz79gCkt7venyCUove7xWvuUQ7Y4j/5GuWd2AXvvgJu1Kfj
         N0dQ5nNqgLQudUbMeirlTSoTROX+NXDVjv7tmF7iOf3rJrWmkKmh2vS/eJjIzlX3uqx4
         STJgeC8x6DSUy9PENPKGwtPtmXM483oVZq4Tm20Sg9l4PF42SkfQzBy8FNi7A54AoFCP
         k5F6YhLTTRPhmtsmFWLs8KjOql5qNPJDr74p2c7q4oNgfFgToC/aHzfjzHqwBIH5YJcz
         u/9zV1l8RwIgs5Kml7dx0uYElJGbgKN5fExDkFmeNqi4iAmfvBOItS7w5LRN0zL+qcHs
         ssbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9aSxRdpuFtWHR4fiaYF0NucipXPgTqmHceHSDmByEc8=;
        b=rJg1cIZnjA1j/18+0GfLSqJG7FV3ZyFOozrzAgJX1OKGg5PBwbwldvO+Ft/6fg7swT
         UqwfIOQ+8ccayn/7xEmLiwFyIWLUPxyvyQlWoiMBB7/5tOhm64KEt498nz/VtuOi/C1A
         Xgn26Bf5h70ZwvEnjU20VOPktKNVCtN7+z0S0AYaw4egVa9dJeQIJY8udfeeHWsP6V/C
         BCxbAOhUwcZUQE8aM4QqOCcUn4sQAdJBzpU/ONK/5qf7g6mh7uyrJcK/kQTpZfMYUZMW
         6zdHTDfgP52FfiFYW2eEy6y2T1GWVQt3UPgXuO8zBLb0PAeCLs1sohxCsRcErqvM6K+i
         cgoA==
X-Gm-Message-State: APjAAAVmE3+dSPATC3w3YnyKwhpm4//U2H+IuChlE4Ad0gfzNKbxu313
        WOcvSBJxwQXtA+m6lenBG/4=
X-Google-Smtp-Source: APXvYqzDrSyXBmSgmOwIGNCEnIg0mdtNJewcjpzu3/9Z4+a5/R+2nI67UgxKiYB47MIydRckpkp04g==
X-Received: by 2002:a1c:558a:: with SMTP id j132mr6983373wmb.21.1573202731677;
        Fri, 08 Nov 2019 00:45:31 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id q25sm6662665wra.3.2019.11.08.00.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 00:45:31 -0800 (PST)
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
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 7/7] [DO NOT MERGE] arm64: allwinner: h6: enable Beelink GS1 PWM
Date:   Fri,  8 Nov 2019 09:45:17 +0100
Message-Id: <20191108084517.21617-8-peron.clem@gmail.com>
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

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 1d05d570142f..38aba7e5bbd9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -131,6 +131,10 @@
 	vcc-pg-supply = <&reg_aldo1>;
 };
 
+&pwm {
+	status = "okay";
+};
+
 &r_i2c {
 	status = "okay";
 
-- 
2.20.1

