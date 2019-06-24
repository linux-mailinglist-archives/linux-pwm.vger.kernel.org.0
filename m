Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBEF51B00
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2019 20:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfFXSyQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jun 2019 14:54:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35484 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfFXSyN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jun 2019 14:54:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so8048768pfd.2
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jun 2019 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b5H8RtrC0Gc1uC0P9BdPRFehSMvKPE2eLTGWQg50TOo=;
        b=VRfzqrCH2jFEWWjjlDlGd02Xe8ZQsb0AVWLLZIFUZPGPtVv9VLFJ+zz8bC8OUOaOUx
         Oqcae7vUarDSmjpET3Ghcc9JlKP5Vf1bg21hv25Rq8NQJgF9ue1AbbSuNNetGP6GzyMs
         qfJaOC3Qph/i6rx21qTIWZqCKCXB8QBPi1VFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b5H8RtrC0Gc1uC0P9BdPRFehSMvKPE2eLTGWQg50TOo=;
        b=oqrCtWCzHvvzO1MA8HLSX4sfIhQuHHVFPD/PP/UWMSN2sGIaB6OdfZksuP3Xd222Xe
         2YwKqhzkCMrRroMyTxtKDOHSqbt7tIGt13r8IfcylQ031BmH/uQ0AesBaU8FprMEcHMJ
         J1ImYZrq9XpiC78k0qRF/I5Wl7F/3IqIfYwdVehG+TVu93cuQmBpoU/HWATXXeEfqGPv
         B0hIYLTLZXGM+GMzuhiqmiIEErZ6IYJoens/YAndt8MdAhAM7ZmdWwThfWtA2+wg/zHH
         IE1P+Jkd4KdGtgHYyKckeH/kKvfthrPlmCT+jcC+WJ9NiwOCatDLvRe4m43JSDZmCoRc
         /ATg==
X-Gm-Message-State: APjAAAXqhVtxhkEutn8k6+SbK+6IBgix7leTo22lFbsY3/RnqIoLrX8/
        Hb4EFDMqMOxvjJ+qZmjWZt1SAA==
X-Google-Smtp-Source: APXvYqyXn1SQMUZwvxp4v/17SbLT1K8S5ekQlOyMcC+7be/m4tA2Bnx7hthlNDGzX/lhBeNI08UitQ==
X-Received: by 2002:a17:90a:8a0b:: with SMTP id w11mr26442545pjn.125.1561402452192;
        Mon, 24 Jun 2019 11:54:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l7sm14434756pfl.9.2019.06.24.11.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 11:54:11 -0700 (PDT)
Date:   Mon, 24 Jun 2019 11:54:08 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
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
Subject: Re: [PATCH 4/4] backlight: pwm_bl: Set scale type for brightness
 curves specified in the DT
Message-ID: <20190624185408.GB137143@google.com>
References: <20190613194326.180889-1-mka@chromium.org>
 <20190613194326.180889-5-mka@chromium.org>
 <9ea1bb40-95a6-7a67-a8a6-ecc77a70e547@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ea1bb40-95a6-7a67-a8a6-ecc77a70e547@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Daniel,

On Fri, Jun 21, 2019 at 02:10:19PM +0100, Daniel Thompson wrote:
> On 13/06/2019 20:43, Matthias Kaehlcke wrote:
> > Check if a brightness curve specified in the device tree is linear or
> > not and set the corresponding property accordingly. This makes the
> > scale type available to userspace via the 'scale' sysfs attribute.
> > 
> > To determine if a curve is linear it is compared to a interpolated linear
> > curve between min and max brightness. The curve is considered linear if
> > no value deviates more than +/-5% of ${brightness_range} from their
> > interpolated value.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >   drivers/video/backlight/pwm_bl.c | 25 +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> > 
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index f067fe7aa35d..912407b6d67f 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -404,6 +404,26 @@ int pwm_backlight_brightness_default(struct device *dev,
> >   }
> >   #endif
> > +static bool pwm_backlight_is_linear(struct platform_pwm_backlight_data *data)
> > +{
> > +	unsigned int nlevels = data->max_brightness + 1;
> > +	unsigned int min_val = data->levels[0];
> > +	unsigned int max_val = data->levels[nlevels - 1];
> > +	unsigned int slope = (100 * (max_val - min_val)) / nlevels;
> 
> Why 100 (rather than a power of 2)?

I guess it came from the decimal part of my brain, I can change it to
128 ;-)

> It would also be good to have a comment here saying what the maximum
> quantization error is. Doesn't have to be over complex just mentioning
> something like the following (assuming you agree that its true ;-) ):
> 
>   Multiplying by XXX means that even in pathalogical cases such as
>   (max_val - min_val) == nlevels then the error at max_val is less than
>   1%.

Sounds good, thanks for the suggestion!

> With a suitable comment in the fixed point code:
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Thanks
