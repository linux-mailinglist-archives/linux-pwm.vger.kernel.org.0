Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1571A70523
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2019 18:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfGVQNn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Jul 2019 12:13:43 -0400
Received: from vern.gendns.com ([98.142.107.122]:51500 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbfGVQNn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 22 Jul 2019 12:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bUtZJiqidvzjWT6bJy+yoUNKniUAjIYim2yS80dfmnc=; b=yiXU5BeDFWfFqvEWEMLCs+52I
        rBbGtpIx+wRrHnrIs+qYwikqzAWKb15YuHeekcgXxFj/7Ccsxyvw/EXaWfT5zLdt1kyjQ+G+/eQqN
        4RseKQvpH2KTjyRbx/9RJTImV+bC2caRHsDcMbYoS1T2ta1S0G7hYwTfBUHRo5tVStIhymVw/eLoN
        6DJjNA6xZLx0lJ6ID1E5KbX9rcnt0OmTMSt65OYhhZKMyd0RHM9mNNkcNMKzfKTHUfnb4r++ZWska
        DTcZPMuR1N5+b5WUBTUyZnD8XTf+g02mMEEwRzB6PPZXB4qxgzGLVdM+rOhFMSZYj2s8Tv+BftrrO
        7THaOFkbw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:44690 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1hpaW2-006p1O-Dn; Mon, 22 Jul 2019 11:46:18 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: counter: new bindings for TI eQEP
Date:   Mon, 22 Jul 2019 10:45:35 -0500
Message-Id: <20190722154538.5314-2-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722154538.5314-1-david@lechnology.com>
References: <20190722154538.5314-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This documents device tree binding for the Texas Instruments Enhanced
Quadrature Encoder Pulse (eQEP) Module found in various TI SoCs.

Signed-off-by: David Lechner <david@lechnology.com>
---
 .../devicetree/bindings/counter/ti-eqep.txt    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.txt

diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.txt b/Documentation/devicetree/bindings/counter/ti-eqep.txt
new file mode 100644
index 000000000000..fbcebc2c2cc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/ti-eqep.txt
@@ -0,0 +1,18 @@
+Texas Instruments Enhanced Quadrature Encoder Pulse (eQEP) Module
+
+Required properties:
+- compatible:		Must be "ti,am3352-eqep".
+- reg:			Physical base address and size of the registers map.
+- clocks:		Handle to the PWM's functional clock.
+- clock-names:		Must be "fck".
+- interrupts:		Handle to the eQEP event interrupt
+
+Example:
+
+	eqep0: eqep@180 {
+		compatible = "ti,am3352-eqep";
+		reg = <0x180 0x80>;
+		clocks = <&l4ls_gclk>;
+		clock-names = "fck";
+		interrupts = <79>;
+	};
-- 
2.17.1

