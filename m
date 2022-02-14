Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BC84B43C3
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 09:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbiBNIQ7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 03:16:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241726AbiBNIQ4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 03:16:56 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E554EA14
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:16:48 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BC60840335
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 08:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826607;
        bh=1xNmK//HjGNaIQp8eaYbachy53dRAmEobraHrPxOQCQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=o3tEdobawI1R8rqF1yzEPyCxXisRbs4PX/sRxzDhDbEUaf5CDY5FgQ7TJGsWYBO8i
         nbFSnTo3ZnB8qhr8tdsVx2odTeXOJI4qzS07n3rYkCbvGmsIo8WCfT5jaluCVJys3B
         4esXek5aOW1MsotWiDerkLb/z1gms5DC8gsmScJpXmS9yIfqKZoBuzTB1X0EChL9Xi
         2du2Bd+eFPvko/9gEMiF3ghPoK2ZLsBAsfgE/YotGczKloP4N9L9XTXbpoaWVIYCVa
         8fas2tF+KEFYvM/rc8EuWaosW6EkHnXFAg+mYqo0Op9QkOPd4XdRIuQtDkmu9SaO/G
         GD0RUekNNzS2Q==
Received: by mail-ej1-f70.google.com with SMTP id la22-20020a170907781600b006a7884de505so5487100ejc.7
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1xNmK//HjGNaIQp8eaYbachy53dRAmEobraHrPxOQCQ=;
        b=FCKiZTcp39HxYxIgmnMF1kZZiDTKFSKrEnxX+/+RdhYSwQAp8Kr+wfDlZCX9moRMMf
         a16+F56uR63v1xsRnYckEZSHZDJ6DxYf4UXoqDLcyJ7JhVyE0qT+wJtgupEtJ5kkSKX0
         71xPLD+isnqgOD6TdKV/pqQQZERCPhcBFYIgTr3RYxntGjLRosY2ovjEHGyTtogyFSDI
         Uo2wUBfk5Pf+70VINtZZqXaUg22tmX4oiLocWes08skihpzYPnH6yghagwyJcMhTAnAa
         SjdLInuHMaHpF3PqYKi5Uy0Qod4yqJKlWrRK0ZYs3eM818r5hGmJlSSvnCI6FhkzF+WU
         tr5g==
X-Gm-Message-State: AOAM5337a4kyikEJUbOxzBR3TH5T2tIzXFwFrjqswu0GlysoEe4tTIHR
        ef/uZfrl+Wd56dA57L7aV7x3bMbkXjZ1nB5L1iYWJDpA6w6qpYMJgEkmQfTB6tDDB1VTy7C04Vh
        2R7w9yc9zWvso8gphq4kOxCr5bh3Qhq3gr6O6OA==
X-Received: by 2002:a17:906:29d:: with SMTP id 29mr3045154ejf.183.1644826607512;
        Mon, 14 Feb 2022 00:16:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFwQjCgryJA08f/ZPqu91gByLS1lXUPn3UYgvNgieSyLAvCFuIrk9GLlp5SVzdDUHhPKf2qw==
X-Received: by 2002:a17:906:29d:: with SMTP id 29mr3045116ejf.183.1644826607316;
        Mon, 14 Feb 2022 00:16:47 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t21sm3363642edd.74.2022.02.14.00.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:16:46 -0800 (PST)
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
Subject: [PATCH 05/15] dt-bindings: pwm: mxs: include generic pwm schema
Date:   Mon, 14 Feb 2022 09:15:55 +0100
Message-Id: <20220214081605.161394-5-krzysztof.kozlowski@canonical.com>
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
 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml b/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
index 8740e076061e..a34cbc13f691 100644
--- a/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
@@ -10,6 +10,9 @@ maintainers:
   - Shawn Guo <shawnguo@kernel.org>
   - Anson Huang <anson.huang@nxp.com>
 
+allOf:
+  - $ref: pwm.yaml#
+
 properties:
   compatible:
     enum:
@@ -28,7 +31,6 @@ properties:
 required:
   - compatible
   - reg
-  - "#pwm-cells"
   - fsl,pwm-number
 
 additionalProperties: false
-- 
2.32.0

