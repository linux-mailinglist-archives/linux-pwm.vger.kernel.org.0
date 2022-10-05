Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC75F5C7F
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Oct 2022 00:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJEWM6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Oct 2022 18:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJEWMx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Oct 2022 18:12:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CEE83207
        for <linux-pwm@vger.kernel.org>; Wed,  5 Oct 2022 15:12:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w18so19090543wro.7
        for <linux-pwm@vger.kernel.org>; Wed, 05 Oct 2022 15:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JVsjMt/QqWDQIkbN9ThQA44X6Q8M6+q3vjfLdgd5aDk=;
        b=lns6fCmSp1PmCoJBnYkhAb1nQxyf69647ZdqX1ZEZsl0yxpJhWobRqY0R/rhtzgEZj
         KVIoTT60Tv0pIZmmnD9m1I195DBzHzTEMOxrAoWfI5nItLrKzGvaTTVo4TuGA8A/bwgI
         FvgrWLjPE6WSNO7zMIcJD1Dbk2dH4yKS87CRB2Q6aHz4NUP1/OaW4s0QkcFpco4tZKUn
         3GDVX64VGS8OPsMDf9BW8bF+ncgYPOJeZIQvAnnJffEuG8OHg/E+24nQs13P9sDbbPSC
         41g6QzIOh713i2HKRk1UEbxwKUrzreIA0Jfr0gtOGlvY1S1Niqt7u2/jWKOn3DhpeI53
         cZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JVsjMt/QqWDQIkbN9ThQA44X6Q8M6+q3vjfLdgd5aDk=;
        b=5pNR7ETtnDfgdT2BI5PGQxnKrjOt3KuMDS98ZeybRxiVk/mKXvd/Lho1vQQgJotsHD
         Tk2Qe21QI88oeey5avPj/rnhqRXYDv04wyzzWMe3/ndKK9nqw+LC+DcAhJjNLTajhTq+
         rO8V/h36WYNER4LG3TJzgVLzTNK1u06VmJgNKtXLHNwI18RiIZQIo2IvA+wu55vSN2Eu
         kD0gByvsL2g05PLGYkcmQl/hNr8JNVi8xtfIJ8zAiqyfRWjUS19QYmXd1NPjRGNt2kmj
         XD0EqGoI4iuWjOjYuF3ZMbI5CTKVxLrKW2iAscjijzUlJ9yrzYXmmxdHMqZfHlkz8Q/1
         UPmQ==
X-Gm-Message-State: ACrzQf0cZRZwE1EMsNO4ZPZYV4FhvnbuSFYVykkcO82Nfe2D4Lp0dVJ9
        VA4gPgao427ODNxNVVNOExkAQFtq8qKP2x4go/HppiFsGsfl8dojIr6tfeXWExbo80Khbr83pvw
        W561ozRmcWeRXtZbTshizmRCemUiVVX2uNrfI311dahpHSApI/0y1hZZfTcinQiy0kF8rHH6tcQ
        M=
X-Google-Smtp-Source: AMsMyM64144/H+SMQ4cld0JX811x0IsidPU2IR5ZlGuFZbVWusIQE0gBZpA9vl7SFsyXTQungnHxew==
X-Received: by 2002:adf:eacf:0:b0:22e:369:2081 with SMTP id o15-20020adfeacf000000b0022e03692081mr1071029wrn.339.1665007971560;
        Wed, 05 Oct 2022 15:12:51 -0700 (PDT)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id d2-20020adffd82000000b0022e327f849fsm12184437wrr.5.2022.10.05.15.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 15:12:50 -0700 (PDT)
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
Subject: [PATCH v5 05/10] pwm: dwc: use devm_pwmchip_add
Date:   Wed,  5 Oct 2022 23:12:37 +0100
Message-Id: <20221005221242.470734-6-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221005221242.470734-1-ben.dooks@sifive.com>
References: <20221005221242.470734-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use devm_pwmchip_add() to add the pwm chip to avoid having to manually
remove it (useful for the next patch which adds the platform-device
support).

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/pwm/pwm-dwc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 61f11e0a9319..56cde9da2c0e 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -242,7 +242,7 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return -ENOMEM;
 	}
 
-	ret = pwmchip_add(&dwc->chip);
+	ret = devm_pwmchip_add(dev, &dwc->chip);
 	if (ret)
 		return ret;
 
@@ -254,12 +254,8 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 static void dwc_pwm_remove(struct pci_dev *pci)
 {
-	struct dwc_pwm *dwc = pci_get_drvdata(pci);
-
 	pm_runtime_forbid(&pci->dev);
 	pm_runtime_get_noresume(&pci->dev);
-
-	pwmchip_remove(&dwc->chip);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.35.1

