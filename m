Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA9F558644
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2019 17:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfF0PtZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Jun 2019 11:49:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35726 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfF0PtZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Jun 2019 11:49:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id f15so3169377wrp.2
        for <linux-pwm@vger.kernel.org>; Thu, 27 Jun 2019 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=44Mu8dUj9L0ids6Sb6CWNDIoEklnO4VYTdbwKc4aKyc=;
        b=LnfYL9dENRWp68RK7vG0qlql3IoqqpP/rxklMtbkkjRQYXe39yb7G4ucSqJIgltNt4
         XhSr8NGEnd2Oag74G7xFEbVqtPwuaPpyHD7J8B2GHjzh5DiKFrDPFdQORgv1maS6vjcs
         KX41MbperZUATOEY2X29oQFxm0MvGxCKGw93sVcHgSpilZHjtAGxOU+uYwlvdQe81hqr
         evEnE2CcXdGYVoFT8OFTIqPE+AmdmGtIK7Av7XSSfUnuWJANIeqDkkMDeqwFFAPVW6mq
         CfALUOifrtw7WkfXULktuWj6djEi59osVSAET/syisCCbdFgO44iRn+3Cay10GR1smxJ
         l81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=44Mu8dUj9L0ids6Sb6CWNDIoEklnO4VYTdbwKc4aKyc=;
        b=jwF7jBFDeG4vyw24dIs0OTU+DMLf0ySruwk9iROCQKI3QTslrF6MTq+rJYIBkbKuR5
         o5OuYh31+aYirvrBdRm29hXXR/9WWa+uM2LtnXvYlqaaAnb1dmwoRQX7adKhi4/M957b
         xvZsyvqq7GjRXqbjDOzx0HB6b0c8FECkGW5l50KcLCQ5Z4UrCeyWTRgMuiYDcUpXnkm5
         qpK73GpcPbhRxqhO9gqacfPDDKgPQ2M1PnT/dX70ayIRN+qa+IvbZxOehO+GKKbtWWlD
         gwCmxb3GZ+EawHGxVPtgWml/21ncsfSg+xU76PDwSMeuhxdXB4n7JhJdl+uQ6pLyFKQI
         UMpQ==
X-Gm-Message-State: APjAAAWNYtPS4NtgZDrMH21KkWigXbvFFsAI5v3sOOtuUGH1G92vox/S
        dvVBbqlIYan4ABGLS7rHByusqQ==
X-Google-Smtp-Source: APXvYqysjCQU6AMMnWNSo+srDbMEz+UGbQKDPhC9Sr5nPHf9OFgk/UI30HaXEVLBgefpPDnGRYn9Fw==
X-Received: by 2002:adf:afe8:: with SMTP id y40mr3651106wrd.328.1561650563346;
        Thu, 27 Jun 2019 08:49:23 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 35sm3904679wrj.87.2019.06.27.08.49.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 08:49:22 -0700 (PDT)
Date:   Thu, 27 Jun 2019 16:49:20 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH 3/4] backlight: pwm_bl: Set scale type for CIE 1931 curves
Message-ID: <20190627154920.aucjtaguatd5yd4m@holly.lan>
References: <20190613194326.180889-1-mka@chromium.org>
 <20190613194326.180889-4-mka@chromium.org>
 <61ed137c-31bb-c695-4174-0484fe667d6c@linaro.org>
 <20190627092453.GB2000@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627092453.GB2000@dell>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jun 27, 2019 at 10:24:53AM +0100, Lee Jones wrote:
> On Fri, 21 Jun 2019, Daniel Thompson wrote:
> 
> > On 13/06/2019 20:43, Matthias Kaehlcke wrote:
> > > For backlight curves calculated with the CIE 1931 algorithm set
> > > the brightness scale type property accordingly. This makes the
> > > scale type available to userspace via the 'scale' sysfs attribute.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > 
> > I'd like to keep discussion on patch 2 open a bit longer (it's not part of
> > the thread below patch 2 but Pavel had concerns about the sysfs interface)
> > so this ack won't really push things forward but FWIW:
> > 
> > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Does this depend on patch 2, or is it orthogonal?

IIRC it depends on patch 2 (since that't what introduces props.scale ).


Daniel.

> 
> > > ---
> > >   drivers/video/backlight/pwm_bl.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > > index fb45f866b923..f067fe7aa35d 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -553,6 +553,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> > >   		goto err_alloc;
> > >   	}
> > > +	memset(&props, 0, sizeof(struct backlight_properties));
> > > +
> > >   	if (data->levels) {
> > >   		/*
> > >   		 * For the DT case, only when brightness levels is defined
> > > @@ -591,6 +593,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> > >   			pb->levels = data->levels;
> > >   		}
> > > +
> > > +		props.scale = BACKLIGHT_SCALE_CIE1931;
> > >   	} else {
> > >   		/*
> > >   		 * That only happens for the non-DT case, where platform data
> > > @@ -601,7 +605,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> > >   	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
> > > -	memset(&props, 0, sizeof(struct backlight_properties));
> > >   	props.type = BACKLIGHT_RAW;
> > >   	props.max_brightness = data->max_brightness;
> > >   	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, pb,
> > > 
> > 
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
