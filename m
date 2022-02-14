Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91C94B43CE
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 09:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241702AbiBNIQz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 03:16:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241723AbiBNIQy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 03:16:54 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66CD4EA14
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:16:47 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8D4054033C
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 08:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826606;
        bh=05sXSD4PIb8v0ICor9Lwlzw82mhcHvJZHXpVeLkjK/k=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=aLG5u0EEqZ+k+XDmUs8TGF/olqL6f1JhByoVCnw9hRu+TY0pT4ZV2DOs8I59x6qg8
         ev50SgiBio9wxOKqlajm6bSvh+bzyhNPqnpX8rBdCILKEAwMchThCwGOMvVI3+g+WZ
         xpW0yKa6LRzuwzXQeb4lEsWWsR0l8i/aWNIrW6mOFYwob3bGx+qeCaEKd1Fed+SUK9
         OyY0RD1aqUAqOzxENyh8XcwUB1H2ychj+BAtlwVb4dtoEUnwq6eVUlqbvM35Pk//5W
         onEsrVi2pyUH8fk9MRC02LiKDZZQDx9+7Vi97DGDEXBMy2HMEkWB2JrupAm0kcfb02
         Kz9CXUffvolVg==
Received: by mail-ej1-f70.google.com with SMTP id qf24-20020a1709077f1800b006ce8c140d3dso578761ejc.18
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05sXSD4PIb8v0ICor9Lwlzw82mhcHvJZHXpVeLkjK/k=;
        b=goRQMc54fgFAOCyujnUG44PUVKWR7z1Vg6i4Udq6k6m/swfSYiZpGxm8fLxH349fHa
         p7V503zOOaQQDHKk0xK53WelqSa6Qvoz7tn6904ky+rAM4dzSgq+WMtbY1y4loGH617Z
         iEy0CgUMOxW2C7BxcLh8A+sS86+Q4A2oCPZh3PccLzZi2VFjkjfHs3ofJ6u4vzfnjo+h
         WvBqgm/wRStLprIL4dFK3GTGy7rJdZ8lQroe8m4cpGsKuOdB0Yln9TfYokPHcpGYzYqG
         eFjtym88luCYGyylSgKnaaVl0Ayma63qB2eC2gGdIr0L+YrUEgYPwkDUP+WWo0JCCZGV
         md2A==
X-Gm-Message-State: AOAM530tVnpEOmnr5/s6kS9bd8kjdf97qQPbRi8UZeZjayPI5qDKNVM0
        E2s+t5slA3g2iotuHOFSg9nLHGY6ATlOlgF7A1bv7WVVYcxr4LhGZkKYSUKFbnExMlwWuItUjmi
        0pvCOYGbOSPU/TQAqFmKlsiBv5We35zzuttsW8Q==
X-Received: by 2002:a17:907:3f09:: with SMTP id hq9mr10433632ejc.388.1644826606183;
        Mon, 14 Feb 2022 00:16:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+ZKNecHLHlMF1p9Zdz7frO6KM7oerLABDg+IKR8oKqn7czs7ZE3TIi9GnMTbsd5cUpiNWFQ==
X-Received: by 2002:a17:907:3f09:: with SMTP id hq9mr10433614ejc.388.1644826605951;
        Mon, 14 Feb 2022 00:16:45 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t21sm3363642edd.74.2022.02.14.00.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:16:45 -0800 (PST)
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
Subject: [PATCH 04/15] dt-bindings: pwm: iqs620a: include generic pwm schema
Date:   Mon, 14 Feb 2022 09:15:54 +0100
Message-Id: <20220214081605.161394-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
References: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml b/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
index 1d7c27be50da..0a46af240d83 100644
--- a/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
@@ -15,6 +15,9 @@ description: |
   Documentation/devicetree/bindings/mfd/iqs62x.yaml for further details as
   well as an example.
 
+allOf:
+  - $ref: pwm.yaml#
+
 properties:
   compatible:
     enum:
@@ -25,7 +28,6 @@ properties:
 
 required:
   - compatible
-  - "#pwm-cells"
 
 additionalProperties: false
 
-- 
2.32.0

