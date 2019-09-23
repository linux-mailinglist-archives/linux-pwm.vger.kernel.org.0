Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12035BAF09
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2019 10:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437137AbfIWIOA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Sep 2019 04:14:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38608 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437271AbfIWIOA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Sep 2019 04:14:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id u28so9377017lfc.5
        for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2019 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yaEGfYYzHwOCfVyIlgvVjUBZGDRTASgoNwVywAAbPHY=;
        b=ewfXG73buI74XMq7fZvVCWZKlgR+0TiV4JG9jO/fe49Cgrg27am4riX0e0bPmvYroq
         u1b3ifBwwoH+Hu3VVrsI7kvp9IgLIBUnoVgqO1+NL1lZp+dR74yHyrgZ1unaAXzC4J6X
         kayGRA9zv0hm5PTVKc5F3g/2+TsbFV+athuPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yaEGfYYzHwOCfVyIlgvVjUBZGDRTASgoNwVywAAbPHY=;
        b=sPV/LJ0GtXLSP3/ZDv38hheyZ6pkLBI6REZpM53LgbRtxMcIeWmFkMywWZEDamQnU3
         mRfaoQY0oReYV0O3hnsDqJ8jHbVK9t3j32mmNkdHTxqyfhE779NySLyV8oH1zu9UDp7c
         s8Di5XpoiWBPlGgB1BxZ3Zo5aJa3Di5qIXJ1Bx78qckhzJUzKYYaLYr9igvxBOsMtDhh
         0IKW7nDVqyskLB9GIzIbRR/yOaZhrydwlE/1ryodIpFYcSMKtADrPKkMXoZEgXFaRXcj
         w+AGW2cN5DOkHmKMN4MZSTlOK5LGEZh54NaWTCYR5rcVtcBAtyg0CDV1j/mzg96LhXVz
         Y5eg==
X-Gm-Message-State: APjAAAXyz6Lkkjz4+i5xyKYp2OU2DmHbJ5D0wrec5gKminougN/znkEx
        7E9nHlR7hmF70DbDOHIXzOyq7Q==
X-Google-Smtp-Source: APXvYqwa45HyJC3lNRp5/zE7lrzcpW7gGM4PVnCUaEY3v11W5wPXc/WNYcX42D8uo4bAGlw71Tm2Fg==
X-Received: by 2002:a19:c396:: with SMTP id t144mr16546948lff.14.1569226436978;
        Mon, 23 Sep 2019 01:13:56 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id c21sm2054946lff.61.2019.09.23.01.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 01:13:56 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] dt-bindings: pwm: mxs-pwm: Increase #pwm-cells
Date:   Mon, 23 Sep 2019 10:13:48 +0200
Message-Id: <20190923081348.6843-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

We need to increase the pwm-cells for the optional flags parameter, in
order to implement support for polarity setting via DT.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 Documentation/devicetree/bindings/pwm/mxs-pwm.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt b/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
index 96cdde5f6208..1697dcd3b07c 100644
--- a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
@@ -3,7 +3,7 @@ Freescale MXS PWM controller
 Required properties:
 - compatible: should be "fsl,imx23-pwm"
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format.
 - fsl,pwm-number: the number of PWM devices
 
@@ -12,6 +12,6 @@ Example:
 pwm: pwm@80064000 {
 	compatible = "fsl,imx28-pwm", "fsl,imx23-pwm";
 	reg = <0x80064000 0x2000>;
-	#pwm-cells = <2>;
+	#pwm-cells = <3>;
 	fsl,pwm-number = <8>;
 };
-- 
2.20.1

