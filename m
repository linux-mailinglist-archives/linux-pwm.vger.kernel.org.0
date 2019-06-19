Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D354B592
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2019 11:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfFSJw5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jun 2019 05:52:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:2482 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731384AbfFSJwm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jun 2019 05:52:42 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5J9ktnT028226;
        Wed, 19 Jun 2019 11:52:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=I+Fy96rJlsG36GIKvoePX16L+1iTpw0s4H1f1l6+Eco=;
 b=fdI2e6NYsrnpZ5ZCM8EEpGproDk50ozyZso/EUdyZ9sVcoP3ECFuUkK/cWpwKGCGtR8F
 2RpOe3PNEaHfT06CRoQ98mbfJl41GzWtO3nZ0WqOM8OJ47PFmcnMUvNVvrdJmGfYkofN
 45ZsAJj1IUH6UoJkBztD/5xKlAbk9AU8+jEA1nIHkejv8audXwPPNpJJMdAqk+Rk85o1
 oPZIyA8KDImRb6OAKKjEFE5T73X0LY8tcFxOllPo0nIpF6rE70xHIbF/jSkdAuiasrJy
 LNn2ucWfF1/3tL26FJ1JFzcfJ4GryY1CaY7paCG7AkDtZYc1wJ7j4l4Dn/yaUEUgeNZU UA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t781uu6d5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 11:52:15 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6F71A34;
        Wed, 19 Jun 2019 09:52:14 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 42EB024C7;
        Wed, 19 Jun 2019 09:52:14 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun 2019 11:52:13
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
Subject: [PATCH 1/5] dt-bindings: pwm-stm32: add #pwm-cells
Date:   Wed, 19 Jun 2019 11:52:01 +0200
Message-ID: <1560937925-8990-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
References: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_05:,,
 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

STM32 Timers support generic 3 cells PWM bindings to encode PWM number,
period and polarity as defined in pwm.txt.

Fixes: cd9a99c2f8e8 ("dt-bindings: pwm: Add STM32 bindings")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/pwm/pwm-stm32.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
index 3e6d550..a8690bf 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
@@ -8,6 +8,8 @@ Required parameters:
 - pinctrl-names: 	Set to "default".
 - pinctrl-0: 		List of phandles pointing to pin configuration nodes for PWM module.
 			For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
+- #pwm-cells:		Should be set to 3. This PWM chip uses the default 3 cells
+			bindings defined in pwm.txt.
 
 Optional parameters:
 - st,breakinput:	One or two <index level filter> to describe break input configurations.
@@ -28,6 +30,7 @@ Example:
 
 		pwm {
 			compatible = "st,stm32-pwm";
+			#pwm-cells = <3>;
 			pinctrl-0	= <&pwm1_pins>;
 			pinctrl-names	= "default";
 			st,breakinput = <0 1 5>;
-- 
2.7.4

