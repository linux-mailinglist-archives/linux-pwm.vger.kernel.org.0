Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280A02A7CA9
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 12:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgKELNF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Nov 2020 06:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgKELNE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Nov 2020 06:13:04 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C336AC0613CF
        for <linux-pwm@vger.kernel.org>; Thu,  5 Nov 2020 03:13:04 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id g7so948090pfc.2
        for <linux-pwm@vger.kernel.org>; Thu, 05 Nov 2020 03:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BcYYFtNRltYDE4hy/KAkGjdjtprJ1Trm7OKV+MnN8cU=;
        b=u8YwcS6hVr8BwxXTTAlNESEmEgsS3lF6OTr1XaUbam4I/edC3qndBdjg6Uy8iz2Q4Q
         hYlNAs1/XTw3soHv/si3tXmCczuo3mNDte6nlbwM878k4WF91kDK1iYVRDtibkoROSKj
         yjfCZIqB3MO3ncbEJATqL58LXrnls4IqwABwbbGOdNIV9RGTDrMZptXqbnjj+V1N6WqI
         HBRHng10F8RPuKJ6CJ1uCINPNb6xUgsC8CsubJFIRFcKAf9XUt6Zu0y7tcW3MCJO9JyS
         huRJpus5BnMDQprBpyeMBR2Zh8O7Sqy9/tsu93YAUw3ok0YtILTEkI4ZmB3ZgeuvMkLC
         Ze4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BcYYFtNRltYDE4hy/KAkGjdjtprJ1Trm7OKV+MnN8cU=;
        b=BddTyimVnfl70HoP4wNISX3Wh+jIi0GeFYMIUNfwZl3+D+wwVap+5dmBlQaNpL1Dw4
         6uinaGviZGzBwc+cF9mtQnQRFXjBWsG4YNschEUzR+JnVF6Kh0J7iKPmOdL5SlKB/PJ2
         wsfVWUQVK/s8XyFzOdo1RYqstbf6EQ1y99JT0OK6kZWjOqe5DOUPbNEysCv90VuQ7L5u
         UEOErdR+vhyxawki1Nozfu6fHZMDnX6/8jn3yw6hDzjHRxRGZ3kIFWcwOjFfLZsDWvmN
         C7NU05A4lSzRXLw7k7J40XvkB1DHg3si3icuL8JfX90wE0bB7+d99jMkyCX1rd/4dk2a
         Ptnw==
X-Gm-Message-State: AOAM533jv0Nk40hmd1lKS1WKw058zpEFwYtVj/lLIWyO7H/Wnv6R36pW
        DOOP1jOBbWMLFwXZ1hdRPsa46Q==
X-Google-Smtp-Source: ABdhPJwnuuk4daHbZCdYn/aCWQKiS7cX8bO0eWv5v6ODss+cRR8E8lvUDPwS9VwogQBWTDgNXP1wow==
X-Received: by 2002:a17:90a:e391:: with SMTP id b17mr1925329pjz.209.1604574784247;
        Thu, 05 Nov 2020 03:13:04 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id f204sm2296698pfa.189.2020.11.05.03.13.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 03:13:03 -0800 (PST)
Date:   Thu, 5 Nov 2020 16:43:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
Message-ID: <20201105111301.2hxfx2tnmf2saakp@vireshk-i7>
References: <20201104234427.26477-1-digetx@gmail.com>
 <CAPDyKFr7qTU2RPhA_ZrbCayoTTNUEno1zdmvmv+8HBe-Owrfeg@mail.gmail.com>
 <20201105100603.skrirm7uke4s2xyl@vireshk-i7>
 <CAPDyKFoCJt5MBSKBJ8n1OAMdVsWHdwXTx0zFEcZw_F_gQ6Ug0w@mail.gmail.com>
 <20201105104009.oo4dc6a2gdcwduhk@vireshk-i7>
 <CAPDyKFpQG98d6foc1U6fp3YEBdZ1vLqY9cmWxpUwXoKgDn+ojQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpQG98d6foc1U6fp3YEBdZ1vLqY9cmWxpUwXoKgDn+ojQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 05-11-20, 11:56, Ulf Hansson wrote:
> On Thu, 5 Nov 2020 at 11:40, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Btw, how do we identify if it is a power domain or a regulator ?

To be honest, I was a bit afraid and embarrassed to ask this question,
and was hoping people to make fun of me in return :)

> Good question. It's not a crystal clear line in between them, I think.

And I was relieved after reading this :)

> A power domain to me, means that some part of a silicon (a group of
> controllers or just a single piece, for example) needs some kind of
> resource (typically a power rail) to be enabled to be functional, to
> start with.

Isn't this what a part of regulator does as well ? i.e.
enabling/disabling of the regulator or power to a group of
controllers.

Over that the regulator does voltage/current scaling as well, which
normally the power domains don't do (though we did that in
performance-state case).

> If there are operating points involved, that's also a
> clear indication to me, that it's not a regular regulator.

Is there any example of that? I hope by OPP you meant both freq and
voltage here. I am not sure if I know of a case where a power domain
handles both of them.

> Maybe we should try to specify this more exactly in some
> documentation, somewhere.

I think yes, it is very much required. And in absence of that I think,
many (or most) of the platforms that also need to scale the voltage
would have modeled their hardware as a regulator and not a PM domain.

What I always thought was:

- Module that can just enable/disable power to a block of SoC is a
  power domain.

- Module that can enable/disable as well as scale voltage is a
  regulator.

And so I thought that this patchset has done the right thing. This
changed a bit with the qcom stuff where the IP to be configured was in
control of RPM and not Linux and so we couldn't add it as a regulator.
If it was controlled by Linux, it would have been a regulator in
kernel for sure :)

-- 
viresh
