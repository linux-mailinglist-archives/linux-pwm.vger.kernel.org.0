Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCC31D5AF1
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2020 22:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgEOUsi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 May 2020 16:48:38 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:41002 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgEOUsh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 May 2020 16:48:37 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id CC3198052B;
        Fri, 15 May 2020 22:48:30 +0200 (CEST)
Date:   Fri, 15 May 2020 22:48:29 +0200
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
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Uwe Kleine Konig <u.kleine-koenig@pengutronix.de>,
        Zheng Bin <zhengbin13@huawei.com>
Subject: Re: [PATCH v1 0/18] backlight updates
Message-ID: <20200515204829.GB543522@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514191001.457441-1-sam@ravnborg.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=Bma9T9PxULoPMS20tvwA:9 a=CjuIK1q_8ugA:10
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi all.
i
...

> Sam Ravnborg (18):
>       drm/omap: display: use devm_of_find_backlight
>       drm/tilcdc: use devm_of_find_backlight
Tomi - thanks for the prompt review of the above two patches.

>       video: amba-clcd: use devm_of_find_backlight
Any takes for review/ack of this patch?

>       backlight: make of_find_backlight static
>       backlight: drop backlight_put()
>       backlight: make of_find_backlight_by_node() static
The above three patches are moved to the end of the patchset in v2.
They cannot be applied before the users are gone.
As we will remove users of of_find_backlight_by_node() in
drm-misc-next, we can only merge the "make static" patches in the
backlight tree after the merge window.
So move them to the end so we may apply other patches before.

I plan to send v2 end of the weekend, and hope for some feedback on the
doc pathches until then.

	Sam

>       backlight: refactor fb_notifier_callback()
>       backlight: add backlight_is_blank()
>       backlight: improve backlight_ops documentation
>       backlight: improve backlight_properties documentation
>       backlight: improve backlight_device documentation
>       backlight: document inline functions in backlight.h
>       backlight: document enums in backlight.h
>       backlight: remove the unused backlight_bl driver
>       backlight: drop extern from prototypes
>       backlight: add overview and update doc
>       backlight: wire up kernel-doc documentation
>       backlight: use backlight_is_blank() in all backlight drivers
> 
>  Documentation/gpu/backlight.rst                 |  12 +
>  Documentation/gpu/index.rst                     |   1 +
>  drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c |  18 +-
>  drivers/gpu/drm/tilcdc/tilcdc_panel.c           |  17 +-
>  drivers/video/backlight/88pm860x_bl.c           |   8 +-
>  drivers/video/backlight/Kconfig                 |   8 -
>  drivers/video/backlight/Makefile                |   1 -
>  drivers/video/backlight/adp5520_bl.c            |   5 +-
>  drivers/video/backlight/adp8860_bl.c            |   5 +-
>  drivers/video/backlight/adp8870_bl.c            |   5 +-
>  drivers/video/backlight/as3711_bl.c             |   8 +-
>  drivers/video/backlight/backlight.c             | 237 ++++++++------
>  drivers/video/backlight/bd6107.c                |   4 +-
>  drivers/video/backlight/corgi_lcd.c             |   5 +-
>  drivers/video/backlight/cr_bllcd.c              |  22 +-
>  drivers/video/backlight/da903x_bl.c             |   8 +-
>  drivers/video/backlight/ep93xx_bl.c             |   3 +-
>  drivers/video/backlight/generic_bl.c            | 110 -------
>  drivers/video/backlight/gpio_backlight.c        |   4 +-
>  drivers/video/backlight/hp680_bl.c              |   4 +-
>  drivers/video/backlight/jornada720_bl.c         |   2 +-
>  drivers/video/backlight/kb3886_bl.c             |   4 +-
>  drivers/video/backlight/led_bl.c                |   4 +-
>  drivers/video/backlight/lm3533_bl.c             |   4 +-
>  drivers/video/backlight/locomolcd.c             |   4 +-
>  drivers/video/backlight/lv5207lp.c              |   4 +-
>  drivers/video/backlight/max8925_bl.c            |   8 +-
>  drivers/video/backlight/pwm_bl.c                |   4 +-
>  drivers/video/backlight/qcom-wled.c             |   4 +-
>  drivers/video/backlight/tps65217_bl.c           |   4 +-
>  drivers/video/backlight/wm831x_bl.c             |   8 +-
>  drivers/video/fbdev/amba-clcd.c                 |  19 +-
>  include/linux/backlight.h                       | 415 +++++++++++++++++++-----
>  33 files changed, 536 insertions(+), 433 deletions(-)
> 
