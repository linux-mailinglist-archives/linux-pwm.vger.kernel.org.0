Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC3A682F6A
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Jan 2023 15:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjAaOhc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 31 Jan 2023 09:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjAaOha (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 31 Jan 2023 09:37:30 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3C8136;
        Tue, 31 Jan 2023 06:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675175848; x=1706711848;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0QgTIW/8nGL0dj03k0ypVgrXG9s41tMeuOVlaBrfweE=;
  b=fYTboIWJRFUcYQRcPBwOyR5UUh9RkTVFEhz+mkUJxMAwwr+X8LdfQBw9
   2kEX4iPFAMOb/zXnMjR2ofAqIMUTAkRz+W4TM4oQOnNLqSg7Z+Ml8DmsD
   dGA53CkaT7Y236rcSXQhCHoX+1pjwOMsGNf9aItU362YUReiDbdg5tp4t
   8u867OpODj7V3JbZEEjV5jrfDamrfXjC9TRVDRwPvRNutb9+uDjJlNWuz
   RLh9N3Qv2pnOUO1wz6bsga8aHM6T6qh51nI5bwqpzQapbnCBAjXQZ0gzD
   HvsEUpSaPpgBL1giJ+oTVDRI/wKLkPEnmqQMdyke4wlHMJ4p2vNf8GwZe
   A==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="28775433"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 Jan 2023 15:37:26 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 31 Jan 2023 15:37:26 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 31 Jan 2023 15:37:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675175846; x=1706711846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0QgTIW/8nGL0dj03k0ypVgrXG9s41tMeuOVlaBrfweE=;
  b=ORmRCo6O8RupqMat9Reeql7KrGtIjIJHKYS+oFHQ4z93SDOcikA/evMn
   vF9RmBe1HWpM8b+Sp8UMIOx2piuXjpsPKCVN+UFov57RhvktqF8O2UA9H
   i5AFFh4oXdDNUsx0sRXscX679LXpUsrZqM5ilh10rIINB30lY4KhqPs4D
   fj/rMf5c9K3+bZF7RzMuvKPUHvqD8luR35E2dJyWBF2qnKmWykkekeAm7
   iyBeIqHR3/FAjSx0R1nR/kZyCKRaOSLjtvb1Qw+kWGzWHE737KDCqFlRw
   CO7T0/AffMpv71xHYz1sUmReMt3qQRdpFDzjI4qBVg+v4tNKeQmI1z1ck
   A==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="28775432"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 Jan 2023 15:37:26 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 3DE67280056;
        Tue, 31 Jan 2023 15:37:26 +0100 (CET)
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
Subject: [PATCH 1/1] dt-bindings: pwm: imx: add i.MX8QXP compatible
Date:   Tue, 31 Jan 2023 15:37:20 +0100
Message-Id: <20230131143720.3250427-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

i.MX8QXP compatible is missing in the list, add it.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
index b3da4e629341..9270fd40b95b 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
@@ -43,6 +43,7 @@ properties:
               - fsl,imx8mn-pwm
               - fsl,imx8mp-pwm
               - fsl,imx8mq-pwm
+              - fsl,imx8qxp-pwm
           - const: fsl,imx27-pwm
 
   reg:
-- 
2.34.1

