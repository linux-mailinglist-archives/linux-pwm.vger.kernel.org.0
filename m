Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9BE232BF6
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Jul 2020 08:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgG3GeL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 Jul 2020 02:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgG3GeL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Jul 2020 02:34:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C278C061794;
        Wed, 29 Jul 2020 23:34:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s26so14451105pfm.4;
        Wed, 29 Jul 2020 23:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kToeWqX8LPcqEgnlfCirN12A/tdS+maRL6/n1yqysKA=;
        b=DFTK2YieJvfvPDKWhYoMJif2Vo7FFZPyhZ6OtelC8L8bXX3DkJmDk0amg+bWxS9ldX
         8ovwZ5s6g8EPy/D6AQWaMo3syOhSqZ47uNGuS54gbGYKkrGFowDz8+WwKvv1wna0h4yp
         iQtI0AtkRkuKZOFVPo1AoBZZbkL58uPlDJ2N1tNDZ6i7iRDZhFUvdGppdXW9KgcVrVzp
         qWoxsGaO9/W+Q1TKQRKV4PvxTUNOiqNzJMlmT1dL11Eiy4eSDSrG0ikFKpjjsduQdXYy
         ZYxjHaCMKVVCBQDjrmZiOb/o1efd1+o0Zqusue3qymwRpP2ATHu9CEeJCUIy1NXLpRSQ
         FDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kToeWqX8LPcqEgnlfCirN12A/tdS+maRL6/n1yqysKA=;
        b=iHdSNMlKHP82NGQysIcNaJ5GxINE9uXn9sh3vgbZgWHmHhcp4mlKncRfulXnLJAJzm
         qBZnDAqd7PHtaI7utMmf/RaPL1c7QaXVci19kHLX3cSolsoVykFYWFKskdhcYj2EbQfO
         vD9z0gXMsqgeekqGyBh+qPw43N8WQiL6EbbP36GLL1VU+B36hulMg1dx3EFMCbzpuRnQ
         NrW99b5U3vfLmsFhzTR9T+Eq0GRUWazGYKm6I/GMSfEZeYoXB9iNFiREwNQKJb7ER+XA
         UOpiuOxO3n74TZAXL3YXAVqU+oGOGgDonM5agnVu1Cz5If4kVkj7OAYpmVo03FHQLmZY
         gKfA==
X-Gm-Message-State: AOAM530VuUiOTkh8po7fYkNXMFUDbfVOKY+Pn7wj34tK8SNrxkr/u5wM
        MGYLn0emfDqpBRIQhu3LqXEsmtmeSLY=
X-Google-Smtp-Source: ABdhPJyv6RK+O8lL+CYILDbAM/GG3tDeH+ZwPqCepMPINZRWS+JvYYQGMnVu+rx8//8jf5CfpQirfg==
X-Received: by 2002:a63:c50a:: with SMTP id f10mr33919624pgd.167.1596090848451;
        Wed, 29 Jul 2020 23:34:08 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id n26sm284380pgl.42.2020.07.29.23.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 23:34:07 -0700 (PDT)
Date:   Wed, 29 Jul 2020 23:34:04 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Roy Im <roy.im.opensource@diasemi.com>,
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
        linux-pwm@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v18 3/3] Input: new da7280 haptic driver
Message-ID: <20200730063404.GH1665100@dtor-ws>
References: <cover.1595991580.git.Roy.Im@diasemi.com>
 <23b3470401ec5cf525add8e1227cb67586b9f294.1595991580.git.Roy.Im@diasemi.com>
 <20200729063638.GY1665100@dtor-ws>
 <20200729072145.ifzoe656sjpxdior@pengutronix.de>
 <20200730050653.GA1665100@dtor-ws>
 <20200730061631.y4r4s6v3xepktj54@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200730061631.y4r4s6v3xepktj54@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jul 30, 2020 at 08:16:31AM +0200, Uwe Kleine-König wrote:
> [Adding vsprintf maintainers to Cc:]
> 
> Hello,
> 
> On Wed, Jul 29, 2020 at 10:06:53PM -0700, Dmitry Torokhov wrote:
> > On Wed, Jul 29, 2020 at 09:21:45AM +0200, Uwe Kleine-König wrote:
> > > Hello,
> > > 
> > > On Tue, Jul 28, 2020 at 11:36:38PM -0700, Dmitry Torokhov wrote:
> > > > > v9: 
> > > > > 	- Removed the header file and put the definitions into the c file.
> > > > > 	- Updated the pwm code and error logs with %pE
> > > > 
> > > > I believe the %pE is to format an escaped buffer, you probably want to
> > > > %pe (lowercase) to print errors. I am also not quite sure if we want to
> > > > use it in cases when we have non-pointer error, or we should stick with
> > > > %d as most of the kernel does.
> > > 
> > > compared with %d %pe is easier to understand as it emits "-ETIMEOUT"
> > > instead of "-110". And yes, %pE is wrong.
> > 
> > While I can see that symbolic name instead of a numeric constant might
> > be appealing, I do not believe that we want fragments like this with
> > endless conversions between integer and pointer errors:
> > 
> > 	if (haptics->const_op_mode == DA7280_PWM_MODE) {
> > 		haptics->pwm_dev = devm_pwm_get(dev, NULL);
> > 		if (IS_ERR(haptics->pwm_dev)) {
> > 			error = PTR_ERR(haptics->pwm_dev);
> > 			if (error != -EPROBE_DEFER)
> > 				dev_err(dev, "unable to request PWM: %pE\n",
> > 					ERR_PTR(error));
> > 			return error;
> > 		}
> > 
> > Maybe we should introduce something like '%de' for the integer error
> > case?
> 
> I suggested that some time ago with limited success, see
> https://lore.kernel.org/lkml/20200129115516.zsvxu56e6h7gheiw@pathway.suse.cz/
> .
> 
> > In the meantime I would prefer using %d when we have integer
> > error. We should not see these error messages anyway ;)
> 
> I don't agree. Error messages are supposed to be helpful and I prefer
> some casting between error pointer and error int over emitting bare
> numbers to the kernel log. (And additionally the uglyness might help to
> convince the vsprintf guys that %de might be a good idea after all :-)

Sorry, but I do not think that I want to introduce this pointless
casting just to sway printk folks. Either we have proper way of
formatting error codes, or we do not and we stick with what was working
since forever.

Thanks.

-- 
Dmitry
