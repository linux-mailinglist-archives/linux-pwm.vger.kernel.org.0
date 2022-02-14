Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278574B5C9F
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 22:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiBNVXI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 16:23:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiBNVWw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 16:22:52 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2377D13CEC4
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 13:22:39 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 02CAE405EC
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 21:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644873758;
        bh=nq4ij651Faznv2JZt1q1SNPJWaeI5lkTeLdPO5VR/U4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vx6GJeXVpMQQvLNJLdF5BNo9T0Mp5/LXWJkNaE22nPC1HRpJnkTkiXyP1IjyTZD6Q
         MC5lhg+YQBdl50omVKRr+vx6pLd/S2rsPyXdGlGfvsNS9quyYL5OfBvAtUQRpyuIgK
         a4ZMWYYmiFmBv9LGeOuJHNsmxl9miWFX4UEI7xxRNSsjvb2tyLatwLcysO8wn007Fv
         UR7srekzKQsfFq8LIn1O8ZF7MM5VE7cEcV6JIGhOItrsS79H2h+VY2QejG9gyGZyGM
         uh5R0IOC08dUhTRE6QDW3qpu2Xy8+X3Mble682IxdBiHc0KkzOe5xCJzfeo/apJRJo
         HtMaQUgTCbR4w==
Received: by mail-ed1-f70.google.com with SMTP id n7-20020a05640205c700b0040b7be76147so11055745edx.10
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 13:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nq4ij651Faznv2JZt1q1SNPJWaeI5lkTeLdPO5VR/U4=;
        b=3F1VMYeE+XUN8sZWg79bPkoEUhWS25mj2SUgBDumUgWxZpnTCKVp2DCYyGn0qA59rE
         nM6IaFeE9vqFDxAK2JOdehD8FqO3atSciKcak+/rZ/6Ni3C0TZkJ6ZNSV6tiGb0m7DlA
         qqt3z5Fz5KP1kgLm633sSbjDsUuKIXNuy7///REyui5BlGZ2HrGmGYKbo9UUnBehYuh+
         qBE+8D7r/S/asPZWUvQ3/ZNj21ZuPKgMKCFu8ezaNmMsItM9ga1nuvA3guHLasEa5bgk
         ofn+Jp+R9IKoBWN/ifIZJDyOeOwJOLQqv3KHM+LKmlgjYhe+o3XPRCHiji0+cbOGnHkK
         xkcw==
X-Gm-Message-State: AOAM533AmsmBtmoglWQgdQGNcSM/2NkLxmdZKfoqyawhnriH1Ri4fTzo
        BCwfUCkyOpLTYoelamHbvAH6QcbrGxkils81l37qjg9dKQLGrd4Az1RkNFxQkpThQP3HFYLoU4H
        RC9G8HLntEsMPrX4t0dH7UguXgXgq62QOjhdsGw==
X-Received: by 2002:a05:6402:298a:: with SMTP id eq10mr800852edb.71.1644873746915;
        Mon, 14 Feb 2022 13:22:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz80Pl7KOImaUzcJEjp8kENwO8sBpFHNKeJMvOW/i73kktJXPrP1OEMsEJv+HrKWeHE8aPXYg==
X-Received: by 2002:a05:6402:298a:: with SMTP id eq10mr800841edb.71.1644873746761;
        Mon, 14 Feb 2022 13:22:26 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v24sm2327203ejf.7.2022.02.14.13.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:22:26 -0800 (PST)
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
Subject: [PATCH v2 15/15] dt-bindings: pwm: renesas,tpu: Do not require pwm-cells twice
Date:   Mon, 14 Feb 2022 22:21:54 +0100
Message-Id: <20220214212154.8853-16-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
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

pwm-cells property is already required by pwm.yaml schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index 1f5c6384182e..c6b2ab56b7fe 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -68,7 +68,6 @@ properties:
 required:
   - compatible
   - reg
-  - '#pwm-cells'
   - clocks
   - power-domains
 
-- 
2.32.0

