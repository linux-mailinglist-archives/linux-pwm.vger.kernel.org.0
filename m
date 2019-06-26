Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C0456CEA
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2019 16:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFZO4V (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jun 2019 10:56:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42482 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfFZO4U (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jun 2019 10:56:20 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5369E807BA; Wed, 26 Jun 2019 16:56:07 +0200 (CEST)
Date:   Wed, 26 Jun 2019 16:56:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v2 2/4] backlight: Expose brightness curve type through
 sysfs
Message-ID: <20190626145611.GA22348@xo-6d-61-c0.localdomain>
References: <20190624203114.93277-1-mka@chromium.org>
 <20190624203114.93277-3-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624203114.93277-3-mka@chromium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi!

> Export the type of the brightness curve via the new sysfs attribute
> 'scale'. The value of the attribute may be a simple string like
> 'linear' or 'non-linear', or a composite string similar to
> 'compatible' strings of the device tree. A composite string consists
> of different elements separated by commas, starting with the
> most-detailed description and ending with the least-detailed one. An
> example for a composite string is "cie-1931,perceptual,non-linear"
> This brightness curve was generated with the CIE 1931 algorithm, it
> is perceptually linear, but not actually linear in terms of the
> emitted light. If userspace doesn't know about 'cie-1931' or
> 'perceptual' it should at least be able to interpret the 'non-linear'
> part.

I'm not sure the comma-separated thing is a good idea. If it is, it should 
go to the Documentation, not to changelog.

> +What:		/sys/class/backlight/<backlight>/scale
> +Date:		June 2019
> +KernelVersion:	5.4
> +Contact:	Daniel Thompson <daniel.thompson@linaro.org>
> +Description:
> +		Description of the scale of the brightness curve. The
> +		description consists of one or more elements separated by
> +		commas, from the most detailed to the least detailed
> +		description.
> +
> +		Possible values are:
> +
> +		unknown
> +		  The scale of the brightness curve is unknown.
> +
> +		linear
> +		  The brightness changes linearly in terms of the emitted
> +		  light, changes are perceived as non-linear by the human eye.
> +
> +		non-linear
> +		  The brightness changes non-linearly in terms of the emitted
> +		  light, changes might be perceived as linear by the human eye.

non-linear is not too useful as described.

> +		perceptual,non-linear
> +		  The brightness changes non-linearly in terms of the emitted
> +		  light, changes should be perceived as linear by the human eye.
> +
> +		cie-1931,perceptual,non-linear
> +		  The brightness curve was calculated with the CIE 1931
> +		  algorithm. Brightness changes non-linearly in terms of the
> +		  emitted light, changes should be perceived as linear by the
> +		  human eye.

Is it useful to know difference between perceptual, and cie-1931?

Would it be useful to export absolute values in some well-known units?

If I'm in dark room, I may want 100mW/m^2 of backlight... And it would
be nice if I could set same backlight intensity on all my devices easily.

								Pavel
