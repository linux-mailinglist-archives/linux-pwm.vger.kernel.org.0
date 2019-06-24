Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 720D850479
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2019 10:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfFXIZ6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jun 2019 04:25:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39637 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfFXIZ6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jun 2019 04:25:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id i34so13559451qta.6
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jun 2019 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MyzSe86pd6m09RXZJhAaILxRtDC9io0NqaivpGEpp+s=;
        b=HotmTGcoYfsj0T10+4PD2gf3kr73tSRgfUgT+ywrqi1OO635tt1J3VCPOGLH5Ivb6L
         BOmedNfFbaRTeMXNfcG672LIrmBXxnWA+nWK+/lD3pLW3UucFuDogsereKFrZFRmlzQr
         d/G7RAZDyQib1WELVRmM/wrJr9L9ubmzZff8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MyzSe86pd6m09RXZJhAaILxRtDC9io0NqaivpGEpp+s=;
        b=b4yapZCrxfVn5H7WwANgPFKc8PR72ci49Gql2YluzZJEp9gpZHJnYAEOuXZnF61EwW
         OBOo2QSblA8sQZGcJQXtwbwqV64o5FhTgg08x6UDrGkeT5QoB5vzjaTxRRNaUkrqOUSp
         0ss0S79a4LADl72gr2Yrhn3D4rUEMdEmt7jqzDiJCfnwsp5olpCmC7aFTK5sJftsD1Nb
         7/Lbw1C2FX3INrcKNlURwJf/To5mh8GFBP4JHgLUzenF+CnbMVz/RA9JTb2i6luD8z6V
         90Fv40Xzd5I8qqiYZnpti3b/+RDOH1jj8IaufzENvJBc9XuhK1tz8KMMqBujeEVqFHjb
         m98Q==
X-Gm-Message-State: APjAAAWfOd2ht4fTftbFcw01tQNFJXHAebfUTSOoIJCqd1cVn9l3a5fY
        n8B1PCY/K3oSvJItvAD/AQh0g/NAK7UV2JRIjPhbeQ==
X-Google-Smtp-Source: APXvYqxLRF2Cf2gSo/iOri7vsgokbiowc5BYHrSVneMZFVSw9lTHfRUALSTbNzGANFovHYOhRlNTwuasprjvcDGPQFk=
X-Received: by 2002:a0c:b04d:: with SMTP id l13mr57514429qvc.104.1561364756429;
 Mon, 24 Jun 2019 01:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190624060343.62451-1-jitao.shi@mediatek.com> <20190624060343.62451-3-jitao.shi@mediatek.com>
In-Reply-To: <20190624060343.62451-3-jitao.shi@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 24 Jun 2019 16:25:45 +0800
Message-ID: <CANMq1KABzuKu1nyP4Mq-6eHPA3tFZ+AViAaouzrgHu9RL4i-6A@mail.gmail.com>
Subject: Re: [v2 2/2] drm/panel: support for BOE tv101wum-nl6 wuxga dsi video
 mode panel
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>, stonea168@163.com,
        dri-devel@lists.freedesktop.org,
        Andy Yan <andy.yan@rock-chips.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Vincent Palatin <vpalatin@chromium.org>,
        cawa cheng <cawa.cheng@mediatek.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jun 24, 2019 at 2:04 PM Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> Add driver for BOE tv101wum-nl6 panel is a 10.1" 1200x1920 panel.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |  10 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 715 ++++++++++++++++++
>  3 files changed, 726 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index e36dbb4df867..2b055ce0700b 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -17,6 +17,15 @@ config DRM_PANEL_ARM_VERSATILE
>           reference designs. The panel is detected using special registers
>           in the Versatile family syscon registers.
>
> +config DRM_PANEL_BOE_TV101WUM_NL6
> +       tristate "BOE TV101WUM 1200x1920 panel"
> +       depends on OF
> +       depends on DRM_MIPI_DSI
> +       depends on BACKLIGHT_CLASS_DEVICE
> +       help
> +         Say Y here if you want to support for BOE TV101WUM WUXGA PANEL
> +         DSI Video Mode panel
> +
>  config DRM_PANEL_LVDS
>         tristate "Generic LVDS panel driver"
>         depends on OF
> @@ -272,4 +281,5 @@ config DRM_PANEL_TRULY_NT35597_WQXGA
>         help
>           Say Y here if you want to enable support for Truly NT35597 WQXGA Dual DSI
>           Video Mode panel
> +

Drop this change.

>  endmenu
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 78e3dc376bdd..8d009223c44e 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
> +obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_NL6) += panel-boe-tv101wum-nl6.o
>  obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
>  obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
>  obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> new file mode 100644
> index 000000000000..6e06c8506623
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -0,0 +1,715 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Jitao Shi <jitao.shi@mediatek.com>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_panel.h>
> +
> +#include <video/mipi_display.h>
> +
> +struct panel_desc {
> +       const struct drm_display_mode *modes;
> +       unsigned int bpc;
> +
> +       /**
> +        * @width: width (in millimeters) of the panel's active display area
> +        * @height: height (in millimeters) of the panel's active display area
> +        */
> +       struct {
> +               unsigned int width;
> +               unsigned int height;
> +       } size;
> +
> +       unsigned long mode_flags;
> +       enum mipi_dsi_pixel_format format;
> +       const struct panel_init_cmd *init_cmds;
> +       unsigned int lanes;
> +};
> +
> +struct boe_panel {
> +       struct drm_panel base;
> +       struct mipi_dsi_device *dsi;
> +
> +       const struct panel_desc *desc;
> +
> +       struct backlight_device *backlight;
> +       struct regulator *pp1800;
> +       struct regulator *avee;
> +       struct regulator *avdd;
> +       struct gpio_desc *enable_gpio;
> +
> +       bool prepared;
> +       bool enabled;
> +
> +       const struct drm_display_mode *mode;
> +};
> +
> +enum dsi_cmd_type {
> +       INIT_DCS_CMD,
> +       DELAY_CMD,
> +};
> +
> +struct panel_init_cmd {
> +       enum dsi_cmd_type type;
> +       size_t len;
> +       const char *data;
> +};
> +
> +#define _INIT_DCS_CMD(...) { \
> +       .type = INIT_DCS_CMD, \
> +       .len = sizeof((char[]){__VA_ARGS__}), \
> +       .data = (char[]){__VA_ARGS__} }
> +
> +#define _INIT_DELAY_CMD(...) { \
> +       .type = DELAY_CMD,\
> +       .len = sizeof((char[]){__VA_ARGS__}), \
> +       .data = (char[]){__VA_ARGS__} }
> +
> +static const struct panel_init_cmd boe_init_cmd[] = {
> +       _INIT_DELAY_CMD(24),
> +       _INIT_DCS_CMD(0xB0, 0x05),
> +       _INIT_DCS_CMD(0xB1, 0xE5),
> +       _INIT_DCS_CMD(0xB3, 0x52),
> +       _INIT_DCS_CMD(0xB0, 0x00),
> +       _INIT_DCS_CMD(0xB3, 0x88),
> +       _INIT_DCS_CMD(0xB0, 0x04),
> +       _INIT_DCS_CMD(0xB8, 0x00),
> +       _INIT_DCS_CMD(0xB0, 0x00),
> +       _INIT_DCS_CMD(0xB6, 0x03),
> +       _INIT_DCS_CMD(0xBA, 0x8B),
> +       _INIT_DCS_CMD(0xBF, 0x1A),
> +       _INIT_DCS_CMD(0xC0, 0x0F),
> +       _INIT_DCS_CMD(0xC2, 0x0C),
> +       _INIT_DCS_CMD(0xC3, 0x02),
> +       _INIT_DCS_CMD(0xC4, 0x0C),
> +       _INIT_DCS_CMD(0xC5, 0x02),
> +       _INIT_DCS_CMD(0xB0, 0x01),
> +       _INIT_DCS_CMD(0xE0, 0x26),
> +       _INIT_DCS_CMD(0xE1, 0x26),
> +       _INIT_DCS_CMD(0xDC, 0x00),
> +       _INIT_DCS_CMD(0xDD, 0x00),
> +       _INIT_DCS_CMD(0xCC, 0x26),
> +       _INIT_DCS_CMD(0xCD, 0x26),
> +       _INIT_DCS_CMD(0xC8, 0x00),
> +       _INIT_DCS_CMD(0xC9, 0x00),
> +       _INIT_DCS_CMD(0xD2, 0x03),
> +       _INIT_DCS_CMD(0xD3, 0x03),
> +       _INIT_DCS_CMD(0xE6, 0x04),
> +       _INIT_DCS_CMD(0xE7, 0x04),
> +       _INIT_DCS_CMD(0xC4, 0x09),
> +       _INIT_DCS_CMD(0xC5, 0x09),
> +       _INIT_DCS_CMD(0xD8, 0x0A),
> +       _INIT_DCS_CMD(0xD9, 0x0A),
> +       _INIT_DCS_CMD(0xC2, 0x0B),
> +       _INIT_DCS_CMD(0xC3, 0x0B),
> +       _INIT_DCS_CMD(0xD6, 0x0C),
> +       _INIT_DCS_CMD(0xD7, 0x0C),
> +       _INIT_DCS_CMD(0xC0, 0x05),
> +       _INIT_DCS_CMD(0xC1, 0x05),
> +       _INIT_DCS_CMD(0xD4, 0x06),
> +       _INIT_DCS_CMD(0xD5, 0x06),
> +       _INIT_DCS_CMD(0xCA, 0x07),
> +       _INIT_DCS_CMD(0xCB, 0x07),
> +       _INIT_DCS_CMD(0xDE, 0x08),
> +       _INIT_DCS_CMD(0xDF, 0x08),
> +       _INIT_DCS_CMD(0xB0, 0x02),
> +       _INIT_DCS_CMD(0xC0, 0x00),
> +       _INIT_DCS_CMD(0xC1, 0x0D),
> +       _INIT_DCS_CMD(0xC2, 0x17),
> +       _INIT_DCS_CMD(0xC3, 0x26),
> +       _INIT_DCS_CMD(0xC4, 0x31),
> +       _INIT_DCS_CMD(0xC5, 0x1C),
> +       _INIT_DCS_CMD(0xC6, 0x2C),
> +       _INIT_DCS_CMD(0xC7, 0x33),
> +       _INIT_DCS_CMD(0xC8, 0x31),
> +       _INIT_DCS_CMD(0xC9, 0x37),
> +       _INIT_DCS_CMD(0xCA, 0x37),
> +       _INIT_DCS_CMD(0xCB, 0x37),
> +       _INIT_DCS_CMD(0xCC, 0x39),
> +       _INIT_DCS_CMD(0xCD, 0x2E),
> +       _INIT_DCS_CMD(0xCE, 0x2F),
> +       _INIT_DCS_CMD(0xCF, 0x2F),
> +       _INIT_DCS_CMD(0xD0, 0x07),
> +       _INIT_DCS_CMD(0xD2, 0x00),
> +       _INIT_DCS_CMD(0xD3, 0x0D),
> +       _INIT_DCS_CMD(0xD4, 0x17),
> +       _INIT_DCS_CMD(0xD5, 0x26),
> +       _INIT_DCS_CMD(0xD6, 0x31),
> +       _INIT_DCS_CMD(0xD7, 0x3F),
> +       _INIT_DCS_CMD(0xD8, 0x3F),
> +       _INIT_DCS_CMD(0xD9, 0x3F),
> +       _INIT_DCS_CMD(0xDA, 0x3F),
> +       _INIT_DCS_CMD(0xDB, 0x37),
> +       _INIT_DCS_CMD(0xDC, 0x37),
> +       _INIT_DCS_CMD(0xDD, 0x37),
> +       _INIT_DCS_CMD(0xDE, 0x39),
> +       _INIT_DCS_CMD(0xDF, 0x2E),
> +       _INIT_DCS_CMD(0xE0, 0x2F),
> +       _INIT_DCS_CMD(0xE1, 0x2F),
> +       _INIT_DCS_CMD(0xE2, 0x07),
> +       _INIT_DCS_CMD(0xB0, 0x03),
> +       _INIT_DCS_CMD(0xC8, 0x0B),
> +       _INIT_DCS_CMD(0xC9, 0x07),
> +       _INIT_DCS_CMD(0xC3, 0x00),
> +       _INIT_DCS_CMD(0xE7, 0x00),
> +       _INIT_DCS_CMD(0xC5, 0x2A),
> +       _INIT_DCS_CMD(0xDE, 0x2A),
> +       _INIT_DCS_CMD(0xCA, 0x43),
> +       _INIT_DCS_CMD(0xC9, 0x07),
> +       _INIT_DCS_CMD(0xE4, 0xC0),
> +       _INIT_DCS_CMD(0xE5, 0x0D),
> +       _INIT_DCS_CMD(0xCB, 0x00),
> +       _INIT_DCS_CMD(0xB0, 0x06),
> +       _INIT_DCS_CMD(0xB8, 0xA5),
> +       _INIT_DCS_CMD(0xC0, 0xA5),
> +       _INIT_DCS_CMD(0xC7, 0x0F),
> +       _INIT_DCS_CMD(0xD5, 0x32),
> +       _INIT_DCS_CMD(0xB8, 0x00),
> +       _INIT_DCS_CMD(0xC0, 0x00),
> +       _INIT_DCS_CMD(0xBC, 0x00),
> +       _INIT_DCS_CMD(0xB0, 0x07),
> +       _INIT_DCS_CMD(0xB1, 0x00),
> +       _INIT_DCS_CMD(0xB2, 0x02),
> +       _INIT_DCS_CMD(0xB3, 0x0F),
> +       _INIT_DCS_CMD(0xB4, 0x25),
> +       _INIT_DCS_CMD(0xB5, 0x39),
> +       _INIT_DCS_CMD(0xB6, 0x4E),
> +       _INIT_DCS_CMD(0xB7, 0x72),
> +       _INIT_DCS_CMD(0xB8, 0x97),
> +       _INIT_DCS_CMD(0xB9, 0xDC),
> +       _INIT_DCS_CMD(0xBA, 0x22),
> +       _INIT_DCS_CMD(0xBB, 0xA4),
> +       _INIT_DCS_CMD(0xBC, 0x2B),
> +       _INIT_DCS_CMD(0xBD, 0x2F),
> +       _INIT_DCS_CMD(0xBE, 0xA9),
> +       _INIT_DCS_CMD(0xBF, 0x25),
> +       _INIT_DCS_CMD(0xC0, 0x61),
> +       _INIT_DCS_CMD(0xC1, 0x97),
> +       _INIT_DCS_CMD(0xC2, 0xB2),
> +       _INIT_DCS_CMD(0xC3, 0xCD),
> +       _INIT_DCS_CMD(0xC4, 0xD9),
> +       _INIT_DCS_CMD(0xC5, 0xE7),
> +       _INIT_DCS_CMD(0xC6, 0xF4),
> +       _INIT_DCS_CMD(0xC7, 0xFA),
> +       _INIT_DCS_CMD(0xC8, 0xFC),
> +       _INIT_DCS_CMD(0xC9, 0x00),
> +       _INIT_DCS_CMD(0xCA, 0x00),
> +       _INIT_DCS_CMD(0xCB, 0x16),
> +       _INIT_DCS_CMD(0xCC, 0xAF),
> +       _INIT_DCS_CMD(0xCD, 0xFF),
> +       _INIT_DCS_CMD(0xCE, 0xFF),
> +       _INIT_DCS_CMD(0xB0, 0x08),
> +       _INIT_DCS_CMD(0xB1, 0x04),
> +       _INIT_DCS_CMD(0xB2, 0x05),
> +       _INIT_DCS_CMD(0xB3, 0x11),
> +       _INIT_DCS_CMD(0xB4, 0x24),
> +       _INIT_DCS_CMD(0xB5, 0x39),
> +       _INIT_DCS_CMD(0xB6, 0x4F),
> +       _INIT_DCS_CMD(0xB7, 0x72),
> +       _INIT_DCS_CMD(0xB8, 0x98),
> +       _INIT_DCS_CMD(0xB9, 0xDC),
> +       _INIT_DCS_CMD(0xBA, 0x23),
> +       _INIT_DCS_CMD(0xBB, 0xA6),
> +       _INIT_DCS_CMD(0xBC, 0x2C),
> +       _INIT_DCS_CMD(0xBD, 0x30),
> +       _INIT_DCS_CMD(0xBE, 0xAA),
> +       _INIT_DCS_CMD(0xBF, 0x26),
> +       _INIT_DCS_CMD(0xC0, 0x62),
> +       _INIT_DCS_CMD(0xC1, 0x9B),
> +       _INIT_DCS_CMD(0xC2, 0xB5),
> +       _INIT_DCS_CMD(0xC3, 0xCF),
> +       _INIT_DCS_CMD(0xC4, 0xDB),
> +       _INIT_DCS_CMD(0xC5, 0xE8),
> +       _INIT_DCS_CMD(0xC6, 0xF5),
> +       _INIT_DCS_CMD(0xC7, 0xFA),
> +       _INIT_DCS_CMD(0xC8, 0xFC),
> +       _INIT_DCS_CMD(0xC9, 0x00),
> +       _INIT_DCS_CMD(0xCA, 0x00),
> +       _INIT_DCS_CMD(0xCB, 0x16),
> +       _INIT_DCS_CMD(0xCC, 0xAF),
> +       _INIT_DCS_CMD(0xCD, 0xFF),
> +       _INIT_DCS_CMD(0xCE, 0xFF),
> +       _INIT_DCS_CMD(0xB0, 0x09),
> +       _INIT_DCS_CMD(0xB1, 0x04),
> +       _INIT_DCS_CMD(0xB2, 0x02),
> +       _INIT_DCS_CMD(0xB3, 0x16),
> +       _INIT_DCS_CMD(0xB4, 0x24),
> +       _INIT_DCS_CMD(0xB5, 0x3B),
> +       _INIT_DCS_CMD(0xB6, 0x4F),
> +       _INIT_DCS_CMD(0xB7, 0x73),
> +       _INIT_DCS_CMD(0xB8, 0x99),
> +       _INIT_DCS_CMD(0xB9, 0xE0),
> +       _INIT_DCS_CMD(0xBA, 0x26),
> +       _INIT_DCS_CMD(0xBB, 0xAD),
> +       _INIT_DCS_CMD(0xBC, 0x36),
> +       _INIT_DCS_CMD(0xBD, 0x3A),
> +       _INIT_DCS_CMD(0xBE, 0xAE),
> +       _INIT_DCS_CMD(0xBF, 0x2A),
> +       _INIT_DCS_CMD(0xC0, 0x66),
> +       _INIT_DCS_CMD(0xC1, 0x9E),
> +       _INIT_DCS_CMD(0xC2, 0xB8),
> +       _INIT_DCS_CMD(0xC3, 0xD1),
> +       _INIT_DCS_CMD(0xC4, 0xDD),
> +       _INIT_DCS_CMD(0xC5, 0xE9),
> +       _INIT_DCS_CMD(0xC6, 0xF6),
> +       _INIT_DCS_CMD(0xC7, 0xFA),
> +       _INIT_DCS_CMD(0xC8, 0xFC),
> +       _INIT_DCS_CMD(0xC9, 0x00),
> +       _INIT_DCS_CMD(0xCA, 0x00),
> +       _INIT_DCS_CMD(0xCB, 0x16),
> +       _INIT_DCS_CMD(0xCC, 0xAF),
> +       _INIT_DCS_CMD(0xCD, 0xFF),
> +       _INIT_DCS_CMD(0xCE, 0xFF),
> +       _INIT_DCS_CMD(0xB0, 0x0A),
> +       _INIT_DCS_CMD(0xB1, 0x00),
> +       _INIT_DCS_CMD(0xB2, 0x02),
> +       _INIT_DCS_CMD(0xB3, 0x0F),
> +       _INIT_DCS_CMD(0xB4, 0x25),
> +       _INIT_DCS_CMD(0xB5, 0x39),
> +       _INIT_DCS_CMD(0xB6, 0x4E),
> +       _INIT_DCS_CMD(0xB7, 0x72),
> +       _INIT_DCS_CMD(0xB8, 0x97),
> +       _INIT_DCS_CMD(0xB9, 0xDC),
> +       _INIT_DCS_CMD(0xBA, 0x22),
> +       _INIT_DCS_CMD(0xBB, 0xA4),
> +       _INIT_DCS_CMD(0xBC, 0x2B),
> +       _INIT_DCS_CMD(0xBD, 0x2F),
> +       _INIT_DCS_CMD(0xBE, 0xA9),
> +       _INIT_DCS_CMD(0xBF, 0x25),
> +       _INIT_DCS_CMD(0xC0, 0x61),
> +       _INIT_DCS_CMD(0xC1, 0x97),
> +       _INIT_DCS_CMD(0xC2, 0xB2),
> +       _INIT_DCS_CMD(0xC3, 0xCD),
> +       _INIT_DCS_CMD(0xC4, 0xD9),
> +       _INIT_DCS_CMD(0xC5, 0xE7),
> +       _INIT_DCS_CMD(0xC6, 0xF4),
> +       _INIT_DCS_CMD(0xC7, 0xFA),
> +       _INIT_DCS_CMD(0xC8, 0xFC),
> +       _INIT_DCS_CMD(0xC9, 0x00),
> +       _INIT_DCS_CMD(0xCA, 0x00),
> +       _INIT_DCS_CMD(0xCB, 0x16),
> +       _INIT_DCS_CMD(0xCC, 0xAF),
> +       _INIT_DCS_CMD(0xCD, 0xFF),
> +       _INIT_DCS_CMD(0xCE, 0xFF),
> +       _INIT_DCS_CMD(0xB0, 0x0B),
> +       _INIT_DCS_CMD(0xB1, 0x04),
> +       _INIT_DCS_CMD(0xB2, 0x05),
> +       _INIT_DCS_CMD(0xB3, 0x11),
> +       _INIT_DCS_CMD(0xB4, 0x24),
> +       _INIT_DCS_CMD(0xB5, 0x39),
> +       _INIT_DCS_CMD(0xB6, 0x4F),
> +       _INIT_DCS_CMD(0xB7, 0x72),
> +       _INIT_DCS_CMD(0xB8, 0x98),
> +       _INIT_DCS_CMD(0xB9, 0xDC),
> +       _INIT_DCS_CMD(0xBA, 0x23),
> +       _INIT_DCS_CMD(0xBB, 0xA6),
> +       _INIT_DCS_CMD(0xBC, 0x2C),
> +       _INIT_DCS_CMD(0xBD, 0x30),
> +       _INIT_DCS_CMD(0xBE, 0xAA),
> +       _INIT_DCS_CMD(0xBF, 0x26),
> +       _INIT_DCS_CMD(0xC0, 0x62),
> +       _INIT_DCS_CMD(0xC1, 0x9B),
> +       _INIT_DCS_CMD(0xC2, 0xB5),
> +       _INIT_DCS_CMD(0xC3, 0xCF),
> +       _INIT_DCS_CMD(0xC4, 0xDB),
> +       _INIT_DCS_CMD(0xC5, 0xE8),
> +       _INIT_DCS_CMD(0xC6, 0xF5),
> +       _INIT_DCS_CMD(0xC7, 0xFA),
> +       _INIT_DCS_CMD(0xC8, 0xFC),
> +       _INIT_DCS_CMD(0xC9, 0x00),
> +       _INIT_DCS_CMD(0xCA, 0x00),
> +       _INIT_DCS_CMD(0xCB, 0x16),
> +       _INIT_DCS_CMD(0xCC, 0xAF),
> +       _INIT_DCS_CMD(0xCD, 0xFF),
> +       _INIT_DCS_CMD(0xCE, 0xFF),
> +       _INIT_DCS_CMD(0xB0, 0x0C),
> +       _INIT_DCS_CMD(0xB1, 0x04),
> +       _INIT_DCS_CMD(0xB2, 0x02),
> +       _INIT_DCS_CMD(0xB3, 0x16),
> +       _INIT_DCS_CMD(0xB4, 0x24),
> +       _INIT_DCS_CMD(0xB5, 0x3B),
> +       _INIT_DCS_CMD(0xB6, 0x4F),
> +       _INIT_DCS_CMD(0xB7, 0x73),
> +       _INIT_DCS_CMD(0xB8, 0x99),
> +       _INIT_DCS_CMD(0xB9, 0xE0),
> +       _INIT_DCS_CMD(0xBA, 0x26),
> +       _INIT_DCS_CMD(0xBB, 0xAD),
> +       _INIT_DCS_CMD(0xBC, 0x36),
> +       _INIT_DCS_CMD(0xBD, 0x3A),
> +       _INIT_DCS_CMD(0xBE, 0xAE),
> +       _INIT_DCS_CMD(0xBF, 0x2A),
> +       _INIT_DCS_CMD(0xC0, 0x66),
> +       _INIT_DCS_CMD(0xC1, 0x9E),
> +       _INIT_DCS_CMD(0xC2, 0xB8),
> +       _INIT_DCS_CMD(0xC3, 0xD1),
> +       _INIT_DCS_CMD(0xC4, 0xDD),
> +       _INIT_DCS_CMD(0xC5, 0xE9),
> +       _INIT_DCS_CMD(0xC6, 0xF6),
> +       _INIT_DCS_CMD(0xC7, 0xFA),
> +       _INIT_DCS_CMD(0xC8, 0xFC),
> +       _INIT_DCS_CMD(0xC9, 0x00),
> +       _INIT_DCS_CMD(0xCA, 0x00),
> +       _INIT_DCS_CMD(0xCB, 0x16),
> +       _INIT_DCS_CMD(0xCC, 0xAF),
> +       _INIT_DCS_CMD(0xCD, 0xFF),
> +       _INIT_DCS_CMD(0xCE, 0xFF),
> +       _INIT_DCS_CMD(0xB0, 0x00),
> +       _INIT_DCS_CMD(0xB3, 0x08),
> +       _INIT_DCS_CMD(0xB0, 0x04),
> +       _INIT_DCS_CMD(0xB8, 0x68),
> +       _INIT_DELAY_CMD(150),
> +       {},
> +};
> +
> +static inline struct boe_panel *to_boe_panel(struct drm_panel *panel)
> +{
> +       return container_of(panel, struct boe_panel, base);
> +}
> +
> +static int boe_panel_init(struct boe_panel *boe)
> +{
> +       struct mipi_dsi_device *dsi = boe->dsi;
> +       struct drm_panel *panel = &boe->base;
> +       int err, i;
> +
> +       if (boe->desc->init_cmds) {
> +               const struct panel_init_cmd *init_cmds = boe->desc->init_cmds;
> +
> +               for (i = 0; init_cmds[i].len != 0; i++) {
> +                       const struct panel_init_cmd *cmd = &init_cmds[i];
> +
> +                       switch (cmd->type) {
> +                       case DELAY_CMD:
> +                               msleep(cmd->data[0]);
> +                               err = 0;
> +                               break;
> +
> +                       case INIT_DCS_CMD:
> +                               err = mipi_dsi_dcs_write(dsi, cmd->data[0],
> +                                                        cmd->len <= 1 ? NULL :
> +                                                        &cmd->data[1],
> +                                                        cmd->len - 1);
> +                               break;
> +                       }
> +
> +                       if (err < 0) {
> +                               dev_err(panel->dev,
> +                                       "failed to write command %u\n", i);
> +                               return err;
> +                       }
> +               }
> +       }
> +       return 0;
> +}
> +
> +static int boe_panel_off(struct boe_panel *boe)
> +{
> +       struct mipi_dsi_device *dsi = boe->dsi;
> +       int ret;
> +
> +       dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +       ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int boe_panel_disable(struct drm_panel *panel)
> +{
> +       struct boe_panel *boe = to_boe_panel(panel);
> +
> +       if (!boe->enabled)
> +               return 0;
> +
> +       backlight_disable(boe->backlight);
> +
> +       boe->enabled = false;
> +
> +       return 0;
> +}
> +
> +static int boe_panel_unprepare(struct drm_panel *panel)
> +{
> +       struct boe_panel *boe = to_boe_panel(panel);
> +       int ret;
> +
> +       if (!boe->prepared)
> +               return 0;
> +
> +       ret = boe_panel_off(boe);
> +       if (ret < 0) {
> +               dev_err(panel->dev, "failed to set panel off: %d\n", ret);
> +               return ret;
> +       }
> +
> +       msleep(150);
> +       if (boe->enable_gpio)
> +               gpiod_set_value(boe->enable_gpio, 0);
> +       usleep_range(500, 1000);
> +       regulator_disable(boe->avee);
> +       regulator_disable(boe->avdd);
> +       usleep_range(5000, 7000);
> +       regulator_disable(boe->pp1800);
> +
> +       boe->prepared = false;
> +
> +       return 0;
> +}
> +
> +static int boe_panel_prepare(struct drm_panel *panel)
> +{
> +       struct boe_panel *boe = to_boe_panel(panel);
> +       int ret;
> +
> +       if (boe->prepared)
> +               return 0;
> +
> +       if (boe->enable_gpio) {
> +               gpiod_set_value(boe->enable_gpio, 0);
> +               usleep_range(1000, 1500);
> +       }
> +
> +       ret = regulator_enable(boe->pp1800);
> +       if (ret < 0)
> +               return ret;
> +
> +       usleep_range(3000, 5000);
> +
> +       ret = regulator_enable(boe->avdd);
> +       if (ret < 0)
> +               goto poweroff1v8;
> +       ret = regulator_enable(boe->avee);
> +       if (ret < 0)
> +               goto poweroffavdd;
> +
> +       msleep(100);
> +
> +       if (boe->enable_gpio) {
> +               gpiod_set_value(boe->enable_gpio, 1);
> +               usleep_range(10000, 12000);
> +       }
> +
> +       ret = boe_panel_init(boe);
> +       if (ret < 0) {
> +               dev_err(panel->dev, "failed to init panel: %d\n", ret);
> +               goto poweroff;
> +       }
> +
> +       boe->prepared = true;
> +
> +       return 0;
> +
> +poweroff:
> +       regulator_disable(boe->avee);
> +poweroffavdd:
> +       regulator_disable(boe->avdd);
> +poweroff1v8:
> +       usleep_range(5000, 7000);
> +       regulator_disable(boe->pp1800);
> +       if (boe->enable_gpio)
> +               gpiod_set_value(boe->enable_gpio, 0);
> +       return ret;
> +}
> +
> +static int boe_panel_enable(struct drm_panel *panel)
> +{
> +       struct boe_panel *boe = to_boe_panel(panel);
> +       int ret;
> +
> +       if (boe->enabled)
> +               return 0;
> +
> +       ret = backlight_enable(boe->backlight);
> +       if (ret) {
> +               dev_err(panel->dev, "Failed to enable backlight %d\n",
> +                       ret);
> +               return ret;
> +       }
> +
> +       boe->enabled = true;
> +
> +       return 0;
> +}
> +
> +static const struct drm_display_mode boe_default_mode = {
> +       .clock = 159425,
> +       .hdisplay = 1200,
> +       .hsync_start = 1200 + 100,
> +       .hsync_end = 1200 + 100 + 40,
> +       .htotal = 1200 + 100 + 40 + 24,
> +       .vdisplay = 1920,
> +       .vsync_start = 1920 + 10,
> +       .vsync_end = 1920 + 10 + 14,
> +       .vtotal = 1920 + 10 + 14 + 4,
> +       .vrefresh = 60,
> +       .type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static const struct panel_desc boe_tv101wum_nl6_desc = {
> +       .modes = &boe_default_mode,
> +       .bpc = 8,
> +       .size = {
> +               .width = 216,
> +               .height = 135,
> +       },
> +       .lanes = 4,
> +       .format = MIPI_DSI_FMT_RGB888,
> +       .mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +                     MIPI_DSI_MODE_LPM,
> +       .init_cmds = boe_init_cmd,
> +};
> +
> +static int boe_panel_get_modes(struct drm_panel *panel)
> +{
> +       struct boe_panel *boe = to_boe_panel(panel);
> +       const struct drm_display_mode *m = boe->desc->modes;
> +       struct drm_display_mode *mode;
> +
> +       mode = drm_mode_duplicate(panel->drm, m);
> +       if (!mode) {
> +               dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
> +                       m->hdisplay, m->vdisplay, m->vrefresh);
> +               return -ENOMEM;
> +       }
> +
> +       drm_mode_set_name(mode);
> +

Sam suggested adding this here:
mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;

> +       drm_mode_probed_add(panel->connector, mode);
> +
> +       panel->connector->display_info.width_mm = boe->desc->size.width;
> +       panel->connector->display_info.height_mm = boe->desc->size.height;
> +       panel->connector->display_info.bpc = boe->desc->bpc;
> +
> +       return 1;
> +}
> +
> +static const struct drm_panel_funcs boe_panel_funcs = {
> +       .disable = boe_panel_disable,
> +       .unprepare = boe_panel_unprepare,
> +       .prepare = boe_panel_prepare,
> +       .enable = boe_panel_enable,
> +       .get_modes = boe_panel_get_modes,
> +};
> +
> +static int boe_panel_add(struct boe_panel *boe)
> +{
> +       struct device *dev = &boe->dsi->dev;
> +
> +       boe->avdd = devm_regulator_get(dev, "avdd");
> +       if (IS_ERR(boe->avdd))
> +               return PTR_ERR(boe->avdd);
> +
> +       boe->avee = devm_regulator_get(dev, "avee");
> +       if (IS_ERR(boe->avee))
> +               return PTR_ERR(boe->avee);
> +
> +       boe->pp1800 = devm_regulator_get(dev, "pp1800");
> +       if (IS_ERR(boe->pp1800))
> +               return PTR_ERR(boe->pp1800);
> +
> +       boe->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
> +       if (IS_ERR(boe->enable_gpio)) {
> +               dev_err(dev, "cannot get reset-gpios %ld\n",
> +                       PTR_ERR(boe->enable_gpio));
> +               return PTR_ERR(boe->enable_gpio);
> +       }
> +
> +       gpiod_set_value(boe->enable_gpio, 0);
> +
> +       boe->backlight = devm_of_find_backlight(dev);
> +       if (IS_ERR(boe->backlight))
> +               return PTR_ERR(boe->backlight);
> +
> +       drm_panel_init(&boe->base);
> +       boe->base.funcs = &boe_panel_funcs;
> +       boe->base.dev = &boe->dsi->dev;
> +
> +       return drm_panel_add(&boe->base);
> +}
> +
> +static int boe_panel_probe(struct mipi_dsi_device *dsi)
> +{
> +       struct boe_panel *boe;
> +       int ret;
> +       const struct panel_desc *desc;
> +
> +       boe = devm_kzalloc(&dsi->dev, sizeof(*boe), GFP_KERNEL);
> +       if (!boe)
> +               return -ENOMEM;
> +
> +       desc = of_device_get_match_data(&dsi->dev);
> +       dsi->lanes = desc->lanes;
> +       dsi->format = desc->format;
> +       dsi->mode_flags = desc->mode_flags;
> +       boe->desc = desc;
> +       boe->dsi = dsi;
> +       ret = boe_panel_add(boe);
> +       if (ret < 0)
> +               return ret;
> +
> +       mipi_dsi_set_drvdata(dsi, boe);
> +
> +       return mipi_dsi_attach(dsi);
> +}
> +
> +static int boe_panel_remove(struct mipi_dsi_device *dsi)
> +{
> +       struct boe_panel *boe = mipi_dsi_get_drvdata(dsi);
> +       int ret;
> +
> +       ret = boe_panel_disable(&boe->base);
> +       if (ret < 0)
> +               dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);
> +
> +       ret = mipi_dsi_detach(dsi);
> +       if (ret < 0)
> +               dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
> +
> +       if (boe->base.dev)
> +               drm_panel_remove(&boe->base);
> +
> +       return 0;
> +}
> +
> +static void boe_panel_shutdown(struct mipi_dsi_device *dsi)
> +{
> +       struct boe_panel *boe = mipi_dsi_get_drvdata(dsi);
> +
> +       boe_panel_disable(&boe->base);
> +}
> +
> +static const struct of_device_id boe_of_match[] = {
> +       { .compatible = "boe,tv101wum-nl6",
> +         .data = &boe_tv101wum_nl6_desc
> +       },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, boe_of_match);
> +
> +static struct mipi_dsi_driver boe_panel_driver = {
> +       .driver = {
> +               .name = "panel-boe-tv101wum-nl6",
> +               .of_match_table = boe_of_match,
> +       },
> +       .probe = boe_panel_probe,
> +       .remove = boe_panel_remove,
> +       .shutdown = boe_panel_shutdown,
> +};
> +module_mipi_dsi_driver(boe_panel_driver);
> +
> +MODULE_AUTHOR("Jitao Shi <jitao.shi@mediatek.com>");
> +MODULE_DESCRIPTION("BOE tv101wum-nl6 1200x1920 video mode panel driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.21.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
