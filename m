Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D8B27937A
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Sep 2020 23:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgIYV0U (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Sep 2020 17:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgIYV0U (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 25 Sep 2020 17:26:20 -0400
Received: from localhost.localdomain (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2164321741;
        Fri, 25 Sep 2020 21:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601069179;
        bh=N9JaW+8SGbvwdQLMGjpUpaTkyxkJEPp68PVp3/IQptU=;
        h=From:To:Cc:Subject:Date:From;
        b=cABLsbryWFwTywQxxkCDGE/Abyt7GQeZpCzuuhiTBU3ZJvUh0TViIaMbHcdZ75GzE
         QViKgvnBL6yLExJ1j64OTwCPR0tsSJYayDRspg+d6rsClU8d2Rf+S5gfQkWDEg/dmh
         g4TXtjM38v2e/Q+nyZXNQtvXdX0bnfvFMF2oDF5A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: pwm: imx: document i.MX compatibles
Date:   Fri, 25 Sep 2020 23:26:09 +0200
Message-Id: <20200925212609.23093-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document all ARMv5, ARMv6 and ARMv7 i.MX compatibles to fix dtbs_check
warnings like:

  arch/arm/boot/dts/imx6dl-colibri-eval-v3.dt.yaml: pwm@2080000: compatible:0:
    'fsl,imx6q-pwm' is not one of ['fsl,imx8mm-pwm', 'fsl,imx8mn-pwm', 'fsl,imx8mp-pwm', 'fsl,imx8mq-pwm']

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
index 473863eb67e5..379d693889f6 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
@@ -25,6 +25,17 @@ properties:
           - fsl,imx27-pwm
       - items:
           - enum:
+              - fsl,imx25-pwm
+              - fsl,imx31-pwm
+              - fsl,imx50-pwm
+              - fsl,imx51-pwm
+              - fsl,imx53-pwm
+              - fsl,imx6q-pwm
+              - fsl,imx6sl-pwm
+              - fsl,imx6sll-pwm
+              - fsl,imx6sx-pwm
+              - fsl,imx6ul-pwm
+              - fsl,imx7d-pwm
               - fsl,imx8mm-pwm
               - fsl,imx8mn-pwm
               - fsl,imx8mp-pwm
-- 
2.17.1

