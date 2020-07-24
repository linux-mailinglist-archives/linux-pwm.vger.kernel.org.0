Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF33022D0D8
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jul 2020 23:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgGXVhb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jul 2020 17:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgGXVhb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jul 2020 17:37:31 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C503FC0619D3;
        Fri, 24 Jul 2020 14:37:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a14so9513350wra.5;
        Fri, 24 Jul 2020 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UyLweN+II0ZCIyIgBj5I2+zaWb8dHrtfnlcwzt5oGNM=;
        b=UNs3GuihAWHCTR9hET3VEcxcq7WMVX+ELHyM4UHV7CETbtCF1m5+/7KO22va1IUkIq
         +1fkKnqssP31mj0evgJ/Lwak8npUBRJeFIutSGGylvGSFeDF63rQQ74j8M085mtP6IdL
         yShmUAjK8An6YFzSSwW5w1U9F9mOSINZajKEAnI6IzSs70PQLb+9P5NRjd2r9PV9qBsJ
         EJ2rMG/KvJVR89ZkHgvCwD8PJbsWXtzjQ0HmW1FWmsa3dpChDcNYGXDYBYa4CizLFDqH
         GiHBdw8jaoFdAFbMk0OmDQloGdu7JQ17rAd+BLyRfZcbhq54xt2JsahGGFzwma1p3Gk0
         fG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UyLweN+II0ZCIyIgBj5I2+zaWb8dHrtfnlcwzt5oGNM=;
        b=JhVsmAS2srevKmz61TKXYIuVBxgFNJSdtFFXU/qmD5G08+IsYfLzFZjv1SooU6O7la
         wDcdwLpBbsjh/Ht5J/EEYNFkPCKOdKvHNHu05iuuGO+Kcueu7NElBABcY85mFLsa6C/F
         v18madTkL0zGZ3fTJx44JgPAKcx4zj99jCkBnCeyLlLvAouoquGi6C5JXw0ydjNZ7TJ4
         OH/+5SkLfZwBJ0YIVdPV9GcgNwMqR1QACWFjFCtO5yxes/nDqv4epxrmd4jSnScST8KI
         fE+cdjljtEl5rifyA8YC8wOegPglhajBcUJcyGYo75x3sG1Bww0/1L++I9I6t2LeKciQ
         zFQA==
X-Gm-Message-State: AOAM5322bxnvQarNm+xNpeg9p760qUw8N2i3s65K9oDz1QUL1Sm7ZNy/
        lP2/6veTLIOsgh2wiV+LwLo=
X-Google-Smtp-Source: ABdhPJwLF1RqObtNpTGBQwMpigWEhUqbE+eLdxny/Qtkb5+QTqBldol986Ypp/6PgZjOITEYjaDXNg==
X-Received: by 2002:adf:ea85:: with SMTP id s5mr3155449wrm.55.1595626649546;
        Fri, 24 Jul 2020 14:37:29 -0700 (PDT)
Received: from TimeMachine.localdomain (bband-dyn34.178-41-255.t-com.sk. [178.41.255.34])
        by smtp.googlemail.com with ESMTPSA id 129sm8853400wmd.48.2020.07.24.14.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:37:29 -0700 (PDT)
From:   Martin Botka <martin.botka1@gmail.com>
Cc:     Martin Botka <martin.botka1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH RFC 0/6] Add QCOM pwm-lpg and tri-led drivers
Date:   Fri, 24 Jul 2020 23:36:50 +0200
Message-Id: <20200724213659.273599-1-martin.botka1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,
This series brings QCOM pwm-lpg and tri-led drivers from 4.14 that is required to support pmic-connected notification LED.
This comes straight from downstream and I'm ready for your comments.

Fenglin Wu (6):
  pwm: Add different PWM output types support
  pwm: core: Add option to config PWM duty/period with u64 data length
  pwm: pwm-qti-lpg: Add PWM driver for QTI LPG module
  leds: leds-qti-tri-led: Add LED driver for QTI TRI_LED module
  Documentation: Add binding for qti-tri-led
  Documentation: Add binding for pwm-qti-lpg

 .../bindings/leds/leds-qti-tri-led.txt        |   72 +
 .../devicetree/bindings/pwm/pwm-qti-lpg.txt   |  163 +++
 drivers/leds/Kconfig                          |    9 +
 drivers/leds/Makefile                         |    1 +
 drivers/leds/leds-qti-tri-led.c               |  640 ++++++++
 drivers/pwm/Kconfig                           |   10 +
 drivers/pwm/Makefile                          |    1 +
 drivers/pwm/core.c                            |   56 +-
 drivers/pwm/pwm-qti-lpg.c                     | 1284 +++++++++++++++++
 drivers/pwm/sysfs.c                           |   56 +-
 include/linux/pwm.h                           |  144 +-
 11 files changed, 2418 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-qti-tri-led.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-qti-lpg.txt
 create mode 100644 drivers/leds/leds-qti-tri-led.c
 create mode 100644 drivers/pwm/pwm-qti-lpg.c

-- 
2.27.0

