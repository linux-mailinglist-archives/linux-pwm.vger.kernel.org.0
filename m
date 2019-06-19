Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CA54B596
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2019 11:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfFSJwk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jun 2019 05:52:40 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13226 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726826AbfFSJwk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jun 2019 05:52:40 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5J9kvaL028234;
        Wed, 19 Jun 2019 11:52:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=rXR4M7t22XwNh12WImA9EjQhM49Lilzc8OvfTApgm+o=;
 b=iGGsogxeuihyRqyf+NUuAHw1UY8OdhkL66YAdnA03GETYkx8MvSRj/acGEsad8Bv9CZL
 yflRA4BVX68NOhqfBKkYR/ldH4q0H8mtoDXk2198JgawTSuSfYxANORwl2rpz1OukU8M
 p3owuyH3jdgaxsSwaxE/KgkD0q72El3OGyLNFocpuuPvI3MQmPgdPdrszukc0K+q8J+V
 K8jHfRrbQAdHf5AVdAMbJ0Mtqngvm+ckjur9u7Mb3+d4cg6sIZ8Nl8Y40hNwvQ32Nw1p
 fnar9ce4L7R/af3VHInsrXbCJV/hIw3WvWLlNSjapiA/BLoVzHRZTsiWvVm9FDa/3vlv Lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t781uu6dm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 11:52:17 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2E17634;
        Wed, 19 Jun 2019 09:52:17 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 126D124CA;
        Wed, 19 Jun 2019 09:52:17 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun 2019 11:52:16
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
Subject: [PATCH 5/5] ARM: dts: stm32: add pwm cells to stm32f746
Date:   Wed, 19 Jun 2019 11:52:05 +0200
Message-ID: <1560937925-8990-6-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
References: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_05:,,
 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

STM32 Timers support generic 3 cells PWM to encode PWM number, period and
polarity.

Fixes: 9bd7b77af8e4 ("ARM: dts: stm32: add Timers driver for stm32f746
MCU")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index a25b700..d26f93f 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -94,6 +94,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -123,6 +124,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -152,6 +154,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -180,6 +183,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -249,6 +253,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -270,6 +275,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
@@ -285,6 +291,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
@@ -419,6 +426,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -440,6 +448,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -512,6 +521,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -533,6 +543,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
@@ -548,6 +559,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
-- 
2.7.4

