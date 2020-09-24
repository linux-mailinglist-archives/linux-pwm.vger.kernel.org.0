Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D4E2770D6
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Sep 2020 14:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgIXMXg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Sep 2020 08:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbgIXMXg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Sep 2020 08:23:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6199C0613D4
        for <linux-pwm@vger.kernel.org>; Thu, 24 Sep 2020 05:23:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so3576830wrx.7
        for <linux-pwm@vger.kernel.org>; Thu, 24 Sep 2020 05:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PtKTSY41aN1c2YuBo2WSiO9cWck/dx6VHgtWV4uIRZY=;
        b=JTw9rlKqb7OA6x+z5c1wx9ysAooN1pK080IGSL+W35JC7huBDX4ODEhwa9uX9gS/ot
         JEVVjHvndcj5/E5EzEOC5riFAwzXaybbulwl6mgodr25RK+mfdfKEUDvxRZWNIUgbpl4
         j4g0hcpdhVYblF1r6JUgpqOPid/6OEcM6CIcaVrg2YWW/rXAwuQKuPOU/a2zxO8SGtRS
         g3mTZ2FqLPc7o8kVlyVXuyqVMKetHSqpmMQUoB1T/XsWl3yCTWcgcXeU7txgvZzMiMRt
         EgR2nJWLr8t+D2qENoyn2l8rn6hcUr9p/E8EswMTPZMieAVp6dnmeCnKd1vT+46+SugJ
         dBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PtKTSY41aN1c2YuBo2WSiO9cWck/dx6VHgtWV4uIRZY=;
        b=twHBG4BUX8nSWA8HJKXCKn6VBOU2s0XiF5LBvzPWMKZV0AIJWGr1TKvGFIewO1SxoK
         MJk7GmmK/yXVVXieNIHmny3f9CQgNOHYzu6CyT6NiLdWKF4i+Boc/Zex0/RaXn+ZKLoB
         3VN+4pNOiKaf6ux6w59svNR8xbMLv9YSrpPkFZaHecWcqLURWtXGNJY/dl5E/rtDTzwC
         h2XuU1k/uv7OlRO5FhaVfhQK9n/pGZLTSjlx7mQtY+Fa1ryhAquHHzWHselRm/eVRbr5
         YZGEUY5TNqzlhTIk+RRIfVc4Mh/c5A1Pmh65kQwYS1QEpXGY/+tlxiKuOWZAwI6dpn5M
         Kr6g==
X-Gm-Message-State: AOAM530cc4PtTdmOUctzKClL2WqJty6Dqv7/P21aeLmAC40wPzOG0db4
        cvKmsVQe9nXHnZH1gGe2b993Dw==
X-Google-Smtp-Source: ABdhPJy7ULYZbpEC8tfOVe9Mmk1pHPqjw5QNKn8R14l+Rp01r1fpkEf03DuUAi+CWOla+NWxotL9FA==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr4714560wrq.282.1600950214250;
        Thu, 24 Sep 2020 05:23:34 -0700 (PDT)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id m13sm3500600wrr.74.2020.09.24.05.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:23:33 -0700 (PDT)
Date:   Thu, 24 Sep 2020 13:23:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: add Dan Murphy as TP LP8xxx drivers
 maintainer
Message-ID: <20200924122331.GI4678@dell>
References: <20200922152839.2744-1-krzk@kernel.org>
 <fe4609b5-5aab-46ed-5280-9a4742b97fe5@ti.com>
 <20200923205857.5af407ee@archlinux>
 <CAJKOXPdWD47OvK7qQ4Md2t3U=NmSf=j5hNjBq4+8CgZKLdup=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJKOXPdWD47OvK7qQ4Md2t3U=NmSf=j5hNjBq4+8CgZKLdup=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 24 Sep 2020, Krzysztof Kozlowski wrote:

> On Wed, 23 Sep 2020 at 22:01, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Wed, 23 Sep 2020 11:53:33 -0500
> > Dan Murphy <dmurphy@ti.com> wrote:
> >
> > > Hello
> > >
> > > On 9/22/20 10:28 AM, Krzysztof Kozlowski wrote:
> > > > Milo Kim's email in TI bounces with permanent error (550: Invalid
> > > > recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> > > > credits and add Dan Murphy from TI to look after:
> > > >   - TI LP855x backlight driver,
> > > >   - TI LP8727 charger driver,
> > > >   - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
> > > >
> > > > Cc: Dan Murphy <dmurphy@ti.com>
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > >
> > > Acked-by: Dan Murphy <dmurphy@ti.com>
> > >
> > Not sure who will pick this one up, but
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I guess whoever is first. :)
> This spans across systems but the common part is MFD, so maybe Lee -
> could you pick it up?

Yes, I'll handle it.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
