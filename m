Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E4518A33C
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2020 20:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgCRTit (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Mar 2020 15:38:49 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55301 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRTis (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Mar 2020 15:38:48 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M7ehh-1jDo7O19GX-007yVe; Wed, 18 Mar 2020 20:38:47 +0100
Received: by mail-qt1-f173.google.com with SMTP id l20so21845055qtp.4;
        Wed, 18 Mar 2020 12:38:47 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2vIZImQVsuWD+d3viqlLNbwYGtobCuUdMwTfqoTQHayJq3giuZ
        OkDEYQPqXNBB+xw3+TvDAj6By0j8dqrVfvExYqA=
X-Google-Smtp-Source: ADFU+vvn/6/+JawTXEpY46QemN/gQyb00B1s81HT/rGLG3mO0v4lt6mV+QCRhTmc7BB0nT5XX3OMjO55fPDz2zi5SMg=
X-Received: by 2002:ac8:5193:: with SMTP id c19mr6236752qtn.204.1584560326056;
 Wed, 18 Mar 2020 12:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584473399.git.gurus@codeaurora.org> <587f9ccae68ad7e1ce97fa8da6037292af1a5095.1584473399.git.gurus@codeaurora.org>
 <CAK8P3a2Hi_AoRC3g7qKth4e_Y1jZrbBDhWUb3YPZm10FWMu-ig@mail.gmail.com>
 <20200317233003.GA11350@codeaurora.org> <CAK8P3a2a-QEwFfDE5FbFCVdDS+t9jirgbHWJQQv0i5_OMCYXJg@mail.gmail.com>
 <20200318170010.GA26509@codeaurora.org>
In-Reply-To: <20200318170010.GA26509@codeaurora.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Mar 2020 20:38:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2A3RuRu3bOSvq58Unb=vpnYnkxKsxJdLqkS=hPFDgM2Q@mail.gmail.com>
Message-ID: <CAK8P3a2A3RuRu3bOSvq58Unb=vpnYnkxKsxJdLqkS=hPFDgM2Q@mail.gmail.com>
Subject: Re: [PATCH v9 04/11] pwm: clps711x: Use 64-bit division macro
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3JSJPpzbkwjgdVbp+gyxcFIXYgKKNGhYit0teCaK00Nig3keMNV
 O5hNnyLIDCu4amv42mbNjc3uTgsHmMP9xDlz8rRp7noxYaOtG26hTUM8itKn1/OdGRS8K/U
 ZVylJkeh/YoSUsYplE1B4/0M4U3x32QMhmjpSjkRZem1MP443Yf1WVGwiNmAfcvueDcM6uf
 0W77NjwiiocsyTRClOWMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DKLpfu+dqtA=:YQKUFrvUkaWZSloHcyHCjO
 NZrCBNCiMrdc3oQMqQiTZ/gXKKKfjmIVU8pMzKVTCL+gndIidCrEfC3dYAXyWDYPn6pDOeTWJ
 PSYjJSq/cBJ/XEfOaBsIoofyUzmGaxPUarmVQC7T9jyNhcHIUgLHY8gisYSAh/XGb8f56cJ7Q
 F3GPV0N7dQWr/qhXKdjEYK76HIHZikf+d2phIz6aE/0DCt8osA5DYnoDdi4LBRA25CbGf/WMN
 V3EWjufG7Yz8KjazIyh1fWEW6R7b3jOrO8mhclXWRDVM9toGQZMdihh/KT+BOXNFRcuZ6imTz
 ny1LNh8MTET+xE3mHgNf40pPTpXQn8jCyemATM6EWdk2JFPzCLW5Jw3ZQTFHHQJkFpRkz8rq7
 q1roe4fxanagTTGmFHAi5yfqAbrslj1Di8PdvDagL8lDOUKX5QNAlqylmoRS6Z5ob4AhpCZab
 6M5K4GTQZwtcvK4EcsWDcWx61KczOu9WCXRGkTGw9/ApXpx6Ymng653qDocmnoPInbQrMhvYU
 j2rINxroh6iEsJfxfWHXg4r6SlyKmKTnsclsUCggCnhnV44YGxoavfpo6j9LreBjdL+ahF+Gn
 LW1u0PUW7/UpYHRNZfhIw4YGEshH8RzOhv2TphfWVlX0bilPtteuu4WMG83kJhZSqHW57hoGs
 dYgwnd5V2dVYhzgTFBZM/E6/qFV0URX3qcdFlE7sB6LIwiNraxNbcydbT9x6CJSWamIEaXD22
 YmbfT1EYA2Gc3LpZjrVlr2pb9mLkkeaNdIz18cJLP5qtQ20LGTDB5stJJ17mDMby7IyBEI13B
 KhowcRiQWPHrP5wQygAutcTKlZcDXYpN7IQ6AzBoMEn+HtJVCY=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Mar 18, 2020 at 6:00 PM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>
> On Wed, Mar 18, 2020 at 10:49:34AM +0100, Arnd Bergmann wrote:
> > On Wed, Mar 18, 2020 at 12:30 AM Guru Das Srinagesh
> > <gurus@codeaurora.org> wrote:
> > >
> > > On Tue, Mar 17, 2020 at 11:22:06PM +0100, Arnd Bergmann wrote:
> > > > > diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> > > > > index 924d39a..ba9500a 100644
> > > > > --- a/drivers/pwm/pwm-clps711x.c
> > > > > +++ b/drivers/pwm/pwm-clps711x.c
> > > > > @@ -43,7 +43,7 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
> > > > >  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
> > > > >  {
> > > > >         /* Duty cycle 0..15 max */
> > > > > -       return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > > > > +       return DIV64_U64_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > > > >  }
> > > >
> > > > Is it actually going to exceed U32_MAX? If not, a type cast may be
> > > > more appropriate here than the expensive 64-bit division.
> > >
> > > With the final change in this patch series, the framework will support
> > > periods that exceed U32_MAX. My concern is that using a typecast would
> > > mean that in those cases, this driver will not support > U32_MAX values.
> > > Using DIV64_U64_ROUND_CLOSEST makes the driver future proof and able to
> > > handle > U32_MAX values correctly. What do you think?
> >
> > Ah, so if the period can actually be larger than U32_MAX, you need to
> > handle that case. However, I see that the divident in this code (v * 0xf)
> > is still a 32-bit number, so a correct and efficient implementation could be
> >
> >    if (pwm->args.period > (UINT_MAX / 0xf))
>
> Shouldn't the if condition be the following? Or am I missing
> something here?
>
>      if (pwm->args.period > (UINT_MAX / (v * 0xf)))
>                                         ^^^^^^^^^

That would require performing a division, which is an external function
call on ARMv4. My version just checks for an upper bound and completely
avoids the division. You could also just check for ">UINT_MAX" if you
find that clearer.

      Arnd
