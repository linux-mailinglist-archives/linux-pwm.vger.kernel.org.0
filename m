Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D522924E6A6
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Aug 2020 11:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHVJXa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Aug 2020 05:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHVJXa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 Aug 2020 05:23:30 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DC2C061573;
        Sat, 22 Aug 2020 02:23:30 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v15so2134841pgh.6;
        Sat, 22 Aug 2020 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aI39wUQrT4gwVKkfiPc/6BrYsBsFxtTiYiQuKGUyQNc=;
        b=BjRC2XO6ziRv5s9rs7O7otCwVIpQS+qXELx0bfeHcgi7yZMg4ZDjYCKCzeE3cSrn7J
         h4rt+xfTU7u3rEtLqLTGv/nx/hmTQOJM5YZIJH2l2TP+6Z9sWo6O0X+LDYXWfDrGHZFJ
         Aha7B53M6BI+GRJorY7VSNxeD7kQ82nnZeclcZICDoVEFKn1GwaFbFkmNZvRVFMWjcLk
         ygWjIEK/hsHVLQbtAM+aq9UkdYx1spA51nTnAHVL+b+nu1B6VMIIY2vW6F6KkIXUIwfb
         zzBeU9UXeVKXTAmxcK+hVjZq4b7zZxDNIi/Q55A/2LmnGUHt45k1x0ry0jfeNHoWkAZA
         RlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aI39wUQrT4gwVKkfiPc/6BrYsBsFxtTiYiQuKGUyQNc=;
        b=CgHdDhIh1TS0kOaQCWSKo5f9MMBiPgtCe34Ot5b9FLpy85E60P42c3Ho1ivcEvN91D
         1VpE3vHAoSGx0dZSsBBK93Ql6tOFuwkHoCSqpyNBJwFhCGgeg5W6T5gYJfoQSKYLBLQQ
         IUynCCG1hnGubSITmGiqqfD9ckIVHOir9PqexS+rYPNHv/UBN9P8Jj8A996B4Wy36oS5
         VUfqcfOn/K75uspeAo+z07KFcHeclMI0SpP0/QEQpu9noidie69ZttrQr6TtSkFsiX+9
         iILXAviE1S9UYRBa42Uq+HCt6YCjqSftcpwzlRSOwnbsyDXg2fa6nvfkqfzgY4ncTv5r
         UKBA==
X-Gm-Message-State: AOAM530GjCK3lEzGRl/2h0i12UvH0QXuoh/M21OwH0Eax+WbibpkuHpb
        mW8Gb9htfwPYzl8BIrQ5U4nTBETIynx/wJRmXlH3svQkzGKsfw==
X-Google-Smtp-Source: ABdhPJz4qAwL/hficWhPP7/Q7Cn9/sFEW/U3BO4PJc8qZ0j+3vpx+hdgMhcqDNRluDgzEX2ahyveuiGTLzTTJBe0Qco=
X-Received: by 2002:a62:c319:: with SMTP id v25mr5537864pfg.130.1598088209565;
 Sat, 22 Aug 2020 02:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598001442.git.rahul.tanwar@linux.intel.com>
 <fedf5d1ace7c389a5fc0116865b9b88aa3ddeaa5.1598001442.git.rahul.tanwar@linux.intel.com>
 <20200821105618.GO1891694@smile.fi.intel.com> <d8c85de1-dacf-e8eb-6e49-131d007f3a6b@linux.intel.com>
In-Reply-To: <d8c85de1-dacf-e8eb-6e49-131d007f3a6b@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 22 Aug 2020 12:23:12 +0300
Message-ID: <CAHp75Vc1=_SeYHtQvXrV+G-b5t4vWS6ga3s_Zmez7rQPORWr7w@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] Add PWM fan controller driver for LGM SoC
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com, rtanwar@maxlinear.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Aug 22, 2020 at 8:25 AM Tanwar, Rahul
<rahul.tanwar@linux.intel.com> wrote:
> On 21/8/2020 6:56 pm, Andy Shevchenko wrote:
> > On Fri, Aug 21, 2020 at 05:32:11PM +0800, Rahul Tanwar wrote:

...

> >> +#include <linux/bitfield.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of_device.h>
> > We haven't settle this yet...
>
> I investigated more about it. I was getting build error because we were
> relying on of_device.h for including platform_device.h. You are right that
> we are not using anything from of_device.h. So i removed of_device.h from
> driver and added include <linux/platform_device.h> & build is ok.
>
> Regarding mod_devicetable.h header, it gets included indirectly from
> <linux/pwm.h> which includes of.h which includes mod_devicetable.h. So i
> think no point including it again in the driver.

Ideally you should include all headers you have direct users of.
mod_devicetable.h is exactly one and I doubt the pwm.h should include
it, but it's another story.

There are, of course, some cases when not all required because there
is a guarantee that upper one includes lower one. For example, if you
use bitops.h there is no need to include bits.h.

> >> +#include <linux/pwm.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/reset.h>

-- 
With Best Regards,
Andy Shevchenko
