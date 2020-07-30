Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D257232B2D
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Jul 2020 07:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgG3FKS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 Jul 2020 01:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgG3FKS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Jul 2020 01:10:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C7CC061794;
        Wed, 29 Jul 2020 22:10:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d1so13135960plr.8;
        Wed, 29 Jul 2020 22:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Vkw/8crPqmhVB2Zcyh0SoqmwjZCclFsRnwB76cJQ0w=;
        b=vfT1P3WGIsMFyWgzAeDSPjrX3k6/wgMcQwpcVeG1XYoe0HNZd2ApnUmvCtIFQVnZLE
         yVQKnl4GVlnw4vOAD8rU+EWGf95i9xhoG1u1r/LYJ5Hwnd0oyGDVpfkOnGDH3cvkYy5r
         MjAcpE4QijWE0Owfvj2X9a9IPLIFTkhiuOFPmzwlUrpyj3Dle8u0i2Raq2wvKm6XGSTz
         zVFm+qKk88/axVw/ktK2phYFMf7eSRgjVI4hakDITkJt3FKSuK142npj/oAU0DRhZAxu
         LNrJpCJOkAiRA2cxjVpRl57JGlb1OCyrGJoeqMP96M8F8ya6k5NDGsPLX1UUNjBMNpSx
         EiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Vkw/8crPqmhVB2Zcyh0SoqmwjZCclFsRnwB76cJQ0w=;
        b=aXzdvExFUeWY+OZypaqx1enJUK9GkxJuOmayX4etSR5QjlJEEo4HSuynhaqjhmHaym
         ay2XdXTsVujmE1TrYfxP46xzbT1KjmnImVbkvmboK5koYJU2wylP+cr6yN8Z6ubjB/SE
         FOZcqSZqn3c4h5cJoBVVNTuRGcq9nz/i+s2MA8D6AR+JMdIlaGO97f59h2GDGX/mvHPJ
         lgkJaXWmRZdvdRY6n1Bj4Q9LEYvJk2iOO2FvKWjiNSg0lDAjCM/t7P/NtqpZwIoQV1Cw
         +68JQTZtcCX/eBxDPMxK4LBsJKvE1n684I1JsYUlTCtzCC+Fg/X8l5y+MVUpOd7qbQB5
         vl1w==
X-Gm-Message-State: AOAM533BdgQb+NvzRLfGqkJXus29P/dghxlhJRvk0jQFHffarZX2knaR
        pK5GxVIcSNs1flTueOhVroA=
X-Google-Smtp-Source: ABdhPJy/OSW+dLeCrvdE5RnhZsyNUlaL3ioZOOHibWlEKYG66uBPyf4XO7AGHhFtcSZUCWm3c09W2Q==
X-Received: by 2002:a17:90a:3c8f:: with SMTP id g15mr1328728pjc.215.1596085816692;
        Wed, 29 Jul 2020 22:10:16 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id f27sm415310pfk.217.2020.07.29.22.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 22:10:16 -0700 (PDT)
Date:   Wed, 29 Jul 2020 22:10:13 -0700
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
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v18 3/3] Input: new da7280 haptic driver
Message-ID: <20200730051013.GB1665100@dtor-ws>
References: <cover.1595991580.git.Roy.Im@diasemi.com>
 <23b3470401ec5cf525add8e1227cb67586b9f294.1595991580.git.Roy.Im@diasemi.com>
 <20200729063638.GY1665100@dtor-ws>
 <DB8PR10MB3436EF37E1F1581BDB7996C785700@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB8PR10MB3436EF37E1F1581BDB7996C785700@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jul 29, 2020 at 02:09:48PM +0000, Roy Im wrote:
> Hello Dmitry and Uwe,
> 
> Wednesday, July 29, 2020 3:37 PM, Dmitry Torokhov wrote: 
> 
> > On Wed, Jul 29, 2020 at 11:59:40AM +0900, Roy Im wrote:
> > > Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with multiple
> > > mode and integrated waveform memory and wideband support.
> > > It communicates via an I2C bus to the device.
> > 
> > A few questions/suggestions...
> > 
> > >
> > > Reviewed-by: Jes Sorensen <Jes.Sorensen@gmail.com>.
> > >
> > > Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> > >
> > > ---
> > > v18:
> > > 	- Corrected comments in Kconfig
> > > 	- Updated to preferred style for multi line comments in c file.
> > > v17:
> > > 	- fixed an issue.
> > > v16:
> > > 	- Corrected some code and updated description in Kconfig.
> > > v15:
> > > 	- Removed some defines and updated some comments.
> > > v14:
> > > 	- Updated pwm related code, alignments and comments.
> > > v13:
> > > 	- Updated some conditions in pwm function and alignments.
> > > v12: No changes.
> > > v11:
> > > 	- Updated the pwm related code, comments and typo.
> > > v10:
> > > 	- Updated the pwm related function and added some comments.
> > > v9:
> > > 	- Removed the header file and put the definitions into the c file.
> > > 	- Updated the pwm code and error logs with %pE
> > 
> > I believe the %pE is to format an escaped buffer, you probably want to %pe (lowercase) to print errors. I am also not quite sure
> > if we want to use it in cases when we have non-pointer error, or we should stick with %d as most of the kernel does.
> 
> Right, it should be %pe as you and Uwe said, Uwe suggested %pe to understand easier.. do you still prefer to stick with %d?

Depends on the situation. If you already have ERR_PTR-encoded error
there is no reason for not using %pe, but if you have integer error, or
you have already converted pointer to integer I'd prefer we stick with
%d.

As I mentioned in another message maybe we should consider adding '%de'
or similar for formatting integer errors.

Thanks.

-- 
Dmitry
