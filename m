Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA5F4B5C90
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 22:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiBNVWS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 16:22:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiBNVWP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 16:22:15 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EDF13C9CE
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 13:22:05 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3421C4033A
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 21:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644873724;
        bh=Vx5pgZq+wTDk2cXNM++1rpL4of1cb6TeLTw59n/JqH4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=bmLRHw85gqw8wok9EReyAa+vURzmKNoVTAS1Gmmh0QXhzcY4HXzEGqpBSdjwnmpTl
         CwuHKNJMV/NeIGy6Gbl1VT7MrcpcOT7e3buhCka08ugmem9W6Dh7wPZHbvbqC/E0Wx
         MmJuzntmYz0UiMM27SIUYC4ux37SMH/B2OGsQWEkl/6s6yJ7Ac++SQXantgpih5LWO
         j9kIWtBMWS8XHVTONkL/MNE3IYZox5OxVb33TwcukZLBBCLEJSpE4o/NjtRG72obH5
         /MBDtvgYlkUmlV458eOJHUBuV/9s0Ai7PEO1fXjY0dxN8IYKxQa9CSDKlxIknmoOb4
         cabgrUg8bSsxQ==
Received: by mail-ed1-f69.google.com with SMTP id f6-20020a0564021e8600b0040f662b99ffso11050992edf.7
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 13:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vx5pgZq+wTDk2cXNM++1rpL4of1cb6TeLTw59n/JqH4=;
        b=BTBD7XrjtpUoob16NAk349em4MOtk+9IsfhT54nh/+3i579GEdZa/6iAX3FFmBHrDn
         AHWX12zCTBQ5zaxD+491Bqm20Ej5A9xjgdCz80SzxcAwEN2cI5xVVaoKt2puYSg9KYsA
         rlNLMqjZk/PuVUZaluyklQge8R1RRBSkqDnDVJkIB0pi3ZWYckA5JAw9CSAxTgwxZJ3L
         3lELCc8u9JU9k8zLCt+ALD7b+XAo2QuG8Zij+j800rRjbEdfHtaysFZUN0pbzCOOZ+0j
         0XZRBIlM2aOsJ/syFakx5C1ILV/YzPs8eVrfR+gvNzEZaiDFOepW8gVRhen5yYNp9yEM
         8hzw==
X-Gm-Message-State: AOAM532qAzAmbxIqSZs2/J4/Hj5LI9iz8sTgudkpMWEvbpiOCv5OlR/l
        PfsfTT73rbo82/ItMz2NYKHBcNhiJW4VWgnEncmgFkPY8LkBrk8GBPfZBAKrAw3eXDYFIsNlcpM
        HJX9WyY7R66rra6T9+FqLfqOeu65dBsbuUmwuUg==
X-Received: by 2002:a17:907:d17:: with SMTP id gn23mr511672ejc.719.1644873723778;
        Mon, 14 Feb 2022 13:22:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzn9EFz2R0CbHcclhbUA8j9QL+yRr4fQpPA+X8j3jV9fWd1mKh939ozog2RabglBFb1m4mDQw==
X-Received: by 2002:a17:907:d17:: with SMTP id gn23mr511652ejc.719.1644873723619;
        Mon, 14 Feb 2022 13:22:03 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v24sm2327203ejf.7.2022.02.14.13.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:22:02 -0800 (PST)
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
Subject: [PATCH v2 03/15] dt-bindings: pwm: intel,lgm: Include generic pwm schema
Date:   Mon, 14 Feb 2022 22:21:42 +0100
Message-Id: <20220214212154.8853-4-krzysztof.kozlowski@canonical.com>
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

