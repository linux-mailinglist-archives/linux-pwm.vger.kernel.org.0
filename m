Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6560A4B43B5
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 09:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241859AbiBNIRa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 03:17:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241862AbiBNIRU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 03:17:20 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DB35FF1A
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:17:09 -0800 (PST)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C4311402DF
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 08:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826628;
        bh=l15FonF8uQEq+4XEYAwpRwWSHHnXgwOoYp02FVF3qnI=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=QSg8zLL2pUEMr9LQX8hkx1a0zd8rGWBaF0mo0oJrh8myim0yQ0j3aFURCJawyhqsH
         P8rIDS/anz2bAujK7AHasW+VDdU0D5AxgjHHXH5oRngWzKGy0WcNk3slqf1hyikRFl
         z/ni8P2cD86CjB6dUalIlcPjzK4mdQ8NqmLSodyVWdFE4wiD8tzxau4VHHYTfK/k2w
         c8PbaJbxFK6iS1OliNc1yBtuPtZjDes/2Lyp40+ZRca8ufho5+kqo7HY0vdROa14W1
         wOW18X5EQmvTkDB4hep5t0YBgwnPep1twaOAJOAC3xUhUWfmJa9/V1rTmPDgFwXy2Y
         6EvK59mOd8JhQ==
Received: by mail-lf1-f72.google.com with SMTP id o25-20020ac24e99000000b004421aff5064so4978820lfr.7
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l15FonF8uQEq+4XEYAwpRwWSHHnXgwOoYp02FVF3qnI=;
        b=IOcS+qoV7qz2shTBUTQgmIL+bgtXz/0Saw2OCUbMtcsLrplGndCu5W5WHr9SB5Xhy+
         HQ35UlhWGzcqgD+4Jou3Y+k8FTRKJe5F+fiEf5xH6eYtnOLktwnWQ/JD0NEkPTQ3oL0D
         1npLC8JPsIKOKJSjPhXQ4ncTgxryIsr9PdWrkaASDpdSmOwi/sXEKPk1f1YiYhtbnczH
         Dul/n6Q1IFZNZ3KDKH71Psy4SDN+bb4yT6rs/7SOwK8egy+OlOvVxBcr9TFDSPaLn4Oi
         GanVrSU+Y8BkB6b03r2dexDaYjy0egjT76QWhV8Tk7hUmCqiXAe4Vyhzz1lyMSTDqKr4
         C3ow==
X-Gm-Message-State: AOAM5304JKlKKgXBjxgk2oYxmvoh0h+vpVsP4bWwt1cEUNu78c9T1JD5
        B+xJUBqYrH8hmPbUGEDafR7yfCddiovcCR8Fi+sLmmDDANoJe3vZAsQUk13s+6HabT1QTq2plpd
        6Es+Hr/t1LbCdNGAe5YirckhS6dhVFTJx59U6vQ==
X-Received: by 2002:a17:907:1692:: with SMTP id hc18mr1264361ejc.558.1644826617896;
        Mon, 14 Feb 2022 00:16:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7ZFaKPSqzJB7EzZe96ipyX590XuNxFjp7kl2szJXL0JpWvoFuFlVeLyW48x6LMwjXS7gpuA==
X-Received: by 2002:a17:907:1692:: with SMTP id hc18mr1264323ejc.558.1644826617720;
        Mon, 14 Feb 2022 00:16:57 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t21sm3363642edd.74.2022.02.14.00.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:16:57 -0800 (PST)
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
Subject: [PATCH 11/15] dt-bindings: pwm: intel,keembay: do not require pwm-cells
Date:   Mon, 14 Feb 2022 09:16:01 +0100
Message-Id: <20220214081605.161394-11-krzysztof.kozlowski@canonical.com>
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

pwm-cells are already required by pwm.yaml schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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

