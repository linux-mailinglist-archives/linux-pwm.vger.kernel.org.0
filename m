Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE5358AE6C
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Aug 2022 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240941AbiHEQux (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Aug 2022 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240963AbiHEQuu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Aug 2022 12:50:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CF61C921
        for <linux-pwm@vger.kernel.org>; Fri,  5 Aug 2022 09:50:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j1so3905439wrw.1
        for <linux-pwm@vger.kernel.org>; Fri, 05 Aug 2022 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Vd2bnsDvwYK3QZs1/z4/uJM0HKufhSZFOLxUdeVAjx8=;
        b=G6Jq85njjPeRY3sN15vOdG+DjU9Tefc/M8qw3SCWZ9ffVB0UN4rzEOCTCzONvQ2iDi
         soDSuHSh1ccY1fS6Bg5bqYWFCusOe7GJF2JNA+mkf6NoSRrEjbsQZCe5WPcQyj+VsTqi
         4j0HRMRDpSfjoyULvXRcJ3B42XLhoWzinsPzTYzstdIVxHsW2emSdWeN/KUwk6oC0g/R
         4K9Y0XSCcV5nE67o2iXc9k5UosnJQIOYcIGKPi+KApdlNhas5Hpk5y9INdUXQUGoT81S
         XnfPAKCfHTFGe4RY0rPU3L+P71h/npcqP1/wzsVse9KxbM+DcxscwViC8XULb2hb2ZkY
         g0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Vd2bnsDvwYK3QZs1/z4/uJM0HKufhSZFOLxUdeVAjx8=;
        b=6/vVahFqc2tK7w9YyxqXotpKgMM91NLbzY8+Wd8O6S9dy6o8ZjTZqF7pxTcYeBdFkN
         cob5a4ZoBbvxVhQoSREXp3Ny22hgJE4O6BGXXkX/79/raG1UnqPvpKlniHXEjbNKOdUb
         gCQG/9qvz+NNZUTTFazdasggzFpTx7g35qyTajnPZXkKB3yeozxWoW+64YXur6V7c7Yz
         3un885WJmYdJTevdPuFwuQJxyBUxnH11aVot3e6IfyNAh3DIDsGu3doUSwy2fxX6Br2S
         t/2OT34uytXmzQ+oBrJ83XsIh0L3dmXZEdoN0PecKRmacviI+1k/+/fd/u7J+XDaI07O
         AYoQ==
X-Gm-Message-State: ACgBeo1Ij5KhaA85XFIa/49Cn8d43N/CU4n7nv0F2qWLojOtmsKn405Z
        dBWIkBffbtYnHnSigkU0zT+JGvWxSpVR9aXn
X-Google-Smtp-Source: AA6agR5C78I1WPKIFeNtDf+UDUlGcLonrI7K0R0ECqRS6cpCXeJ6kN7M12mEnP4TaGQJ6kWReyPSFg==
X-Received: by 2002:a5d:5957:0:b0:220:79d5:f8ae with SMTP id e23-20020a5d5957000000b0022079d5f8aemr4882449wri.160.1659718247359;
        Fri, 05 Aug 2022 09:50:47 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id h28-20020a05600c2cbc00b003a4f08495b7sm11325374wmc.34.2022.08.05.09.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:50:47 -0700 (PDT)
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
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>, Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH 5/8] pwm: dwc: allow driver to be built with COMPILE_TEST
Date:   Fri,  5 Aug 2022 17:50:30 +0100
Message-Id: <20220805165033.140958-6-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805165033.140958-1-ben.dooks@sifive.com>
References: <20220805165033.140958-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Allow dwc driver to be built with COMPILE_TEST should allow
better coverage when build testing.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v3:
 - add HAS_IOMEM depdency for compile testing
---
 drivers/pwm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index b8717877a524..05718e0faac9 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -176,7 +176,8 @@ config PWM_CROS_EC
 
 config PWM_DWC
 	tristate "DesignWare PWM Controller"
-	depends on PCI || OF
+	depends on PCI || OF || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  PWM driver for Synopsys DWC PWM Controller attached to either a
 	  PCI or platform bus.
-- 
2.35.1

