Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5980D100330
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 12:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKRLAr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 06:00:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33921 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfKRLAr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 06:00:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id j18so15645286wmk.1;
        Mon, 18 Nov 2019 03:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iGqUalssFt90BW+qC26cPJ2ocimtOg3RIH0RE3W1sS4=;
        b=oHTBVWCzKbEEX8ADBqtS0nC4h3CNYn1XfnE4upjcrU9jd9WOlvNbtYTmD+5cn8y61a
         AtXhSXsQe2jqj9xCOUPD47GxZa2WNeUOQP0F/BexCFOxpgS0Cibok9YMUFQCHHSMbJru
         x54QTghn8OTid42B41o6KQZkwK9dqeYDz3fYthk6Bt5dqfpcZ5sW/n3J51nJd1mZbLha
         yshq5NVf/JpBrh8AaZV1sImpXOO7tj68GC2YnSc88Hi4ceBwsC0Na5L8yBAWQvEnswbn
         04sLIfQBYErlUi+bgzg+zfbsE0TSsFdFxMynRVwZlGfBPu7MBD8X5XDO1Grehx2HWHbG
         jSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGqUalssFt90BW+qC26cPJ2ocimtOg3RIH0RE3W1sS4=;
        b=Sm88K1hQKn8ONaLAzHqPG+01ZvS2rQKSrZMPfcZfkIEIj2h6qsXj2nHnbFQWIKGLFS
         +POMW7e2WNanaR/5si8ut5TB1BKZRWr7Z/M8xlzoIrhdXTIY/qxcrRkJhErD6GIhYgH0
         6m3rysfv/m7UedBaEky5IND7Vai1rBexDJRxqTA0FXiYkLdNu+202w0xRE5mL3DtHKi+
         cY/F5GlRglYXVFQFQVTZFD87CyAgF3XUMyrr3SxQn9UtSUxPR13kydaXK0cN6SK97FZ2
         5qiOpmb4nVlUvN7fl0js/7X9tM+9Jgw4VltVNYWxE1YxpSRAlbcBG7qEQYJgReDmaiB0
         X/5A==
X-Gm-Message-State: APjAAAVUdu77Oncear8Gq74+nVvt/5NiQKMCzodU3Bad82mrlBNTLHx/
        cNpGTRdlxb62/CNaLMFmdC8=
X-Google-Smtp-Source: APXvYqylsRp4Nj3fkxX+SPKT7MsCCNLSmcFaIEujk7WAbZj4htC5DEVRLFeS7TNDCdftzyqTPoROuw==
X-Received: by 2002:a1c:7c06:: with SMTP id x6mr30073630wmc.34.1574074845202;
        Mon, 18 Nov 2019 03:00:45 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f67sm19873313wme.16.2019.11.18.03.00.44
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
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v6 8/8] [DO NOT MERGE] arm64: allwinner: h6: enable Beelink GS1 PWM
Date:   Mon, 18 Nov 2019 12:00:34 +0100
Message-Id: <20191118110034.19444-9-peron.clem@gmail.com>
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

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index f335f7482a73..cf684bc7374d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -136,6 +136,10 @@
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

