Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6534B2D7C5F
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Dec 2020 18:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389598AbgLKRGS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Dec 2020 12:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394269AbgLKRF0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Dec 2020 12:05:26 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C271AC0613D6
        for <linux-pwm@vger.kernel.org>; Fri, 11 Dec 2020 09:04:45 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id n11so6852272lji.5
        for <linux-pwm@vger.kernel.org>; Fri, 11 Dec 2020 09:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dXAOnrZDAXXrZfjtk1zGKR2/uAWMdfktcE2U7Ei8Pqo=;
        b=gaKUPrTH2M2stIc8eCA8TbS8vVqUcyvMnS8eQ0ZRxhaenDCT2f/hEeQBoYIiM18IWX
         vlfFFA6gYjVqH8Kz1c9AE8Df5C9NOZtgFmAGcHil1Id9XdczBkhk2Gp9IampOAQQhSNY
         WEVaQXZIlBswPvFnen/svWL5nb4F8yBQY0ZJN8sVohu+sKnGkF4I0D1ot+2w3Zb5FgxF
         tCMUSNG83+3AtHGsOr4TFjntvMcE546cgQmHnELyXorMpvBZzAVRkBwMZZtTJmsNCpQS
         cdFe1v7a437jWBj2HGKZXPYiQnOyX1MUhrXVrCxKUVtvZ+C16xXjv6YOJ89yIoKDjKro
         Mijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dXAOnrZDAXXrZfjtk1zGKR2/uAWMdfktcE2U7Ei8Pqo=;
        b=Gu5JfoqkCk9KYG0q9R39xLVAp9JlJeUzYVceV4wQiDNXU1B89aBpfgI7l9ri4UHNfy
         JsKPDmUHvNMyARDQ+m3MA7oDHsrg8BEMDtv4Itz8pOxe98fHEwjF7QfM2Sv6wnMzfs+z
         orFK4RkrW8MkYX4EBsG+nGBPuGxsUWuegv2+bbp8fNOyn+rGWwE2MB1kqxD+dshsWeMs
         UsY6D7vFUTfD3sBlaZZe7ZIW6jSRtKQmvN8ywz5FHTtmnyuaPGrcmbA05wLohWuYSjpk
         oBWGaNoyyS7Ucgg4nrg/1ARmnKGpQFH9advPOMtgUpieA6trxZo01D1soWRUtxcUPtZ9
         /WAg==
X-Gm-Message-State: AOAM533Di7H5Ml+CCmuS3XJwjZePZ8qTXMTHrKtgL+pA5aHsKPsFOsSr
        i1j0gnSuqDzt9djFm78Nj1Xk8bIvTXtXuFTCzLORrw==
X-Google-Smtp-Source: ABdhPJwppWM9A62xfuQoXn4auxv+1MQ/lGIBuWyYMSilT6c3A4vaAFEYT2a2Ofm3el4hs03MJo0D1g==
X-Received: by 2002:a05:651c:1214:: with SMTP id i20mr5408274lja.324.1607706283975;
        Fri, 11 Dec 2020 09:04:43 -0800 (PST)
Received: from einstein.dilieto.eu (einstein.dilieto.eu. [2a03:4000:17:6e2::1000])
        by smtp.gmail.com with ESMTPSA id c4sm944809lfh.94.2020.12.11.09.04.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 09:04:43 -0800 (PST)
From:   Nicola Di Lieto <nicola.dilieto@gmail.com>
To:     linux-pwm@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/2] pwm: pwm-gpio: New driver
Date:   Fri, 11 Dec 2020 18:04:30 +0100
Message-Id: <20201211170432.6113-1-nicola.dilieto@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

New version, implementing Uwe's suggestions.

Changes in v2:
- Synchronize pwm variables to ensure consistency
- Remove clamping of pwm period and duty cycle
- Rename "to_pwm_gpio" as "pwm_gpio_from_chip"
- Initialize pwm_gpio->chip.base to -1
- Swap order of hrtimer_cancel and pwmchip_remove
- Increase #pwm-cells to 3

Nicola Di Lieto (2):
  pwm: pwm-gpio: New driver
  pwm: pwm-gpio: Add DT bindings

 .../devicetree/bindings/pwm/pwm-gpio.yaml          |  42 +++++
 MAINTAINERS                                        |   7 +
 drivers/pwm/Kconfig                                |  10 ++
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-gpio.c                             | 188 +++++++++++++++++++++
 5 files changed, 248 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
 create mode 100644 drivers/pwm/pwm-gpio.c

-- 
2.11.0

