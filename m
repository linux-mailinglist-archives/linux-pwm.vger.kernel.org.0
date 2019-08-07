Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1811853C2
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2019 21:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389513AbfHGTlJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Aug 2019 15:41:09 -0400
Received: from vern.gendns.com ([98.142.107.122]:43694 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389490AbfHGTlH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 7 Aug 2019 15:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CMx2ESecDAy9GX/sq0J/LnFejZ9aZZn2RCvnxTK34dk=; b=o96uNOvs0qTEkE0S6xZo6aRc/
        s9kprz2AYBH2hMDmZ6w6A6hi/fnOzJQTgAdV1ZhNRtfqseAyQc4U7pQsRRIOvSEfu00bcs/ez4KoX
        /WZeXu0TEZ4IUH9ZT4R/c6pcetbGiuEx9DwjBwzQDeHlMpJAft/pt5bbB/CADuIizefLhifajA83U
        uO/xgX8qQqeJDqzksxmDoNXQma33rwsMScUaWNKbzxgKZuMRVCOX9to6KV+RMBS+0J5qxefXMBTGK
        HFyV8O2snN87DeKLeD0Kbyhx38MbzXdomz8dU/vj09YHTPTaXWN6q9EGvUQS7D3ZROuJMCPMZl/YT
        iOFpAMJEA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:60292 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1hvRo0-00006r-90; Wed, 07 Aug 2019 15:41:04 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2 4/5] ARM: dts: am33xx: Add nodes for eQEP
Date:   Wed,  7 Aug 2019 14:40:22 -0500
Message-Id: <20190807194023.15318-5-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807194023.15318-1-david@lechnology.com>
References: <20190807194023.15318-1-david@lechnology.com>
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

This adds new nodes for the Texas Instruments Enhanced Quadrature
Encoder Pulse (eQEP) module in the PWM subsystem on AM33XX.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes:
- clocks renamed to "sysclkout"

 arch/arm/boot/dts/am33xx-l4.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 3b1fb2ba4dff..47d75f4a81e1 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -1908,6 +1908,15 @@
 					status = "disabled";
 				};
 
+				eqep0: eqep@180 {
+					compatible = "ti,am3352-eqep";
+					reg = <0x180 0x80>;
+					clocks = <&l4ls_gclk>;
+					clock-names = "sysclkout";
+					interrupts = <79>;
+					status = "disabled";
+				};
+
 				ehrpwm0: pwm@200 {
 					compatible = "ti,am3352-ehrpwm",
 						     "ti,am33xx-ehrpwm";
@@ -1961,6 +1970,15 @@
 					status = "disabled";
 				};
 
+				eqep1: eqep@180 {
+					compatible = "ti,am3352-eqep";
+					reg = <0x180 0x80>;
+					clocks = <&l4ls_gclk>;
+					clock-names = "sysclkout";
+					interrupts = <88>;
+					status = "disabled";
+				};
+
 				ehrpwm1: pwm@200 {
 					compatible = "ti,am3352-ehrpwm",
 						     "ti,am33xx-ehrpwm";
@@ -2014,6 +2032,15 @@
 					status = "disabled";
 				};
 
+				eqep2: eqep@180 {
+					compatible = "ti,am3352-eqep";
+					reg = <0x180 0x80>;
+					clocks = <&l4ls_gclk>;
+					clock-names = "sysclkout";
+					interrupts = <89>;
+					status = "disabled";
+				};
+
 				ehrpwm2: pwm@200 {
 					compatible = "ti,am3352-ehrpwm",
 						     "ti,am33xx-ehrpwm";
-- 
2.17.1

