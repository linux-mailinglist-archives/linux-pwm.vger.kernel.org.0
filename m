Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECF539716B
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jun 2021 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhFAKaF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Jun 2021 06:30:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50012 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFAKaD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Jun 2021 06:30:03 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 151ASBnG047453;
        Tue, 1 Jun 2021 05:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622543291;
        bh=Kt/Dpq4dnKW4g0SuYIVEZRWokQRtLf55hA1FZ+izm9g=;
        h=From:To:CC:Subject:Date;
        b=QWxvnjHI6lraBVxr+0FeIo+ajqNYcRLGBtUADBVebhlFWvUywM9wV/hMVsP6ORq4Q
         4rwulGyXs+cYWmWkdCR+8zQJ0XpdClSsPT67UNoy4jl/HsjPLOB0i/zSLGc6agEqtO
         YPqUveJh98fCsDdkQrpiBwf2MUwYDfLaleellRqI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 151ASAP7130352
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Jun 2021 05:28:11 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 1 Jun
 2021 05:28:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 1 Jun 2021 05:28:10 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 151AS56H063553;
        Tue, 1 Jun 2021 05:28:06 -0500
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
Subject: [PATCH 0/2] dt-bindings: pwm: pwm-tiecap: Convert to json schema
Date:   Tue, 1 Jun 2021 15:58:02 +0530
Message-ID: <20210601102804.22152-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series:
- converts tiecap to DT schema format using json-schema
- Add new compatible for AM64 SoC.

Lokesh Vutla (2):
  dt-bindings: pwm: pwm-tiecap: Convert to json schema
  dt-bindings: pwm: pwm-tiecap: Add compatible string for AM64 SoC

 .../devicetree/bindings/pwm/pwm-tiecap.txt    | 51 ---------------
 .../devicetree/bindings/pwm/pwm-tiecap.yaml   | 64 +++++++++++++++++++
 2 files changed, 64 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml

-- 
2.31.1

