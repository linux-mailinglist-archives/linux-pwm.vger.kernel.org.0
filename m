Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7037D399C
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Oct 2023 16:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjJWOkn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Oct 2023 10:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjJWOkk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Oct 2023 10:40:40 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6AD10C7
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 07:40:33 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7788f727dd7so208562485a.1
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698072032; x=1698676832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkwhU2F4TXr5U8/eIVmqKK74gpv3rz72+n1Z9i4NLQY=;
        b=LH/JFoOo4DGpmoRUftCSj1A7BILQ3ApnshBGOzaUYaIPR22+Tqu5vJ5rBdw3zVG24H
         QO7OcoSx30Edxhc83pPnMohQAa5JkozaMOkP22+nQjlGI87gFw3jX9tJVLkbxrGpPnM7
         k6ed4v0deH4rzLManRFpjZ1+DEg8/KRQ1bcFqFimM0SWkSgFTsQ3i3Vl8uWvTzwgJDZE
         FI3GJFbWVIRzx0+Eya2b+Tfvgl4xwdlKTrjPUhTO+D9v/JWTtIIjaXb0yv1iCW68EOa6
         wGexdBbmQyR1TpA1JJ1U5Rtn04BhWvEzl6M5c3Ozx8k1QU6PEci39okSLRD/D6U4stJv
         UoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072032; x=1698676832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkwhU2F4TXr5U8/eIVmqKK74gpv3rz72+n1Z9i4NLQY=;
        b=B6fg7F/vzSQ/eoX8r6ZSGdU0rgcZojGTJ1Nw3Sp8l4JbHGcBCWauPUO3z6F8xCafZ2
         Nqrg8+DzJPkUTfHjM8sk/u/MIA08l1oz42oFOWDpYUwUtpmiiPQh+U+FPxDRNrrz/1/U
         2uu2ciYBCOqK6ZKS3KE/hZYr30RcyRc0xVs2RC2/hHdbRdOHOFY9yYBGPnVh/f7iBdqY
         MMhdEugvdAee0baOlq9UOFG65JigD+QAuv8BkQ/+oyemNTRmVl0m0pSLdHxsbMhafH5K
         QdVdMUYyvSEcsaKnfAicnH/0aN3f/S16+TJjWdGQlaGnXQcH/yg2LZSgeF2Mkjm8nrM4
         pX6A==
X-Gm-Message-State: AOJu0YyUoT2zC4jEbRtsHiklLMGaPl+1CBhbo4SfSXR0pvWWbAyQocki
        muwKF0qDw30iQnjqHNiMB8H/yA==
X-Google-Smtp-Source: AGHT+IFoXaN6pVThre1z/S0bbgU8FS54cZC6t6c+5RXc70MLFec5xoE9QM4x8jGHB1G542vMIjK6xQ==
X-Received: by 2002:a05:620a:1a09:b0:777:74dd:621d with SMTP id bk9-20020a05620a1a0900b0077774dd621dmr9306621qkb.15.1698072032470;
        Mon, 23 Oct 2023 07:40:32 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2725020qko.115.2023.10.23.07.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:40:32 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Oct 2023 16:40:04 +0200
Subject: [PATCH 04/18] dt-bindings: display: mediatek: dither: add binding
 for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v1-4-5c860ed5c33b@baylibre.com>
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
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=938; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=tYxquOkpHCbnFi05aHcxCGsRKb8h7qDvHcF/fXuV370=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlNoXOkwi2U4WCrequXuzYCvok2QkmF3+0zqAfxGGm
 J896eL6JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZTaFzgAKCRArRkmdfjHURViaD/
 oCnO3B16x6z8742sQoq3Qz35HJC9XGKiHeYoOY2xIdc2g7wjcBOLaA02OVr7AbLQPFMJ4zskMA4uaz
 IjSpJd6ha3Gdh4fql86jC1THgW8paGXUOfdna0fEdRXWf/TpfPschReTyn1q6a1YHdByWrYAXbyhkV
 JOOZp7q5szn7Cr+4KUdiAUsdynt83BQMUiWxOf0fwa4+vO/EVy9Ufs9m6xtufJJFGgoEH+UjxHzyrf
 58I40s5RZyWwQo7GAu3VWsqrcMUF/txYb5il27M5gdXSfPH6HbTubmMMBNXMAhm4i9TC172GOCUsXX
 XqCMkDF9xwCbjqPQJgdRR+4Ld+2PpWrTjNEEhf3YGGMV1i2kVJWY4Rk4j5EaNJ3nZvhFng8fnpzwZh
 YcU9lkXwpHD3nfO/9Ll7J7tvDexb3pD5v+M3EsS4ViFAmKogqOXS5Ev99oBj6D5lbzcgB/wryuRK6q
 XGoVJ75TlSy6Yg3XFIMggMWra+1FonABuOdIZx1Zm89vE5/w/MIJ3h4pYuQUSJ6KXdTc7V+nCgGo6N
 BSGnJVYub2dD0vJxKOSqnG2fESwz2kTkO9lcuCYpmW3LkfpxIdfwU0TxKYAmRtGuwsJ6deFOp0NsCM
 SujXn5rcipp1UgI6zjCqhbxOV3FyFENNZ6M3tN9RKHtk0ZN9xiIRoicfSzOA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Display Dither for MT8365 is compatible with another SoC.
Then, add MT8365 binding along with MT8183 SoC.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
index 1588b3f7cec7..6fceb1f95d2a 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
@@ -30,6 +30,7 @@ properties:
               - mediatek,mt8188-disp-dither
               - mediatek,mt8192-disp-dither
               - mediatek,mt8195-disp-dither
+              - mediatek,mt8365-disp-dither
           - const: mediatek,mt8183-disp-dither
 
   reg:

-- 
2.25.1

