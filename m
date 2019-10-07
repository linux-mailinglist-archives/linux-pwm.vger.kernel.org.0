Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F2ECE6A9
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2019 17:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfJGPIn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Oct 2019 11:08:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32885 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728790AbfJGPIn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Oct 2019 11:08:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id b9so15794185wrs.0
        for <linux-pwm@vger.kernel.org>; Mon, 07 Oct 2019 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rmvp3U9wOO9fx1V5/5lVy3lHSgb3r92p/5Ndn8D9Cno=;
        b=PZ88vPGKZhvCrX5TQAJCXwbZ/+D6pVQWntk88MxmxD8JNoIcsCt3mUkxbkopRKq2Ok
         S4zvSHsn2Y4D2U15ngxrUfkOgx2ZnWmIrkIHbxaBIqhfzOQBjA/ixUT+jmWFnoRLJoUf
         Gr+x/k240g7pHGj3e5EWGz+4qddvm/hVrYCBRl/XV+bNGUYRfgnXy5nsWLgkANYb71ix
         9Yl1XlQr8iq+6Qs4GaRLGgzG354SH3TytK8CKLgMVaGPzIVYqikwxQWhAVz18kCQQyT8
         gaM+0swlRNT83/HMqXi3+wEbTmwu2QFdmqwgFVOz/RTQOA+1D1kl8rJ0C8OvcCjj/h3a
         ofpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rmvp3U9wOO9fx1V5/5lVy3lHSgb3r92p/5Ndn8D9Cno=;
        b=QvtdCE+n1haahW3Zw75NN/ZcKFOQwhDS+WarHE4BzhK9nm9DADPn/dPKg+V34Eb/o/
         CsAYszhySBgdHACGzGyFWXLrZAG+leu9nKm8YB2jVdNSsdca1es22s6W1K3ECLpPOzZl
         vP1iu4jhddUaSMPEBmjkULXQTOsedglq2EIYjW5SnJzMvhYXf7VsxEs7Lk6L+F6YK3nd
         5+3ieE8z/hsWXXqv4O4rnnQCQktaAWATRz7ullRDziNWdAlX5MjwivUMAJblxv27X9Rz
         bkgAXOL/XaY59EFpzZtjTe4VjD8Xg5LQM42dLSYK5PpNM21IeCXGzeqAm6OEsHMdmVOE
         HX4w==
X-Gm-Message-State: APjAAAXYPRrcQzi9EQAjGzYF/ITnryNFieWuXMVLsMY3z2CNKzwRIbxx
        bY6WRCJXPZSMNdjomhhZi5Jngw==
X-Google-Smtp-Source: APXvYqwkVghS0eHq32QO7i9QSOrwUCdtltFtZcTTIjruUxA68yY7ARWhzNO4HSBRH43QK2i2Zgw8JA==
X-Received: by 2002:a5d:6a09:: with SMTP id m9mr21687302wru.12.1570460921085;
        Mon, 07 Oct 2019 08:08:41 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s12sm29340436wra.82.2019.10.07.08.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 08:08:40 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:08:38 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] backlight: pwm_bl: fix cie1913 comments and constant
Message-ID: <20191007150838.3qbrten34ln6ufo4@holly.lan>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Sep 19, 2019 at 04:06:16PM +0200, Rasmus Villemoes wrote:
> The "break-even" point for the two formulas is L==8, which is also
> what the code actually implements. [Incidentally, at that point one
> has Y=0.008856, not 0.08856].
> 
> Moreover, all the sources I can find say the linear factor is 903.3
> rather than 902.3, which makes sense since then the formulas agree at
> L==8, both yielding the 0.008856 figure to four significant digits.

Indeed. Interestingly the following doc (with a high search rank in
Google) has exactly this inconsistency and uses different values at
different times:
http://www.photonstophotos.net/GeneralTopics/Exposure/Psychometric_Lightness_and_Gamma.htm

> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/pwm_bl.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 2201b8c78641..be36be1cacb7 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -155,8 +155,8 @@ static const struct backlight_ops pwm_backlight_ops = {
>   *
>   * The CIE 1931 lightness formula is what actually describes how we perceive
>   * light:
> - *          Y = (L* / 902.3)           if L* ≤ 0.08856
> - *          Y = ((L* + 16) / 116)^3    if L* > 0.08856
> + *          Y = (L* / 903.3)           if L* ≤ 8
> + *          Y = ((L* + 16) / 116)^3    if L* > 8
>   *
>   * Where Y is the luminance, the amount of light coming out of the screen, and
>   * is a number between 0.0 and 1.0; and L* is the lightness, how bright a human
> @@ -169,9 +169,15 @@ static u64 cie1931(unsigned int lightness, unsigned int scale)
>  {
>  	u64 retval;
>  
> +	/*
> +	 * @lightness is given as a number between 0 and 1, expressed
> +	 * as a fixed-point number in scale @scale. Convert to a
> +	 * percentage, still expressed as a fixed-point number, so the
> +	 * above formulas can be applied.
> +	 */
>  	lightness *= 100;
>  	if (lightness <= (8 * scale)) {
> -		retval = DIV_ROUND_CLOSEST_ULL(lightness * 10, 9023);
> +		retval = DIV_ROUND_CLOSEST_ULL(lightness * 10, 9033);
>  	} else {
>  		retval = int_pow((lightness + (16 * scale)) / 116, 3);
>  		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
> -- 
> 2.20.1
