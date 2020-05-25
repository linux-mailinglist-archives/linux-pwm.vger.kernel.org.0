Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405FF1E0922
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2020 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389193AbgEYImj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 May 2020 04:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388945AbgEYImj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2020 04:42:39 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F187C05BD43
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 01:42:38 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z22so10122645lfd.0
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 01:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fufxDxITtQnE6s70Vl4sAmvROZfNgK/lnJ+q52QoA08=;
        b=B4NCIL9eH5VkJg+3BOtXsB/4FvA300STIxScRIIPS4HVgfErSzfBb7j+bUOrdxj8bP
         8KvOprIyUKavWNZiHVVB7BNqECV1CUm2jxENHlrIS5rBTRoytQxzt6v6UGy4y7kEQ51a
         rymSWHXsqX5Ly7N0hxtUmPl0M2QH2KjVQH/2PTmnnnCKbCzBcQz9sqPlJJs70HxVa/UA
         YRqt6ZK/sluabIIsP2rLfJOWRpCetX89d3YyA1DaejdK78CciWO/NA0abs61968wwdst
         XzafG+S/tVSMcZWx37PpTjM+8XlWGHD54l58JaY91vRq0pjKTrMLgo+5TX828LU+6rnm
         sNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fufxDxITtQnE6s70Vl4sAmvROZfNgK/lnJ+q52QoA08=;
        b=J+lxS0MDbC859uT60bP52pNyC3A5ATx+0Estb7qoXZPrXZNTVFpbvfbeFQVDEQRL2C
         I7XKnD3UTXFtFzGOag2e6LnrP0e/IvE4Aa9C0IUiJ/0DfO6/I2KUNnYuNfUct/ozJuE8
         q9k7dAeoN+ev2flQs0kTj2BbMYxRrhsFzfuSE1aWAmY2Gr6gw6+YxzI4tRbSVqnFqMdL
         yldfUJPUQCeuQsvt6oUUYiCMSBu2WA8MFgWuz3DmzVaByvyQJaY7VoBSlnDmMdK1dQd4
         nH8odRRX1TCy2ZRLhYTHzwB2c0sciv7xY4DrYKcSNYczXHTVI4ORjLbJHj+eK0YsdzPG
         vt2Q==
X-Gm-Message-State: AOAM531b7ptjNcvghyE3WlkuDKnCe9bg79VYyk6q5sEQNB3kkby/PTm0
        MJG8fv7sJf0QiFO7bNEBgF5kSxLcw5I+nzLpMlvx4g==
X-Google-Smtp-Source: ABdhPJzsphYazIbu7mz6UJN+2f7Cmj8mlM7rqS2oT8+3v5YRHwjakHAMdNfDoBlqNzR4RXRuZLynv8GOpP/54ZD+Bjw=
X-Received: by 2002:ac2:414c:: with SMTP id c12mr13977881lfi.47.1590396157054;
 Mon, 25 May 2020 01:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200517190139.740249-1-sam@ravnborg.org> <20200517190139.740249-2-sam@ravnborg.org>
 <CACRpkdbogVA=12Xzh6jC0AaE7DrH8Z7iVuG3s_gS4MQBYF61Dw@mail.gmail.com> <20200518101609.GA759699@ravnborg.org>
In-Reply-To: <20200518101609.GA759699@ravnborg.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 10:42:26 +0200
Message-ID: <CACRpkdY=ROLjHb70=tckOPUDBoinT4XtcUvZSaNxND7HZD5H+g@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] video: amba-clcd: use devm_of_find_backlight
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        MSM <linux-arm-msm@vger.kernel.org>, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Russell King <linux@armlinux.org.uk>,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 18, 2020 at 12:16 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Linus.
>
> On Mon, May 18, 2020 at 10:10:12AM +0200, Linus Walleij wrote:
> > On Sun, May 17, 2020 at 9:01 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > > Look up backlight device using devm_of_find_backlight().
> > > This simplifies the code and prevents us from hardcoding
> > > the node name in the driver.
> > >
> > > v2:
> > >   - Added Cc: Peter Ujfalusi
> > >
> > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Jani Nikula <jani.nikula@intel.com>
> > > Cc: Douglas Anderson <dianders@chromium.org>
> >
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Thanks. I went ahead and applied this now, so we could kill
> the last user of of_find_backlight_by_node().
>
> I hope we can make of_find_backlight_by_node() static after the merge window
> so no new users appears.

For this driver (drivers/video/fbdev/amba-clcd.c) there are zero
users after the merge window (all users moved over to DRM) so
I plan to retire it completely.

Yours,
Linus Walleij
