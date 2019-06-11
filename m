Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 926E8417EF
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 00:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407871AbfFKWLw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Jun 2019 18:11:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34181 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405693AbfFKWLw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Jun 2019 18:11:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so5704054plt.1
        for <linux-pwm@vger.kernel.org>; Tue, 11 Jun 2019 15:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8vFvJ8V6ajJREADlkWcQGOvk5dqkkgFT9ytOdn/LZ6s=;
        b=hPfeNzhq51hsmDu/JK7bh3qIFlI5DoZS5suqWw3uFdum9RZoZ2kLpg+CG3WfwtzWqG
         wUsWqTNqS4DVwjG3bZ5K061mHFseBicQAv9ZBnZKQCzCbAd+m0Wm71AVkht6a9BHwRBP
         mH/ugMZuWCy/YaFsK+qaD6od1aOotlirFt6fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8vFvJ8V6ajJREADlkWcQGOvk5dqkkgFT9ytOdn/LZ6s=;
        b=jAwM3eA2TVgwMfj5IEyRNe9fzkJhlfKME50iN5CJRl7Gf2uAX823W+LjKzRzmPVjPz
         6y5N5e+OM+ESvkuFtbE+YXizxX1F3wO+NMd5hpqOi1imP7Fq9vQGQ+i2pQYvB2O5yaMu
         l6p0//JfgngiOnKEN49xg9niTTxIfYg3V+ndnZV/nJfBSvT8Mf+qEcZ98FueYfEpeboz
         J1j46xoNDlxIJSD0TmTTWvYFCsm/t68rYjMz5V84OCbaLPZLvkGtTvAjCdPRFKdREnS4
         +yVzVRUAiFunE4uf8V0YTFan9R6XkT241mH1/N4JX4tOjO+2VS0PmN5GafyH5QvLn0C6
         Ymgw==
X-Gm-Message-State: APjAAAUZoqNXNDbeSOBe8hanILXS2Z1a9C0toODpuGIUTNBmN65lbKwg
        gIP66Xs/kjso0lJQp2cJngFFgA==
X-Google-Smtp-Source: APXvYqwEviZoSj03YwFf0xshEB8pQdCuQy4uEVw4wDJoV5zm7LJ8rVpZzWCRBK0Mj4y2Dqy1neX5Aw==
X-Received: by 2002:a17:902:e58b:: with SMTP id cl11mr57462355plb.24.1560291110514;
        Tue, 11 Jun 2019 15:11:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id u4sm17102828pfu.26.2019.06.11.15.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 15:11:49 -0700 (PDT)
Date:   Tue, 11 Jun 2019 15:11:47 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
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
Subject: Re: [PATCH 1/2] dt-bindings: pwm-backlight: Add 'max-brightness'
 property
Message-ID: <20190611221147.GG137143@google.com>
References: <20190610233739.29477-1-mka@chromium.org>
 <00220cd7-ed4b-5250-d448-cf83ed4c2012@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00220cd7-ed4b-5250-d448-cf83ed4c2012@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Jacek,

On Tue, Jun 11, 2019 at 10:02:23PM +0200, Jacek Anaszewski wrote:
> Hi Matthias,
> 
> On 6/11/19 1:37 AM, Matthias Kaehlcke wrote:
> > Add an optional 'max-brightness' property, which is used to specify
> > the number of brightness levels (max-brightness + 1) when the node
> > has no 'brightness-levels' table.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >   .../devicetree/bindings/leds/backlight/pwm-backlight.txt       | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > index 64fa2fbd98c9..98f4ba626054 100644
> > --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > @@ -27,6 +27,9 @@ Optional properties:
> >                               resolution pwm duty cycle can be used without
> >                               having to list out every possible value in the
> >                               brightness-level array.
> > +  - max-brightness: Maximum brightness value. Used to specify the number of
> > +                    brightness levels (max-brightness + 1) when the node
> > +                    has no 'brightness-levels' table.
> 
> In the LED subsystem we have led-max-microamp property which seems to
> better describe hardware capabilities. It says just: this is the current
> level the LED can withstand. max-brightness does not implicitly convey
> this kind of information.
> 
> Why the need for the property at all? If for the reasons other than
> hardware capabilities than it should be more likely handled
> by userspace.

The driver needs to know how many brightness levels to expose to
userspace. It currently uses a heuristic for that which is broken:

https://elixir.bootlin.com/linux/v5.1.9/source/drivers/video/backlight/pwm_bl.c#L234
https://lore.kernel.org/patchwork/patch/1086777/#1282610

In any case it seems the discussion is going into the direction of
fixing the heuristic (apparently using the period as an indicator of
the PWM resolution has more merit than I was initially aware of), if
that moves forward the property wouldn't be needed.
