Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2787E393C98
	for <lists+linux-pwm@lfdr.de>; Fri, 28 May 2021 06:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbhE1FAQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 May 2021 01:00:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50938 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhE1FAO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 May 2021 01:00:14 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14S4wV6T069129;
        Thu, 27 May 2021 23:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622177911;
        bh=iqTgAH5lyTl4oLGQvR2G8gbqpeiHC7BoOJX4JeW4NDs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PlPvGIGk5lu65vz20s3ajlJfJh6fXRdabjzM2z0ahw/mC2HZDmyiRhCPDcawHggnM
         OS0jPQFJI0IjoZ9AsULiHhYQyhkBebaTGJoLuxgboR0tAj66vOyfsY2VhPAJBjMTRK
         rOO8aBEi33gFQHlpoPVFoaeAktQb8+AtddU3wTy0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14S4wV4X067094
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 May 2021 23:58:31 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 23:58:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 27 May 2021 23:58:31 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14S4wInA088708;
        Thu, 27 May 2021 23:58:27 -0500
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
Subject: [PATCH v2 2/4] dt-bindings: pwm: tiehrpwm: Make clock and clock-names as required properties
Date:   Fri, 28 May 2021 10:28:15 +0530
Message-ID: <20210528045817.16618-3-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528045817.16618-1-lokeshvutla@ti.com>
References: <20210528045817.16618-1-lokeshvutla@ti.com>
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

