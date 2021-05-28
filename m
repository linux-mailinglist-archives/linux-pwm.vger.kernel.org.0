Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0764393C92
	for <lists+linux-pwm@lfdr.de>; Fri, 28 May 2021 06:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhE1FAF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 May 2021 01:00:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50868 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhE1FAE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 May 2021 01:00:04 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14S4wNI4069105;
        Thu, 27 May 2021 23:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622177903;
        bh=ag6IoYnwjuEMmfGFog/fG9kPs5XoDbEnX1ew2XxCxu4=;
        h=From:To:CC:Subject:Date;
        b=wZbT39t4p3kYFeDLHY+xGZDpZ3Dpq7p+dNkCRkShCGj5UIX5/VXbTw5X0dKPp+o+7
         i45R0AlpDqMhc7eXKgREffjiS9QVetJGNsul1Th1QdnaGLl/MDl3El8ku+3CgVEHx0
         vSPULJ6cY5Vpu750gO8MTkvZ67VaO0CNHFDQ03pc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14S4wN84067027
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 May 2021 23:58:23 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 23:58:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 27 May 2021 23:58:22 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14S4wIn8088708;
        Thu, 27 May 2021 23:58:19 -0500
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
Subject: [PATCH v2 0/4] dt-bindings: pwm: pwm-tiehrpwm: Convert to json schema
Date:   Fri, 28 May 2021 10:28:13 +0530
Message-ID: <20210528045817.16618-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series:
- drops a redundant compatible
- converts tiehrpwn to DT schema format using json-schema
- Add new compatible for AM64 SoC.

Changes since v1:
- Updated the am64 compatible to ti,am64-epwm as High resolution is not
  supported.

Lokesh Vutla (4):
  arm: dts: ti: drop usage of redundant compatible
  dt-bindings: pwm: tiehrpwm: Make clock and clock-names as required
    properties
  dt-bindings: pwm: pwm-tiehrpwm: Convert to json schema
  dt-bindings: pwm: pwm-tiehrpwm: Add compatible string for AM64 SoC

 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt  | 50 --------------
 .../devicetree/bindings/pwm/pwm-tiehrpwm.yaml | 65 +++++++++++++++++++
 arch/arm/boot/dts/am33xx-l4.dtsi              |  9 +--
 arch/arm/boot/dts/am437x-l4.dtsi              | 18 ++---
 arch/arm/boot/dts/da850.dtsi                  |  6 +-
 5 files changed, 76 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml

-- 
2.31.1

