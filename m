Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E22381731
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Aug 2019 12:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfHEKhz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Aug 2019 06:37:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55416 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfHEKhz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Aug 2019 06:37:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so74218929wmj.5
        for <linux-pwm@vger.kernel.org>; Mon, 05 Aug 2019 03:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EjSGNU5tuMFasj89k5pfoAkxeWuwm7YGZxI63pDJurY=;
        b=SdYRFXozELsThSHXdS1mXooull3R6J9nnf8C9J4LG2rf8Ay/tHpcXw2sFKAZoIllXB
         UKzi8TW1M0OqDdoMJIDgbNPtrLtVsqGNe/0mrOegp1PJbxsi91tSM2AMp05i+GQJGWfv
         0ndxMSUXoF6zD4BAG4BkQVA5ggAsEF1fWdZLuxRZwHQxF2mE9tNSwMUHD6NPuvpOd/pG
         t6FqshJ99YgzsFLuWKobI7n04sKxA23fNY0aWKPCmWnE/D5C39GPb0eyMHtNpKwaD/mJ
         4ho5THOfnm4/3mlbtxwCfPSP8ZB7VdziBnItzlaaDFyKQ7bhlLHbMKVB7phZr+csRiRE
         XmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EjSGNU5tuMFasj89k5pfoAkxeWuwm7YGZxI63pDJurY=;
        b=o4pXLeohOegnILZZ8MUKu+IY0gB3yoW9tjiYQOW45sV9BmKspiWP3apMMwmnf6q1a0
         vYZwRXNNCT7PjaOWwZDh950rHHlRfF4zJfjpvG+B3wH6M5l8TlUPciY7wxWUfwGxOa5j
         Nb0wFDEm5VFgJKRvyI6f1ERqVorEfEO6GhKmXt3gYCMIAGnqHhAbNnAwAQiduqjoOhnM
         8qoF1OuTFBPBZqJlUh8tDvlpkvRJHGH5bNVuQtDLwfH+gfrj8LjkCv9sJe4s89mK4szA
         vG6nTmzrARI4BB7UaZ0KGKqkMCal/AWdvwU9liS6zS60bqckrglttuaE7opcjXakJ5VV
         /Vdw==
X-Gm-Message-State: APjAAAVwHfdjHx83u6c8SkJ07+prQjE3M1sRGlR9n7dHR9kD12MxbXkw
        8aGmgCzcqlcwiHXVlHMN+4IdyA==
X-Google-Smtp-Source: APXvYqyfPy8bJ4jliIHsN8Aii8j0f6KsqZMMACwhVIeHmj6Cf501bv9kzRahA7ZUnqifBzzHRD/S/w==
X-Received: by 2002:a1c:cfc3:: with SMTP id f186mr17103441wmg.134.1565001472966;
        Mon, 05 Aug 2019 03:37:52 -0700 (PDT)
Received: from dell ([109.180.115.177])
        by smtp.gmail.com with ESMTPSA id o11sm79528209wmh.37.2019.08.05.03.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 03:37:52 -0700 (PDT)
Date:   Mon, 5 Aug 2019 11:37:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v3 0/4] backlight: Expose brightness curve type through
 sysfs
Message-ID: <20190805103750.GG4739@dell>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190722235926.GA250418@google.com>
 <20190725111541.GA23883@dell>
 <20190725171726.GD250418@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190725171726.GD250418@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 25 Jul 2019, Matthias Kaehlcke wrote:

> On Thu, Jul 25, 2019 at 12:15:41PM +0100, Lee Jones wrote:
> > On Mon, 22 Jul 2019, Matthias Kaehlcke wrote:
> > 
> > > On Tue, Jul 09, 2019 at 12:00:03PM -0700, Matthias Kaehlcke wrote:
> > > > Backlight brightness curves can have different shapes. The two main
> > > > types are linear and non-linear curves. The human eye doesn't
> > > > perceive linearly increasing/decreasing brightness as linear (see
> > > > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> > > > linearly to human eye"), hence many backlights use non-linear (often
> > > > logarithmic) brightness curves. The type of curve is currently opaque
> > > > to userspace, so userspace often relies on more or less reliable
> > > > heuristics (like the number of brightness levels) to decide whether
> > > > to treat a backlight device as linear or non-linear.
> > > > 
> > > > Export the type of the brightness curve via a new sysfs attribute.
> > > > 
> > > > Matthias Kaehlcke (4):
> > > >   MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
> > > >   backlight: Expose brightness curve type through sysfs
> > > >   backlight: pwm_bl: Set scale type for CIE 1931 curves
> > > >   backlight: pwm_bl: Set scale type for brightness curves specified in
> > > >     the DT
> > > > 
> > > >  .../ABI/testing/sysfs-class-backlight         | 26 ++++++++++++++
> > > >  MAINTAINERS                                   |  2 ++
> > > >  drivers/video/backlight/backlight.c           | 19 ++++++++++
> > > >  drivers/video/backlight/pwm_bl.c              | 35 ++++++++++++++++++-
> > > >  include/linux/backlight.h                     |  8 +++++
> > > >  5 files changed, 89 insertions(+), 1 deletion(-)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight
> > > 
> > > ping, any comments on v3?
> > 
> > Looks like PATCH 2/4 still needs seeing to.
> 
> The patch currently doesn't have any comments.
> 
> Do you see any specific things that need improvement? If so, could you
> comment on the patch?

It needs Daniel T's Ack.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
