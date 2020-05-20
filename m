Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551F71DB0CD
	for <lists+linux-pwm@lfdr.de>; Wed, 20 May 2020 12:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgETK7l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 May 2020 06:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETK7l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 May 2020 06:59:41 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F44C061A0E;
        Wed, 20 May 2020 03:59:39 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g7so1091795uap.7;
        Wed, 20 May 2020 03:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CXGaKccVrRy36L43Nke8P+zhim7bpSfiT4aGLV8CKcA=;
        b=gjE595vXwYwWb9RsVXte3hkyNLKaKLXIfqRmP3wfz4Q35f2vBm56o9xjAIOm4ofxRz
         /pitgVFqXv7tx/J5njhqQvse0iyN9L6LSDQXJqTtib1g/JUb437VTS39XK6jAQrY4+9k
         oxSdnsxnxbIrJa2DPBKn+MvewMRlq/mXBBSrIuv0Lsdq2kjUiUUkgBT9Afi01jgUHIyV
         WA3bTZ0XEBv1AFSH6WRpZdlxnhWNplSt1OB5mjNtBzTQ8lmssykQWwTvFKJ/aK7tO3d1
         CLDoGRshoZ5uSgkJ2wJe8JOm840PXTF2VXwSwA0kDJnD3tGn25jYXslVjxxYob986b2l
         7CgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXGaKccVrRy36L43Nke8P+zhim7bpSfiT4aGLV8CKcA=;
        b=tXe48ENgvrzY/n6A4QQ6L7kKW4zcIl4C2nz8ESlAfA3bbrGf3DUQ7Xb+CT67muM7Jl
         vCQSzF7F8rLYpZSBTby1/LL1gLLWdskQhtDQyku/i7BhIcSVAHAxzwJ3x5As7o0ZMB5S
         HFPGIDtBvCW53IOCJ+ENQWZfFONacyurN2VO3lfW3BcUKTbw13Rab+v2O6Ty9rgb08hP
         8YdCSacwyPUBh80kfqcJA5aPmL702xSeqc0pIdFQQxqTdA6qGrfImO4GGWQUYfsvXetK
         /TiMm4aDigcedumDfnLmGI/qCgBAcYV9kYx+Q6oHe2mNoD3v/vTZxe7CIbUaaFZNP6zl
         ArYA==
X-Gm-Message-State: AOAM5320k3drgWSLa63zb2pv6lcIXxJBrUx3uX43eQc5uoUnMTGOZpKY
        6ZQK9TQVZD7MzH3XGLg6ko3mSUKkVy1UdX8B7oE=
X-Google-Smtp-Source: ABdhPJyvHJkmJbRptDh8mQ4oHd78/X7Er/4FZ5Lj5ztGvU007xdvuspQeMjeeyWTK3Fw7+MINPYnYsWh9TxmVdhbooo=
X-Received: by 2002:ab0:4e0d:: with SMTP id g13mr2929360uah.64.1589972379086;
 Wed, 20 May 2020 03:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200517190139.740249-1-sam@ravnborg.org> <20200517190139.740249-17-sam@ravnborg.org>
In-Reply-To: <20200517190139.740249-17-sam@ravnborg.org>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 20 May 2020 11:56:43 +0100
Message-ID: <CACvgo51C6zb_K3DBwG-xhf9=baoxmcp8YeCFEyB3XvqA5p7r2A@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] backlight: use backlight_is_blank() in all
 backlight drivers
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-pwm@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        patches@opensource.cirrus.com,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Sam,

On Sun, 17 May 2020 at 20:02, Sam Ravnborg <sam@ravnborg.org> wrote:

> --- a/drivers/video/backlight/88pm860x_bl.c
> +++ b/drivers/video/backlight/88pm860x_bl.c
> @@ -123,13 +123,7 @@ static int pm860x_backlight_update_status(struct backlight_device *bl)
>  {
>         int brightness = bl->props.brightness;
>
> -       if (bl->props.power != FB_BLANK_UNBLANK)
> -               brightness = 0;
> -
> -       if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> -               brightness = 0;
> -
> -       if (bl->props.state & BL_CORE_SUSPENDED)
> +       if (backlight_is_blank(bl))
>                 brightness = 0;
Off the top of my head, the above two lines should really be in backlight core.
There's nothing driver specific to them, plus it minimises the chances
of next-driver getting it wrong.


> --- a/drivers/video/backlight/as3711_bl.c
> +++ b/drivers/video/backlight/as3711_bl.c
> @@ -107,13 +107,11 @@ static int as3711_bl_update_status(struct backlight_device *bl)
>         int brightness = bl->props.brightness;
>         int ret = 0;
>
> -       dev_dbg(&bl->dev, "%s(): brightness %u, pwr %x, blank %x, state %x\n",
> +       dev_dbg(&bl->dev, "%s(): brightness %u, pwr %x, state %x\n",
>                 __func__, bl->props.brightness, bl->props.power,
> -               bl->props.fb_blank, bl->props.state);
> +               bl->props.state);
>
Let's also move this to backlight core.

-Emil
