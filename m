Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E99762D50E
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Nov 2022 09:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiKQIbT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Nov 2022 03:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKQIbS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Nov 2022 03:31:18 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4FA2253E
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 00:31:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id cl5so2458528wrb.9
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 00:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oytgHF2zqcFAqvfno9BAcRuH9sB7IOSYWpf50TD+LNQ=;
        b=IOX1MNIfFOdzxJjGKNm86ccX8vijfrRHOHtKg7tU/wrAHJLMFsaXwV0wwJdc6BxB3k
         N99eptiqsHqqwDGkOsSkN9MV2s9XbaKxsmsW9FCAtUIyNXn87MASbOki7zRWcH3xEP1Q
         mwhjqqIoEQxLcQwMX8yko2bBj2f7TDUzYqXyimc4P7yGCjw3um5xXBkn8JLeGG2RxGVf
         JOVuebymfwQpdH5B7D4g8S0E/PIj8YsoNgPZAxJZ/twpvRzGmRQ6g1Du1M0X0gLdhxbt
         DSVh95XBE1Rd9aEC0CQSqmpRSYyb2B8+83Ix58apr+sx/VD+TjfoXqV6KXbSMvNACy0G
         907A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oytgHF2zqcFAqvfno9BAcRuH9sB7IOSYWpf50TD+LNQ=;
        b=JtvozpkbScJPPxiyGuWZ6Zb7Ti2QMxjHn/3rEfkmD7MuxCcljhBYKG97hVpvgHhgji
         tgf5Jl0+bld/u8ABfsd258jzqTE/O6t0+/sJGsPJ/94Mx+LoR57TRhj5z8TWelV2olB0
         jdCjvjSZfe626BVbucy3tekxJPrPZkKe6UW8ZlHbByH4LRWOwFRgsDWz7fIIGDQdsfXu
         qdKuHDmLDSQzL306gLpY0OmsJer4ECjWkRC6JQ+GYNNBySfySAAE2STmsvoegaOKito0
         OkLbzI1NKdEjQ8wnPr/9Llw26iyuDc10b+/sg+d7+nrxAhxBVpJXkzJIQjc5YNYZB/6Q
         dkvg==
X-Gm-Message-State: ANoB5pn7y8nn+cwKYK0T0j8NZtjK2ujwJvWBDVVbFisrjz9IpMp4vO5g
        SQFLSQxV7grtU6wGAhSCwmZiPQ==
X-Google-Smtp-Source: AA0mqf6AfSvDKsPewebSsg9fhm8xxwj34Tz8VGK4JtIaM2c5e1oV9T++ndf3i+XNQ+e3v99zK2jllw==
X-Received: by 2002:adf:cd91:0:b0:230:1a1:ac8 with SMTP id q17-20020adfcd91000000b0023001a10ac8mr781241wrj.530.1668673875668;
        Thu, 17 Nov 2022 00:31:15 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d61c5000000b002362f6fcaf5sm315363wrv.48.2022.11.17.00.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 00:31:15 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     robh@kernel.org, linux-pwm@vger.kernel.org,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v2] pwm: core: Do not create device link for same consumer & supplier
Date:   Thu, 17 Nov 2022 09:31:11 +0100
Message-Id: <20221117083111.1260643-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If the PWM consumer is the child DT device of PWM supplier, i.e., the
same 'struct device' then do not create device link.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/pwm/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ebb2c53ac7a7..7acc87316626 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -704,6 +704,12 @@ static struct device_link *pwm_device_link_add(struct device *dev,
 		return NULL;
 	}
 
+	/*
+	 * Do not create device link if consumer & supplier are the same.
+	 */
+	if (dev == pwm->chip->dev)
+		return 0;
+
 	dl = device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
 	if (!dl) {
 		dev_err(dev, "failed to create device link to %s\n",

base-commit: bf22908680cca3dd9f575335b5d7716d7b97f0d8
-- 
2.37.3

