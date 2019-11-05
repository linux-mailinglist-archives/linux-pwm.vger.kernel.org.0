Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 325F2EFE22
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 14:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389106AbfKENPJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 08:15:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52351 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388710AbfKENPI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 08:15:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id c17so13508018wmk.2;
        Tue, 05 Nov 2019 05:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9aSxRdpuFtWHR4fiaYF0NucipXPgTqmHceHSDmByEc8=;
        b=WkHd/djk0ORgHMR2yAYNS+7CN1X0l1n8DgXtwwIvVzlhEHMkHD/NTxTZpWptYTlZoB
         RhCVfRsBADwmaNlswVb33scnynJbmb3xJwdaa2RmMSYOTJL/KvYY+fi6hEB+ZMpsriaJ
         fNircKP4McRAi3tzSUZPeKuw2GeN+pkjXNeR1+7THv8EFuyl5Fv4hvOoODBd36JgTVxl
         8F4f6KkDHX+4xxxWx/BPKC753KJbfk/ObcxfGrjTf4OeQx4yMkSFMeRTLxHjuTXbBrnF
         gG8RzslXj+BvVVPL0ERWMv9W8lszVwUwJ1GZW7zgiJdhRdF6XLw8RIGlkZnBUs2G4UFn
         KSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9aSxRdpuFtWHR4fiaYF0NucipXPgTqmHceHSDmByEc8=;
        b=ogm7D0KD9Vy4skTS95auU2C/gphlJT1I65AL7Zpi0t7tW2rzCKdbZg0ScHihDXEQP/
         ztteisc3fUX2TilO2CT9mMNhjcmruTyK/5zBy0s5abHoIOzVpKCLAhygkciR0A7j9apd
         41mX5kHtSEVxNTOL1Rznsue8VnAl/ZxLOAHo8cCMZwzs4bDiOq20dOb7XUjxLRLbP4uN
         Qy9XsQ5zRL5fHsK4kbcHaFOLnAgSFud8GmRBJNtb5Uy7dXJkHTxKJ6XwohFhvrqbEKG7
         BDxUUZ4kUwuKAAntwdBjd3yuH9sZpKwZxBRbh8G5nFpZHbTKJd5McVk5Rx+NayxaYQqc
         abMA==
X-Gm-Message-State: APjAAAX7mPQ7LYqe2I7B7v/IqeUFNxy5qCDU4zdguQf/blGQtRIuQhBV
        O6KCS9FZ0vzNcB3+5HanR+c=
X-Google-Smtp-Source: APXvYqw6UFPNrurMZG2uJGWFoKHNaQqgij6b0hb605Rot6sbahLBVS34Xu72r3LgwNTT0W2EYgOUNg==
X-Received: by 2002:a7b:c747:: with SMTP id w7mr4417876wmk.62.1572959706136;
        Tue, 05 Nov 2019 05:15:06 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id a6sm13549920wmj.1.2019.11.05.05.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 05:15:05 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 7/7] [DO NOT MERGE] arm64: allwinner: h6: enable Beelink GS1 PWM
Date:   Tue,  5 Nov 2019 14:14:56 +0100
Message-Id: <20191105131456.32400-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105131456.32400-1-peron.clem@gmail.com>
References: <20191105131456.32400-1-peron.clem@gmail.com>
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

