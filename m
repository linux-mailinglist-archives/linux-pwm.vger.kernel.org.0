Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F020538831
	for <lists+linux-pwm@lfdr.de>; Mon, 30 May 2022 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbiE3UV4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 May 2022 16:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243156AbiE3UVz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 May 2022 16:21:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1B8D12C
        for <linux-pwm@vger.kernel.org>; Mon, 30 May 2022 13:21:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so16019757wrg.3
        for <linux-pwm@vger.kernel.org>; Mon, 30 May 2022 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1vM38OHwAw07wuSGNIKDmB9lfDMUrNeDwo+6N+zaQs=;
        b=rbdYWKHYaxO3Oo8biiJo4zPn/Ul+w5RbkvyVOEB3/4mnXnlGjHkQehTA3Koq7wkzna
         FanKAs5XeFi7bavoqnYVyXkGtIJPIdz1+W1Nm8pyYiizUkUEFFw2pkjPoQl2uq6c9/z5
         nSjTLmzejeBhrDY4LRaF1mPc7TLZboHRNtzkdVCZAYdDl8Tw1T1NXswiZGzXbcHfoePd
         uFR+KgaUg1jZpAie1lzpXFgk/wiMyjpTZdAZ5Dmq3QX0LgO3CAmoNXcqRjRrVBXUeK9q
         othnVsbT+f1fp5rxwduR7JhVfhUemm9rQOBeheHbp9zfpzNfinf4FFdNzteofmqhara0
         hCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1vM38OHwAw07wuSGNIKDmB9lfDMUrNeDwo+6N+zaQs=;
        b=RIAAte/tGp93Ti89C4Qyl4rVsjrIe60JPhswSXRGdD/gw91KtzY8aH36K4ia+Al8iH
         sZ3UaiWtaJFY+58hD4A9wnvpQpWdW8/krCs9LpL9JSlXocviv3zxSpy46gWbOX6US6qx
         PvD6Zr8lAVcdTQ5WAmDbFNGhOpJu8o5NRICwrH7kskzLPtWf1soJu4+QHClAd/wbQ7fM
         qKIjcWqkDD16Xfw3YjnMdtaCjwA6UjSfhDjtCtSfNbK60BRv1a6xSxhl1P0Hv09bEfSe
         lonC2/O/q0oQ4dKLua5qPWllfMzWCSOBzBtF4eCWoJgMW/SgNcCUI++S90jJS3FFz8gE
         622A==
X-Gm-Message-State: AOAM531P1WXKVbTOSyqwtLHTII5IUwqGuyjmAuTGsmN7KyJ7qo2AZhm2
        00v/6GiVFSl5pSSK0HMSHZ6LkA==
X-Google-Smtp-Source: ABdhPJzqnMXzNaCigIjz1GAjTxyI8tshTxFw9D7Ucx2lKOehy+yE5Khqw9vdo4X+p+YlrV2WOmcARw==
X-Received: by 2002:adf:fb04:0:b0:20c:dcbb:95bc with SMTP id c4-20020adffb04000000b0020cdcbb95bcmr47590696wrr.393.1653942112182;
        Mon, 30 May 2022 13:21:52 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id q9-20020a1cf309000000b0039754d1d327sm261860wmq.13.2022.05.30.13.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 13:21:51 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] pwm: mediatek: add MT8365 support
Date:   Mon, 30 May 2022 22:21:35 +0200
Message-Id: <20220530202136.906407-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530202136.906407-1-fparent@baylibre.com>
References: <20220530202136.906407-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add support for PWM on MT8365

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 568b13a48717..fd586bc51c5f 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -294,6 +294,12 @@ static const struct pwm_mediatek_of_data mt8183_pwm_data = {
 	.has_ck_26m_sel = true,
 };
 
+static const struct pwm_mediatek_of_data mt8365_pwm_data = {
+	.num_pwms = 3,
+	.pwm45_fixup = false,
+	.has_ck_26m_sel = true,
+};
+
 static const struct pwm_mediatek_of_data mt8516_pwm_data = {
 	.num_pwms = 5,
 	.pwm45_fixup = false,
@@ -307,6 +313,7 @@ static const struct of_device_id pwm_mediatek_of_match[] = {
 	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
 	{ .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data },
 	{ .compatible = "mediatek,mt8183-pwm", .data = &mt8183_pwm_data },
+	{ .compatible = "mediatek,mt8365-pwm", .data = &mt8365_pwm_data },
 	{ .compatible = "mediatek,mt8516-pwm", .data = &mt8516_pwm_data },
 	{ },
 };
-- 
2.36.1

