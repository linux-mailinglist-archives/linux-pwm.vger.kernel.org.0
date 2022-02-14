Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B7C4B5CAB
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 22:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiBNVXD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 16:23:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiBNVWv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 16:22:51 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F180713C9EE
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 13:22:34 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A1B0A402E0
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 21:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644873753;
        bh=2GfdITO+DKwVQsf6qkFkxVmUjntYlwpPLBCNaZvP8rs=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=m1X7d+8qIxx387qBBt7rW2xg0H+OgnDdwTWiLSPrKYi0AnyrU1n/NSJjqC4Ya6PXL
         rKwHNz9JgE36D+uqA0Z7ftM9f9hTP/kIe8OaX+W6xr7P8ooxIK+SvarvVnbT4zC0Mg
         lWtTeHfGGA8kcSk16iPMV5I46D6/RFa3yVgXthHab8rSqpNkWG3b8XGhLxR3nxHiVM
         U92b+6juO2JgfiJfdg8FAR0GK2qjj27NY93JQAfKo5vCBfR3e+t/6PojfbUHxzIxCq
         MSdi02I8jqMHVOJIW5n4eH6ATtECgKc++VhEPbjIbVBKXqUhuC42joF843Qyw1bprz
         Rmr2wfYfCo4ZQ==
Received: by mail-wm1-f70.google.com with SMTP id i188-20020a1c3bc5000000b0037bb9f6feeeso225356wma.5
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 13:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2GfdITO+DKwVQsf6qkFkxVmUjntYlwpPLBCNaZvP8rs=;
        b=JLy9TgvdnI6HodG1cg9QC7PcOQa5ssOrk2sz2iIoG+QjY7zg3bZVEUVHFKdrZHy5sn
         v5zMj1+Tb6VfkKFmJG9bLDRgiMckXdmwmkQx9lwvXRsmtFKPKsbKMWtuOom+zePz/Eam
         Y3VsDcnpl7xUIt7w6Vj5ilJEk7YvTV0lINwsE0Cs7M+abqquRTiL1L1K19atmmUoVAGq
         v9P9jGS987qdvtXNxIGaja6dDVZn1FzdSqOqT8/HglVT01FZIovktnr0YJZx2gyWoEST
         T1fJE1ZqzN4/Ok9S90blqQFIf6Gns9pbAPL0lT2blcP7vNGlXO6wBQmpez4la1LVxtj4
         CM9A==
X-Gm-Message-State: AOAM532lxmJEwBdrZjhHjTaT2cRYJlzlDTlUq8fPpMcRf+8mQcTLvwRx
        aoO0A6RmEt6l5XOhSX0bSrhphHu9akGSdFjnTlxGKic2EVR7+pY504LriHUY8TOOWaGZLT0+wuQ
        At9Cj1Tik5aFQ6no7rcbf+Glzfs9Eis++pVhChg==
X-Received: by 2002:a05:6402:518e:: with SMTP id q14mr795783edd.155.1644873742483;
        Mon, 14 Feb 2022 13:22:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxF3h26z/5uxDbEq+54Opag5L4k/zFtMBfvScttTAdV5Yv9njK8Ir/cF1x90gGCn8KuufGFTA==
X-Received: by 2002:a05:6402:518e:: with SMTP id q14mr795759edd.155.1644873742300;
        Mon, 14 Feb 2022 13:22:22 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v24sm2327203ejf.7.2022.02.14.13.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:22:21 -0800 (PST)
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
Subject: [PATCH v2 13/15] dt-bindings: pwm: tiecap: Do not require pwm-cells twice
Date:   Mon, 14 Feb 2022 22:21:52 +0100
Message-Id: <20220214212154.8853-14-krzysztof.kozlowski@canonical.com>
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
 Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml b/Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml
index ed35b6cc48d5..3840ae709bc6 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml
@@ -47,7 +47,6 @@ properties:
 required:
   - compatible
   - reg
-  - "#pwm-cells"
   - clocks
   - clock-names
 
-- 
2.32.0

