Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A234927BB52
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Sep 2020 05:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgI2DOp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Sep 2020 23:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbgI2DOp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Sep 2020 23:14:45 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2DCC0613D4
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2020 20:14:45 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id b12so901496oop.13
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2020 20:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIlNUdxEGSFfbjWcNq+Z8ZxMTaW9g2NynmJ/obF8AgQ=;
        b=mGfWybiqpo/+BrhDH3wbskXWUEmVWqQeaqKnsahJR0v2pBENUUFj2RYd3G5gp0PSCx
         sFMB1WK0xgviJ/z2xEMtdIsztAzQWvUCTFRw2KvKY7SoqFW8wReoewFyKFlYha5eahcH
         R43nPzuBtwYUoZQT0QeoauXi+/kNKLLZhDUy1aHUiNPwoMJGetIGkGQjt3o7Vzacybz1
         sZGO8QljsHqNE9qp20NM/wGj/F9zFh62/Csac+J9yAAib14yCK0vL4cV/wGJzoXN7IGM
         hLblDXr7IyN2xMnFi4c7zU2OvLAyV524hQyo7Winw1oM8+onFjdeGanapKp+bjK1ERpq
         U1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIlNUdxEGSFfbjWcNq+Z8ZxMTaW9g2NynmJ/obF8AgQ=;
        b=NUasYrcPpkHZb+4LY01vXbb/UzhqUHBnzLd1EVkwAyYNEMh5ttIzi/0oMFlRHkgKJZ
         uf4dZUyftcmqpyfJTPG0T68bzBJB0AAZ1ZsNT3vNlfZLvx1UtsJ42g99YyE/HmYvJveQ
         Fidh5glMKZIhQuSp/QBdXUYATnLpsqmQxC5y8vU2nR5HTujDq0oMBRTpiaOTq+l09/l5
         gRAFQN9PImO4uwuBkC83O5qI4DGBC1lvHSmWZIItRzIAqkNKPWYVp081luk3H741Y+ml
         kZoSTalaYwK/v5YJHfoCYyiVj5Z6pXGrVKJWv5iNtOApy8yaDELu3c8Ar3yPRIvmSGTW
         rK2Q==
X-Gm-Message-State: AOAM532/mw1Y+EOB41cZcSYz5wtQUvkb+XdiASTWALnEHM8IcY2EbVvJ
        Ax6Q8t+QkVuBtExE0/FKTo1caQ==
X-Google-Smtp-Source: ABdhPJzwCi7ao/H+8OErGk5NmFdGRn2n18mn3wKEJziScU+conJVKX5SPZeE9vzKQ7lasDxro3UN9w==
X-Received: by 2002:a4a:5258:: with SMTP id d85mr3028655oob.72.1601349284435;
        Mon, 28 Sep 2020 20:14:44 -0700 (PDT)
Received: from localhost.localdomain (99-135-181-32.lightspeed.austtx.sbcglobal.net. [99.135.181.32])
        by smtp.gmail.com with ESMTPSA id 36sm729548otb.30.2020.09.28.20.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 20:14:43 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v4 0/4] Qualcomm Light Pulse Generator
Date:   Mon, 28 Sep 2020 20:15:40 -0700
Message-Id: <20200929031544.1000204-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series introduces a generic pattern interface in the LED class and
a driver for the Qualcomm Light Pulse Generator.

It seems like it's been almost 3 years since I posted v3, which was hung
up on the lack of conclusion on the hw_pattern and multicolor support.
Now that those are concluded I hope we can make some progress on the LPG
support again.

The dts patches are included in the series as "examples", ultimately my
expectation is that the dt binding and driver patches are picked up
through the leds tree, while Andy or myself take the dts patches.

Bjorn Andersson (4):
  dt-bindings: leds: Add Qualcomm Light Pulse Generator binding
  leds: Add driver for Qualcomm LPG
  arm64: dts: qcom: msm8996: Add mpp and lpg blocks
  arm64: dts: qcom: Add user LEDs on db820c

 .../bindings/leds/leds-qcom-lpg.yaml          |  170 +++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi  |   49 +
 arch/arm64/boot/dts/qcom/pm8994.dtsi          |    9 +
 arch/arm64/boot/dts/qcom/pmi8994.dtsi         |   20 +
 drivers/leds/Kconfig                          |    9 +
 drivers/leds/Makefile                         |    1 +
 drivers/leds/leds-qcom-lpg.c                  | 1213 +++++++++++++++++
 7 files changed, 1471 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
 create mode 100644 drivers/leds/leds-qcom-lpg.c

-- 
2.28.0

