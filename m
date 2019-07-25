Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8767374CAB
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2019 13:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391696AbfGYLQA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 25 Jul 2019 07:16:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40385 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388791AbfGYLQA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 25 Jul 2019 07:16:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so44397521wmj.5
        for <linux-pwm@vger.kernel.org>; Thu, 25 Jul 2019 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QF+7Jm8pJkonsuJf5bcYYdklp7SuR7E7WLX/qpmLIMY=;
        b=JPcCwXhG2xYcAxickSomrOJkvgTBB5DjGLN3ImW41oQin65O47uBJez5y6QHqPi4CR
         R7p/PX3cBDvjHCCXcAM73DTDSepGGTQQ2CN2Mn3M7v7z93rwWzHrKJCmJY9wOEvBDKq2
         NpiyRbMo36jxYlVEKnTElXwIE0Y6sqOOKYRQcc+CbQLpWYGGyF1vhlYKPIneuigp7lER
         g/uEtUrvKDd1sm7FXHFVMcoPSdQ6TQYr3xRhUnqsEI0ABKQ9ZgKAV5U2smgQQPt2O5M5
         Inroyadx6ibMupV0tHIR/8R1NUETYkUXGcS33jsQ20wFt42RB7EmtkbcaAmdRw7W/QHJ
         31MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QF+7Jm8pJkonsuJf5bcYYdklp7SuR7E7WLX/qpmLIMY=;
        b=DXIh+eVMP2Cv5lBoUx/o6iJdfY86v3tIg9WQWaqlcl7BzIye9nxhHei/8GnC4IaVU5
         jKDp2R4ZqqoBsbq6QJTuAkS2xtQY20n+piZ0W8DIpPwDIZOpL458Hao/+nKcebgiPDRk
         m2COJ0HcjpkHBvtkFsKPNORd74AfqziWJeZgQ/veTv72t3kkPmHbD2p2Ch1+yJWx1D/C
         kueqgvY2uLnfi3Pas4lcq7CnOHu2NhtCBqV1xY7+Qx/fuFCkK46RPeYwS/fa9bLv162e
         v4kjdbefXxMJGogw3jHeLMoRA1eFkTcKrLnOJV+zJPYURE1Ni5CjGWCLJWP660p5qRTZ
         Xc+Q==
X-Gm-Message-State: APjAAAXUVZyWz5QezW5rNB5C7qLF9O9kA7R7qRP/bKMfGgv7aPQGV3GR
        NNZINmf3DN35RJ0ok8P1cKG3kw==
X-Google-Smtp-Source: APXvYqwHJQvJFZHzw1frET7Zmr1qdyEsn845eWjpbVigiDXyd3xqohC1yA+q2+bnBWLbG0Uze50N5Q==
X-Received: by 2002:a1c:3c04:: with SMTP id j4mr74612867wma.37.1564053358224;
        Thu, 25 Jul 2019 04:15:58 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id y16sm100988574wrg.85.2019.07.25.04.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 04:15:57 -0700 (PDT)
Date:   Thu, 25 Jul 2019 12:15:41 +0100
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
Message-ID: <20190725111541.GA23883@dell>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190722235926.GA250418@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722235926.GA250418@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 22 Jul 2019, Matthias Kaehlcke wrote:

> On Tue, Jul 09, 2019 at 12:00:03PM -0700, Matthias Kaehlcke wrote:
> > Backlight brightness curves can have different shapes. The two main
> > types are linear and non-linear curves. The human eye doesn't
> > perceive linearly increasing/decreasing brightness as linear (see
> > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> > linearly to human eye"), hence many backlights use non-linear (often
> > logarithmic) brightness curves. The type of curve is currently opaque
> > to userspace, so userspace often relies on more or less reliable
> > heuristics (like the number of brightness levels) to decide whether
> > to treat a backlight device as linear or non-linear.
> > 
> > Export the type of the brightness curve via a new sysfs attribute.
> > 
> > Matthias Kaehlcke (4):
> >   MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
> >   backlight: Expose brightness curve type through sysfs
> >   backlight: pwm_bl: Set scale type for CIE 1931 curves
> >   backlight: pwm_bl: Set scale type for brightness curves specified in
> >     the DT
> > 
> >  .../ABI/testing/sysfs-class-backlight         | 26 ++++++++++++++
> >  MAINTAINERS                                   |  2 ++
> >  drivers/video/backlight/backlight.c           | 19 ++++++++++
> >  drivers/video/backlight/pwm_bl.c              | 35 ++++++++++++++++++-
> >  include/linux/backlight.h                     |  8 +++++
> >  5 files changed, 89 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight
> 
> ping, any comments on v3?

Looks like PATCH 2/4 still needs seeing to.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
