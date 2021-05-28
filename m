Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB1E393C9E
	for <lists+linux-pwm@lfdr.de>; Fri, 28 May 2021 06:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhE1FAV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 May 2021 01:00:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50956 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbhE1FAU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 May 2021 01:00:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14S4weTV069199;
        Thu, 27 May 2021 23:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622177920;
        bh=j69Eq/1BumC8qYZYJK7gexBx1nLH7uJRoiYi0NY1ejg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=t+Bdr9EI83oCBT7Q1IKL5Ns7JaLa/6kaXcr8uJkzQWy84ta0VbOFqxZoeZS7okjH5
         N98QTF7umVX6zDLnsXnGE3LseEVXftfHWCBHA9yPq7lEP88lGXwmrNvUIUSK9N+IHN
         O7xrRoFVlmKdBsDUzFstzytBheOVx8wrj8qGvqj0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14S4wei0062149
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 May 2021 23:58:40 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 23:58:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 27 May 2021 23:58:39 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14S4wInC088708;
        Thu, 27 May 2021 23:58:36 -0500
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
Subject: [PATCH v2 4/4] dt-bindings: pwm: pwm-tiehrpwm: Add compatible string for AM64 SoC
Date:   Fri, 28 May 2021 10:28:17 +0530
Message-ID: <20210528045817.16618-5-lokeshvutla@ti.com>
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

Add compatible string for AM64 SoC in device tree binding.
EPWM IP in AM64 does not support High resolution, so named epwm instead
of ehrpwm in compatible. However IP is till compatible with features
supported by driver with ti,am3352-ehrpwm compatible.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
index 84a8d6d38cee..ee312cb210e6 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
@@ -22,6 +22,7 @@ properties:
               - ti,am4372-ehrpwm
               - ti,dra746-ehrpwm
               - ti,am654-ehrpwm
+              - ti,am64-epwm
           - const: ti,am3352-ehrpwm
 
   reg:
-- 
2.31.1

