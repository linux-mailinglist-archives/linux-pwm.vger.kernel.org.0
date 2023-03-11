Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6377D6B5F3B
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Mar 2023 18:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjCKRjO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 11 Mar 2023 12:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjCKRi7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 11 Mar 2023 12:38:59 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BC31DBB1
        for <linux-pwm@vger.kernel.org>; Sat, 11 Mar 2023 09:38:15 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i34so33006394eda.7
        for <linux-pwm@vger.kernel.org>; Sat, 11 Mar 2023 09:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0p0qqpSJoTCtFb+Kr7i0GNnHTIvTQKai2vdNlxuKcM=;
        b=WK3QS4sDwcl1MqsLZ8ZlJxBQN83C2NF1ZVUas7Zl16IihZuW8nnIiAdMlXVMQstawm
         aSFXBEdoeRHAIlLChzTvHtvDu26dyUkunrmDxTMVkpIkxs2BkyC5bOVJyCR0YxQLFJSa
         x/depFRKep/anvIBotssZD8NTUXO1cfEOd3ZXEFJ+un3wIKGeIS6yibWWrSKqBTEAjOl
         jMN+Ct87AroeiHIqPLojAgVZZ733+E8IUZ9Ap1uT5gT3PezCbTk4W3g+bIL9RAnHRdMV
         S8ODEW3VD0b9RaZmdAiddu87FtWTOM6/TrhR9jBcOi7tV9E9yJruCRrsSBcqNiHs7KPm
         6nxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0p0qqpSJoTCtFb+Kr7i0GNnHTIvTQKai2vdNlxuKcM=;
        b=KVjppT1QPssvE2nL2C4Bt2hbKfTr4C+GQdzOX+G7XrADRJ+/Bp3+/SdG0g+ue1mDVD
         2P++wmAkwhCiis6I2DWIKhADfPgztG4ux4YEyZFoaDKsPN+hPtD5Dmow3wZEUCpPy7kE
         vqfqVNcnzLsklVAxPvb2hf+3G9+va34PRLLmiVVbqdTeJc8Ofc92rkvVroz3XrUpcOd4
         QZcIAXkGaJPN2EqQNN3/Pjp1Ns9/F0dC/ivQtfW5/FFdpoE8aw60+WplALoP4HEUjOlx
         LDAXwDf6a3Qfnsu/F4QT5wOk/w7ShjVxPHdSL/Ygf31y6VKGYlMXfyq8zDjTP2oxYcVA
         fGbA==
X-Gm-Message-State: AO0yUKX7TsNMMggu1QtkIcFIZhyOPGt65zcB7GLkZGY1CI4u7FSm053A
        ZabiobhneIPvbnDR4xLLdSBK7Q==
X-Google-Smtp-Source: AK7set8RZc0nvHdqJFDMyISOImOTBaMDNv5a9BgnTgUHSP/vQIbWUHqUGpilsm9lUqmtf3eDSf0ZFg==
X-Received: by 2002:a05:6402:10c9:b0:4f9:9be3:a538 with SMTP id p9-20020a05640210c900b004f99be3a538mr3722729edu.13.1678556257370;
        Sat, 11 Mar 2023 09:37:37 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id k15-20020a50ce4f000000b004d8287c775fsm1444903edj.8.2023.03.11.09.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:37:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] pwm: rcar: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:37:34 +0100
Message-Id: <20230311173735.263293-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).

  drivers/pwm/pwm-rcar.c:252:34: error: ‘rcar_pwm_of_table’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pwm/pwm-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 55f46d09602b..8f31f3cc93d5 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -260,7 +260,7 @@ static struct platform_driver rcar_pwm_driver = {
 	.remove = rcar_pwm_remove,
 	.driver = {
 		.name = "pwm-rcar",
-		.of_match_table = of_match_ptr(rcar_pwm_of_table),
+		.of_match_table = rcar_pwm_of_table,
 	}
 };
 module_platform_driver(rcar_pwm_driver);
-- 
2.34.1

