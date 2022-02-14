Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB74B5CBF
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 22:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiBNVWv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 16:22:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiBNVWl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 16:22:41 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEF413CA3D
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 13:22:20 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DFDE6407C3
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 21:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644873738;
        bh=L1zH491qgS41n2AXbaIQ7HS33ONC7FahLUP0TNtgPew=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=g1peq0p9VsEjouTjRirFrNHgSuXPBgdyQFoaYBv0ajLmpDWPblTNVzCgJRN65Jsx9
         NWwkjW5rXtyD76cai3BKwih44W9jDFcl6pY26ckRFXjQ8tACHNOB45K1A3Wj5Naxsw
         MJFAv1WZI4JTrzkx5O3zA+BrAI5ZGgcd8ujxiEyWAT61anupJWCSMX9KymVLaOVL9X
         j5NYgyeKTjnVFV6qU5RtHGQHw44hdOx1vdse+KV1vR/9WOcJNlsgpRGQVuJtHwUkNd
         jcL8SjzrDT72KGIwtsGCT0tBsJwrZ+PTlnGf3HXsh9Y5+V35AzNguns5A+c+PtypAQ
         9fKX+MST+qXuw==
Received: by mail-ej1-f69.google.com with SMTP id qa30-20020a170907869e00b006cee5e080easo1341140ejc.3
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 13:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1zH491qgS41n2AXbaIQ7HS33ONC7FahLUP0TNtgPew=;
        b=M5n6fN8CY+TWnyUVzLa3s4k1dwYiMTKxkluNAUpaWsmecej+otdRWPquxy8DRUzlHQ
         BcX8bi0TUiO1orOtFUIN8QVWqEccZEYwj1/nuYjV6ZNbbiKNg6grTQJhRQ35XZ7JyIT5
         2oACJwXco5JBcuLN0CnXI/NY8G4Jw+l6PDQKl+m8oscUjnSkd2ZSuHn+iP5O/VaeKodf
         p/0YVd59Mx85Kl9jIaWLvZ1lajjsx4h4U+G/CyeoZzSxH72bJk+o+qf/WnVWsGK2qRef
         s3Ldfpc8FGFkMpVyVVwBI9i9H1OQp6pYLwv0E02/rJAlYeihb4f874FPZS2Em+jUwPCF
         wiOw==
X-Gm-Message-State: AOAM5319BaG/4IJAVRJa8C+WWEl5A1azJRPpDq62aD0CgXtR8UuGI279
        M6eIUFmGnGR5vyFPgr2w28l+9VA3evxG3uU5QAl40FUtCyjDUhIVWLzqkej5af90uyXr6hh44FE
        38tWOCPSgatdDXx0qn3BzCeZXWzYNjW+M99SWUw==
X-Received: by 2002:aa7:dd04:: with SMTP id i4mr764664edv.313.1644873738464;
        Mon, 14 Feb 2022 13:22:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYZT3hfmG99BK+ndmDIe3ewA0JwFYesWd9OClq7wO2HS/MuYgpu2ey6gvbQ4bbF24Sx8ij6w==
X-Received: by 2002:aa7:dd04:: with SMTP id i4mr764632edv.313.1644873738297;
        Mon, 14 Feb 2022 13:22:18 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v24sm2327203ejf.7.2022.02.14.13.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:22:17 -0800 (PST)
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
Subject: [PATCH v2 11/15] dt-bindings: pwm: intel,keembay: Do not require pwm-cells twice
Date:   Mon, 14 Feb 2022 22:21:50 +0100
Message-Id: <20220214212154.8853-12-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
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

pwm-cells property is already required by pwm.yaml schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
---
 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
index ff6880a02ce6..ec9f6bab798c 100644
--- a/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
@@ -31,7 +31,6 @@ required:
   - compatible
   - reg
   - clocks
-  - '#pwm-cells'
 
 additionalProperties: false
 
-- 
2.32.0

