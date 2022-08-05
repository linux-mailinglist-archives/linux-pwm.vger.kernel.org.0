Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDD858AE61
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Aug 2022 18:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbiHEQur (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Aug 2022 12:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbiHEQuq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Aug 2022 12:50:46 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036E11BEBD
        for <linux-pwm@vger.kernel.org>; Fri,  5 Aug 2022 09:50:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z17so3878843wrq.4
        for <linux-pwm@vger.kernel.org>; Fri, 05 Aug 2022 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=yFyYh97IYuVooEC2yIKQXKO7OyDRqCyKCP13Fg1c4I4=;
        b=NrSGXLYMebNqXf4mU8+m7aQGcgnArFz4n1QpBagkao3kWUCAU04iwwHRMQSQgSLRnA
         O6JZq2cAbUId7q9FI+VJ7B0zBBTnKdO5gHSi2xR2O6YmVMJy/Dms3bdz3mKJ9NP4wJ4p
         jQbz4SbEwslYi7JXN1D6aAsyqXS/iIcyTaWd9JoXidiTzl3RX9rk9h1b89GzdwVfEs71
         k8qMK0e+mZC9xZgu9Kfqw/t2VAemEk+B5Uvupf7OE45Cslih9jEOFZ/kcfdrht719rOF
         IMEaHJ+6IEuLG120BP9BJLvhjCBHb1LisD0wGsnZ4E2+Q41UzWuhM+f1YZk+HB8VG87O
         hfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=yFyYh97IYuVooEC2yIKQXKO7OyDRqCyKCP13Fg1c4I4=;
        b=q9TPlBFBgcr7YaZRL9LMZuHZ9NLEqVX0y8N7Q8baATnhLTrlDaMEQLdeOBagVdx3Zo
         0T7SDW0TAUVXU68TK3tXGidqF+23/zKWMaJgrpDgxIQ24AswlQYt8GnbzUc6pvxKGDRX
         EUECEl1ER1uxOZOOpkfJBDbIAs9S77zvooguEqtbNi4mPS/iGrIk0PV+GcDAt9AJCfxS
         ywne4+XtDA0o+ciIoF4xpdpNaXKs+NMEgPHwIEmIINttpderNOfH+wnOHIhQXOsXJFxw
         aiBXfHqsbleUTFnEN+s4kpFjVNspZrBjZn15q7/mpN55kNE8nxwVm8dH1WXeKI9zS+Nk
         lMSA==
X-Gm-Message-State: ACgBeo3jMiRiLQX5rxDVwC5otstTYmFtkDyrw+tRS1YBO4ZLuxvL+JBC
        cMJywyv/1BY0Rb0RlXANbMeVXYyJwKEz+dQv
X-Google-Smtp-Source: AA6agR7rP8RAt3poO3DgHsTL5x3vNMfPJ30328j41H5hxzzcKLK2RonYR5W/ky83T7ZtboO9xdeECA==
X-Received: by 2002:a05:6000:178e:b0:220:635f:eb13 with SMTP id e14-20020a056000178e00b00220635feb13mr4940675wrg.634.1659718243421;
        Fri, 05 Aug 2022 09:50:43 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id h28-20020a05600c2cbc00b003a4f08495b7sm11325374wmc.34.2022.08.05.09.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:50:42 -0700 (PDT)
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
        <jude.onyenegecha@sifive.com>
Subject: DesignWare PWM support for device-tree probing
Date:   Fri,  5 Aug 2022 17:50:25 +0100
Message-Id: <20220805165033.140958-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
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

This series is tidying up and adding device-tree support for the
DesignWare DW-APB-timers block.

Changes:

v3:
- change the compatible name
- squash down pwm count patch
- fixup patch naming

v2:
- fix #pwm-cells count to be 3
- fix indetation 
- merge the two clock patches
- add HAS_IOMEM as a config dependency



