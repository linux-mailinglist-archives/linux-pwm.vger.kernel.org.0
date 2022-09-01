Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB695A9983
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Sep 2022 15:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiIANzk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Sep 2022 09:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiIANzd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Sep 2022 09:55:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97267109F;
        Thu,  1 Sep 2022 06:55:32 -0700 (PDT)
Received: from jupiter.universe (dyndsl-037-138-187-177.ewe-ip-backbone.de [37.138.187.177])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7EA5C660038D;
        Thu,  1 Sep 2022 14:55:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662040530;
        bh=S/Fwz+sP2OV+s9AizJMsolHEAHaDJPcK93omLyO1qQM=;
        h=From:To:Cc:Subject:Date:From;
        b=RcXNM05FgwGRKfefzMc+c3TlyhYkVm/ErV7nXEhRx1FjyWIUX+vBVuM3THG7Log/X
         wuaaymVOPULdXidN1lcoflZvoljfzYeqIgNla2n8tOjDH+EQC4/Mk29GmECMd9Jy8R
         672g5NtzzAbLtwO+46TIBfhAKHcXYk1dH93VqvTnKJWv7KwdlcM66DYK7Lh1Je5AVB
         BIAIsiGo+OXkGzjZKt5sj4Jmj800IbNZHhrtLdsU9dOYghKz3phsFDC6HK9ZPkNYG7
         ySd9rk9qV3wzlvze1rglpM6wp1emjAMBDwUkrWxBhwRbTGhYjMUJebT72fcBrPzSWn
         TQIZSUpWs7jhw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 2E88A48015C; Thu,  1 Sep 2022 15:55:28 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>,
        linux-pwm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 1/1] dt-bindings: pwm: rockchip: Add description for rk3588
Date:   Thu,  1 Sep 2022 15:55:23 +0200
Message-Id: <20220901135523.52151-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add "rockchip,rk3588-pwm" compatible string for PWM nodes found
on a rk3588 platform.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
No driver changes required.
---
 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
index a336ff9364a9..f946861e3f8a 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
@@ -30,6 +30,7 @@ properties:
               - rockchip,px30-pwm
               - rockchip,rk3308-pwm
               - rockchip,rk3568-pwm
+              - rockchip,rk3588-pwm
           - const: rockchip,rk3328-pwm
 
   reg:
-- 
2.35.1

