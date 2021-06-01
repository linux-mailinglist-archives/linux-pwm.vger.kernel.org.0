Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3844F396CEF
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jun 2021 07:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFAFp6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Jun 2021 01:45:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40672 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFAFp6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Jun 2021 01:45:58 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1515iAfa118001;
        Tue, 1 Jun 2021 00:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622526250;
        bh=wT+sO92wdMWsr7/UTWln3pfMeaCb+CEbBIUTkjTRU3o=;
        h=From:To:CC:Subject:Date;
        b=WuYsUjyElZt8PHQPQtIgVHY5iSSkMjLyebKfG6qQ/BRV87BwIlooPKPkuBZMCkpK4
         yk5GUbpOBBVtyIw90+VfwwiD8Q1aDBgFfGCidGxKEeq90zGyqJooH8V9FoUUi+48Ni
         ESEYIHVMzCkKkWVw2nuQt7nX7S/bXf82cEbPYOvo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1515iA6S121092
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Jun 2021 00:44:10 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 1 Jun
 2021 00:44:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 1 Jun 2021 00:44:09 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1515i3P3091502;
        Tue, 1 Jun 2021 00:44:04 -0500
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
Subject: [PATCH v3 0/2] dt-bindings: pwm: pwm-tiehrpwm: Convert to json schema
Date:   Tue, 1 Jun 2021 11:14:00 +0530
Message-ID: <20210601054402.2223-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series:
- converts tiehrpwn to DT schema format using json-schema
- Add new compatible for AM64 SoC.

Changes since v2 (https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=489981):
- Dropped DT changes from this series.

Changes since v1:
- Updated the am64 compatible to ti,am64-epwm as High resolution is not
  supported.

Lokesh Vutla (2):
  dt-bindings: pwm: pwm-tiehrpwm: Convert to json schema
  dt-bindings: pwm: pwm-tiehrpwm: Add compatible string for AM64 SoC

 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt  | 50 --------------
 .../devicetree/bindings/pwm/pwm-tiehrpwm.yaml | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml

-- 
2.31.1

