Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E461259645C
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Aug 2022 23:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiHPVPD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 16 Aug 2022 17:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbiHPVPC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Aug 2022 17:15:02 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149327A516
        for <linux-pwm@vger.kernel.org>; Tue, 16 Aug 2022 14:15:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so1089498wmk.1
        for <linux-pwm@vger.kernel.org>; Tue, 16 Aug 2022 14:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BEOpRioXienSDDf6vjruAkPlsDKDhUNbn1dmZioZ4X4=;
        b=eYefCuC/rgQ6p0YNaYBu3lEQX3Uj5IL6sNCWvehy/NqfbV2p8Tg917eIc4dD2xBV0i
         K6XA3rjwJrLptS3Vz6FWghqV/m/+uSJZOHd3f1V/5Iuu7cyDt+EnKxHLceb//0HzG+0U
         VMAw6kcNGsOyYE+zE8yRUZcMNM1FWfVR2vaEptiW2uiAGrPMtoyMmaT+/xiiBPXVNkmx
         JBx3FNmZxxDxmOSq5XtmfuSRL8YncLD/nkyfu/ji3WjuS3IQ/ekjJFSIRpBSF52V2WyO
         I/IocNCe/7jr1MYPJB/9stcdR3DucirXsphktPY+U+g3ZM3M2LUbFC5e29KVDZIggqNs
         bB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BEOpRioXienSDDf6vjruAkPlsDKDhUNbn1dmZioZ4X4=;
        b=k1OfzM1fyubY+hc//SaNyk4hxmu2Je2GZipeTvGqSvnFnKbmrvbWqwCfp4u2J5p/fj
         m5QNLggkhGvxs5hcNOkFCZdaqi4qpAIjOpNUAyvT9vUbn3Ycbq+5meHrCg3Ku5+YFDQB
         KYNwxd1iy1FgXGuoCPAS0S77bTuhzsEe/UxnRQPa1uzPWZ881bQnOUomwGvIE9mIGzLE
         ZDJwNwqT9xfxc4DMxMEWH4YV2rrq7nwq43C+pYKs1eiOzGeYrh4/lSOK/7tp6LKvjbTv
         sSsOZUdPznS5mr9vtPguC0UrGvxUpO/qllCcvSZOoZYCoca3yME3JivbJDw9dRJ0Y3R7
         oS+A==
X-Gm-Message-State: ACgBeo38FjEwIlS02YDdAtrf9BdHVwBaN/zLLDP6l+y/amNY+u7fKEUX
        +j0PJwOXimabykVP3PvYHakbvooEaxGiVQ==
X-Google-Smtp-Source: AA6agR4x5105693B/mvfnk5ocFtht52wNSb/pOgM+837u+GyY9Nw0+ugNz4CTpZcN8mxWyQV6UPlmg==
X-Received: by 2002:a1c:3b04:0:b0:3a5:487c:6240 with SMTP id i4-20020a1c3b04000000b003a5487c6240mr212714wma.152.1660684499117;
        Tue, 16 Aug 2022 14:14:59 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c4404000000b003a3170a7af9sm23913wma.4.2022.08.16.14.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:14:58 -0700 (PDT)
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
Subject: [RFC v4 03/10] pwm: dwc: change &pci->dev to dev in probe
Date:   Tue, 16 Aug 2022 22:14:47 +0100
Message-Id: <20220816211454.237751-4-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816211454.237751-1-ben.dooks@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The dwc_pwm_probe() assignes dev to be &pci->dev but then uses
&pci->dev throughout the function. Change these all to the be
'dev' variable to make lines shorter.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-dwc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 7568300bb11e..c706ef9a7ba1 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -202,14 +202,13 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	struct dwc_pwm *dwc;
 	int ret;
 
-	dwc = devm_kzalloc(&pci->dev, sizeof(*dwc), GFP_KERNEL);
+	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
 	if (!dwc)
 		return -ENOMEM;
 
 	ret = pcim_enable_device(pci);
 	if (ret) {
-		dev_err(&pci->dev,
-			"Failed to enable device (%pe)\n", ERR_PTR(ret));
+		dev_err(dev, "Failed to enable device (%pe)\n", ERR_PTR(ret));
 		return ret;
 	}
 
@@ -217,14 +216,13 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
 	if (ret) {
-		dev_err(&pci->dev,
-			"Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
+		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	dwc->base = pcim_iomap_table(pci)[0];
 	if (!dwc->base) {
-		dev_err(&pci->dev, "Base address missing\n");
+		dev_err(dev, "Base address missing\n");
 		return -ENOMEM;
 	}
 
-- 
2.35.1

