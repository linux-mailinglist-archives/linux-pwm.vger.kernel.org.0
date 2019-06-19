Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7A04B591
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2019 11:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfFSJwm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jun 2019 05:52:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31778 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbfFSJwl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jun 2019 05:52:41 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5J9q16P021273;
        Wed, 19 Jun 2019 11:52:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=eSCbzDQNc57cUNFoNjuKOilaCyJFUr9RpRGFUxPW9gQ=;
 b=VZH6zawPBXG9edXDm8uo/dE0fPvNXCDG4ILVrjit5H89+6qT+5FG8Ad9kg/vPeJDt37m
 Lua3dQdc+HuwgNaZDmfC65yXw7ATk0Bnen0+AXfnM/M91Wg70ONhTkcl9z0gd3tgOLER
 k9L8NSHllMBAHLZP0yWOuo1LEpIDRaPud/1pXdl67AbMjtShKP0PCKi+RI3OZSgmQbCr
 gOoTgSRX+tcH3kYAw6B29qNzUtkP2UnTYSKuhWDa1i28IXJru7LZK0ayQ46xdnbnpJnE
 ivzuV/byPThaW0TxY7+Ex7IGu4kMyvSHAOw0GC4nwh8S6EsYtQG2bUj7CcTTRy9EVdU7 tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t7813b404-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 11:52:16 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B48AE34;
        Wed, 19 Jun 2019 09:52:15 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F2CA24C7;
        Wed, 19 Jun 2019 09:52:15 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun 2019 11:52:15
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <benjamin.gaignard@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 3/5] ARM: dts: stm32: add pwm cells to stm32mp157c
Date:   Wed, 19 Jun 2019 11:52:03 +0200
Message-ID: <1560937925-8990-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
References: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_05:,,
 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

STM32 Timers support generic 3 cells PWM to encode PWM number, period and
polarity.

Fixes: 61fc211c484d ("ARM: dts: stm32: add timers support to stm32mp157c")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 2afeee6..215dc95 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -133,6 +133,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -161,6 +162,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -187,6 +189,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -215,6 +218,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -272,6 +276,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -293,6 +298,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -314,6 +320,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -545,6 +552,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -575,6 +583,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -637,6 +646,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -661,6 +671,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 			timer@15 {
@@ -684,6 +695,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
-- 
2.7.4

