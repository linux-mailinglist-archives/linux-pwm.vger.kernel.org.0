Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AE5391292
	for <lists+linux-pwm@lfdr.de>; Wed, 26 May 2021 10:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhEZIpD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 May 2021 04:45:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44616 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbhEZIo7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 May 2021 04:44:59 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14Q8hLKx050671;
        Wed, 26 May 2021 03:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622018601;
        bh=iqTgAH5lyTl4oLGQvR2G8gbqpeiHC7BoOJX4JeW4NDs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wTvgNktdG1ooY2WJktb2kUlG2qZjuJlKjelZB9NVMVqGI36ThKUjdjM5Ua/Bik0lu
         84Z6xF5FFjMpeQvXkg9kfhOiOmAirc0tUuXr+IIP5TJi2wqE8l1UF4ailt6YOhpKhj
         kFZN1QZHLqBbfoX4lFFDjYhqn+SjfRxKecNtYqao=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14Q8hLMr054934
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 03:43:21 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 03:43:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 03:43:21 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14Q8h75W049811;
        Wed, 26 May 2021 03:43:17 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
CC:     <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Vignesh R <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        <linux-pwm@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 2/4] dt-bindings: pwm: tiehrpwm: Make clock and clock-names as required properties
Date:   Wed, 26 May 2021 14:13:04 +0530
Message-ID: <20210526084306.6534-3-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084306.6534-1-lokeshvutla@ti.com>
References: <20210526084306.6534-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Driver fails to probe when 'clock' and 'clock-names' properties are not
populated in DT. But the binding documentation says these properties are
optional. Fix this by making 'clock' and 'clock-names' properties as
required.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index e124e41418d8..8eae48c9c5cd 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -11,8 +11,6 @@ Required properties:
   the cells format. The only third cell flag supported by this binding is
   PWM_POLARITY_INVERTED.
 - reg: physical base address and size of the registers map.
-
-Optional properties:
 - clocks: Handle to the PWM's time-base and functional clock.
 - clock-names: Must be set to "tbclk" and "fck".
 
@@ -38,6 +36,8 @@ ehrpwm0: pwm@1f00000 { /* EHRPWM on da850 */
 	compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm";
 	#pwm-cells = <3>;
 	reg = <0x1f00000 0x2000>;
+	clocks = <&psc1 17>, <&ehrpwm_tbclk>;
+	clock-names = "fck", "tbclk";
 };
 
 ehrpwm0: pwm@4843e200 { /* EHRPWM on dra746 */
-- 
2.31.1

