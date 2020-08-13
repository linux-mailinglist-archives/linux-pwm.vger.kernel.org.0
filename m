Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817FD243AF3
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Aug 2020 15:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHMNqC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Aug 2020 09:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgHMNqB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Aug 2020 09:46:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB259C061757
        for <linux-pwm@vger.kernel.org>; Thu, 13 Aug 2020 06:46:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p20so5363905wrf.0
        for <linux-pwm@vger.kernel.org>; Thu, 13 Aug 2020 06:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+mDarYxBbq/J7Ixc+CG3XEZjLyzyzKfnJvqheYjMPSo=;
        b=XYEFqrb5M5fB90DCMr82s6xu+3kUi6clBH3J28tKhMKeygyzSyUtxHNkRA/aXIPrip
         /KqR/1taagrKL2diCV5inDH2lOvvXlLdeLhm3SxNslPAp9BnkdXdUkeaPxLrV07LMk8F
         vnJEQrP2qAqie3vzkghqQtRDLvf8N2RATLMESMuSYNxOAendWUG/PVRbBlTNmYpRunj2
         NqA9kyuj7qTxop4DFEjiMJUfkzt8sIEUFt/eCzfIzJYShJ8cI35gx4jmzRgqBK4FEbgP
         nb9ccd1ky7aEbw2chQw5x5eD/J1I23/yWnTg2P0J1tgAo2d2umAFUtxPbYPA9gWBniYm
         b7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+mDarYxBbq/J7Ixc+CG3XEZjLyzyzKfnJvqheYjMPSo=;
        b=WRNvTLBEWYbHLgYkCk7LnwXdSqLOUnCgpsG7FhX4lCmzNuswYgmpDNKOl4Fo78w4V1
         tFaokR9kNqaTFKzReqL8cyRKIbIbjywHDEWjNf2aT/PhSBmkxrfPdWIzsvepxQZsl/OF
         7uJCEPTlBFBq2l/G8FX39Av3w2jHjqqcghXX0yt5toI8nGmWTGwq1bBEuhThoPTHhosh
         QX18tWOcSsSUdeNzbpLt3Yl9JfWtVKDqmTrtOECTSvLGa8ozrn4k0vVRjJ02eCTPE5ye
         HEGO+1e4W4f8/BO2DNGcZJ5fQ52B/yU1SDCs8wUUeFbfJC0bh/syR0VZCX6jN3+avgRQ
         eBqQ==
X-Gm-Message-State: AOAM532ghqn3BgJblrE0uUTwdSKyUMRVwHKWJDuzuxDSz/RT0ASy/4V2
        Znj6898WXylKkjyTaWpUbuH/nw==
X-Google-Smtp-Source: ABdhPJx7xfjEhBxs/ZAYptGT+NyxCdP60vku9IappFsc1k/bm/potYSblfH9oTAcEG9YnIt13D4dGw==
X-Received: by 2002:adf:ab46:: with SMTP id r6mr4167024wrc.260.1597326359282;
        Thu, 13 Aug 2020 06:45:59 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d14sm10603833wre.44.2020.08.13.06.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 06:45:57 -0700 (PDT)
Date:   Thu, 13 Aug 2020 14:45:53 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Alexandru Stan <amstan@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH 2/3] backlight: pwm_bl: Artificially add 0% during
 interpolation
Message-ID: <20200813134553.2hykfvqjtgr4e2pl@holly.lan>
References: <20200721042522.2403410-1-amstan@chromium.org>
 <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
 <20200807082113.GI6419@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807082113.GI6419@phenom.ffwll.local>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 07, 2020 at 10:21:13AM +0200, daniel@ffwll.ch wrote:
> On Mon, Jul 20, 2020 at 09:25:21PM -0700, Alexandru Stan wrote:
> > Some displays need the low end of the curve cropped in order to make
> > them happy. In that case we still want to have the 0% point, even though
> > anything between 0% and 5%(example) would be skipped.
> > 
> > Signed-off-by: Alexandru Stan <amstan@chromium.org>
> > ---
> > 
> >  drivers/video/backlight/pwm_bl.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index 5193a72305a2..b24711ddf504 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -349,6 +349,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
> >  			/* Fill in the last point, since no line starts here. */
> >  			table[x2] = y2;
> >  
> > +			/*
> > +			 * If we don't start at 0 yet we're increasing, assume
> > +			 * the dts wanted to crop the low end of the range, so
> > +			 * insert a 0 to provide a display off mode.
> > +			 */
> > +			if (table[0] > 0 && table[0] < table[num_levels - 1])
> > +				table[0] = 0;
> 
> Isn't that what the enable/disable switch in backlights are for? There's
> lots of backligh drivers (mostly the firmware variety) where setting the
> backlight to 0 does not shut it off, it's just the lowest setting.
> 
> But I've not been involved in the details of these discussions.

It's been a long standing complaint that the backlight drivers are not
consistent w.r.t. whether 0 means off or lowest. The most commonly used
backlights (ACPI in particular) do not adopt 0 means off but lots of
specific drivers do.

IMHO what is "right" depends on the display technology. For displays
that are essentially black when the backlight is off and become
difficult or impossible to read I'm a little dubious about standardizing
on zero means off. There are situations when zero means off
does make sense however. For example front-lit or transflexive displays
are readable when the "backlight" is off and on these displays it would
make sense.


Daniel.
