Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38FD6B66FF
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Mar 2023 14:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCLNvl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Mar 2023 09:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjCLNvi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Mar 2023 09:51:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A67B38B47
        for <linux-pwm@vger.kernel.org>; Sun, 12 Mar 2023 06:51:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cn21so8531656edb.0
        for <linux-pwm@vger.kernel.org>; Sun, 12 Mar 2023 06:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678629095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkVYC+wu1aL5ZaMnE/Wfc7AXFtfPa1srDddtutZjKIg=;
        b=PBBLFoWjxELJQdQqoNyC8b9CBEZ06P7rxyzovfxm0JB/Fbi4q/v0iFUED2KasnzcOk
         8p0vSh2PNexacdl0rT66R1xo4xfYHBhAdvmDNLiKo2WyfMimKUWBQwoe+IHH5SR0m8Op
         5kSdKutzy2mg7yXsS1cQJ3DIpek6WEfkWGS8pfFqcWpDJTyT6JCPMym49C0XeekjoH/H
         yXua0nfUOtONQikxtKOV5NK3VLk1evSaoYx4DgxD0liykRfJlkOi5qXTrZXB7DmiQtUN
         llTaSfrEGJiPYgL2KkuOorgc9z2iSasmkoeFWBqb+lg1i0TMkhRlzEbP6TS9duL2rdsY
         AI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678629095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkVYC+wu1aL5ZaMnE/Wfc7AXFtfPa1srDddtutZjKIg=;
        b=1Iyv3DN5I2xwwpikXB1GvE39LkDMee2s7IMgyB9eYCgrJLXLgwgc7Z+t33kO7Ip0M6
         ZyYPBHneMu4WoxfS5e+BKbO0bKItaWh/YJimbmUNEPEiEgquke7ua6z0jAt071hI57PH
         wEWqBiav53kU4l5PdmiLAuS6ZcQ5XTyy+BXZ6dYAuNHnnL7LH388qtt1hac2k02Yn5bQ
         hNKuxZO99QZLLJDZ1gD8Sgx9YHQb7BtIlUb06rE9qjUESDDoUlHayDbzn2fkwCFVC/X1
         bzrGhLoHSmn4XSGV+NseK1i9XzIuq4a7hKci7e2WWtSStR7hbgNcj7yqSUQkCEMBiv6w
         2F7Q==
X-Gm-Message-State: AO0yUKXSjGymUbYSB2flawzk8LkTngqn9VzJI1b83WNtWVEqsGWo2q9+
        x/mk8dsocCXW4VdZOeczoYymWRZMg/uFbj+IzD8=
X-Google-Smtp-Source: AK7set/IuMUxX046CBxVvW3ePmZ3nQnQZMlQCR0hcIwerZxQ/d61QF6Fl9Vbf2CQ3y4g0fuGBg7g5w==
X-Received: by 2002:a17:907:ca85:b0:922:3a53:46f8 with SMTP id ul5-20020a170907ca8500b009223a5346f8mr3960276ejc.64.1678629094817;
        Sun, 12 Mar 2023 06:51:34 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906701400b008b17fe9ac6csm2263946ejj.178.2023.03.12.06.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:51:34 -0700 (PDT)
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
Subject: [PATCH v2 2/2] pwm: stm32-lp: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:51:20 +0100
Message-Id: <20230312135120.357713-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312135120.357713-1-krzysztof.kozlowski@linaro.org>
References: <20230312135120.357713-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).  This
also fixes !CONFIG_OF error:

  drivers/pwm/pwm-stm32-lp.c:245:34: error: ‘stm32_pwm_lp_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Extend commit msg.
---
 drivers/pwm/pwm-stm32-lp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index f315fa106be8..bb3a045a7334 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -252,7 +252,7 @@ static struct platform_driver stm32_pwm_lp_driver = {
 	.probe	= stm32_pwm_lp_probe,
 	.driver	= {
 		.name = "stm32-pwm-lp",
-		.of_match_table = of_match_ptr(stm32_pwm_lp_of_match),
+		.of_match_table = stm32_pwm_lp_of_match,
 		.pm = &stm32_pwm_lp_pm_ops,
 	},
 };
-- 
2.34.1

