Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4821B622AB1
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Nov 2022 12:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiKILhn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Nov 2022 06:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiKILhf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Nov 2022 06:37:35 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE922C65E
        for <linux-pwm@vger.kernel.org>; Wed,  9 Nov 2022 03:37:31 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3D615423E2
        for <linux-pwm@vger.kernel.org>; Wed,  9 Nov 2022 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667993847;
        bh=PUPJbzepJx5AFbllHqJhTSHtk/HwYip0Muk/9EDtYSQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=pRVxIMH/k1z9d5jMwhUNJcWhZYrKmf903e+QjDs/KfEfMYtyp7l2sx/Bb7LLDq7sS
         Er+L4tV4ew2uY5tdtVd6k3MGvfRVce2keEX6Y3Y+XMoiqz25c/hsy1g1jaV0j00Wnc
         LzYGPWLc85M9xdjEBvLh+EcP//9FoxvMtyg/hYmej3C09PaGd76bTL4O6WGVMGKiDv
         qOETeeLmExWq2ZIzFufzNh1VLrNmTSmRQJTC60v4zJq1q3xF8Ji2MPVGaNuRwq5vs8
         Rqb01Tp+GoasQwVO8cp29oALspwB1nTacVDekjTB2zw+B64ZLndQQMvQmiZS4CSr3N
         sw/AQUKCfaJww==
Received: by mail-wm1-f72.google.com with SMTP id m34-20020a05600c3b2200b003cf549cb32bso903487wms.1
        for <linux-pwm@vger.kernel.org>; Wed, 09 Nov 2022 03:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUPJbzepJx5AFbllHqJhTSHtk/HwYip0Muk/9EDtYSQ=;
        b=3ee4uaPGaOQ2XfPV6IsgnvR8SjQioVmSBB378ZmOfClt6kxqVci2FNAYm4ALHLQufi
         ox9j7sZ+8q7yj1vCdcRk+O2joYmskVHK+6zsT2IF65afZ9alEq7RMG0wE7fdwCRI1TDi
         XaccBfzhJRyW8qGNCvh8c3j0ZvqI1EC6YAE1Ac6nnqAQuSvmDWPc2Q55sFud9c0kVTfQ
         jpiyNF8vxbw4inGaMHqDE/SADt304NsSYS1lmwIH/AytLbLOsQTUMIKmVysbhVrJyVzp
         P8WWbOt+1TwkEKq4iJiLUEde652JpSbVPM5NngGAUzQPLtgIBDxoOZZGL3SKKzAg1NQS
         Nn7A==
X-Gm-Message-State: ACrzQf2TNBN7xkysT+EjvWvatqU/8/iXdxELxNOaN3jqyEwkHt5qZdMO
        uv3ygGW7Yxe1FVtA0tPoz7/kJGnCOYVWjrkRzTcRO4kP3Q01E3b7C1iWmjJGr0QJObf5YJIWr5q
        lUTdIHlxuB8PUy9ry77StlKeYrbQPuz8p1PPbgQ==
X-Received: by 2002:adf:dd88:0:b0:236:57e3:fc86 with SMTP id x8-20020adfdd88000000b0023657e3fc86mr37599037wrl.493.1667993846676;
        Wed, 09 Nov 2022 03:37:26 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6NtbE5g2zTudkMZu+AtZfvOOIrFo9uWBtwl+NVJp9Bq1Dv1FfXdNKK8Djewf5xz5JNHgBBSg==
X-Received: by 2002:adf:dd88:0:b0:236:57e3:fc86 with SMTP id x8-20020adfdd88000000b0023657e3fc86mr37599028wrl.493.1667993846479;
        Wed, 09 Nov 2022 03:37:26 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b003cf6c2f9513sm1487261wms.2.2022.11.09.03.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:37:26 -0800 (PST)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>
Cc:     linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pwm: sifive: Always let the first pwm_apply_state succeed
Date:   Wed,  9 Nov 2022 12:37:24 +0100
Message-Id: <20221109113724.519021-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Commit 2cfe9bbec56ea579135cdd92409fff371841904f added support for the
RGB and green PWM controlled LEDs on the HiFive Unmatched board
managed by the leds-pwm-multicolor and leds-pwm drivers respectively.
All three colours of the RGB LED and the green LED run from different
lines of the same PWM, but with the same period so this works fine when
the LED drivers are loaded one after the other.

Unfortunately it does expose a race in the PWM driver when both LED
drivers are loaded at roughly the same time. Here is an example:

  |          Thread A           |          Thread B           |
  |  led_pwm_mc_probe           |  led_pwm_probe              |
  |    devm_fwnode_pwm_get      |                             |
  |      pwm_sifive_request     |                             |
  |        ddata->user_count++  |                             |
  |                             |    devm_fwnode_pwm_get      |
  |                             |      pwm_sifive_request     |
  |                             |        ddata->user_count++  |
  |         ...                 |          ...                |
  |    pwm_state_apply          |    pwm_state_apply          |
  |      pwm_sifive_apply       |      pwm_sifive_apply       |

Now both calls to pwm_sifive_apply will see that ddata->approx_period,
initially 0, is different from the requested period and the clock needs
to be updated. But since ddata->user_count >= 2 both calls will fail
with -EBUSY, which will then cause both LED drivers to fail to probe.

Fix it by letting the first call to pwm_sifive_apply update the clock
even when ddata->user_count != 1.

Fixes: 9e37a53eb051 ("pwm: sifive: Add a driver for SiFive SoC PWM")
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/pwm/pwm-sifive.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 2d4fa5e5fdd4..b3c60ec72a6e 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -159,7 +159,13 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	mutex_lock(&ddata->lock);
 	if (state->period != ddata->approx_period) {
-		if (ddata->user_count != 1) {
+		/*
+		 * Don't let a 2nd user change the period underneath the 1st user.
+		 * However if ddate->approx_period == 0 this is the first time we set
+		 * any period, so let whoever gets here first set the period so other
+		 * users who agree on the period won't fail.
+		 */
+		if (ddata->user_count != 1 && ddata->approx_period) {
 			mutex_unlock(&ddata->lock);
 			return -EBUSY;
 		}
-- 
2.37.2

