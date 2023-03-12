Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FC96B66FD
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Mar 2023 14:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCLNvi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Mar 2023 09:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCLNvh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Mar 2023 09:51:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBCA38028
        for <linux-pwm@vger.kernel.org>; Sun, 12 Mar 2023 06:51:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so7594217edb.6
        for <linux-pwm@vger.kernel.org>; Sun, 12 Mar 2023 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678629094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDnsPd/LWUjlQN35JHFuhsEYXZwtHp7Tg6xyrNKkcx0=;
        b=leBUfM+kGmFx3lbw8Ds4LVAFb0egI+bpB6A6mZMS/VNVxu+4LPnPL28e8VsC1XrG3i
         2CAyg+YYxTPz5SkZ1ZbvFBj9aVsaD2i4aG2QkhlrYGx0qWrcFh4P9M9+2byWYonW5fog
         Kc6pcOdb62onyN7rODrAxvycOm0YoDb5yby5JYkvMar5Z81FR+N/XRoNw6ZfT3TRHKyW
         i/Sj5bY6LfKwb3+hyElcwSxDtUmDJzNRmfM8MOxfdk2LrXdUw4h4fEKzeTATAwN8zw0H
         NVIbhrzFARIYBJphMTx+paHb47T1pTPQnIttnaGCTXh77Sxst8zvE0qF9EYk2MR1uArV
         trWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678629094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDnsPd/LWUjlQN35JHFuhsEYXZwtHp7Tg6xyrNKkcx0=;
        b=wBf54jQh7rNPiqZMLlmLiDW1s0HtV9O2QU5ORtSGmfPmt4FkW4teW2nsIelS4SBM72
         5Qgy1KnwtlUiAoqqtZtuVBE7Nn7KFpUWrBtyp6BQqD/5E9Iau5MrsGajCRBgHAhh4qcS
         UvoPPSVwicmoz6eQOYPjPq4wKF9djvlssveFmzsAVpb/eMBPjXv/21ro4ScsGNvJRg3t
         Pr0+x8n94RJXmSsz55abRijD+ftXqo9iY4tBmCnwL9CsYJVkBKWdOdXJfiTeCY6VAfUk
         MkwY6zdBfckRfIncqj7K4FTgGBzoAWt1za/8+bR6sNbFdHeX1KGQyZ2BMeNDAmDMdQ67
         e5YA==
X-Gm-Message-State: AO0yUKUfXDF203O6yKP6T6VayvPEsgR1oZGUfvWehhrNKBoqoHsv4LaV
        PuFFZ5aRmnNR7GlNe1vT1jDnGA==
X-Google-Smtp-Source: AK7set8AeZI1EJibmWQqUYa4b/A/UWGiDLtXaCZSIsf/yj70h2qpSmPI1UJGcprS5rWdcrtwc7TkPQ==
X-Received: by 2002:a17:907:980b:b0:88c:4f0d:85af with SMTP id ji11-20020a170907980b00b0088c4f0d85afmr39938981ejc.75.1678629093861;
        Sun, 12 Mar 2023 06:51:33 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906701400b008b17fe9ac6csm2263946ejj.178.2023.03.12.06.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:51:33 -0700 (PDT)
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
Subject: [PATCH v2 1/2] pwm: rcar: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:51:19 +0100
Message-Id: <20230312135120.357713-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

  drivers/pwm/pwm-rcar.c:252:34: error: ‘rcar_pwm_of_table’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Extend commit msg.
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

