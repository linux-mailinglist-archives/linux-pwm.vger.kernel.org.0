Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEE439129A
	for <lists+linux-pwm@lfdr.de>; Wed, 26 May 2021 10:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhEZIpL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 May 2021 04:45:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47124 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbhEZIpJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 May 2021 04:45:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14Q8hU70106306;
        Wed, 26 May 2021 03:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622018610;
        bh=00A4y9iCMVGyxzhvAGt5Fyc166t88jfB0IHPljtczsA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=T0+lXOl0DBJYbqwCEXt0F5Y3hxqkibuzUtk1IViDThbEqjh22dAYVQl/k3Ko7FQcU
         rzaFnY8ywvEIcbX5BpQiRWoFOisyYatgEgCY2MofMuSSNtsZlYJKJx5RRZUMiiDRnO
         dvM0/dDaAgzkdd1HHUXar/tl+G10007yFJGeOiO0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14Q8hUXJ067219
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 03:43:30 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 03:43:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 03:43:30 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14Q8h75Y049811;
        Wed, 26 May 2021 03:43:26 -0500
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
Subject: [PATCH 4/4] dt-bindings: pwm: pwm-tiehrpwm: Add compatible string for AM64 SoC
Date:   Wed, 26 May 2021 14:13:06 +0530
Message-ID: <20210526084306.6534-5-lokeshvutla@ti.com>
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

Add compatible string for AM64 SoC in device tree binding.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
index 84a8d6d38cee..347ba356a3f5 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
@@ -22,6 +22,7 @@ properties:
               - ti,am4372-ehrpwm
               - ti,dra746-ehrpwm
               - ti,am654-ehrpwm
+              - ti,am64-ehrpwm
           - const: ti,am3352-ehrpwm
 
   reg:
-- 
2.31.1

