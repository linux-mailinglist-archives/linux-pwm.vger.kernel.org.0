Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F854FDB6B
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Apr 2022 12:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354029AbiDLKDd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Apr 2022 06:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390170AbiDLJYf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Apr 2022 05:24:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249D9496B5
        for <linux-pwm@vger.kernel.org>; Tue, 12 Apr 2022 01:41:03 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso1137779wmz.4
        for <linux-pwm@vger.kernel.org>; Tue, 12 Apr 2022 01:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JVS8yoTed/57DjCwKIW1A/c1IofL37wt+tYJEPzUAmU=;
        b=Z+VbZn7FPHNe/GBsQyuivnzzgGzYvxBZDES1LMjk+AMruKFaWMliPs/DaWe4wQcj1V
         Z46VUcXBRlve5tWnD6t/jEuT+5XKFrUE5df/ekH+6vCNCqWOXn6MuAX1Kaz4F4MRmb0u
         prutTbcdiNtijUHwv3SzkXxA25iy5vFpLZA4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JVS8yoTed/57DjCwKIW1A/c1IofL37wt+tYJEPzUAmU=;
        b=tVKvWpftMu/FFuPmvU18M2ol8w70OpKOwIrABglJCgCqDT8ALqb35wTQY1fXETR+ZP
         1s5vL0L6hU58s/Ut+6x3AbZITctr4e04zuzNinHxbRZtXATlaXAsmUSSHq9bqLaD9b7C
         rcN6fJm10rzrmLCEkfvuX5Qfcpjq9d/yaz5EzK/zXnmYjJ1tiIe0TC0k1ir5PhT8SfXz
         dsnqJvrVx3oOQE3u3FEkPVgT4Fv6hayKTsaqqoSG/vu6zZHYslghYxNAe6McAHy8OeSW
         2HeMUjuMe5KAF7rynVmt8ZonGdApm0xgUvWx1R1sNGAeLo/rrAmFtNsv7gRjipyqc7K6
         l8CA==
X-Gm-Message-State: AOAM532ilCnrdVejqbIcZV7m8QdDHFMySh4+zzKnorJQg/dyqe/CFx76
        uFlXeUuby//v0kQsrcvbLoT9Rg==
X-Google-Smtp-Source: ABdhPJyHye7sxKTODHYVlr0Iw88mdVOrIKEdTmPAKEL4TcsxZIZQomuSpVY1efYdnCyhwPqDkolHGQ==
X-Received: by 2002:a05:600c:1c0e:b0:38c:ae37:c1d2 with SMTP id j14-20020a05600c1c0e00b0038cae37c1d2mr2964820wms.205.1649752861339;
        Tue, 12 Apr 2022 01:41:01 -0700 (PDT)
Received: from google.com ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c144a00b0038ccc75a6adsm1769601wmi.37.2022.04.12.01.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 01:41:00 -0700 (PDT)
Date:   Tue, 12 Apr 2022 08:40:58 +0000
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] drivers: pwm: pwm-cros-ec: add channel type
 support
Message-ID: <YlU7GoSYMPapAsVv@google.com>
References: <20220411152114.2165933-1-fabiobaltieri@chromium.org>
 <20220411152114.2165933-3-fabiobaltieri@chromium.org>
 <YlUq8W+xjdxqYCo5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlUq8W+xjdxqYCo5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Tzung-Bi,

On Tue, Apr 12, 2022 at 03:32:01PM +0800, Tzung-Bi Shih wrote:
> On Mon, Apr 11, 2022 at 03:21:12PM +0000, Fabio Baltieri wrote:
> > Add support for EC_PWM_TYPE_DISPLAY_LIGHT and EC_PWM_TYPE_KB_LIGHT pwm
> > types to the PWM cros_ec_pwm driver. This allows specifying one of these
> > PWM channel by functionality, and let the EC firmware pick the correct
> > channel, thus abstracting the hardware implementation from the kernel
> > driver.
> > 
> > To use it, define the node with the "google,cros-ec-pwm-type"
> > compatible.
> 
> Not sure whether you decide to leave the prefix as is or not[1], just another
> reminder: to be neat, suggest to remove "drivers: " prefix from the commit
> title.

Sorry I messed up there, fixed in on the wrong branch and then forgot to
re-fix it once I moved to the wrong one -- I'll make sure to get that
right now, thanks for your patience.

> 
> [1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220331125818.3776912-3-fabiobaltieri@chromium.org/
> 
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id cros_ec_pwm_of_match[] = {
> > +	{
> > +		.compatible = "google,cros-ec-pwm",
> > +	},
> > +	{
> > +		.compatible = "google,cros-ec-pwm-type",
> > +		.data = OF_CROS_EC_PWM_TYPE,
> > +	},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
> > +#else
> > +#define cros_ec_pwm_of_match NULL
> > +#endif
> > +
> >  static int cros_ec_pwm_probe(struct platform_device *pdev)
> >  {
> >  	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
> >  	struct device *dev = &pdev->dev;
> > +	const struct of_device_id *id;
> >  	struct cros_ec_pwm_device *ec_pwm;
> >  	struct pwm_chip *chip;
> >  	int ret;
> > @@ -251,17 +312,27 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
> >  	chip = &ec_pwm->chip;
> >  	ec_pwm->ec = ec;
> >  
> > +	id = of_match_device(cros_ec_pwm_of_match, dev);
> > +	if (id && id->data == OF_CROS_EC_PWM_TYPE)
> > +		ec_pwm->use_pwm_type = true;
> > +
> [...]
> > -#ifdef CONFIG_OF
> > -static const struct of_device_id cros_ec_pwm_of_match[] = {
> > -	{ .compatible = "google,cros-ec-pwm" },
> > -	{},
> > -};
> > -MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
> > -#endif
> > -
> 
> Use dev->driver->of_match_table to access the table so that the table
> declaration doesn't actually need a move.  Instead, the helper function
> of_device_get_match_data() is preferred.
> 
> Alternatively, it could use
> of_device_is_compatible(..."google,cros-ec-pwm-type") so that it doesn't
> need to introduce OF_CROS_EC_PWM_TYPE and reduce some bits.  I would prefer
> this way.

That's a very good point, should simplify things a fair bit, did not
realize of_device_is_compatible() was an option somehow, will rework it
for that and send a v4 soon. Thanks for the pointer.

Fabio

-- 
Fabio Baltieri
