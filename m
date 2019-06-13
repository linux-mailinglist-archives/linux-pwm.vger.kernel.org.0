Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0697744C6F
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2019 21:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfFMTnc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Jun 2019 15:43:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42402 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfFMTnc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Jun 2019 15:43:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id go2so8555571plb.9
        for <linux-pwm@vger.kernel.org>; Thu, 13 Jun 2019 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i/JBzTlaIRys/4FXlOVowrLaN7Y7ioCSg9apqikje/Y=;
        b=gy6E/NSdOlgf6LDqxXvrrdZaWN9fZiGtU2p+2qfuTU2RRFBgGSCkswaDXP5lnek7Gt
         gIVtAu43gayoXBKbFHeReMDQsGHMe0OrC+LStPfMP/aB3BLgPDlqHg6jhTl5BH7TWDvR
         ALcClNEmwV9FnItsyQwG8b7Eyniz5DLVJMvZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i/JBzTlaIRys/4FXlOVowrLaN7Y7ioCSg9apqikje/Y=;
        b=g45VvHweR1a6ojyfOGCd9z3+7b0Rky3hxzEAABFuUmccVQ6FmFs0VfJlSS2zBkzqaF
         cfvdaTGU09129aziMrCJ+cyYr9rz57b7URNQMcAGSZH9Yuv1+Ll2YZ6tEr+lsGfveLoV
         8+nvyCHyUo2Es0W9yvQlMfBC0w9a3QkNpjBsD5B6ejyWrHaEwwnooGHrrhrxzVMMVjuR
         IypPMcD7FwPx8/RI7jxsDp04daVn5H3oHaaj+a29ccydOuZyhnSI6UczKfTg3D2TAOTw
         52NzuPHtMD2JBqkHdXROMbIUP8Vw3ME5C7xWXaC8f6uDFWxZXEgK4ZXA4iQTqqGVrvqP
         WoRg==
X-Gm-Message-State: APjAAAWwwftQadEBBvdIN7xsFe4lSghMXUnmb1avvMR1bx29uJmtRTIu
        y0+Akumt5CCQLHth5oDHqkfkZQ==
X-Google-Smtp-Source: APXvYqy985in01FdAKRYCWFmFh62RofTuNsQ+FVfIK1rCnkbbPytQd81yY4V9MCH3ohqvL1VEyDFfA==
X-Received: by 2002:a17:902:21:: with SMTP id 30mr88301989pla.302.1560455011492;
        Thu, 13 Jun 2019 12:43:31 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f2sm498807pgs.83.2019.06.13.12.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 12:43:31 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 0/4] backlight: Expose brightness curve type through sysfs
Date:   Thu, 13 Jun 2019 12:43:22 -0700
Message-Id: <20190613194326.180889-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Backlight brightness curves can have different shapes. The two main
types are linear and non-linear curves. The human eye doesn't
perceive linearly increasing/decreasing brightness as linear (see
also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
linearly to human eye"), hence many backlights use non-linear (often
logarithmic) brightness curves. The type of curve is currently opaque
to userspace, so userspace often relies on more or less reliable
heuristics (like the number of brightness levels) to decide whether
to treat a backlight device as linear or non-linear.

Export the type of the brightness curve via a new sysfs attribute.

Matthias Kaehlcke (4):
  MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
  backlight: Expose brightness curve type through sysfs
  backlight: pwm_bl: Set scale type for CIE 1931 curves
  backlight: pwm_bl: Set scale type for brightness curves specified in
    the DT

 .../ABI/testing/sysfs-class-backlight         | 32 +++++++++++++++++++
 MAINTAINERS                                   |  2 ++
 drivers/video/backlight/backlight.c           | 22 +++++++++++++
 drivers/video/backlight/pwm_bl.c              | 30 ++++++++++++++++-
 include/linux/backlight.h                     | 10 ++++++
 5 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight

-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

