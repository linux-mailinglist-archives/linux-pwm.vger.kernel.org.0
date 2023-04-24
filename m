Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3490A6EC7C3
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Apr 2023 10:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjDXIVS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Apr 2023 04:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjDXIVS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Apr 2023 04:21:18 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA0A10C;
        Mon, 24 Apr 2023 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1682324476; x=1713860476;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nj8t15/BuaSEIZBoe6wzlupOsHZekY7oQAB+lRrkXCY=;
  b=KzA4i5jCcCOKPacUuD8FDZK5gwsDO11IOHwqUgmeoFch0oARthG841/i
   Gi6NxGGRx829o1+VeTxd6KHwsJ8Zl77QqFGgw/Qw6LqJn7ZWcnOtF1WT9
   iuJ0Ad8PB/7DCvQsHwvH2s5hBTlfm3YGf4sgekLWKFTD5oYiPWJz+EoHk
   DR/Y+969KgfhDUZ3Nke894sS9MN/PboNjx8EM8ogisnufEJ8zxhlPY889
   zp1cTMeHB0HURG0MHrAlseRwMrpnSzJmky9Uq1tOb4EIF+Vs6T5tXmbl0
   bAPkU8yZdoSkqS6fdvSAcDx8IQPagCXwDg+u9WRm2frLuAI5DkRg11KBk
   g==;
X-IronPort-AV: E=Sophos;i="5.99,222,1677538800"; 
   d="scan'208";a="30508608"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 24 Apr 2023 10:21:14 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 24 Apr 2023 10:21:14 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 24 Apr 2023 10:21:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1682324474; x=1713860474;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nj8t15/BuaSEIZBoe6wzlupOsHZekY7oQAB+lRrkXCY=;
  b=fNbjXZt0yJE8W3+4OfEsIe6V6ZdAfRkrHVI/w/OLdg+MFW8/BzOOmdoH
   C6VKmOnjuHjsi+aA85ojwK0wS6wTvIwMO7mozy+DnCf5JmOMYJSu7xoiG
   dTbw5sBrqLlfaAvCe2ndzriNdpgzm9StAIAu5LD4aLtNousqJZIHzBD87
   lD3CEsRnUS3DPJ9hx6sZyzcAIgNjHnvv1lFCq5WORnbY5vYROZbqaEPwb
   GeEjbokrc1oj26v6FHcoSDSqn3A++87Q0BY8aRw3Jodu8rKpQgC3SdFDR
   043jTBwWh74YyAIAdrVhxwFn/bW9WjbUFOOqABTF05KQBTEeTVA8ITGqp
   w==;
X-IronPort-AV: E=Sophos;i="5.99,222,1677538800"; 
   d="scan'208";a="30508604"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Apr 2023 10:21:14 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 386EF280056;
        Mon, 24 Apr 2023 10:21:14 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: pwm: imx: add i.MX8QXP compatible
Date:   Mon, 24 Apr 2023 10:21:07 +0200
Message-Id: <20230424082108.26512-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

i.MX8QXP compatible is missing in the list, add it.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Add power-domains property

 Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
index b3da4e629341..c01dff3b7f84 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
@@ -43,6 +43,7 @@ properties:
               - fsl,imx8mn-pwm
               - fsl,imx8mp-pwm
               - fsl,imx8mq-pwm
+              - fsl,imx8qxp-pwm
           - const: fsl,imx27-pwm
 
   reg:
@@ -61,6 +62,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.34.1

