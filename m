Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B4F396CF6
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jun 2021 07:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhFAFqM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Jun 2021 01:46:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40724 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbhFAFqL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Jun 2021 01:46:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1515iPec118058;
        Tue, 1 Jun 2021 00:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622526265;
        bh=j69Eq/1BumC8qYZYJK7gexBx1nLH7uJRoiYi0NY1ejg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DlBg17KPePWwWtjmJ/NuII8kv2xdZy2IWQ6H5aNoJTsYVLZ47B053DRi7t2i6AKIW
         WTPPPpL8w6Z1K8+JMecedlixuXSZWt520mfNVQVXuXWHkA2VKG5HF8Gv5Cafv2XbsA
         lu2kDUpD4Z8TD3taJNrfkiGL4Mz1JM8qsu7cdDIo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1515iPIt047101
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Jun 2021 00:44:25 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 1 Jun
 2021 00:44:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 1 Jun 2021 00:44:24 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1515i3P5091502;
        Tue, 1 Jun 2021 00:44:17 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
CC:     <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, <linux-pwm@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 2/2] dt-bindings: pwm: pwm-tiehrpwm: Add compatible string for AM64 SoC
Date:   Tue, 1 Jun 2021 11:14:02 +0530
Message-ID: <20210601054402.2223-3-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210601054402.2223-1-lokeshvutla@ti.com>
References: <20210601054402.2223-1-lokeshvutla@ti.com>
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

