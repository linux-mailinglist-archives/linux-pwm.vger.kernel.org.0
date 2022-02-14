Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6544B4405
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 09:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiBNIYi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 03:24:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiBNIYh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 03:24:37 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3BA25C4E
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:24:29 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 14D5C3F1E8
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 08:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644827068;
        bh=Y1pkt7sh1u4nhMjpCSj85kjYF7GKoQX1FycUfW16GNg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=mScKK/mCUmuBw3TQsDa2EQjwhB70X6bevcnHegI//cO29kumstvg/70sK1SQgNVxu
         1roFI99Gjyg8ww2eYrPPrEXMuFqUdsyHIn3kaXVyhn3fRztzgGDfN4DxGks7gb8fYy
         i0TX/c9vhm9f+uRArp0WYTkFSYiXiVwpnJXiD1xC89Ytst1o+/KYQ8o4jqgtITq7Do
         chYEM/B6M2RLhcqsQyX5usgGFVxyZr/3D+mjryDylT4zD/4Bu4qd17YGnnYOjrAd/w
         FjInkhqGV/fXb13G4tUANo7HySe/l4KZa+2ppvYZp4ygyNdCrSE7sJ1x1PC3SogCU4
         uiDS5vHjSP08g==
Received: by mail-ed1-f69.google.com with SMTP id en7-20020a056402528700b00404aba0a6ffso9803670edb.5
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1pkt7sh1u4nhMjpCSj85kjYF7GKoQX1FycUfW16GNg=;
        b=OcE41QuCt+8AKuOi24zBmsBf3G6voE+eZGnZd83b4ePRpeTtPPtyQ3U3+az0c3jPqN
         tLxlf9WyVjgm6XCI40nLW20UmwfYdmeE7Fa2+fpze77vguiBLPxnDJZzjgZ+wqXn5ohO
         9JDTIdFq1V+RxlrD2T1tzYRJURf12JZfkyEqd0EyE+OHbRDovd5AhjYzl/mm3MWhBV2B
         zGhn/vPLg9TRQRZwiFA+VN4BMUUXGlZW6Q9h2Mmcg2dXKfXrvVeH2sEqFtmwZ2OA5PzJ
         t7bV88RTAI+88+BDUUBYi7lM6lF6hL6pzSssDXlnuC0XAEOG9tFulygEeg1K6ndz9snT
         6aQA==
X-Gm-Message-State: AOAM532UqjLnF9mUETl3RgovuepulIBJTGJnmggcTlDwjo2LW7BZKyGI
        tGo/bh1W+1HzOe9hkfj4y5mRdU9H63niewfSdzSqPISnmWajLcT0ijArO9cvG+JjM2NNEMoV05f
        +Xx9tpYANfi/UbT6ME8hlrpVDBRRN59d8U0mxpQ==
X-Received: by 2002:aa7:c3d8:: with SMTP id l24mr9023389edr.63.1644827065919;
        Mon, 14 Feb 2022 00:24:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3sWIkomqniJbHGA9USzgWbkd0+vKt73BSCiBXKwRHhK2HxngI2g+YQq0rzs3pSOItOjbAow==
X-Received: by 2002:aa7:c3d8:: with SMTP id l24mr9023363edr.63.1644827065698;
        Mon, 14 Feb 2022 00:24:25 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id fn5sm1363850ejc.179.2022.02.14.00.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:24:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH] MAINTAINERS: sifive: drop Yash Shah
Date:   Mon, 14 Feb 2022 09:23:49 +0100
Message-Id: <20220214082349.162973-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
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

Emails to Yash Shah bounce with "The email account that you tried to
reach does not exist.", so drop him from all maintainer entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/gpio/sifive,gpio.yaml     | 1 -
 Documentation/devicetree/bindings/pwm/pwm-sifive.yaml       | 1 -
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml          | 1 -
 MAINTAINERS                                                 | 6 ------
 4 files changed, 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
index e04349567eeb..427c5873f96a 100644
--- a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
@@ -7,7 +7,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: SiFive GPIO controller
 
 maintainers:
-  - Yash Shah <yash.shah@sifive.com>
   - Paul Walmsley <paul.walmsley@sifive.com>
 
 properties:
diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
index 676b2160bada..605c1766dba8 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
@@ -8,7 +8,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: SiFive PWM controller
 
 maintainers:
-  - Yash Shah <yash.shah@sifive.com>
   - Sagar Kadam <sagar.kadam@sifive.com>
   - Paul Walmsley <paul.walmsley@sifive.com>
 
diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
index 2b1f91603897..e2d330bd4608 100644
--- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
+++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
@@ -9,7 +9,6 @@ title: SiFive L2 Cache Controller
 
 maintainers:
   - Sagar Kadam <sagar.kadam@sifive.com>
-  - Yash Shah <yash.shah@sifive.com>
   - Paul Walmsley  <paul.walmsley@sifive.com>
 
 description:
diff --git a/MAINTAINERS b/MAINTAINERS
index ebf7a75a6bec..87eeac970ca2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7090,12 +7090,6 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/sb_edac.c
 
-EDAC-SIFIVE
-M:	Yash Shah <yash.shah@sifive.com>
-L:	linux-edac@vger.kernel.org
-S:	Supported
-F:	drivers/edac/sifive_edac.c
-
 EDAC-SKYLAKE
 M:	Tony Luck <tony.luck@intel.com>
 L:	linux-edac@vger.kernel.org
-- 
2.32.0

