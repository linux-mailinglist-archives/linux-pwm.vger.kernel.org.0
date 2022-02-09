Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4004AEF3A
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Feb 2022 11:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiBIKYQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Feb 2022 05:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiBIKYP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Feb 2022 05:24:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 883FCE090CFB
        for <linux-pwm@vger.kernel.org>; Wed,  9 Feb 2022 02:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644401760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4eeYHOMbfBp5aJX22HSUQ/DkBidHbSNtGBPohb4rodE=;
        b=eDWze+CvkOp6XrPFWwQ7mmn6w2i+w4KnJlug6CCUF7g96l/XHgDtz6aSybYzlYCOdtW29x
        s62l5IZr9zurgFE3xp30Cu5wLIV5o3o/FLirgoqnc3pwnQQjWSIaH0Hpy0YagZD5VCs5gy
        bPJHB4c0WaKQ0Rx53j2IyVKcxnSly5A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-Y3K3RcIYORSp_CrMef_GVw-1; Wed, 09 Feb 2022 04:03:27 -0500
X-MC-Unique: Y3K3RcIYORSp_CrMef_GVw-1
Received: by mail-wm1-f70.google.com with SMTP id c7-20020a1c3507000000b0034a0dfc86aaso2337429wma.6
        for <linux-pwm@vger.kernel.org>; Wed, 09 Feb 2022 01:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4eeYHOMbfBp5aJX22HSUQ/DkBidHbSNtGBPohb4rodE=;
        b=iQcL/rDrplgvHZvEWaLfE6XI7lPYD3Qk4VcCj8+BEB8WdN0dtM5G8IyrVJak0bS+c7
         XaLZab2Vm0sswmRfUgygvC8rmBtHuZPlW2cpeiTormPKyvWTVMk+Cpfdp0Z1/2b7RISS
         5KqBkUO8BpvOgqkY7+rxWOAMbJUfNpNJ4+oI5cSnhOJ3FVimGX1GD8zSKP1D/uPZqamP
         MMpDYESSNEfzchwuoCEggq1eSNHnabeLhpBQA6kF7utY5gwph13xRaQejjYb+6+wcP8Z
         jisyUftNvjAw9G7PwDU6TPx9vSfxOC5Vdlhplz5XE1vb1zH1iGjlclAume8+tgyeKbij
         1kDg==
X-Gm-Message-State: AOAM531jy/OqpsdwGo3FzYDH/+aFJPD7Lfrw/Fmp3Do2VAqMHs5J6IJP
        8PjWRpB/QQRbefXRYGxiku7/LjwiFmqcVisE4aqNLNK61JpB2hOWCfEPsbVTgbHs7TCp89IZbb/
        1MSSW7Z8VJPwe3N3XcYJT
X-Received: by 2002:adf:e94c:: with SMTP id m12mr1188870wrn.383.1644397404833;
        Wed, 09 Feb 2022 01:03:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGce9tpVO3qLOEdvm/oHaTzszOq6dg27pXCBKFJe+wFhoSKZTbcd2S+PJ9oFnd0L2GTF8TAA==
X-Received: by 2002:adf:e94c:: with SMTP id m12mr1188836wrn.383.1644397404569;
        Wed, 09 Feb 2022 01:03:24 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z1sm4058866wmk.32.2022.02.09.01.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 01:03:24 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v3 0/7] drm: Add driver for Solomon SSD130X OLED displays
Date:   Wed,  9 Feb 2022 10:03:07 +0100
Message-Id: <20220209090314.2511959-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.

Using the DRM fb emulation, all the tests from Geert Uytterhoeven's fbtest
(https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git) passes.

I've also tested it using the display as a VT output and even though fbcon
seems to work, it is mostly unusable on a 128x64 SSD1306 display.

This is a v3 that addresses all the issues pointed in v2. Thanks a lot
to everyone that gave me feedback and reviews.

Patch #1 splits per-line conversion logic in drm_fb_xrgb8888_to_gray8() to
a separate drm_fb_xrgb8888_to_gray8_line() helper function.

Patch #2 adds two new helpers, drm_fb_gray8_to_mono_reversed() to convert
from grayscale to monochrome and a drm_fb_xrgb8888_to_mono_reversed() to
convert from XR24 to monochrome. The latter internally converts each line
first to gray8 and then to reversed monochrome.

Patch #3 adds the driver. This only has the core support but doesn't have
any bus specific code, separate drivers are needed for the transport used.

Patch #4 adds a driver to use the I2C bus to communicate with the device
and patch #5 adds a similar driver for SPI. This one is a WIP and wasn't
tested. I'm including for people to test and modify for their displays.

Patch #6 just adds a MAINTAINERS entry for the DRM driver and patch #7
adds myself as a co-maintainer of the existing Device Tree binding for
ssd1307fb, since the same is shared between the fbdev and DRM drivers.

Best regards,
Javier

Changes in v3:
- Add a drm_fb_xrgb8888_to_gray8_line() helper function (Thomas Zimmermann)
- Also add a drm_fb_xrgb8888_to_mono_reversed() helper (Thomas Zimmermann)
- Split lines copy to drm_fb_gray8_to_mono_reversed_line() (Thomas Zimmermann)
- Handle case where the source buffer is not aligned to 8 (Thomas Zimmermann)
- Move driver from tiny sub-dir to drivers/gpu/drm/solomon (Sam Ravnborg)
- Split driver in a bus agnostic core and bus specific (Andy Shevchenko)
- Use regmap to access the chip registers (Andy Shevchenko)
- Remove unnecessary blank lines (Andy Shevchenko)
- Remove unneeded inline specifier in functions (Andy Shevchenko)
- Add a comment about always returning a single mode (Andy Shevchenko)
- Change write command logic to use do while loop (Andy Shevchenko)
- Use "firmware description" instead of "device tree" (Andy Shevchenko)
- Use return foo() instead of returning the return value (Andy Shevchenko)
- Don't split lines longer than 80 chars if makes less readable (Andy Shevchenko)
- Remove redundant else statements in .mode_valid callback (Andy Shevchenko)
- Rename powero{n,ff}() functions to power_o{n,ff)() (Andy Shevchenko)
- Use dev_err_probe() to prevent spam logs on probe deferral (Andy Shevchenko)
- Remove ',' after sentinel terminator in array (Andy Shevchenko)
- Fix a bug when doing partial updates (Geert Uytterhoeven)
- Add a separate driver for SSD130X chips I2C support (Andy Shevchenko)
- Add a separate driver for SSD130X chips SPI support (Andy Shevchenko)
- Adapt MAINTAINERS entry to point to the new drivers/gpu/drm/solomon directory.

Changes in v2:
- Drop patch that was adding a DRM_MODE_CONNECTOR_I2C type.
- Invert order of backlight {en,dis}able and display {on,off} (Sam Ravnborg)
- Don't clear the screen and turn on display on probe (Sam Ravnborg)
- Use backlight_get_brightness() macro to get BL brightness (Sam Ravnborg)
- Use dev managed version of devm_backlight_device_register() (Sam Ravnborg)
- Use dev_name(dev) for backlight name instead of an array (Sam Ravnborg)
- Drop the .get_brightness callback since isn't needed  (Sam Ravnborg)
- Rename driver to ssd130x since supports a display family (Thomas Zimmermann)
- Drop the TINY prefix from the Kconfig symbol (Thomas Zimmermann)
- Sort the Kconfig symbol dependencies alphabetically (Thomas Zimmermann)
- Rename struct ssd130x_array to struct ssd130x_i2c_msg (Thomas Zimmermann)
- Rename struct ssd130x_i2c_msg .type member to .cmd (Thomas Zimmermann)
- Use sizeof(*foo) instead of sizeof(struct foo) (Thomas Zimmermann)
- Use struct_size() macro to calculate sizeof(*foo) + len (Thomas Zimmermann)
- Use kcalloc() instead of kmalloc_array() + memset() (Thomas Zimmermann)
- Use shadow plane helpers virtual screen support (Thomas Zimmermann)
- Remove unused goto label in ssd1307_fb_blit_rect() (Thomas Zimmermann)
- Use drm_set_preferred_mode() inset of manually set (Thomas Zimmermann)
- Use shadow plane helpers virtual screen support (Thomas Zimmermann)
- Remove unused goto label in ssd1307_fb_blit_rect() (Thomas Zimmermann)
- Use drm_set_preferred_mode() inset of manually set (Thomas Zimmermann)
- Reorganize code in probe to make it more legible (Thomas Zimmermann)
- ssd130x_write_cmd() uses varargs to simplify I2C code (Thomas Zimmermann)
- Move regulator/pwm init logic to display pipe enable callback.
- Add Sam Ravnborg's acked-by to patch adding a MAINTAINERS entry (Sam Ravnborg)
- Add myself as co-maintainer of the ssd1370fb DT binding (Sam Ravnborg).

Javier Martinez Canillas (7):
  drm/format-helper: Add drm_fb_xrgb8888_to_gray8_line()
  drm/format-helper: Add drm_fb_{xrgb8888,gray8}_to_mono_reversed()
  drm: Add driver for Solomon SSD130X OLED displays
  drm/solomon: Add SSD130X OLED displays I2C support
  (WIP) drm/solomon: Add SSD130X OLED displays SPI support
  MAINTAINERS: Add entry for Solomon SSD130X OLED displays DRM driver
  dt-bindings: display: ssd1307fb: Add myself as binding co-maintainer

 .../bindings/display/solomon,ssd1307fb.yaml   |   1 +
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/drm_format_helper.c           | 188 +++-
 drivers/gpu/drm/solomon/Kconfig               |  30 +
 drivers/gpu/drm/solomon/Makefile              |   3 +
 drivers/gpu/drm/solomon/ssd130x-i2c.c         | 117 +++
 drivers/gpu/drm/solomon/ssd130x-spi.c         | 114 +++
 drivers/gpu/drm/solomon/ssd130x.c             | 823 ++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.h             |  76 ++
 include/drm/drm_format_helper.h               |   8 +
 12 files changed, 1358 insertions(+), 12 deletions(-)
 create mode 100644 drivers/gpu/drm/solomon/Kconfig
 create mode 100644 drivers/gpu/drm/solomon/Makefile
 create mode 100644 drivers/gpu/drm/solomon/ssd130x-i2c.c
 create mode 100644 drivers/gpu/drm/solomon/ssd130x-spi.c
 create mode 100644 drivers/gpu/drm/solomon/ssd130x.c
 create mode 100644 drivers/gpu/drm/solomon/ssd130x.h

-- 
2.34.1

