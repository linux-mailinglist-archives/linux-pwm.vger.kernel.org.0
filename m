Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061122497C4
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Aug 2020 09:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgHSHya (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Aug 2020 03:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgHSHy3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Aug 2020 03:54:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C06C061389;
        Wed, 19 Aug 2020 00:54:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id i10so5458426pgk.1;
        Wed, 19 Aug 2020 00:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QwAFEdEDDKqsIqgg3REMrn8uyD1d4b02qEp5VMYwHFc=;
        b=YUfV5Yv2LLHOkYYtkzy81GZYkI754KspfwgvN8IHMM/uLtIrAFaqgi207aSOIRwAkL
         UX9rSUoMVKZ/K+kv4DE4JrZWd+gLvJFcWnP4VMlRxU8feWyWOOfEF1DhroSkt7ooZdvU
         DJzaTeJVvVn4dOscNdc/W/2m8WKJWSxfBDNSr6BUlcujKN+ix8ycxeTiCuV5rhejzkbc
         /HgsIUcoKnJqkUTjDofjwqdwm7uRFrOYI1laVE4zaVMO/kAQ11OPJo9wSdSkECLr5wgF
         G6VwgMIfoLQ/q20kPpEeSR0yQksqL3mQTlQ/MEUP1zswhMtJ/57zeq6xo4AOt/Xvv7Nm
         JJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QwAFEdEDDKqsIqgg3REMrn8uyD1d4b02qEp5VMYwHFc=;
        b=ufZVrdWFRNXRdJgMT4Kj96bvSLLGpoBzp38VfOKgl1ecOgahLW/lLb0oDQqGa+v/2s
         supn+mDuo4vcuElg28nfucZ3EEmX0JSxC3RYro6ibx6bxsERrvuiOq+IFkKrRi2rm9sy
         v9eWdNJ78Vui0yHhyB8yE1o+VkuoTT0OdnF9pFP50dYoKJIZ1T77BxWSu4omgcb4bzU9
         jiEyxFTod0zZDb6NO9G8oUmO+Oyxb4CDQkE9G/BC6xqOPRXD71X02Qj4PxLg3fFRFjX/
         +H3GaIfxDZ7W/g4fbrBz0xNXSoDO+g9U6lgcAoMXvmb3ME+8Q+Id7IGaT2i45RwWEeiS
         lMPw==
X-Gm-Message-State: AOAM533+Q7AWGOQbVUXIfwtqw6GIMOyf5cBbCT/rC/LxQ16Vmnb4LpWt
        Nl8cC8kfvprs5qJoY3PnMji22VM6WErKesI9vOxKjUJZagfvmw==
X-Google-Smtp-Source: ABdhPJwACp1MR02sLehcTpPFfUhepYG7xdneExOXR2U4CUUcjuPq4pETeCnX+rbhFL6Wk9T8p7vqOqjoS/Kt4hMDTbg=
X-Received: by 2002:a62:758f:: with SMTP id q137mr17847033pfc.170.1597823668158;
 Wed, 19 Aug 2020 00:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597729246.git.rahul.tanwar@linux.intel.com>
 <20200818083852.GC1891694@smile.fi.intel.com> <37f7526e-5a04-1d27-347c-772fe085771e@linux.intel.com>
In-Reply-To: <37f7526e-5a04-1d27-347c-772fe085771e@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Aug 2020 10:54:11 +0300
Message-ID: <CAHp75VfDq7bRe6YQdUQyv=8jK737-QwpxZjGZ2HxCJ7iaQPwMg@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] pwm: intel: Add PWM driver for a new SoC
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

On Wed, Aug 19, 2020 at 7:18 AM Tanwar, Rahul
<rahul.tanwar@linux.intel.com> wrote:
>
>
> Hi Andy,
>
> On 18/8/2020 4:38 pm, Andy Shevchenko wrote:
> > On Tue, Aug 18, 2020 at 01:48:59PM +0800, Rahul Tanwar wrote:
> >> Patch 1 adds dt binding document in YAML format.
> >> Patch 2 add PWM fan controller driver for LGM SoC.
> >>
> >> v7:
> >> - Address code quality related review concerns.
> >> - Rename fan related property to pwm-*.
> >> - Fix one make dt_binding_check reported error.
> > I guess it misses the answer why pwm-fan can't be integrated into the soup?
> >
>
> Can you please elaborate more? I could not understand your point clearly.

It's not mine, it's Uwe's. There is an hwmon module called pwm-fan. As
far as *I* understand this, it can be utilized to control fans via PWM
APIs. And Uwe asked you if you considered that and why you don't
integrated  (coupled) it here.

-- 
With Best Regards,
Andy Shevchenko
