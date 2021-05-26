Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3178439128C
	for <lists+linux-pwm@lfdr.de>; Wed, 26 May 2021 10:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhEZIo4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 May 2021 04:44:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44600 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbhEZIoz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 May 2021 04:44:55 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14Q8hCG9050640;
        Wed, 26 May 2021 03:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622018592;
        bh=xz5M2jphu9cJZTHVb9oK3P7dVEJQMjcf/AMHdb2E6So=;
        h=From:To:CC:Subject:Date;
        b=kAvvGTL4aZaYQGprqXiRvK5491uhPtiGxmY1AT6YASTxv5mqqem3wAlSsX6/8itgB
         6Y0n77Igot7TIe+7JMlVBegxt5GDYLZvknCPZy+XJ+ayyXkiAxQFvs68AU+8HVdQMP
         ZGhjHSv7cGJvFWvrSoUuOehBsenk7qQ0txIScDng=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14Q8hCA9054763
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 03:43:12 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 03:43:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 03:43:12 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14Q8h75U049811;
        Wed, 26 May 2021 03:43:07 -0500
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
Subject: [PATCH 0/4] dt-bindings: pwm: pwm-tiehrpwm: Convert to json schema
Date:   Wed, 26 May 2021 14:13:02 +0530
Message-ID: <20210526084306.6534-1-lokeshvutla@ti.com>
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

