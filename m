Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070941E9E75
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 08:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgFAGwS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 02:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAGwR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 02:52:17 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC18C061A0E;
        Sun, 31 May 2020 23:52:17 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j12so569913lfh.0;
        Sun, 31 May 2020 23:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lcs4UfCjZfwBNFi+8rkSrZ11oxhwX1U+s8m8XO/pfDI=;
        b=kTEQfOPA4AqYBYajHUGCtoyClG+Bp8MGoxPyjdJm8jSB8Cv0a1Gf6qFlAXPQchzp7F
         ni3sWO8OzBm68Su+yZ9jDMiOv/rYuX015JMwKNi2VCvT4YIU+q6PuBtyaCM+Q1LPJyFD
         kJosFcJxmSRV14YcYNsKJ2wr3GUUMvX4L9P4CdUBA65o0RIGDC6arVBe6VA4dIhxArB+
         SCDdoi86W/e/vAukfCJEME27jt+IM3rr8boU1IKENSwZCIHEnAKA5wCMxpDFiTwtmo7P
         yyZHMTMxT00WJYwv79ZFjsXTSLS8/DNKtrdyHcE4ovt5TaNVSHSz5a5T6uCQST98wL4t
         jU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Lcs4UfCjZfwBNFi+8rkSrZ11oxhwX1U+s8m8XO/pfDI=;
        b=EOLJ8sNWtmj54J8WF3qHoDRzIkze7pc4Fibw5qoy1eTs1iXZoabBhtJ4QkE5nDNBTh
         UUbGVGFelifLcuonz1vDxPpWYd+4qRhioiNJ652hEtq4yns44TRSgloOMynEsUF1Wf2p
         WR6J9bd6pIK2wYL5jvq0vlHvmXX9hTVF9oDtWP/6FvhwamwIA3eb/eM0FVqTjiRk2iax
         VqshcyUh3KvY/jlOddw2ouPz0IZK/97WNNr3bNzBiZWZ782lnsPyeyg+JbgVvaIv03+6
         BLZ8rVV4bz3hUeLCfPdowCKCAP+vkWHtlrGsSu920B0pDqPL/g19PBhlPNNdeMHwJlLc
         DOag==
X-Gm-Message-State: AOAM530imOe+x8sYhzkShFP39psGkkQtudPyCcosZOBMFrHlcHijJn7o
        p9nhHvdjl7cW2S+jtNwaBH8=
X-Google-Smtp-Source: ABdhPJzjz/NAIyLeXql3zfTZPD5z1MKZ+BU+XLz6PTkE13Afx7zKl2wz/s4PDc86x6D1L7XcDcp2mw==
X-Received: by 2002:ac2:54b4:: with SMTP id w20mr10547915lfk.48.1590994335553;
        Sun, 31 May 2020 23:52:15 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:281d:a604:434c:a58d])
        by smtp.gmail.com with ESMTPSA id e13sm2540462ljl.117.2020.05.31.23.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 23:52:14 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH v3 0/16] backlight updates
Date:   Mon,  1 Jun 2020 08:51:54 +0200
Message-Id: <20200601065207.492614-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

v3:
 - Dropped video patch that was reviewd and thus applied
 - Updated kernel-doc so all fields now have a short intro
 - Improved readability in a lot of places, thanks to review
   feedback from Daniel - thanks!
 - Added better intro to backlight
 - Added acks

   Several other smaller changes documented in the
   patches.
   I left out patches to make functions static as
   there are dependencies to drm-misc-next for these.
   When this is landed I have a pile of follow-up patches waiting,
   mostly introducing backlight_is_blank() all over.

v2:
  - Dropped drm patches that was reviewed and thus applied (Thanks Tomi)
  - Updated backligth_is_blank() based on Daniel's feedback
  - Dropped EXPORT_SYMBOL that was no longer relevant
  - Reordered patches, so patches with no external
    dependencies comes first
  - Updated the description that follows.

This following series touches a lot of backlight things.

Starts with a small refactoring in backligth.c to remove some indents.
This increases the readability and no functional changes.

Then a new helper backlight_is_blank() is added.
This helper will simplify the implementation of update_status()
in almost all backlight drivers.

Then while surfing the code I missed some documentation.
So I got a bit carried away and updated the documentation
for the backlight core and added it to kernel-doc.
The documentation express my current understanding.
Everything from spelling errors to outright wrong content
shall be anticipated - so please review!
We are all best helped if the documentation is correct
and up-to-date and it is readable.

In this process I identified that the backlight_bl driver
was no longer in use - so drop it.

Everything builds, but so far no run-time testing.

	Sam

Sam Ravnborg (13):
      backlight: refactor fb_notifier_callback()
      backlight: add backlight_is_blank()
      backlight: improve backlight_ops documentation
      backlight: improve backlight_properties documentation
      backlight: improve backlight_device documentation
      backlight: document inline functions in backlight.h
      backlight: document enums in backlight.h
      backlight: remove the unused backlight_bl driver
      backlight: drop extern from prototypes
      backlight: add overview and update existing doc
      backlight: wire up kernel-doc documentation
      backlight: as3711_bl: introduce backlight_is_blank()
      backlight: use backlight_is_blank() in all backlight drivers

 Documentation/gpu/backlight.rst          |  12 +
 Documentation/gpu/index.rst              |   1 +
 drivers/video/backlight/88pm860x_bl.c    |   8 +-
 drivers/video/backlight/Kconfig          |   8 -
 drivers/video/backlight/Makefile         |   1 -
 drivers/video/backlight/adp5520_bl.c     |   5 +-
 drivers/video/backlight/adp8860_bl.c     |   5 +-
 drivers/video/backlight/adp8870_bl.c     |   5 +-
 drivers/video/backlight/as3711_bl.c      |   8 +-
 drivers/video/backlight/backlight.c      | 174 +++++++++-----
 drivers/video/backlight/bd6107.c         |   4 +-
 drivers/video/backlight/corgi_lcd.c      |   5 +-
 drivers/video/backlight/cr_bllcd.c       |  22 +-
 drivers/video/backlight/da903x_bl.c      |   8 +-
 drivers/video/backlight/ep93xx_bl.c      |   3 +-
 drivers/video/backlight/generic_bl.c     | 110 ---------
 drivers/video/backlight/gpio_backlight.c |   4 +-
 drivers/video/backlight/hp680_bl.c       |   4 +-
 drivers/video/backlight/jornada720_bl.c  |   2 +-
 drivers/video/backlight/kb3886_bl.c      |   4 +-
 drivers/video/backlight/led_bl.c         |   4 +-
 drivers/video/backlight/lm3533_bl.c      |   4 +-
 drivers/video/backlight/locomolcd.c      |   4 +-
 drivers/video/backlight/lv5207lp.c       |   4 +-
 drivers/video/backlight/max8925_bl.c     |   8 +-
 drivers/video/backlight/pwm_bl.c         |   4 +-
 drivers/video/backlight/qcom-wled.c      |   4 +-
 drivers/video/backlight/tps65217_bl.c    |   4 +-
 drivers/video/backlight/wm831x_bl.c      |   8 +-
 include/linux/backlight.h                | 374 +++++++++++++++++++++++++------
 30 files changed, 465 insertions(+), 346 deletions(-)


