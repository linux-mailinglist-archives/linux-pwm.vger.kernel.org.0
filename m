Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C8C2319A2
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Jul 2020 08:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgG2Ggo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 02:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2Ggo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Jul 2020 02:36:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39780C061794;
        Tue, 28 Jul 2020 23:36:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p3so13727425pgh.3;
        Tue, 28 Jul 2020 23:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IsasfM56692RUOErbgn2ABZzJ6c631XfiLeQVHWEUsI=;
        b=eFhHBUQj6ipfDY5v+hKk8aL0YcnAalVllbCOZzgH++rlzaJSlNhw7c4eAcRiAVPB5i
         iNYjMfATnkf88ldCnPAx+oG14Jl86MX6aZB07gcYeDON1lhf0bHbgYUcoNtfheqk5Aqv
         AyA9x8JmA04+sJL6ChCmRJb4j0d7YgmUV5eqG4JgpbmvLeU3bdpe3+IQUvCqMwMwYtLR
         h6evFRiHi1yCCMkp1+SJbOl8nC2OOQPgiRds9csNGeXqwdeV0pGPeYB1FpXk6+g6InuN
         HS6xzNni5MbR7u/TS5YRQLYH2Ab8VfxaUbZlU6xF5c9iSdws7+EPPpQExE9u6tBWqfRN
         tplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IsasfM56692RUOErbgn2ABZzJ6c631XfiLeQVHWEUsI=;
        b=IC8veYICTIQMD3GBEjrybjV/rRq/6e+ErTTkjECHs33zBQsCgDNohTcP8FWyDtmA7W
         +Cr0tZJNdMOR9AjEsZjdSk1eTa3FYz1jP6lSuUHdRxyFeI0kMaODTkGL5D+WRE5pObU4
         hdzGrvGdmaawjmH/553fJPnWSM3oMWk8fEANLoAQslyVa2O5V6OfMUA3xygNwWPRmUhr
         /La4GftOmACizbsVIpQ4j6Adr+PWYfWKWQ2XwvVA8gloTx5D46mPyayX2dMd4wt/a7jl
         oDKUHp3/D14Dx+5OqFzPHyeSdlnnyv5v38Feifi9RPPOrocGwpJBnfUHHFNsLL8enLqf
         Br4g==
X-Gm-Message-State: AOAM530WNv0KfxHSzSkQUUgxQcype39ukBZgSpnVBDqgip+S84low030
        mwL9/VxNS9LSRcMcwK3wnf8=
X-Google-Smtp-Source: ABdhPJzDxjQQTnVon7UXunhTQddxypSgdNT5v7VIizUudg7wcWuNzDnq1EeBjQdkGAoL/GmxLh1RgQ==
X-Received: by 2002:a63:5b55:: with SMTP id l21mr28743015pgm.348.1596004602248;
        Tue, 28 Jul 2020 23:36:42 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id y6sm1053424pfr.61.2020.07.28.23.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 23:36:41 -0700 (PDT)
Date:   Tue, 28 Jul 2020 23:36:38 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Roy Im <roy.im.opensource@diasemi.com>
Cc:     Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v18 3/3] Input: new da7280 haptic driver
Message-ID: <20200729063638.GY1665100@dtor-ws>
References: <cover.1595991580.git.Roy.Im@diasemi.com>
 <23b3470401ec5cf525add8e1227cb67586b9f294.1595991580.git.Roy.Im@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23b3470401ec5cf525add8e1227cb67586b9f294.1595991580.git.Roy.Im@diasemi.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Roy,

On Wed, Jul 29, 2020 at 11:59:40AM +0900, Roy Im wrote:
> Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
> multiple mode and integrated waveform memory and wideband support.
> It communicates via an I2C bus to the device.

A few questions/suggestions...

> 
> Reviewed-by: Jes Sorensen <Jes.Sorensen@gmail.com>.
> 
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> 
> ---
> v18:
> 	- Corrected comments in Kconfig
> 	- Updated to preferred style for multi line comments in c file.
> v17:
> 	- fixed an issue.
> v16:
> 	- Corrected some code and updated description in Kconfig.
> v15:
> 	- Removed some defines and updated some comments.
> v14:
> 	- Updated pwm related code, alignments and comments.
> v13:
> 	- Updated some conditions in pwm function and alignments.
> v12: No changes.
> v11: 
> 	- Updated the pwm related code, comments and typo.
> v10: 
> 	- Updated the pwm related function and added some comments.
> v9: 
> 	- Removed the header file and put the definitions into the c file.
> 	- Updated the pwm code and error logs with %pE

I believe the %pE is to format an escaped buffer, you probably want to
%pe (lowercase) to print errors. I am also not quite sure if we want to
use it in cases when we have non-pointer error, or we should stick with
%d as most of the kernel does.

...
> +
> +/* DA7280_ACTUATOR3 (Address 0x0e) */
> +#define DA7280_IMAX_MASK			(31 << 0)

We have GENMASK(h,l) macro in include/linux/bits.h that could be used
here and in other mask definitions.

> +
> +	bool legacy;
> +	struct delayed_work work_duration;
> +	struct work_struct work_playback;
> +	struct work_struct work_setgain;

How do we ensure that all these works do not clash with each other?
As far as I can see we could have the "duration" work executing
simultaneously with playback...

> +static int da7280_haptics_playback(struct input_dev *dev,
> +				   int effect_id, int val)
> +{
> +	struct da7280_haptic *haptics = input_get_drvdata(dev);
> +
> +	if (!haptics->op_mode) {
> +		dev_warn(haptics->dev,
> +			 "Any effects are not uploaded yet\n");

"No effects have been uploaded"?

> +		return -EPERM;

I'd say EINVAL.

> +static DEVICE_ATTR_RW(ps_seq_id);
> +static DEVICE_ATTR_RW(ps_seq_loop);
> +static DEVICE_ATTR_RW(gpi_seq_id0);
> +static DEVICE_ATTR_RW(gpi_seq_id1);
> +static DEVICE_ATTR_RW(gpi_seq_id2);
> +static DEVICE_ATTR_WO(patterns);

Should this be a binary attribute instead of having string parsing in
the kernel?

Thanks.

-- 
Dmitry
