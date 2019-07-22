Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6F670DCF
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jul 2019 01:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbfGVX73 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Jul 2019 19:59:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42288 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731759AbfGVX73 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Jul 2019 19:59:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id t132so18413166pgb.9
        for <linux-pwm@vger.kernel.org>; Mon, 22 Jul 2019 16:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yKJpc6b5YDtH8HQ6uiATAFLuSozdZCVilkIngvbXM5A=;
        b=BwwNgGULwWCLx8dsVMfholYHHZtahSRNI4WRi8GeRE1cTEnEj7+QLHRFtS1OwD7OfL
         PBhCf2HLH/xHTCrVy2tXcVrzcxjy/X/9XS3xE3DB5oNwZDSgYT1w2T1voSeXQoCgP+lE
         YAbbno9nOKjFkhoG+ymLqQNzmX7kqXLBCtzVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yKJpc6b5YDtH8HQ6uiATAFLuSozdZCVilkIngvbXM5A=;
        b=eAvyahcx+eiD9PgA+N09j8Le5qyL/hFo9Rd4sveAjsDcCrGutVZpvx3hGBiMo75WkN
         1oF/7e5ItDr5DLJVaCt+pUZUVnxePgUNl6oNYbXHwBmW+x3sRJJp5Kl7Zzl5zJ2rMtVr
         qp9RHsMJmKzbB3tExG00PqYUf0u8bwNRH/f8nG7BTWDB8gjuFVOTyCGpCoS7wQbVxRXU
         kOZdfxSvYnBmxaxbARQ74BBEt6A1pSeS5NM6ik44WXS88GryfcaRn8tfv61nwf/dtR/G
         7u2Cc6nxjdGHvGIa1Fj0L5jXVbAx4HEVSQw2txmpJkWuBcwSUclRmlmTOqFQ/KvXfwTJ
         U+ig==
X-Gm-Message-State: APjAAAWAiVd8T2HaAnG7bwUQLmKzFEe8NIS26tBv1qApv4WvwnlXFEfq
        gIw2owXhnmgcDYWVG0sf1+SNFw==
X-Google-Smtp-Source: APXvYqylBuVwl7XZwxbVNxqA1DcLvAlMOG8gWbqhX7r0RR7aDWH3sQ/kfj0iiNgQmQOUzrSpDH2+kA==
X-Received: by 2002:a63:4e60:: with SMTP id o32mr75155489pgl.68.1563839968519;
        Mon, 22 Jul 2019 16:59:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f88sm40294971pjg.5.2019.07.22.16.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 16:59:27 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:59:26 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v3 0/4] backlight: Expose brightness curve type through
 sysfs
Message-ID: <20190722235926.GA250418@google.com>
References: <20190709190007.91260-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190709190007.91260-1-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jul 09, 2019 at 12:00:03PM -0700, Matthias Kaehlcke wrote:
> Backlight brightness curves can have different shapes. The two main
> types are linear and non-linear curves. The human eye doesn't
> perceive linearly increasing/decreasing brightness as linear (see
> also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> linearly to human eye"), hence many backlights use non-linear (often
> logarithmic) brightness curves. The type of curve is currently opaque
> to userspace, so userspace often relies on more or less reliable
> heuristics (like the number of brightness levels) to decide whether
> to treat a backlight device as linear or non-linear.
> 
> Export the type of the brightness curve via a new sysfs attribute.
> 
> Matthias Kaehlcke (4):
>   MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
>   backlight: Expose brightness curve type through sysfs
>   backlight: pwm_bl: Set scale type for CIE 1931 curves
>   backlight: pwm_bl: Set scale type for brightness curves specified in
>     the DT
> 
>  .../ABI/testing/sysfs-class-backlight         | 26 ++++++++++++++
>  MAINTAINERS                                   |  2 ++
>  drivers/video/backlight/backlight.c           | 19 ++++++++++
>  drivers/video/backlight/pwm_bl.c              | 35 ++++++++++++++++++-
>  include/linux/backlight.h                     |  8 +++++
>  5 files changed, 89 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight

ping, any comments on v3?

Thanks

Matthias
