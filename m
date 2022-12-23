Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C5865522E
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Dec 2022 16:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiLWPi3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Dec 2022 10:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbiLWPi2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Dec 2022 10:38:28 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F6637F90
        for <linux-pwm@vger.kernel.org>; Fri, 23 Dec 2022 07:38:27 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id co23so4907521wrb.4
        for <linux-pwm@vger.kernel.org>; Fri, 23 Dec 2022 07:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaKMC7NJJS8Y0MMlr5K0QsyzZJpC85cOVEafIt4Qty0=;
        b=V1l553I7oXg2C4qHnYmFpqG503sjIbNgnxto6sYHsaO6xODmi2RhQG3hUeJIQMhxil
         ienlHVx59OcUQoZAFPhXm0SvnJzf4HPu05gMUSEw18ld1kIqzuyQUxq+xZZWx7xlC+rz
         yNhsjYUMEzQHfyAHBaYRj1ReZWj+ldX8KfK0aJwMXEQ7UVT77SNAI6YkyfbsznrceyuY
         u55Q0IsrCnclU7f+E+N6Hfrwz9eLkG6yn0sviThtmL7YuPys4HJmiNTRpW31SopmUxSZ
         0JBZrrxWaEfiq8QFob3Ba27uPL+xK4p13H3SoiBwORvRyC2RAwqRBq1+7o6QBy+6U4HF
         1NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaKMC7NJJS8Y0MMlr5K0QsyzZJpC85cOVEafIt4Qty0=;
        b=cBQ2MRIsTdB/JYgsX0uDKjPAuBhFeBMPfbG9LTvOhIrHf8PyKORDwI6h5/h/Yjd3eK
         qtES0L2KbiDvn8HMnOX8O8grZJEvBbVsGHFXxtuXepVtdzzu7k3hwHu4n8AGynbK/o2n
         d3zwrcaSesvuGTITy2fk5ElfzGslsJShE90EbT9kd5aqtE/GM8Su7WgXMn94ZD7guEMe
         sJLxbBNydFDadN7x0de/gJ+EoA1SqFB0v3R9WPsT8BPfRCCvyyrX4ImHHlozjjFrpASP
         X8h0LSTz5+sebSe4+D4ZWMh5GNSqGz/ncMWGJcoM0MdT4Zpk/LAwFCz3bd8mDqzAH+f6
         tWug==
X-Gm-Message-State: AFqh2kpHkDWQ2NyQNH+fEuWpV0pLZSQa5MsVNBePoKrfKKNwyhUZMF+t
        SXqyuBxAXG5P05BjbZhM8fiztCEqunBnSauF0OR22IKJt46BjvfCfIClCVaB9FPa6bCIkdYIj1I
        +vJKFmnYXRbpDrYATfifoc4v7np+nZb6uMT0Tsp86SuwSw7BIj923UlRd3HEw4Jckap4UXupNjW
        ZlaA==
X-Google-Smtp-Source: AMrXdXtsOoK7IIaJwi0rQ/Qg1U1ANupeWnCz12A+frhdNo1KNGXo1GQqy7SEtL7EEzLMqGDMLwRHAA==
X-Received: by 2002:a5d:46c3:0:b0:242:404c:2039 with SMTP id g3-20020a5d46c3000000b00242404c2039mr6729654wrs.34.1671809905358;
        Fri, 23 Dec 2022 07:38:25 -0800 (PST)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id m5-20020adfc585000000b00236488f62d6sm3491610wrg.79.2022.12.23.07.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 07:38:25 -0800 (PST)
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
Subject: [PATCH v7 02/10] pwm: dwc: allow driver to be built with COMPILE_TEST
Date:   Fri, 23 Dec 2022 15:38:12 +0000
Message-Id: <20221223153820.404565-3-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221223153820.404565-1-ben.dooks@sifive.com>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
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

