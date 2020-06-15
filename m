Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A8F1F99D2
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2020 16:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgFOOQO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 Jun 2020 10:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOOQN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Jun 2020 10:16:13 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0685FC061A0E;
        Mon, 15 Jun 2020 07:16:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id mb16so17631617ejb.4;
        Mon, 15 Jun 2020 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WC5bFIazCh8vFZr3dbJEpqc1xCdQ+Y0EsDw6h2APg/s=;
        b=vGpLo03wEbecIwDZs6aLM5MifTH9cIaqISkQ2o8hV3akDsHB8L7PFAdBQYZlhcGMtA
         TkrxZkXjVCEKb7U+79U16j9wr4Idqho4y+s8QngzmmDcwEtJUAiXW5oBDO/eA7GabpAd
         cZrKTkKf86XAXvgxHcdsFjPPsYQGDPj7MT2sJ36NGA4pnP5x0ICjMUc73VfKvie0Y/WH
         r+KoQnbycHx8PoW8PFK096V/HOnwDnFsBd2YV3PPDuZL4Y1lH9ZmiCFwhE1QdalvPgFT
         3v+jvihcdujS8AVg55AJTK697VUH7/xbL1KNoTZR0eTUK3BgO8+dzBFH2Pbs7EGkwJNi
         IT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WC5bFIazCh8vFZr3dbJEpqc1xCdQ+Y0EsDw6h2APg/s=;
        b=VPzvQgJN/SACjKdrFMmuOJIUwyCp4MA+G8wZfP6XV22kpGVgeAfLNo8Ex4gQ3FvCx8
         bh/32z1iU32BtPSCvtbYn508fHP1y/fKgG/ZFLPD+rdT6hWV4BMKOrbwnclVketHo/8o
         rLiVCm8CJIrxCIX5VCqEK7MEjn/f/7Xp/Ucv0mrkyLgAgCOQpiylnTz1d2Ede0TX0HHt
         5fsgFmm3I2wG3tmvJI/TMEedIfVUOGyMhfibZrFgDFi31lv6U//ry2+ZaNhh4Yyy9yqw
         SUo7dAkF1yYQb/b73tjqZnFgBqFHlVTcolhsT4J32Ylce/PGmINN94awcb6EJQTcwtcZ
         PA+w==
X-Gm-Message-State: AOAM532cDYiU5lGJHbXaAijS5XH2ukwffi/OWiQJZUkGiqfTP5kk3btE
        3vkqRprbR09XoovXyDBRq8s=
X-Google-Smtp-Source: ABdhPJxjOCr7M3aDqtDu1vsNHUEZH+2MiLrmJ8gWGmyUIpeeQ9Egc2sRH9S49Y4grpgwP83wTtCoKg==
X-Received: by 2002:a17:906:1b1a:: with SMTP id o26mr25252560ejg.176.1592230571615;
        Mon, 15 Jun 2020 07:16:11 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id s5sm9042275eji.73.2020.06.15.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:16:10 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] pwm: Miscellaneous fixes for 64-bit support
Date:   Mon, 15 Jun 2020 16:16:04 +0200
Message-Id: <20200615141606.2814208-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

this contains a couple of fixes for issues that I ran into after
applying Guru's series to convert PWM period and duty-cycle to 64-bit.

Bartlomiej, can you provide an Acked-by on the first patch so that I can
take it through the PWM tree along with the rest of Guru's series?

Thanks,
Thierry

Thierry Reding (2):
  video: ssd1307fb: Print PWM period using 64-bit format specifier
  pwm: iqs620a: Use 64-bit division

 drivers/pwm/pwm-iqs620a.c       | 7 ++++---
 drivers/video/fbdev/ssd1307fb.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.24.1

