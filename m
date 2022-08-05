Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093CF58AE65
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Aug 2022 18:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbiHEQut (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Aug 2022 12:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240844AbiHEQus (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Aug 2022 12:50:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649E0237F4
        for <linux-pwm@vger.kernel.org>; Fri,  5 Aug 2022 09:50:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b6so1653551wmq.5
        for <linux-pwm@vger.kernel.org>; Fri, 05 Aug 2022 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3SdKoJam1KKdYl+ZS8hBn9qpHaB89KQkUoXzOnMw6QQ=;
        b=ORSNTqW0aszfvoeBRZnTDN41qOivzjx0F7rX23lt1kov76+r+OBDrFaxt4wmwzcWUs
         NKdLH0Fz08LJ5mJJoqiPOl/pmJugHcr/2KcYQI7HlGyMSxxyKMzWyAcOCyr7yini6nsp
         gBDVIqp5Td6qjdC4n5Qjv0I+l/yTc+wTGiOpArRM7PBEpSuHqC14XuCDT8K+Gj7kePp2
         pbYtcsNB5dvDLQITfCgPDEw4vy5fF+J8ZB+UcF4wrB3sRnLcpos4/cwy+RZpsLY4V9g8
         5Q//DmalwDPi7GpYN2Fqtvbl1R3t4Zvw97F2++ubl8a0ykLqKJ+Ut70tt4tsehB1sDrP
         BpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3SdKoJam1KKdYl+ZS8hBn9qpHaB89KQkUoXzOnMw6QQ=;
        b=mdlHPwuugO0puvbLdZBH/OZQsOs2LwgotlnRDi1OMF9uX7qUSxkUYvI0HVqHrn0FAn
         G5ZyX7/NrzBXjrL/1I0KNRKRf1CLty1yx68zN80/a6dnjypqf2ZB+PIzM/AClIdFC6W3
         W3h8RwyYo9l/uqwI9eIQJ1ODRRgbVNo3ObvKsuhoMQY+18ro6krC5w2wBRTxDCmpY2yd
         KNFBCLkFgMk1y910UFp/1GNoZVImGO2hsGvOzs05AccwqZccFyrtWGBtFIHgCgrjfDxd
         dCYx1u5ttFaNhxeyHZmNXjwfgSB7tqRNsGbVbGuGnOGbR7aeQXmjJlTZbIzorQ1w3V1H
         zlVQ==
X-Gm-Message-State: ACgBeo1EPrVrlh20beGTdHiLQoeps2w/5Yt44xeyw78edPocTqAbPTna
        9ywP/Bz9hfMBlXYiRD/8RAF/HWsu8K3x2KIe
X-Google-Smtp-Source: AA6agR4lUviTrRBkbUQ62ydSaj/VkxFS4e7xnlk9+JsVdn5/8IgUIxDpYvwBdHugKNjRyScN4Wf1dA==
X-Received: by 2002:a05:600c:654:b0:3a4:ecd6:9aea with SMTP id p20-20020a05600c065400b003a4ecd69aeamr5370290wmm.66.1659718245804;
        Fri, 05 Aug 2022 09:50:45 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id h28-20020a05600c2cbc00b003a4f08495b7sm11325374wmc.34.2022.08.05.09.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:50:45 -0700 (PDT)
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
Subject: [PATCH 3/8] pwm: move dwc memory alloc to own function
Date:   Fri,  5 Aug 2022 17:50:28 +0100
Message-Id: <20220805165033.140958-4-ben.dooks@sifive.com>
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

In preparation for adding other bus support, move the allocation
of the pwm struct out of the main driver code.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/pwm/pwm-dwc.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index c706ef9a7ba1..61f11e0a9319 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -196,13 +196,29 @@ static const struct pwm_ops dwc_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
+{
+	struct dwc_pwm *dwc;
+
+	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
+	if (!dwc)
+		return NULL;
+
+	dwc->chip.dev = dev;
+	dwc->chip.ops = &dwc_pwm_ops;
+	dwc->chip.npwm = DWC_TIMERS_TOTAL;
+
+	dev_set_drvdata(dev, dwc);
+	return dwc;
+}
+
 static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
 	struct device *dev = &pci->dev;
 	struct dwc_pwm *dwc;
 	int ret;
 
-	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
+	dwc = dwc_pwm_alloc(dev);
 	if (!dwc)
 		return -ENOMEM;
 
@@ -226,12 +242,6 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return -ENOMEM;
 	}
 
-	pci_set_drvdata(pci, dwc);
-
-	dwc->chip.dev = dev;
-	dwc->chip.ops = &dwc_pwm_ops;
-	dwc->chip.npwm = DWC_TIMERS_TOTAL;
-
 	ret = pwmchip_add(&dwc->chip);
 	if (ret)
 		return ret;
-- 
2.35.1

