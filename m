Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD50E1D3CCC
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 21:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbgENTKS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 15:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729893AbgENTKQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:10:16 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F34C061A0C;
        Thu, 14 May 2020 12:10:16 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h26so3591151lfg.6;
        Thu, 14 May 2020 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IAfqMKSnJtIb4fNmt4augkqWT66BiC7XJZ5A9JCXvs4=;
        b=oxsBeLSdgQOS6MRl095JBSHOAfKwHeO7wwuftnEBEhzfK068erkSPeqPTGh/e6j7pL
         e7kwmhg6rWrKVGNIx7gCl7N2XRfDeS4JKiN4NcE+9Cox1nZsGA8OvFb2Gz4/i/nlTWhz
         F/ctVjBKAVfj7F6KpOJMMHUxebl9awYK86pHTqnCY7ZDX7NwAPPFcJbsultH8r7Syn4v
         Lg02v2d6sH3DsXSCLZKHzli0OSHOtwgI4XpBplkYUkgZ6fhg3wQ+WOwG4kun1t1iq/9B
         actUfLcY/fr8Gww3Jf9xCMfOTuAB7nOuebu7k2xkGWsIg2VJTTRqjoP/EHj/iNy/vqXi
         xw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=IAfqMKSnJtIb4fNmt4augkqWT66BiC7XJZ5A9JCXvs4=;
        b=DnCJzElasrrHxKjs7Z12RD2C4LP1JOTbwsn4jSk73ZbdJImzA/miNvBTJFvF358Lsz
         ehKOF6ppzLzB8vy2HQLoZ2U2U8oM8n4j2O97qCU22riRHCQxRnH8u8AOuR4UkiR6iRo4
         v969Dx7VLU7ohgRNlbkrhOm36KxB1n/WXmBMS+lyaBVFLmYHKdRC28NfbXsD54tpxHe7
         ORU6GMqS0rOa/i/Z3ZtSlpz0d7FugVdEOcPEMPMyZmXm1UlT0Ecmc84RDP+bO0ijqq9C
         gzdcKukdCYfB29dQENIXnnREH/g2eR88+FgMVWLy8rOj95uc6UdMxIb4TyOyf9dSK787
         wb8w==
X-Gm-Message-State: AOAM530nk/CrpBO+aG5zIjSNsn5n9JDFFXsPCTYgulHA79uPFK0T5OC1
        pvgVw1eoI12Cn3lFgtUZeSg=
X-Google-Smtp-Source: ABdhPJyPKXZJER042IijHbVEeNT5dPMCnTzHjzehTNfpBkMkXytgSCvIlTYGGbO/DbW3EzrMjPvisg==
X-Received: by 2002:ac2:5496:: with SMTP id t22mr4364239lfk.0.1589483414392;
        Thu, 14 May 2020 12:10:14 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:8d23:71d:e677:1c7c])
        by smtp.gmail.com with ESMTPSA id q30sm2362958lfd.32.2020.05.14.12.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:10:13 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Allison Randal <allison@lohutok.net>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Weigelt <info@metux.net>,
        Jani Nikula <jani.nikula@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Jyri Sarha <jsarha@ti.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Uwe Kleine Konig <u.kleine-koenig@pengutronix.de>,
        Zheng Bin <zhengbin13@huawei.com>
Subject: [PATCH v1 0/18] backlight updates
Date:   Thu, 14 May 2020 21:09:43 +0200
Message-Id: <20200514191001.457441-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The following series touches a lot of backlight things.

It starts by migrating users of of_find_backlight_by_node()
over to devm_of_find_backlight() to simplify code and to
use the preferred way to register backlight.

All the functions in the backlight core that is no longer
used by any drivers are then marked static to avoid
adding new users.

Then a new helper backlight_is_blank() is added.
This helper will simplify the implementation of update_status()
in almost all backlight drivers.

While surfing the code I really missed some documentation.
So I got a bit carried away and updated the documentation
for the backlight core and added it to kernel-doc.
The documentation express my current understanding.
Everything from spelling errors to outright wrong content
shall be anticipated - so please review!
We are all best helped if the documentation is correct
and up-to-date and it is readable.

In this process I identified that the backlight_bl driver
was no longer is use - so drop it.

The last patch is for now just an RFC patch that shows
the potential simplifications by introducing the
use of the backlight_is_blank() helper.
I may split it up later.

I have local patches to introduce backlight_is_blank()
in the remaining backlight drivers.
But they will await that this patch set matures a bit.

Everything builds, but so far no run-time testing.

	Sam

Sam Ravnborg (18):
      drm/omap: display: use devm_of_find_backlight
      drm/tilcdc: use devm_of_find_backlight
      video: amba-clcd: use devm_of_find_backlight
      backlight: make of_find_backlight static
      backlight: drop backlight_put()
      backlight: make of_find_backlight_by_node() static
      backlight: refactor fb_notifier_callback()
      backlight: add backlight_is_blank()
      backlight: improve backlight_ops documentation
      backlight: improve backlight_properties documentation
      backlight: improve backlight_device documentation
      backlight: document inline functions in backlight.h
      backlight: document enums in backlight.h
      backlight: remove the unused backlight_bl driver
      backlight: drop extern from prototypes
      backlight: add overview and update doc
      backlight: wire up kernel-doc documentation
      backlight: use backlight_is_blank() in all backlight drivers

 Documentation/gpu/backlight.rst                 |  12 +
 Documentation/gpu/index.rst                     |   1 +
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c |  18 +-
 drivers/gpu/drm/tilcdc/tilcdc_panel.c           |  17 +-
 drivers/video/backlight/88pm860x_bl.c           |   8 +-
 drivers/video/backlight/Kconfig                 |   8 -
 drivers/video/backlight/Makefile                |   1 -
 drivers/video/backlight/adp5520_bl.c            |   5 +-
 drivers/video/backlight/adp8860_bl.c            |   5 +-
 drivers/video/backlight/adp8870_bl.c            |   5 +-
 drivers/video/backlight/as3711_bl.c             |   8 +-
 drivers/video/backlight/backlight.c             | 237 ++++++++------
 drivers/video/backlight/bd6107.c                |   4 +-
 drivers/video/backlight/corgi_lcd.c             |   5 +-
 drivers/video/backlight/cr_bllcd.c              |  22 +-
 drivers/video/backlight/da903x_bl.c             |   8 +-
 drivers/video/backlight/ep93xx_bl.c             |   3 +-
 drivers/video/backlight/generic_bl.c            | 110 -------
 drivers/video/backlight/gpio_backlight.c        |   4 +-
 drivers/video/backlight/hp680_bl.c              |   4 +-
 drivers/video/backlight/jornada720_bl.c         |   2 +-
 drivers/video/backlight/kb3886_bl.c             |   4 +-
 drivers/video/backlight/led_bl.c                |   4 +-
 drivers/video/backlight/lm3533_bl.c             |   4 +-
 drivers/video/backlight/locomolcd.c             |   4 +-
 drivers/video/backlight/lv5207lp.c              |   4 +-
 drivers/video/backlight/max8925_bl.c            |   8 +-
 drivers/video/backlight/pwm_bl.c                |   4 +-
 drivers/video/backlight/qcom-wled.c             |   4 +-
 drivers/video/backlight/tps65217_bl.c           |   4 +-
 drivers/video/backlight/wm831x_bl.c             |   8 +-
 drivers/video/fbdev/amba-clcd.c                 |  19 +-
 include/linux/backlight.h                       | 415 +++++++++++++++++++-----
 33 files changed, 536 insertions(+), 433 deletions(-)


