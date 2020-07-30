Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744DE232B27
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Jul 2020 07:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgG3FG6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 Jul 2020 01:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3FG5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Jul 2020 01:06:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F890C061794;
        Wed, 29 Jul 2020 22:06:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r11so6451388pfl.11;
        Wed, 29 Jul 2020 22:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=csGDARq6b67KYWYmxqYqD/AZkqsPXyTKLHgn7KZ5CSU=;
        b=iFZtHijepeHiW8lpFoesuBmCw5FvhFeSGueyq1aO25HAlASZeMFfhT9IxLfbynqj8+
         LRIxPKrEe0vuzKMj4pBqW+AJTo05X/keELVZwGNFnltqY6BBcN+6F9B3P9c3729Bwfrc
         p6ldZ3N6ZL/b2CyYJDgnoYii8IG2Ze2RWo4AU6IQBSxAX81uwp5Alo2cFCLtvwQHku4x
         g9Aln+1K79p186bdkzWNhYX1o53cft7uNtrSjHdSHSf32g6CbQh5PCmJ6HBz2OBgsCOG
         CS7tRQ0+TnnfIp3e16q0Gr57qqHM43sW/tyOgItSCCxjSbjxyoU1logX7PDDEgCAPZc1
         cqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=csGDARq6b67KYWYmxqYqD/AZkqsPXyTKLHgn7KZ5CSU=;
        b=D29WZPghAJe0JBUj9D9w+564agA3++kf9eouWB8IoiUlzuP3x6zd/4MHeH/Hv1IQS9
         JsN2qcJAkrThRo1icuyqhDDwYrAbVyv/ly2lYh96X7Z/+Mv05teveXnn5uQwXqpYG/lB
         vzc1759ezTYXiLplKqI/7OVTGP24jTInAmnCM7TqshZbPmaDYRoxu5/9IZz8oVijcctu
         SipVVjiVBbgsTZoORkdPm3IV+CtMptOsMvKm5CDNuJ36gxDyVx0SaGBfnslILdKFDvyA
         Ap1b/0ZUlpgVyrPosRtV3Tdl9LzH2mYjeaiIfsNPk4eL/el78+NosyGAKg1JfF85AVFN
         a9BA==
X-Gm-Message-State: AOAM530GqYomprH+76QYFTBZCfsBK37f8606WNxpyRfyVGSuHIh8icEu
        hgWzrBB5yQrEbrSNHl+m3/c=
X-Google-Smtp-Source: ABdhPJz7X/HOx1YGwe094F980kEM3sIFfOs1hxNLhNinFp4BaaRxlhFKsMt9SI28JMZdWR+buRh7Lg==
X-Received: by 2002:a65:6384:: with SMTP id h4mr32525387pgv.196.1596085616645;
        Wed, 29 Jul 2020 22:06:56 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id k29sm4369451pfp.142.2020.07.29.22.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 22:06:56 -0700 (PDT)
Date:   Wed, 29 Jul 2020 22:06:53 -0700
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
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v18 3/3] Input: new da7280 haptic driver
Message-ID: <20200730050653.GA1665100@dtor-ws>
References: <cover.1595991580.git.Roy.Im@diasemi.com>
 <23b3470401ec5cf525add8e1227cb67586b9f294.1595991580.git.Roy.Im@diasemi.com>
 <20200729063638.GY1665100@dtor-ws>
 <20200729072145.ifzoe656sjpxdior@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200729072145.ifzoe656sjpxdior@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Wed, Jul 29, 2020 at 09:21:45AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Jul 28, 2020 at 11:36:38PM -0700, Dmitry Torokhov wrote:
> > > v9: 
> > > 	- Removed the header file and put the definitions into the c file.
> > > 	- Updated the pwm code and error logs with %pE
> > 
> > I believe the %pE is to format an escaped buffer, you probably want to
> > %pe (lowercase) to print errors. I am also not quite sure if we want to
> > use it in cases when we have non-pointer error, or we should stick with
> > %d as most of the kernel does.
> 
> compared with %d %pe is easier to understand as it emits "-ETIMEOUT"
> instead of "-110". And yes, %pE is wrong.

While I can see that symbolic name instead of a numeric constant might
be appealing, I do not believe that we want fragments like this with
endless conversions between integer and pointer errors:

	if (haptics->const_op_mode == DA7280_PWM_MODE) {
		haptics->pwm_dev = devm_pwm_get(dev, NULL);
		if (IS_ERR(haptics->pwm_dev)) {
			error = PTR_ERR(haptics->pwm_dev);
			if (error != -EPROBE_DEFER)
				dev_err(dev, "unable to request PWM: %pE\n",
					ERR_PTR(error));
			return error;
		}

Maybe we should introduce something like '%de' for the integer error
case? In the meantime I would prefer using %d when we have integer
error. We should not see these error messages anyway ;)

Thanks.

-- 
Dmitry
