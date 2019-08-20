Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A62F0961B1
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2019 15:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbfHTN4W (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Aug 2019 09:56:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34628 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbfHTN4W (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Aug 2019 09:56:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id s18so12530855wrn.1
        for <linux-pwm@vger.kernel.org>; Tue, 20 Aug 2019 06:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wDIyrvQrJ7olDJx41Fmi3P0la+SkzTZEmDdMNDh+30I=;
        b=gHpXzBj2HL/VekC+rb66mdgaCBKRClLKy21GikAy3/4y5NYI7osptw1VTKx7dbKmgm
         wTBMtuCGm6J3JkWDmtHxAjvJ7+An0qz0fmggqwT9d75Qt4eKVYsf+UZhGRDxXymwKaRl
         CgZPfsylKsFcoYik07XFEyQMFuZZlRWgVFhduIAoOAWgXMt4Jw41KIF6HD1vdy8kPdXB
         A65WjUhS70ecM65suXwwNrL2owGD4dozg0DmiHFH79YckQU9hhBJL4/kgV5YmxnDBdLI
         SMqg926sVYcMMFdKRJC6uN4odrvDKlRR6Kw5kZoypu/h2BlONSYPV1qtI7nEbBUf2aaw
         0Duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wDIyrvQrJ7olDJx41Fmi3P0la+SkzTZEmDdMNDh+30I=;
        b=f8qaY7Cc0GiUumevWV7O6XwMxh29yHtykj+Rcc6cdZlruqLaNKKseFKYuP32N7DqO8
         kljQC46N50rFX9ql2HubuLHHb9FuNMMbz25Si8NotLbJNzVeJZ46+AHL8VMVWxtXAUTc
         nh1gGDocwT8rcsO4XmVZ77J5DMydWlIsrd0ndYI22PiI8xGekIf47YErwXVUICWHM0mz
         lnmuBGy+Q49lHxYa305byYT3gYAw465HnOT4dFBaRUOmszmjKl4YI6U0TDmq64LmC1H7
         adG+pkY47lXYO75GseT/TcChYBJFWrR1+4+NH7nKPpyMBFAhNV/y0XkYHS8zqOwKupPC
         Ijdw==
X-Gm-Message-State: APjAAAXYLYCx09VGAI3keff8fzAw3b9PbVMJq1Z+Vewn8Eec+zs0NwzU
        Ho6nNHvgLKYNiz5LCtUUdx3xOiEhyAfMng==
X-Google-Smtp-Source: APXvYqzz1/Yz1/10NYh2GUB6nM4DQfiK8JY8XxzUwqSv7W5p2geXhM3XKJZmh4+lXcZIK+QpcDCQww==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr35734925wrs.88.1566309380044;
        Tue, 20 Aug 2019 06:56:20 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a11sm18644102wrx.59.2019.08.20.06.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:56:19 -0700 (PDT)
Date:   Tue, 20 Aug 2019 14:56:17 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through
 sysfs
Message-ID: <20190820135617.64urowbu2kwdynib@holly.lan>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190807201528.GO250418@google.com>
 <510f6d8a-71a0-fa6e-33ea-c4a4bfa96607@linaro.org>
 <20190816175317.GU250418@google.com>
 <20190819100241.5pctjxmsq6crlale@holly.lan>
 <20190819185049.GZ250418@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819185049.GZ250418@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 19, 2019 at 11:50:49AM -0700, Matthias Kaehlcke wrote:
> Hi Daniel,
> 
> On Mon, Aug 19, 2019 at 11:02:41AM +0100, Daniel Thompson wrote:
> > On Fri, Aug 16, 2019 at 10:53:17AM -0700, Matthias Kaehlcke wrote:
> > > On Fri, Aug 16, 2019 at 04:54:18PM +0100, Daniel Thompson wrote:
> > > > On 07/08/2019 21:15, Matthias Kaehlcke wrote:
> > > > > On Tue, Jul 09, 2019 at 12:00:05PM -0700, Matthias Kaehlcke wrote:
> > > > > > Backlight brightness curves can have different shapes. The two main
> > > > > > types are linear and non-linear curves. The human eye doesn't
> > > > > > perceive linearly increasing/decreasing brightness as linear (see
> > > > > > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> > > > > > linearly to human eye"), hence many backlights use non-linear (often
> > > > > > logarithmic) brightness curves. The type of curve currently is opaque
> > > > > > to userspace, so userspace often uses more or less reliable heuristics
> > > > > > (like the number of brightness levels) to decide whether to treat a
> > > > > > backlight device as linear or non-linear.
> > > > > > 
> > > > > > Export the type of the brightness curve via the new sysfs attribute
> > > > > > 'scale'. The value of the attribute can be 'linear', 'non-linear' or
> > > > > > 'unknown'. For devices that don't provide information about the scale
> > > > > > of their brightness curve the value of the 'scale' attribute is 'unknown'.
> > > > > > 
> > > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > 
> > > > > Daniel (et al): do you have any more comments on this patch/series or
> > > > > is it ready to land?
> > > > 
> > > > I decided to leave it for a long while for others to review since I'm still
> > > > a tiny bit uneasy about the linear/non-linear terminology.
> > > > 
> > > > However that's my only concern, its fairly minor and I've dragged by feet
> > > > for more then long enough, so:
> > > > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > 
> > > Thanks!
> > > 
> > > If you or someone else has another suggestion for the terminology that
> > > we can all agree on I'm happy to change it.
> > 
> > As you will see in my reply to Uwe. The term I tend to adopt when I want
> > to be precise about userspace behaviour is "perceptual" (e.g. that a
> > backlight can be mapped directly to a slider and it will feel right).
> > 
> > However that raises its own concerns: mostly about what is perceptual
> > enough.
> > 
> > Clear the automatic brightness curve support in the PWM driver is
> > perceptual.
> > 
> > To be honest I suspect that in most cases a true logarithmic curve (given a
> > sane exponent) would be perceptual enough. In other words it will feel
> > comfortable with a direct mapped slider and using it for animation
> > won't be too bad.
> > 
> > However when we get right down to it *that* is the information that is
> > actually most useful to userspace: explicit confirmation that the scale
> > can be mapped directly to a slider. I think it also aligned better with
> > Uwe's feedback (e.g. to start working towards having a preferred scale).
> 
> IIUC the conclusion is that there is no need for a string attribute
> because we only need to distinguish between 'perceptual' and
> 'non-perceptual'. If that is correct, do you have any preference for
> the attribute name ('perceptual_scale', 'perceptual', ...)?

More a summary than a conclusion! There is a reason I have left a bit or
space for others to comment on this over the last month (and a bit).

To be clear my Reviewed-by: means that I believe that the kernel is better
with "non-linear/linear/unknown" than without it and that I am comfortable
the API isn't likely to be a millstone for us.

Lee, Jingoo: Either of you care to offer $0.02


Daniel.
