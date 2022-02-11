Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38E74B27FC
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Feb 2022 15:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350895AbiBKOeK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Feb 2022 09:34:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244152AbiBKOeJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Feb 2022 09:34:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33669184
        for <linux-pwm@vger.kernel.org>; Fri, 11 Feb 2022 06:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644590047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7pELLYgWMGHfb1eD+P0kvOw1QS3O+QiHtobyux8MW8A=;
        b=h8dMQK78IlMgBNzwWwgXAVD7CTocQakgn+z269QYAM17qek7pQEyr2eSPGkdcZT3Dbobeg
        rnK2rbxdS8xbYlmPbcJDGl9nL+cpqCGFFx4FQTYpb/CUHv+VJim9fyUATsLLnVnL6BSf5o
        XP+zcxEEHsvOrfOIGIXCQlUyDafpNsA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367--jwVXQWTMYKp_XxtxcIifg-1; Fri, 11 Feb 2022 09:34:06 -0500
X-MC-Unique: -jwVXQWTMYKp_XxtxcIifg-1
Received: by mail-wm1-f70.google.com with SMTP id h82-20020a1c2155000000b003552c13626cso5994663wmh.3
        for <linux-pwm@vger.kernel.org>; Fri, 11 Feb 2022 06:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7pELLYgWMGHfb1eD+P0kvOw1QS3O+QiHtobyux8MW8A=;
        b=t6KvYAtAK+UeERvbUlM49HjJUUiK3u0hHribpG0PnpWKGwMuXwyyNA5igsZpuDST6X
         obOxav0XWkjPxY5nK6uiPVJU0FpjZg/OBFWyXCmKCkxIymzGHAukG/1Qcr+76siXjSz0
         rQwdfoUPy9a3OKFWNOw4HfVO6kicuS1tOtwvSnq6qz6TkICwIilZyStky1OaTYV1RXi8
         M1+Tt1Z3HJnQrYrlHMLJBDBQWaNpF4aKbvZOtB3YDDcDCz3RM7e7BmNpy6kReJf5jP4a
         MyOqzLsgud4+79REwTe7jm/gJoYIDRAEgIZxizIlg9hIOdSi9TtjRnOjoTyDBPlqphyS
         IA3Q==
X-Gm-Message-State: AOAM533cK2VzJFfHnm7d9k05q3c/XFlUqJDjr1fyNbddN26AVMccUP3V
        oGrN9pgBCruc3lfvjXEYzsGua18XiTihsk4ay1FWlP6SXfe4giqziCUAIhKGXJ9AlQ7zhhEkVro
        T6WrwUCqmWb3gSn42FQ4R
X-Received: by 2002:a05:600c:1d06:: with SMTP id l6mr525140wms.80.1644590044764;
        Fri, 11 Feb 2022 06:34:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9HYffAxRy281VmCR9z8jQH2Zk4rA1j2xix+By5dKN0AIGJplP5u2ysGU5TmbC53PxJiRsUQ==
X-Received: by 2002:a05:600c:1d06:: with SMTP id l6mr525128wms.80.1644590044461;
        Fri, 11 Feb 2022 06:34:04 -0800 (PST)
Received: from minerva.redhat.com ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o14sm24616012wry.104.2022.02.11.06.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:34:04 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v5 0/6] drm: Add driver for Solomon SSD130x OLED displays
Date:   Fri, 11 Feb 2022 15:33:52 +0100
Message-Id: <20220211143358.3112958-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.

Using the DRM fbdev emulation, all the tests from Geert Uytterhoeven repo
(https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git) passes.

I've also tested it using the display as a VT output and even though fbcon
seems to work, it is mostly unusable on a 128x64 SSD1306 display.

This is a v5 that addresses the issues pointed in v4. Thanks a lot to all
reviewers that gave me feedback and comments.

I didn't include the patch that adds the SPI support this time, because it
will require changes in the existing Device Tree binding. And I wanted to
avoid that bikesheeding for now, to focus on the core and I2C parts.

Once this series land, I'll post patches for the SPI support. But the WIP
patch posted in v3 should still apply cleanly on top of this v5:

https://patchwork.kernel.org/project/dri-devel/patch/20220209091204.2513437-1-javierm@redhat.com/

Patch #1 splits per-line conversion logic in drm_fb_xrgb8888_to_gray8() to
a separate drm_fb_xrgb8888_to_gray8_line() helper function.

Patch #2 adds a new drm_fb_xrgb8888_to_mono_reversed() helper function to
convert from XR24 to reversed monochrome. The latter internally converts
each line first to 8-bit grayscale and then to 1-bit reversed monochrome.

Patch #3 adds the driver. This only has the core support and doesn't have
any bus specific code, separate drivers are needed for the transport used.

Patch #4 adds a driver to use the I2C bus to communicate with the device.

Patch #5 adds a MAINTAINERS entry for the DRM driver and patch #6 adds
myself as co-maintainer of the existing DT binding for the ssd1307fb,
since the same DT binding is used for both the fbdev and DRM drivers.

Best regards,
Javier

Changes in v5:
- Add Thomas Zimmermann's Reviewed-by to patch #1.
- Use drm_WARN_ON* macros instead of deprecated ones (Thomas Zimmermann)
- Include <linux/bits.h> header (Andy Shevchenko)
- Drop parenthesis for command options macros (Andy Shevchenko)
- Explain in ssd130x_write_cmd() comment how commands are sent (Andy Shevchenko)
- The pwm_*() functions check for NULL already (Andy Shevchenko)
- Remove unnecesary blank line (Andy Shevchenko)
- Simplify error handling for backlight registration failure (Geert Uytterhoeven)
- Don't clear screen on enable, instead send the full buffer (Thomas Zimmermann)
- Add Andy Shevchenko's Reviewed-by tag to patch #4.
- Add Andy Shevchenko's Reviewed-by tag to patch #5.
- Add Andy Shevchenko's Reviewed-by tag to patch #6.

Changes in v4:
- Rename end_offset to end_len (Thomas Zimmermann)
- Warn once if dst_pitch is not a multiple of 8 (Thomas Zimmermann)
- Drop drm_fb_gray8_to_mono_reversed() that's not used (Thomas Zimmermann)
- Allocate single buffer for both copy cma memory and gray8 (Thomas Zimmermann)
- Add Thomas Zimmermann Reviewed-by tag to patch adding XR24 -> mono helper.
- Rename vbat supply to vcc since is how's labeled in the device (Mark Brown)
- Don't make the regulator option since is always needed (Mark Brown)
- Add solomon Kconfig source and directory inclusion sorted (Andy Shevchenko)
- Use SSD130x instead of SSD130X to denote is not a model name (Andy Shevchenko)
- Check if there's a reset pin in the callee and not the caller (Andy Shevchenko)
- Define missing commands instead of using magic numbers (Andy Shevchenko)
- Use GENMASK() and FIELD_PREP() macros when possible (Andy Shevchenko)
- Avoid using ternary operators to ease code readablity (Andy Shevchenko)
- Use i++ instead of --i on some for loops (Andy Shevchenko)
- Remove redundant blank lines (Andy Shevchenko)
- Rename power_off label to out_power_off (Andy Shevchenko)
- Use dev_err_probe() even if no -EPROBE_DEFER (Andy Shevchenko)
- Don't use plural Authors if there's only one (Andy Shevchenko)
- Remove unnecessary casting (Geert Uytterhoeven)
- Remove redundant blank lines (Andy Shevchenko)
- Remove comma after of_device_id table terminator (Andy Shevchenko)
- Add Rob Herring Acked-by tag to patch adding as DT binding co-maintainer.

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

Javier Martinez Canillas (6):
  drm/format-helper: Add drm_fb_xrgb8888_to_gray8_line()
  drm/format-helper: Add drm_fb_xrgb8888_to_mono_reversed()
  drm: Add driver for Solomon SSD130x OLED displays
  drm/solomon: Add SSD130x OLED displays I2C support
  MAINTAINERS: Add entry for Solomon SSD130x OLED displays DRM driver
  dt-bindings: display: ssd1307fb: Add myself as binding co-maintainer

 .../bindings/display/solomon,ssd1307fb.yaml   |   1 +
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/drm_format_helper.c           | 141 ++-
 drivers/gpu/drm/solomon/Kconfig               |  21 +
 drivers/gpu/drm/solomon/Makefile              |   2 +
 drivers/gpu/drm/solomon/ssd130x-i2c.c         | 116 +++
 drivers/gpu/drm/solomon/ssd130x.c             | 851 ++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.h             |  76 ++
 include/drm/drm_format_helper.h               |   4 +
 11 files changed, 1210 insertions(+), 12 deletions(-)
 create mode 100644 drivers/gpu/drm/solomon/Kconfig
 create mode 100644 drivers/gpu/drm/solomon/Makefile
 create mode 100644 drivers/gpu/drm/solomon/ssd130x-i2c.c
 create mode 100644 drivers/gpu/drm/solomon/ssd130x.c
 create mode 100644 drivers/gpu/drm/solomon/ssd130x.h

-- 
2.34.1

