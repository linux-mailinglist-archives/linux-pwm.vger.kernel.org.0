Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70102189877
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2020 10:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgCRJtx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Mar 2020 05:49:53 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45189 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCRJtx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Mar 2020 05:49:53 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M7ayR-1jD8Pi3tHx-0080EA; Wed, 18 Mar 2020 10:49:52 +0100
Received: by mail-qt1-f181.google.com with SMTP id n5so20097201qtv.7;
        Wed, 18 Mar 2020 02:49:51 -0700 (PDT)
X-Gm-Message-State: ANhLgQ074gg76hLHWhbR90Ftqsgg0fDdbaD+R5o+qXfuEDh0sBhsXjBs
        Ufgp8B/uRgMiosC+zw7VqPTeENzXPJ/DqD2VgE8=
X-Google-Smtp-Source: ADFU+vuZatV17Zl74+SHt/QiM6dlAWSwco+C3yE07S6yC/qyO02awDJyibHaLjvX8iQIPaB1c+EJ0/kfYHZL62HxXJ8=
X-Received: by 2002:aed:3b4c:: with SMTP id q12mr3400957qte.18.1584524990718;
 Wed, 18 Mar 2020 02:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584473399.git.gurus@codeaurora.org> <587f9ccae68ad7e1ce97fa8da6037292af1a5095.1584473399.git.gurus@codeaurora.org>
 <CAK8P3a2Hi_AoRC3g7qKth4e_Y1jZrbBDhWUb3YPZm10FWMu-ig@mail.gmail.com> <20200317233003.GA11350@codeaurora.org>
In-Reply-To: <20200317233003.GA11350@codeaurora.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Mar 2020 10:49:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2a-QEwFfDE5FbFCVdDS+t9jirgbHWJQQv0i5_OMCYXJg@mail.gmail.com>
Message-ID: <CAK8P3a2a-QEwFfDE5FbFCVdDS+t9jirgbHWJQQv0i5_OMCYXJg@mail.gmail.com>
Subject: Re: [PATCH v9 04/11] pwm: clps711x: Use 64-bit division macro
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GJNg+zbJ/QTr93mXo+ZUGvwLJZcrToMwk5hiStg0JKtSAfJ+jkx
 DL/IFajK7amfBNdOpRZrLp3YsL1MG6AZdEAQ43ycfvw6LP36azEprK7WI+3ip29mhwwpaDQ
 +hDpiajVtmgeYQBAbNZXGjIZ/boPADTXjK2MYiy4jeGywZpEarMgjXAH0dC6iF9PNm4aVVs
 HjBwlYP2A+LbTzmWmQdiQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:D1cv3uqKd2M=:9LvQjGE/K8Nz7rkz10WynY
 X0ykvFjkbkQ/SxwFchNgiEsqf9I3+6PElY3eKR4TS4iSkJi5F+IvrfYrY4r6yzonpJKAiDHec
 epvr46nsD3ezZIyJB/tB5d5gLXNLiGNUfGE/Pw4V30el+aH8AWXcS8zDVeJoKVlrlnjRK4bOw
 fq4vWIvaDOvIejDr2ny58Hbdmvx3xLeDevtNvxBaEBuFuSYNDRmnaYkS7tKW0auvPs4MvRFOw
 XdMD2+Q/SqpsRaRzR+8BiURjoQk5+kjzKhSdydhZXJrhBtF7sdmwlsvWUDI1D4rlA+yfm6cdb
 c3G93BUVhNax1ObtZcDurv2zuUe6912f4PQIC2Zi7rFhufP1iytyfrcHoX4sw8gXb0WzVrJOY
 xZKLJP2dD9QrmEI5bFdLwovK+v95vrUj9N/eZlOFGzTvRw0mdTycPGmpfCEXDJR1uIazq/vaV
 MkzhRo4N5Rr6gL+BhtTfK9Ss4k73SUHIvLE2u7mJO1nIyB6fTz1f7WdoiZGyi2zdDrYWESz8c
 2JRo0uhyyyl51u4pFPSocchxQoo/Cb64Dj7FnvmAj7glkNfwrdbISxxYYUN9aTnKqwl+zXsqA
 fN2Tm0aetkdLpfcbLwmu3etv5xclhzMVFuRrH6qo9mXhIf2bAsRt2n2c+OGr31QJTR96IN446
 HLZKvnvLKKvOW/X9KAIO/0/dgsHUi5NVPYD13+Xj3IOL3rFqTch6XZAkKXBWlEDPqCkmaj6so
 RbQHgnZa5hwMh+CAU08G8HtP+S2hIfAxerNKQLxdrL2OC4iL+wPq1s+ITJgrwIMnkztPyl7Dj
 5NAJW07sFqtSAB8B1QSbYjJ6rITMPWxfD9veMDwrAoucC8RUuo=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Mar 18, 2020 at 12:30 AM Guru Das Srinagesh
<gurus@codeaurora.org> wrote:
>
> On Tue, Mar 17, 2020 at 11:22:06PM +0100, Arnd Bergmann wrote:
> > > diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> > > index 924d39a..ba9500a 100644
> > > --- a/drivers/pwm/pwm-clps711x.c
> > > +++ b/drivers/pwm/pwm-clps711x.c
> > > @@ -43,7 +43,7 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
> > >  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
> > >  {
> > >         /* Duty cycle 0..15 max */
> > > -       return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > > +       return DIV64_U64_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > >  }
> >
> > Is it actually going to exceed U32_MAX? If not, a type cast may be
> > more appropriate here than the expensive 64-bit division.
>
> With the final change in this patch series, the framework will support
> periods that exceed U32_MAX. My concern is that using a typecast would
> mean that in those cases, this driver will not support > U32_MAX values.
> Using DIV64_U64_ROUND_CLOSEST makes the driver future proof and able to
> handle > U32_MAX values correctly. What do you think?

Ah, so if the period can actually be larger than U32_MAX, you need to
handle that case. However, I see that the divident in this code (v * 0xf)
is still a 32-bit number, so a correct and efficient implementation could be

   if (pwm->args.period > (UINT_MAX / 0xf))
          return 0;
   return DIV_ROUND_CLOSEST(v * 0xf, (u32)pwm->args.period);

        Arnd
