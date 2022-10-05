Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329E85F5C78
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Oct 2022 00:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJEWMz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Oct 2022 18:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJEWMu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Oct 2022 18:12:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5A88304A
        for <linux-pwm@vger.kernel.org>; Wed,  5 Oct 2022 15:12:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so1592483wmb.3
        for <linux-pwm@vger.kernel.org>; Wed, 05 Oct 2022 15:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pOKidRu+yxajr1o110Z9rt8XpJh4zLytmd2a75/kdaY=;
        b=JfTi7Q4REwIMcUKxyjals5QXXaBkiKSjiHGfvVJiUh9pJA4nKbMPndrv+Uf4On0HUT
         yeQodr0ZlNeWkEZ2aDPOZmClKlQV/AETC/C6IfCDGJ0nh6enqCN6Yxj1kypNEUsGgZfJ
         Lcnjnfv7aCTF7jK/BbuIPr6nKeL8ckv1n+MDyNvQjwT2ixTehdUxZL30c312cMrSMpS1
         7frz1ihgRrLgKa9xAHXf8HlbKmG4rR4sn31ZnB5EthkL91DBwcwDih0OwDxOimucmWzm
         Z6P3laNOC1KL9cK6Iy3BzQVkbDqXsuuOXa6TM85ChIRXlzZs/IZL643iQLZV/ivv9vKt
         bNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pOKidRu+yxajr1o110Z9rt8XpJh4zLytmd2a75/kdaY=;
        b=m2erUjMsQ65c9zaaU8QgZ0INtwtMmVuwA5BMa8wh+HoVSCpQIsyIkzwv52yYs8WBpZ
         +kEEPqrkx8nT1zd2gfnC4KbNmCQM0XMO/yrCkG3OTwSZZ1q0kb1Sv9IVNFWqHwubx2b7
         JHaFY+/rnICv8KJsswxhRSKyiiXuxKI757GPR09SJ3mbc5kDw6sIPUAOeBOFyo162JDH
         webcdK/pBnqTL0jmSPlqs3tKZW+Xqj8r9Ddfbra0cpacYocc99ArDPG9RuLQ6Dj/slrY
         DAR+E8FsW/tT/Z9QMzGB7b+4qjh0m9XppPIptaBJzpgsYNbVO9fsgSdepVrOHz/0p30Q
         AyqA==
X-Gm-Message-State: ACrzQf1Q/QR2S3L+yP4mpzSJiOzzaFTbe1pMUSjTwjU6mZ3odga/qf4b
        hHn4yb3xtqUdn1Q0lkVKXLin9ekErApnlGEpO6ixAtTvykXKNFiS1K53YdW5pEz3yO1abeIod/W
        IcH5m1BJDUqrEWku3F9Wt72/g79Zbm+L5N34xExDmIv1bOmZItdMYlLon44u11RTwANqv9uOIY2
        4=
X-Google-Smtp-Source: AMsMyM65hJh6hJqULT8KOjLg6DEY1ebIrG7h+/neOAH34aclmhLTi/wYs2S1O91+peqAakpAjYVZOg==
X-Received: by 2002:a05:600c:1d11:b0:3b4:7644:b788 with SMTP id l17-20020a05600c1d1100b003b47644b788mr1107538wms.114.1665007968129;
        Wed, 05 Oct 2022 15:12:48 -0700 (PDT)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id d2-20020adffd82000000b0022e327f849fsm12184437wrr.5.2022.10.05.15.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 15:12:47 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH v5 02/10] pwm: dwc: allow driver to be built with COMPILE_TEST
Date:   Wed,  5 Oct 2022 23:12:34 +0100
Message-Id: <20221005221242.470734-3-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221005221242.470734-1-ben.dooks@sifive.com>
References: <20221005221242.470734-1-ben.dooks@sifive.com>
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

Allow dwc driver to be built with COMPILE_TEST should allow
better coverage when build testing.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v4:
 - moved to earlier in the series
v3:
 - add HAS_IOMEM depdency for compile testing
---
 drivers/pwm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 60d13a949bc5..3f3c53af4a56 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -176,7 +176,8 @@ config PWM_CROS_EC
 
 config PWM_DWC
 	tristate "DesignWare PWM Controller"
-	depends on PCI
+	depends on PCI || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
 
-- 
2.35.1

