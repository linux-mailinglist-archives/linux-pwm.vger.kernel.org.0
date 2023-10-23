Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3B77D39A6
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Oct 2023 16:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjJWOk7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Oct 2023 10:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjJWOko (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Oct 2023 10:40:44 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0756D10C6
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 07:40:40 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77063481352so357229085a.1
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698072039; x=1698676839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qh9PxU4hB2rhg7F6m0ON5sprlF2NLZLAaf9QKMnEl8=;
        b=z/LFXUO1j/nkkF2vKn69H8Z9zoMpqHVeasIXIjeQztHA/DHKtmWT3sXNSFeN8DFDmE
         K1yw8bTJ4NOs5hpYJ/DTbv/yNUXPuLG2YKH7UPKXwV2ELB1VL+NzLto/ev+XTLftvvCl
         vmRJL+f5Q06Kw4nfRdMBmVANX+ShOqH73uEMQDeWPeNyR+WWWyMME8nrkoD0dd8teD/3
         xj8ryOS6/CilpqKrVn3jeJeZZvUeuxtCtKNGo8dZQ8xyZ5iTiviPm+nf8IH7QBmKjlaV
         hWEWALT3l+ZIEd3dAq4h03eyYZOdb1tT1StnD2jiF3YEc7MZP8a+cUkqo31vweNMH2Lj
         DnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072039; x=1698676839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qh9PxU4hB2rhg7F6m0ON5sprlF2NLZLAaf9QKMnEl8=;
        b=KmebtHuK4Xbt7dCNedhrTDs326th26JsDiM7p63JTaoofEApMWHi2T+3MEYnkaFXyG
         MgR9GUFPL/KBoUwD/vusg4SREo/RGAm2teBGxP4v6qhnk5+EEu1O6v2VQ4tyrsUCYpj4
         rCf18TydrebFMwWb70FJ6EmlXCLetVoQEHnskhvl1r00lc69RY5fHK9yrVMlEC++s1vD
         JxUkKClEQ+PN5fj66u/l6doZAoIOYP+rQMF1irFt92qrmedfbYNGYKPQTZ8Fg73t1Qd4
         9Kn6HjhWuVNOMWoBzllk7L5UIAyI1vY/3YkDNHEMwF5oaGcr/jL+IFpMOluXNyA9qpwg
         kJTQ==
X-Gm-Message-State: AOJu0Ywnt+zHZawgIajLBzXFP20kZI2aHwGAEvTFZ5ly/n+2nt+lxKeC
        Jc+CcHvlUyoR7Ma1QKVxz0jwwA==
X-Google-Smtp-Source: AGHT+IGmkh9O1L77tHkFCr0ysnRzrxjRi2acXqt64UGUhhSvN/MH3ee3+LZqnzFy176Ke8Fnz9QwRg==
X-Received: by 2002:a05:620a:2590:b0:76c:a952:c70f with SMTP id x16-20020a05620a259000b0076ca952c70fmr12157510qko.35.1698072039552;
        Mon, 23 Oct 2023 07:40:39 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2725020qko.115.2023.10.23.07.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:40:39 -0700 (PDT)
From:   amergnat@baylibre.com
Date:   Mon, 23 Oct 2023 16:40:06 +0200
Subject: [PATCH 06/18] dt-bindings: display: mediatek: dpi: add
 power-domains property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v1-6-5c860ed5c33b@baylibre.com>
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
In-Reply-To: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=P6NTpV6Hcl2nq4Xnripe5Czc4f+S/tebkAJSAKKZfY8=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlNoXPLAFxugtO1wZ1wc6FF7eR6Teq9Ksq5ScGKNOo
 wQqT5GaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZTaFzwAKCRArRkmdfjHURU8PD/
 9nARfanwZ43dC7K38128J+6s4DtRyTG8Hj37dZv3E61VaZVngol48cTkmXw090pPu59i5eED3Je7Zj
 j23oVIMjIX68q/zeBxDw4f2iBdqzrQpcfbYsEJM/wyt9jzk9K0d41kVLw2EOuf/8CcnISQFn9v0vr4
 Ba3mxWWRTn3rke0AR8IAfs/3OVQrzxbT1/9ZYihMIic0eoBoE0rHOxX1qgAux2bzUPRkTjecZF1NZE
 1t8Y+rNbCXFXtynEILOxuQeYMSudfUWkLJ3DmObNMbbcMvXdcBKq9TWTRn3nu26GnrnyKMyc8lt32s
 +eybrWvI8JX0OlCT3qtGZKq6DjCs/2YiegaxQnAWVQqwQlmbvSy7i182JHCPHmsdYy48fpz5pyAfQN
 tX5f2ghH3h90rmfwd80LH3T5u69lBpIUgNl3xs56SqCZcESvviuxGUEdKZRcWKHHAQlLr1Qx58vfnY
 4swHECrNRS8mQvQk00mISHgkWFE+FGp21hFuG126GPOpCSQetVNlq9Y+vLWL3hTuYAJTtcsOPFdm2I
 pfljEC21uDHrwGEdXicc8Nsm6w40nIkw6t71siqyx0vgQ8PchwCecgKZWz/2yuqO2XlOaICRDtbhU4
 4Cn75XRdTzR6Ax/7Q/RCVx15kQa1IubAdplkKWdvRb+g07dHmShLPZJgHFTA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

DPI is part of the display / multimedia block in MediaTek SoCs, and
always have a power-domain (at least in the upstream device-trees).
Add the power-domains property to the binding documentation.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index 803c00f26206..e126486e8eac 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -64,6 +64,9 @@ properties:
       Output port node. This port should be connected to the input port of an
       attached HDMI, LVDS or DisplayPort encoder chip.
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -78,11 +81,13 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/power/mt8173-power.h>
 
     dpi0: dpi@1401d000 {
         compatible = "mediatek,mt8173-dpi";
         reg = <0x1401d000 0x1000>;
         interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
+        power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
         clocks = <&mmsys CLK_MM_DPI_PIXEL>,
              <&mmsys CLK_MM_DPI_ENGINE>,
              <&apmixedsys CLK_APMIXED_TVDPLL>;

-- 
2.25.1

