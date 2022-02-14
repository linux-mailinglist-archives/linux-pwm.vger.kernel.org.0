Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFAD4B43B6
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 09:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbiBNIRW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 03:17:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241827AbiBNIRL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 03:17:11 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A195FF0F
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:17:02 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AD7C240518
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 08:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826621;
        bh=2POCSk/6TwWTazpis9hGbBMQ4KYz1OTALCTDWqaBti4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=uKfYYfGk8rjS0XOWJqoTPC16mJqDHK5h+c5RcrYvV0mmiMRQr4AW91RBrrigLM6Bv
         oivdvyo8iCqrLFZIz+nMkk8CvyDduF9HbK1pDPsWgmAsRFARTO/nl32HCbxtF/N/rp
         70s5OD+8Yj2G8I7ONp7zB3Vef6vyjwV9BAlepfHwqIV0ZLaqMNBoSjSXEIgTcb5u73
         2HL2UjrKpD02FrIXLB4Qt8b836EtAeakoPoazTqsoT+inH4RrVzbNNZuydnoYu8aOH
         zgUjMuJeDHv2WKBhDWkj49NNvUwJPG81IaVfrkzL+XZ+RTjnOi5bdcLy78tKSAVY1P
         qgVbBy1ThkgeA==
Received: by mail-ed1-f69.google.com with SMTP id f9-20020a056402354900b0040fb9c35a02so9783289edd.18
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2POCSk/6TwWTazpis9hGbBMQ4KYz1OTALCTDWqaBti4=;
        b=1zciZDnGnHX7PRc6mdVfrdUjKCpQRui6HTO4IATDpvmvbbTNAkDNGT8u48O/tflZE0
         SHvVyKjPLF6DaWMKxe4n7nb/zsG4PRuvsv0kr7SjJC5ROxQYJHSsY53pOO+cnYDpV27G
         NNGaJN9q2GI9euWQokMR1OssOTk2f/Hs0JBi11UaqAto07SNIIX24VsqU9F3scYZQNC1
         +pkNlVAVV1KN1w0VDNyJ483MAMv6l4pr/3E+U3hfDrFOkU3WxMMpQXBFl0NsMTnppYY4
         I3MmPLoNkUVu76tXJLDDvg96BhlvavjFbVTlngLpaU6R3MRl+ZIvbQN4CME4xzOjN7PB
         vmnQ==
X-Gm-Message-State: AOAM5330w+QWEjOdAYs7g5jaYB+Ph40zmh/8Nhf0hrM6FuPudeb5SVAd
        Rj0kZdJVC7aEMNCTgriVhVn+JBnQH+VtfCijTtemtkhYNDEqwkWJBPTfqbIUykG0kLFYJB71C77
        cCep4hTIiQkz13Z38zwCsvyZbZE705E8kZTRoQA==
X-Received: by 2002:a05:6402:d0:: with SMTP id i16mr14154271edu.163.1644826610628;
        Mon, 14 Feb 2022 00:16:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzehUJnpv0saAzMdWPLDXiuxxvQr3Bh+VUR68F9vzvxoszvsgh+RQPNbOAs8Fmy07wTsUQlpA==
X-Received: by 2002:a05:6402:d0:: with SMTP id i16mr14154229edu.163.1644826610426;
        Mon, 14 Feb 2022 00:16:50 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t21sm3363642edd.74.2022.02.14.00.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:16:49 -0800 (PST)
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
Subject: [PATCH 07/15] dt-bindings: pwm: sifive: include generic pwm schema
Date:   Mon, 14 Feb 2022 09:15:57 +0100
Message-Id: <20220214081605.161394-7-krzysztof.kozlowski@canonical.com>
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
 Documentation/devicetree/bindings/pwm/pwm-sifive.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
index 84e66913d042..676b2160bada 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
@@ -22,6 +22,9 @@ description:
 
   https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
 
+allOf:
+  - $ref: pwm.yaml#
+
 properties:
   compatible:
     items:
@@ -55,7 +58,6 @@ required:
   - compatible
   - reg
   - clocks
-  - "#pwm-cells"
   - interrupts
 
 additionalProperties: false
-- 
2.32.0

