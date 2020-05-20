Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45281DB072
	for <lists+linux-pwm@lfdr.de>; Wed, 20 May 2020 12:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgETKon (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 May 2020 06:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETKon (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 May 2020 06:44:43 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC73EC061A0E;
        Wed, 20 May 2020 03:44:42 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id u2so1501233vsi.13;
        Wed, 20 May 2020 03:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8Ed4esVyLwxGK/ed6iQzqE+rcqzfGB1NnWxeSSQtK0=;
        b=LMo7BXsekhXmrXHuaiP1G2MkQ1j914Wla5i0ywG6W9XT0iquGvIPV3BliE8K0E5xc7
         NObMTM0aP22cwtd5HNWPz44lIo1j0IKbRsKmQqMAAiBhyugOEVfLTeZriyknUuhst1Ib
         fx9nFEbo1NA1tz0ATqqVuLzPfI2ztMG3B0zGQgLtsW1xw+goXzOjiE4TPiP88S/wPoi9
         gRb+vlVisdLUGuRyE3URXw+fgu0YrgTPd0KSBTSmjBbpy1M8ii1Shg86dpUc2T3qAL4F
         upyAOzqhccKkVDERI8W7zS4G9haYdfwLAPfz0WvsIT2UJbhwrfv4Zl3Y5PB6Iobxa2OM
         B/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8Ed4esVyLwxGK/ed6iQzqE+rcqzfGB1NnWxeSSQtK0=;
        b=eU7vD3ttGPDqs0X4LZhagqWZD2KjRu7i9Vl5Y1CEOjTRdoPb0kbGOdgtUuMf7HPIsf
         4ubk7LU3gnIB1AooIMs8l92+QSWti8GNGd5+4M2wAAOT2Dd3Lju1BtAwci2E0HcYq0SS
         5EuXunTZQaJgqPg0GuPVSsLJX6gLF3eRDTykehztEH1ieRA23HK7n3kr5AUQ5aYJTHLO
         A+GUiFukmHM4QfdcDqY4uaKckypzIVAQ6AhnZ+95s0SgmXOkPY75GOstcI58TTbNg/UE
         eDqcYGIWEtzccOLtM8KbBwz9UR5Cfuq6P6nIq7sakUJK/RPXoMo4jb3ULa2VD0LGNXOf
         kImA==
X-Gm-Message-State: AOAM533jXsjHzTBO3Yw9T5e8LtsuijBcVAxpPaq2a06drj0Bpd94A1hR
        gjg06hLoEg4nxMTOAWC6G27oYSaBBbKHLR+A5kA=
X-Google-Smtp-Source: ABdhPJyuWRsi6C3bfq5M4MOyQ9byWY9bxWsctP/KplOAKui4DADof0x9My3MNA1jStEseX1SLxjQp7LPJ3e6/IGtfGI=
X-Received: by 2002:a67:ff14:: with SMTP id v20mr2696940vsp.118.1589971481760;
 Wed, 20 May 2020 03:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200517190139.740249-1-sam@ravnborg.org> <20200517190139.740249-3-sam@ravnborg.org>
In-Reply-To: <20200517190139.740249-3-sam@ravnborg.org>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 20 May 2020 11:41:46 +0100
Message-ID: <CACvgo50p6M59C-cdwCUFYNE7pWBA-oTwa9EN90yrkOkW2S-BKA@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] backlight: refactor fb_notifier_callback()
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
>
> Increase readability of fb_notifier_callback() by removing
> a few indent levels.
> No functional change.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  drivers/video/backlight/backlight.c | 43 +++++++++++++++--------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index cac3e35d7630..17f04cff50ab 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -58,28 +58,29 @@ static int fb_notifier_callback(struct notifier_block *self,
>
>         bd = container_of(self, struct backlight_device, fb_notif);
>         mutex_lock(&bd->ops_lock);
> -       if (bd->ops)
> -               if (!bd->ops->check_fb ||
> -                   bd->ops->check_fb(bd, evdata->info)) {
> -                       fb_blank = *(int *)evdata->data;
> -                       if (fb_blank == FB_BLANK_UNBLANK &&
> -                           !bd->fb_bl_on[node]) {
> -                               bd->fb_bl_on[node] = true;
> -                               if (!bd->use_count++) {
> -                                       bd->props.state &= ~BL_CORE_FBBLANK;
> -                                       bd->props.fb_blank = FB_BLANK_UNBLANK;
> -                                       backlight_update_status(bd);
> -                               }
> -                       } else if (fb_blank != FB_BLANK_UNBLANK &&
> -                                  bd->fb_bl_on[node]) {
> -                               bd->fb_bl_on[node] = false;
> -                               if (!(--bd->use_count)) {
> -                                       bd->props.state |= BL_CORE_FBBLANK;
> -                                       bd->props.fb_blank = fb_blank;
> -                                       backlight_update_status(bd);
> -                               }
> -                       }
> +
> +       if (!bd->ops)
> +               goto out;
> +       if (bd->ops->check_fb && !bd->ops->check_fb(bd, evdata->info))
Mildly related: Would be a nice to define which ops are mandatory and
which aren't.
That plus enforcement in backlight_device_register.

But that's for another patchset.

> +               goto out;
> +
> +       fb_blank = *(int *)evdata->data;
> +       if (fb_blank == FB_BLANK_UNBLANK && !bd->fb_bl_on[node]) {
> +               bd->fb_bl_on[node] = true;
> +               if (!bd->use_count++) {
> +                       bd->props.state &= ~BL_CORE_FBBLANK;
> +                       bd->props.fb_blank = FB_BLANK_UNBLANK;
> +                       backlight_update_status(bd);
> +               }
> +       } else if (fb_blank != FB_BLANK_UNBLANK && bd->fb_bl_on[node]) {
> +               bd->fb_bl_on[node] = false;
> +               if (!(--bd->use_count)) {
> +                       bd->props.state |= BL_CORE_FBBLANK;
> +                       bd->props.fb_blank = fb_blank;
> +                       backlight_update_status(bd);
>                 }
Something like the following reads better, plus one could simplify it
with follow-on patch.

if (fb_blank == FB_BLANK_UNBLANK)
    if (!bd->fb_bl_on[node] && !bd->use_count++) {
        bd->props.state &= ~BL_CORE_FBBLANK;
        bd->props.fb_blank = FB_BLANK_UNBLANK;
        backlight_update_status(bd);
        // above is backlight_enable()
    }
    bd->fb_bl_on[node] = true;
} else {
    if (bd->fb_bl_on[node] && !(--bd->use_count)) {
        bd->props.state |= BL_CORE_FBBLANK;
        bd->props.fb_blank = fb_blank;
        backlight_update_status(bd);
        // above is backlight_disable()
   }
    bd->fb_bl_on[node] = false;
}

As-is, one cannot use the backlight helpers indicated, since it
touches .power. First one should ensure the drivers honour .power - by
using the helper introduced later.

-Emil
