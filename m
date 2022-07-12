Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDB957165E
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Jul 2022 12:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiGLKBV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Jul 2022 06:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiGLKBU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Jul 2022 06:01:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F947AA811
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jul 2022 03:01:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z12so10426074wrq.7
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jul 2022 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N/5YHVYkMP3FSk3QX5wWOUuw+qNa02mfKY0l3vaai+I=;
        b=AySovvk3fqw+yPROzYVXmrN80AINP6EYyxGVLHxu5IbGL2S7n/MYulgDYMHTAf6Lmk
         4XS+YiRUfoDvfQkR5N6zjxahWi28433Wkf1ff4S6gJ7uYKsgMI4oEED/JmnxTcLw3hfT
         qEtW+4ZkUYDScQbLmIXpBYPpVmFhdsU48Qkpm6TYd8OdKj3VLU9WOvzE3tL8sjW2IdFk
         Piqmeg1iNXgxibtP40ILhdo7zweUt8+43EDUMzJEA/3gqFgg717QrbBHl7cHCcHBkYce
         Oz9zAjP+kpmw08P2dDEi74E+Mli8eFGQIx4SX8N8WDN4oerMzQWMXnaqBVobzRN4moTV
         uRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N/5YHVYkMP3FSk3QX5wWOUuw+qNa02mfKY0l3vaai+I=;
        b=OFeAMuxZyFxxf/444jDE8D8ls5JXrRvcXyZZY0nqCMnB39YS/lQHJvcqO/mZTsMeUq
         YTBi/7j79cck3TiSP9Nzy1BNJaNdiTsuMSrH2trRAr3r+ICpUpjldqPeuO+far4vQGHf
         Ct2t2Hy5HEBB8iM5hBXulg5TyDGxcIPzhcim8zIVxxfDfNfy06DZJf05mwgez3Vgw1Ut
         BEn4Zlf1kUYTz3Gs2B0S3zLxJqjC6Scbq3spo66xGnqaVmvb6azA7+fRh1zWzyBm1WmN
         WO5ZYGCBEzkuXvsikbJPabH00swtuxeigxdm2JJzfKL/5Lyl8XfGvefbHgQjXVRM/ROO
         mYFg==
X-Gm-Message-State: AJIora+HBdWCypZf3NpG7wyprVvHDLXyxcaHEhknR+8RIcO1XbgD/4uP
        OPcHMDnHvZjtYrJXSvpBMf0Qtp3V1LTSoVge
X-Google-Smtp-Source: AGRyM1vh+pSJqS6dzB1374CSARYTt47OGk/7BuqqsIFSKPxyDvna+EC0kzyyC2wVgh0s2KBm5CtAgA==
X-Received: by 2002:a5d:4e0f:0:b0:21d:8ca4:2563 with SMTP id p15-20020a5d4e0f000000b0021d8ca42563mr21549143wrt.272.1657620077096;
        Tue, 12 Jul 2022 03:01:17 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id u9-20020a7bc049000000b0039747cf8354sm8895314wmc.39.2022.07.12.03.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:01:16 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH 1/7] pwm: change &pci->dev to dev in probe
Date:   Tue, 12 Jul 2022 11:01:07 +0100
Message-Id: <20220712100113.569042-2-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712100113.569042-1-ben.dooks@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
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

The dwc_pwm_probe() assignes dev to be &pci->dev but then uses
&pci->dev throughout the function. Change these all to the be
'dev' variable to make lines shorter.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
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

