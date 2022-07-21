Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B7057D258
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Jul 2022 19:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiGURVc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Jul 2022 13:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiGURV3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Jul 2022 13:21:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7166D2D1CF
        for <linux-pwm@vger.kernel.org>; Thu, 21 Jul 2022 10:21:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k11so2761054wrx.5
        for <linux-pwm@vger.kernel.org>; Thu, 21 Jul 2022 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SXLvUdDnjJEodQJ94faqLUeDy8d1elhS2wljuKyR9r4=;
        b=OSGxsO7g2K40pu0NwLqzvnlUz82CEbFPTvtAHhq0Lt42XIo478IZ0cVHDyZcv3LzN+
         doQwS0X5S7UHIxC9NIByl8mpgfD+9fykQt8oCdaEmU61OOI4m/PpDnv1MosqFBkN+Mm6
         Eah/SZ6SreSS+CWTZNEMdvTvTRoLgblAU2dfyUrMl5tNJESdszbOWXfe3Gd+tsC1mNIa
         V/LZjsE1Rq7iYgiJNcx4XZ1FcwcPBXWrZdOyi6bpWW07Bp7wovr21Nkp97BOPnXf9a9S
         k2mwT8d9r+UvMll3RAl+MpEmvZNnLBOi+1iHTbqB2z5dlGiFL851dRrd2FQgyyixo8v7
         HSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXLvUdDnjJEodQJ94faqLUeDy8d1elhS2wljuKyR9r4=;
        b=u+idPBYmvedgZ5rjNQeNHnnhrgjysqM0wwkC7/yZefGdnDpnTxlZDLsV09AANY+Z/s
         rlBz5yDBrzh+d7AYxfzIH29LAxwu0zeiq/UIYwBxKEGnrFM94SavNsU+aSDyi8R89oLk
         PSOcx1AyO3mW3WdrGE7gmgGZlep/W+Mt7JXEwdyL92l8prpfTvONVpwfNtODaXr6m6uz
         AI/J8NOG2UCfa2C/jZuYojeBG5g8xpJv/sLcjgvHpKz7F9sxJXevSklmJpkKm/JOQsVi
         10YhaVjQ0TpT6NTmji8dyRm3vvyUQ7oVpo+7K6Pfe1d8kL09728LQm7m9OwlIsB/0YzB
         a3Aw==
X-Gm-Message-State: AJIora/UVybcpO3P3JFFZSjzyQzBfDWUmKVPywLqxtTKinsLjdksqc4F
        z0XBJOgI2zYuQvc2FAWJZFb1hg==
X-Google-Smtp-Source: AGRyM1sIASv9vmR7KNGAFsXqp4jOf5Se7BsMQgouD3zNrQ1FA0oeq0+2XKTq6qHLn4chl5q3KOnZWQ==
X-Received: by 2002:a05:6000:1847:b0:21d:c149:263 with SMTP id c7-20020a056000184700b0021dc1490263mr30567246wri.449.1658424086844;
        Thu, 21 Jul 2022 10:21:26 -0700 (PDT)
Received: from henark71.. ([109.76.125.251])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b003a2cf1535aasm2455697wme.17.2022.07.21.10.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:21:26 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     u.kleine-koenig@pengutronix.de
Cc:     conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, thierry.reding@gmail.com
Subject: [PATCH v7 4/4] MAINTAINERS: add pwm to PolarFire SoC entry
Date:   Thu, 21 Jul 2022 18:21:10 +0100
Message-Id: <20220721172109.941900-5-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220721172109.941900-1-mail@conchuod.ie>
References: <20220721172109.941900-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add the newly introduced pwm driver to the existing PolarFire SoC entry.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d14a446df13..c785765c66b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17510,6 +17510,7 @@ F:	drivers/char/hw_random/mpfs-rng.c
 F:	drivers/clk/microchip/clk-mpfs.c
 F:	drivers/mailbox/mailbox-mpfs.c
 F:	drivers/pci/controller/pcie-microchip-host.c
+F:	drivers/pwm/pwm-microchip-core.c
 F:	drivers/rtc/rtc-mpfs.c
 F:	drivers/soc/microchip/
 F:	drivers/spi/spi-microchip-core.c
-- 
2.37.1

