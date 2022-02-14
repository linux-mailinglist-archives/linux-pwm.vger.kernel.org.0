Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A954B43B0
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 09:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbiBNIQy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 03:16:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241709AbiBNIQx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 03:16:53 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07DE4EA14
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:16:46 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 542824049C
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 08:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826605;
        bh=Vx5pgZq+wTDk2cXNM++1rpL4of1cb6TeLTw59n/JqH4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=tl8dZp90zTN/3EA0rvFUUsZ/TaCS/1BYBo2ZytSqcEgUKVNNGj13npXlHNH2OzXmf
         N13k/v/AEBmU5eWO40/75lsP6qhTxJXjB94Ok2IV+jA6v31/T8grK3MvgGyz6pQ/Q8
         hnVWXvh4liqTeDcaHS60FmwKG3O7rtxC63YpXkvMcd1gnwUh5+xvRVnQkd/Izixzij
         0TN8yvW8fR0PdsdqLGlRI/ke6gVLl9ZNh6dvAkSvIMcoIoIXsGDe33OrDUphRvsjC1
         7zf9suvoGsl6rJeMAywggUX8VAZxK8CXjg2snbq4KSP34PA4n8mXfaNNODujuPrge/
         RL0D3muNxk9iQ==
Received: by mail-ej1-f70.google.com with SMTP id la22-20020a170907781600b006a7884de505so5487060ejc.7
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vx5pgZq+wTDk2cXNM++1rpL4of1cb6TeLTw59n/JqH4=;
        b=osJMDbNsMjb26TZ3RrPHMV9EBO3+U8eMPXmz8i6C4z3dF85wi2SbkwnzqWlQG4pHaF
         s/8g0vQERPSHQnVccS3xXrLUIsjfc5cHYCw1Z4rAuUjdVrPVIgOjDUGQERSLbTFowcgX
         7BavP6JTy8QCBKd+HZduqaLOcLClLndR8alJpOgGCjNXpRIBw0SdByfdHOKaAk1+QRzG
         b+HmRxSOfFMfrtjEqrdoFTth+4dcuV6o03q0pvO9c2EbusvQ5pPtwVCi0kQgWToLaBbv
         RnkyQsGnmaEcHjWmHh//Y4YNwfGnSHhNGs9FaeQp8ul3fxY0DvUZs3CDouGBGftoXPH3
         DbGg==
X-Gm-Message-State: AOAM530W4LO7KirA+v6RqtI9RQMYoCLKTMi/X67ekHt5cnO4kmOmcxTM
        uSjFiL8V1EfduFNfxS6iXWb2JV3SDguDS918OmXS8n1aSbyE3i4ZrVi7qG3F/d8BUydFSAtryEH
        g/0aODsj4ESBxNmuw8sDS/2PbBBp1a+RpIbeBFQ==
X-Received: by 2002:a17:907:86a1:: with SMTP id qa33mr10593911ejc.516.1644826604841;
        Mon, 14 Feb 2022 00:16:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHLCvj9EOOMBQpfPrsB+GOXcyF6v8PbErxtuwvlpLnjLHBW4y7stXTy+wJs5s8ptFN23VAWQ==
X-Received: by 2002:a17:907:86a1:: with SMTP id qa33mr10593877ejc.516.1644826604628;
        Mon, 14 Feb 2022 00:16:44 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t21sm3363642edd.74.2022.02.14.00.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:16:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 03/15] dt-bindings: pwm: intel,lgm: include generic pwm schema
Date:   Mon, 14 Feb 2022 09:15:53 +0100
Message-Id: <20220214081605.161394-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
References: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Include generic pwm.yaml schema, which enforces PWM node naming and
brings pwm-cells requirement.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
index 11a606536169..59d7c4d864c1 100644
--- a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
@@ -9,6 +9,9 @@ title: LGM SoC PWM fan controller
 maintainers:
   - Rahul Tanwar <rtanwar@maxlinear.com>
 
+allOf:
+  - $ref: pwm.yaml#
+
 properties:
   compatible:
     const: intel,lgm-pwm
-- 
2.32.0

