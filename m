Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E01538850
	for <lists+linux-pwm@lfdr.de>; Mon, 30 May 2022 22:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbiE3Uur (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 May 2022 16:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239797AbiE3Uur (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 May 2022 16:50:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D9D7DE07
        for <linux-pwm@vger.kernel.org>; Mon, 30 May 2022 13:50:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p10so16077683wrg.12
        for <linux-pwm@vger.kernel.org>; Mon, 30 May 2022 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WRLXEWGUFXz1TBqCoD7auTBGRZvFHTpsQ7F1lieIRog=;
        b=PPZJ904G27hm3et8x7iWcXR+2/DOL4KKyJom79Uix9p/t9dOJ4Re3i8HZCL6awOhXC
         K2em4pXNPg1gqWJXfNVZHXxkyzc/xyeV5juF4Q3jHi6KMvJPhVkDFiHPPbuxUH1hwyW9
         R8OjDsxQY5UD8m5nQ0Naqlsjn15Sh+M0NZC2G2meVIo8k2WZmKA47nyjMK6vmd1KXqsG
         GLxa6GjNNCQNTz3K9bJmiEWt/20rVMKi+HoO9I2i4cr+twzpGxaI4CLnMmwBF7kchVpO
         qCYpPWCGQ7/neIl3xLAU3nh8SDkg3syGg3ERQVvJpcWXsWxrav9Kv73q92zEN3DuIPqQ
         Ee1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WRLXEWGUFXz1TBqCoD7auTBGRZvFHTpsQ7F1lieIRog=;
        b=faUsknbfNxJMvg2+k+K6lAmmJLM2Zyi/TfueXRFqH+cWl16xc9tduhxTwg/P7YKIyo
         TwNHwmwXJUhfCBPzKf63C4gcfBWdb/X6wkd9Zej61xI4gp6UyjvWriyvQGOA59sRFBiP
         s2mPm3RwMW9XBCKcKAQThK/LAqh5hkxtlvkMYy0DCPjkOmMXGtFdSnRE/avDsXBY7v39
         Tg7UoyNcvKcETyN/DiLOOAbKaKcZ7DAx3g7P60W0vlm5MmnEHULNkd8zOGxBdILuvjN+
         ANKmEUD5xe7pLaSfdAOPPQMMX51rpy+XQtaEtIj1rSjgA+a9epVTUR9yXE6Pv/3vNF9k
         pNxg==
X-Gm-Message-State: AOAM531QmuLo5xhK3kHp2FFAZ/kdpmfkefXlQDTuk9yVx4F/ZWIh3s4m
        rImtm0ifYr+Ola7sba4vbCPe+g==
X-Google-Smtp-Source: ABdhPJzTyqcEeVJTkuWOm1/qdu1c4GOnlwcH/o8Q8LSshlKxF8kh7vxZ6/omdda+4o/u0HAsAvegHQ==
X-Received: by 2002:adf:e691:0:b0:210:2d6a:8a82 with SMTP id r17-20020adfe691000000b002102d6a8a82mr8428567wrm.14.1653943844480;
        Mon, 30 May 2022 13:50:44 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b003942a244f2bsm384976wmq.4.2022.05.30.13.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 13:50:43 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/2] pwm: mediatek: add MT8365 support
Date:   Mon, 30 May 2022 22:50:38 +0200
Message-Id: <20220530205038.917431-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530205038.917431-1-fparent@baylibre.com>
References: <20220530205038.917431-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add support for PWM on MT8365

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
v2: no changes

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

