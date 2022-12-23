Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9562765522F
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Dec 2022 16:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiLWPib (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Dec 2022 10:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbiLWPi2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Dec 2022 10:38:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEF537F9B
        for <linux-pwm@vger.kernel.org>; Fri, 23 Dec 2022 07:38:27 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h7so4897124wrs.6
        for <linux-pwm@vger.kernel.org>; Fri, 23 Dec 2022 07:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEOpRioXienSDDf6vjruAkPlsDKDhUNbn1dmZioZ4X4=;
        b=OyISZS7Qk9t7+FnnDQ85qmPH7Q4kMXOvDS6K7Si+TuKJPmpWpRQD9zlJpYs7Cer2qJ
         ZFWrUq5ffQhuCEUDwNmKHeBVDFGgUnAJ3dzhKehZSCDEVNgEFAyhMbh6uxEmibNX69xh
         mL/SAQxcGmilpqWniAHf9b1v2Xw1bnW2pFHaprzQJCJxiEWePQ2LxYfvvR2LeKQsaFkY
         mci5j1/yweXaePewHVd19jqt1Bq5eipQDJxL8YroiK1WCEYdfYOIRIcOdttunVCQeGmA
         QHQgusV1tfMJzNFsF/gjdUv1k5m/hKln05peunk2G4Cao2iESlgYVIJorK6C5Axh5U4H
         ilWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEOpRioXienSDDf6vjruAkPlsDKDhUNbn1dmZioZ4X4=;
        b=YXpZLIoUzOmdM4Ucp4H0AJ3Z8LokXRqqUj3DQJ2qpk/V/3vH36zrHTJz6pXXbJImyU
         kqw8RK2XWkfLOpRHRaINJBEtx0vcfzprU2FsaDlQd7eDbEpjpKSrdmI67mkSQHUHdW2t
         ksjE7biEGzVew7QBTpnrAnqg21wwl+cCTrOBojgLlgA4VLrgnMNynucXntq/UULoPblF
         hVU9KytLDt6zIGCh+x0aMMRnQ6VSNvaUoSWylJ8W1lbllfQYLikCt9iQXVHgJkOC86vK
         rrHSUGB2ZcE1Jw6pVGc2aOzRxXVopSQEX2JBY5RYQNaYGXw18knr/zedK31588a5/KQW
         DUvA==
X-Gm-Message-State: AFqh2koifBf2qEPml4BFXtWRs0lhnRPuWhgIq1XfgOz7fln2qQVNeraE
        i1YlxGcvSYkhfzzjFTkHayw/6a8CgZAOe7Uovo0YOCQ6suII/9crWvLJW8CoBlpJi1tsnhYN7/8
        RjyMoY1yQCUMcpnBR06ZagCabNTIrWGkCDdvqgfcdr5UvrZr76ly7z0IYNUB5xWXzQ/Sxz1vTEq
        EP8Q==
X-Google-Smtp-Source: AMrXdXsl7Njmrz2HYWu9DnqOVotNnuXsBsoN/PpROwbmBBrYuoixwTtK3o4Evy3tC4SOmiVxOgXKtg==
X-Received: by 2002:a5d:5d8a:0:b0:274:fae4:a518 with SMTP id ci10-20020a5d5d8a000000b00274fae4a518mr1697816wrb.11.1671809906235;
        Fri, 23 Dec 2022 07:38:26 -0800 (PST)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id m5-20020adfc585000000b00236488f62d6sm3491610wrg.79.2022.12.23.07.38.25
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
Subject: [PATCH v7 03/10] pwm: dwc: change &pci->dev to dev in probe
Date:   Fri, 23 Dec 2022 15:38:13 +0000
Message-Id: <20221223153820.404565-4-ben.dooks@sifive.com>
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

