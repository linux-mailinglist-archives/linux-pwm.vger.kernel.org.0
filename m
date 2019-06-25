Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92C05200D
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jun 2019 02:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfFYAnK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jun 2019 20:43:10 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41026 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbfFYAnK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jun 2019 20:43:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id c11so11254878qkk.8
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jun 2019 17:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2ogumH57Dk+mOO0y5/CmcdAve3k/tPr0Lofkj3W1yQ=;
        b=gn85bRpxX7rX0vPi2OF9kz6nsjSpDytW5uaW02EslXpNifmNJJW+bfXA/vNHvtnfyd
         LEbGvEe0UTmhomOdUgl3WLDYKeBbP9GS8Ul3o4lm0omA18ix5UVvi5y53tJ9mWlSYZ+O
         2tGmkRpE9D4p4h3dyylbbuMMhbJXozsVkMUW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2ogumH57Dk+mOO0y5/CmcdAve3k/tPr0Lofkj3W1yQ=;
        b=JVNN3iIrqcqhPQCNdjANNDJzfS8sS0bQ6F1ggsYBVmlMs8B2sxP3NKxUlJ8oyCZxRK
         hvItidGajcj9muSckGE1YeiW0VrcnsYHnNkTMBukUtlp66sEIKYBGgmAaRAJ8t4CtIdd
         cXgzv2X7Q7SjKCrVbibN+8lLtoWxcX5XDDPlvNjU34RVIvqSDomDN62dkBEHHqzf6DTm
         9uaBw3LNuWe7lLA1P+fnQ6Ce8HyYCxVQp3jiUskCNyYDeYcHWxgCFN4fo1Phkg7ASMwb
         8ZDv7WuFa5gqxZtweBxbrxZSy5Iw1BpB/ZRAW0WPiwJCliUSy8GqWgXO8e+c7KPvmGWh
         Nudg==
X-Gm-Message-State: APjAAAUD2VjMUYNCgbKEa8S1CBzFbH/qRzbmFSpiBx8n45fL//ujRzQ7
        rGXxtth++DGqIehSI8E1uVfFnkSka45fVIRKYAHXzQ==
X-Google-Smtp-Source: APXvYqwwA4s9JiBdyoHXEJ7/imxeIhWDD7nr1Z+Ib6NtNVV+u9MWlCR9lGtMIebURg5vdee28cPPsppvaqexL5f8k3E=
X-Received: by 2002:a37:9c88:: with SMTP id f130mr19471044qke.457.1561423388940;
 Mon, 24 Jun 2019 17:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190624080001.67222-1-jitao.shi@mediatek.com> <20190624080001.67222-3-jitao.shi@mediatek.com>
In-Reply-To: <20190624080001.67222-3-jitao.shi@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 25 Jun 2019 08:42:57 +0800
Message-ID: <CANMq1KDixwQN13o84Jp6E6tyfTQSZjiZSMzaNFZ02LEVPx0Z8g@mail.gmail.com>
Subject: Re: [v2 2/2] drm/panel: support for auo, kd101n80-45na wuxga dsi
 video mode panel
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

On Mon, Jun 24, 2019 at 4:00 PM Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> Auo,kd101n80-45na's connector is same as boe,tv101wum-nl6.
> The most codes can be reuse.
> So auo,kd101n80-45na and boe,tv101wum-nl6 use one driver file.
> Add the different parts in driver data.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index 6e06c8506623..d1ee43cfcbe2 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -372,6 +372,15 @@ static const struct panel_init_cmd boe_init_cmd[] = {
>         {},
>  };
>
> +static const struct panel_init_cmd auo_init_cmd[] = {
> +       _INIT_DELAY_CMD(24),
> +       _INIT_DCS_CMD(0x11),
> +       _INIT_DELAY_CMD(120),
> +       _INIT_DCS_CMD(0x29),
> +       _INIT_DELAY_CMD(120),
> +       {},
> +};
> +
>  static inline struct boe_panel *to_boe_panel(struct drm_panel *panel)
>  {
>         return container_of(panel, struct boe_panel, base);
> @@ -572,6 +581,34 @@ static const struct panel_desc boe_tv101wum_nl6_desc = {
>         .init_cmds = boe_init_cmd,
>  };
>
> +static const struct drm_display_mode auo_default_mode = {
> +       .clock = 157000,
> +       .hdisplay = 1200,
> +       .hsync_start = 1200 + 80,
> +       .hsync_end = 1200 + 80 + 24,
> +       .htotal = 1200 + 80 + 24 + 36,
> +       .vdisplay = 1920,
> +       .vsync_start = 1920 + 16,
> +       .vsync_end = 1920 + 16 + 4,
> +       .vtotal = 1920 + 16 + 4 + 16,
> +       .vrefresh = 60,
> +       .type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static const struct panel_desc auo_kd101n80_45na_desc = {
> +       .modes = &auo_default_mode,
> +       .bpc = 8,
> +       .size = {
> +               .width = 216,
> +               .height = 135,

Same issue as the BOE panel:
This is wrong, as this is a portrait panel, should be: width=135, height=216.

> +       },
> +       .lanes = 4,
> +       .format = MIPI_DSI_FMT_RGB888,
> +       .mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +                     MIPI_DSI_MODE_LPM,
> +       .init_cmds = auo_init_cmd,
> +};
> +
>  static int boe_panel_get_modes(struct drm_panel *panel)
>  {
>         struct boe_panel *boe = to_boe_panel(panel);
> @@ -695,6 +732,9 @@ static const struct of_device_id boe_of_match[] = {
>         { .compatible = "boe,tv101wum-nl6",
>           .data = &boe_tv101wum_nl6_desc
>         },
> +       { .compatible = "auo,kd101n80-45na",
> +         .data = &auo_kd101n80_45na_desc
> +       },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, boe_of_match);
> --
> 2.21.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
