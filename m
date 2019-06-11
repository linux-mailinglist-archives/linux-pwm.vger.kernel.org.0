Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A44417B4
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2019 23:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407788AbfFKV7C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Jun 2019 17:59:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45288 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407785AbfFKV7C (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Jun 2019 17:59:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so8255379pfm.12
        for <linux-pwm@vger.kernel.org>; Tue, 11 Jun 2019 14:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=STdR09JTplMSpZu8BTmSobDKkVojc1fyDlFwggPK8Uk=;
        b=MR5Ygywl093uFDulviOIYvyfuuIg7LVcRCENxaahnbQl3TWTuyLFxmaN/CsCFje4ZW
         lMOJpV5vlQByThnbSdpFW5pDrScHKNyi5Uayf6G9Qo/JGt6L3QsMwiyIsPBFjywBcNsB
         KOnwwUTJm+TTD2GsLYgy//6zZNVAYMjKqx244=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=STdR09JTplMSpZu8BTmSobDKkVojc1fyDlFwggPK8Uk=;
        b=q3eeoH8McO/YPWArMwnxdTUwb6R6lnIdSQqdVc1tcXvGn5fshyRdWdf97hVpNf9Cn3
         wkYhwWggIJMjDP3OnlrfeojiiCiIIxQG247pPanASoi/zrwCk5xbvvK0GnGR7iABh+kQ
         Ep6bEiMuzMALLZPDf4qaySoz6SQ4VXD1lGTghG1QlrgJVhbSZLJgjG0XkzCziPfcGpQY
         yDE7epqSfzwEesglpE8dp3doJDkReApPi+a3pyJUD0biSvh2S9O5UsVT6yVf5omgnLt6
         adTdniTRT0CuKICocJLXP9OwFXp7Sx1/wJEVe45pI/VYQBO5j9CvSMLHne4kSniG7Jv/
         F2/g==
X-Gm-Message-State: APjAAAXEBrL7QvMZQZrofyQa9x/549EHWtve2Zff1dA3KsleV2l7PSx8
        n9tWXrvjo2MMmUHvh7+TaEX0tg==
X-Google-Smtp-Source: APXvYqwNRiFSWTAdFHpr/jTf2FF34I6ZRq0BdECtRnB+Jk555Y9lQHvSTV1z1QBb+8m6aiHhXzbajQ==
X-Received: by 2002:a17:90b:d8a:: with SMTP id bg10mr29155223pjb.92.1560290341471;
        Tue, 11 Jun 2019 14:59:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id m2sm15311952pgq.48.2019.06.11.14.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 14:59:00 -0700 (PDT)
Date:   Tue, 11 Jun 2019 14:58:59 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 2/2] backlight: pwm_bl: Get number of brightness levels
 for CIE 1931 from the device tree
Message-ID: <20190611215859.GF137143@google.com>
References: <20190610233739.29477-1-mka@chromium.org>
 <20190610233739.29477-2-mka@chromium.org>
 <20190611101843.GD7526@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190611101843.GD7526@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Pavel,

On Tue, Jun 11, 2019 at 12:18:43PM +0200, Pavel Machek wrote:
> On Mon 2019-06-10 16:37:39, Matthias Kaehlcke wrote:
> > Commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> > linearly to human eye") uses pwm_period / hweight32(pwm_period) as
> > as heuristic to determine the number of brightness levels when the DT
> > doesn't provide a brightness level table. This heuristic is broken
> > and can result in excessively large brightness tables.
> > 
> > Instead of using the heuristic try to retrieve the number of
> > brightness levels from the device tree (property 'max-brightness'
> > + 1). If the value is not specified use a default of 256 levels.
> > 
> > Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
> 
> I don't think this one is suitable for stable. I'm pretty sure the
> heuristics works well for many boards, and you just replaced it with
> another heuristics ("256").

whether the patch is suitable for stable/upstream is certainly
debatable, in any case I'd argue the current heuristic is bogus and
works by accident or at a cost:

nlevels = period / hweight(period)

w/ period = 131071 ns  (0x1FFFF)

  nlevels = 131071 / 17 = 7710

w/ period = 131072 ns (0x20000)

  nlevels = 131072 / 1 = 131072

and some PWMs use significantly higher periods like 1 ms or 10 ms.
