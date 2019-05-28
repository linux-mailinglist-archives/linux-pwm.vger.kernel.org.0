Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5217E2CE2C
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2019 20:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfE1SE5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 May 2019 14:04:57 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35415 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE1SE5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 May 2019 14:04:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id n14so18669335otk.2;
        Tue, 28 May 2019 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CQxWFe6czG2bT+E5vQ0cGm/ESs62tRcAolQyTGumg4o=;
        b=S96DHKfGnrWA3fayeAGBuk0VhGyiR0EWi0nRny8YntXYzTGPKq58f4EJtve596fjOJ
         codwqPXsn5sDeRcmx9hR2FbNzwUumlg5Rt6mZQuoPP8TJSunDqzcQ1eI+hkckvuwNaw+
         T0rvJ7Bnyzxl6cWLPWN4nJsqxzOagnXoBx9Vx+WjGun77D+76DZCCPsyWUuwDYsGWTLg
         E1KClD0GDUyCh+M8yKezXOJZX11761ZeraD7tFnD4LbLBbt7wUREWFG0H+ROARi8GwJA
         C/x0Rr+/RApnvVW65xyNSSC9PWexT4EaZ9qspfSTB75Dscey7bP0hKUFl/YTI9gEErrv
         39jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CQxWFe6czG2bT+E5vQ0cGm/ESs62tRcAolQyTGumg4o=;
        b=df1g/zK5K0k/K+JM2T/oWNq1Zkg2xOMAN+mRMJ4UVCOozfW6wkyA8T1N/1DcIagQC+
         M7Xgw8/DQPTjDu0AWElRqiraybznDwBWxq5zerHBnj3okjAdOVPXf7HjByYBcW+7AO6C
         PrxL4IqjK39KGggFRv+MQlBwxbWmj2LV4gh8gYDgXWsypZJKCl/z+246ThjIdPbM4/Wf
         oqdaZlY94fnl59wc2mdVFursL6MdL1RtKoxk3ltpn8E2X8rL+gRN+xkSKHehsK0iJoW2
         uCCjzqWUaAZVlfkekyYEzYfKIdH2gAj9KRJGXg5a3hnVTXPgRSO17diwutc82j1MmoWb
         ke5g==
X-Gm-Message-State: APjAAAUG2p/dxSQ1zj0kH7fWYSC9S5QVoPaloChxMpFiX90pGhN338J2
        J7t735WTloOgSXyueUlEsKi475cNx1N6SuZj448=
X-Google-Smtp-Source: APXvYqxQxsGkXFE+oqzGgB8Id81ggPL3jwHGjadRwPTCK4xlA9P4CLJsxyz90d3Pkk+rQcnZDov0VfIxSa3LyGBHu3I=
X-Received: by 2002:a9d:744d:: with SMTP id p13mr54509230otk.96.1559066696707;
 Tue, 28 May 2019 11:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-5-martin.blumenstingl@googlemail.com>
 <3b61897a-267b-fd6e-181b-a8c7e47918fb@baylibre.com> <CAFBinCDXNy4=6U2gsh6vK6WEtJKAdfDGPMrpPJthbp5Rru1hbg@mail.gmail.com>
 <20190527180047.nfsjfqs22coyqmvp@pengutronix.de>
In-Reply-To: <20190527180047.nfsjfqs22coyqmvp@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 28 May 2019 20:04:45 +0200
Message-ID: <CAFBinCCWYf4TJ8GTL3PrHMRfL3=Ma-QrTAGSyAp5OQc0M-67Jg@mail.gmail.com>
Subject: Re: [PATCH 04/14] pwm: meson: change MISC_CLK_SEL_WIDTH to MISC_CLK_SEL_MASK
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, May 27, 2019 at 8:00 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Mon, May 27, 2019 at 07:46:43PM +0200, Martin Blumenstingl wrote:
> > Hi Neil,
> >
> > On Mon, May 27, 2019 at 2:26 PM Neil Armstrong <narmstrong@baylibre.com=
> wrote:
> > >
> > > On 25/05/2019 20:11, Martin Blumenstingl wrote:
> > > > MISC_CLK_SEL_WIDTH is only used in one place where it's converted i=
nto
> > > > a bit-mask. Rename and change the macro to be a bit-mask so that
> > > > conversion is not needed anymore. No functional changes intended.
> > > >
> > > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.=
com>
> > > > ---
> > > >  drivers/pwm/pwm-meson.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> > > > index c62a3ac924d0..84b28ba0f903 100644
> > > > --- a/drivers/pwm/pwm-meson.c
> > > > +++ b/drivers/pwm/pwm-meson.c
> > > > @@ -33,7 +33,7 @@
> > > >  #define MISC_A_CLK_DIV_SHIFT 8
> > > >  #define MISC_B_CLK_SEL_SHIFT 6
> > > >  #define MISC_A_CLK_SEL_SHIFT 4
> > > > -#define MISC_CLK_SEL_WIDTH   2
> > > > +#define MISC_CLK_SEL_MASK    0x3
> > >
> > > NIT I would have used GENMASK here
> > that was my initial idea but I decided against it.
> > the variant I came up with was: #define MISC_CLK_SEL_MASK    GENMASK(1,=
 0)
> >
> > however, the actual offset is either 4 or 6 (depending on the PWM chann=
el)
> > and I felt that duplicating the macro would just make it more complicat=
ed
> > so instead I chose to be consistent with MISC_CLK_DIV_MASK
>
> An option would be:
>
>         #define MISC_CLK_SEL_MASK(hwid)         GENMASK(1 + 4 * (hwid), 0=
 + 4 * (hwid))
>
> (Note I didn't check a manual to the 4 above is probably wrong.)
that (or at least something similar) will work
the catch here is: we use it to initialize the mux clock and the
common clock framework expects us to set "shift" and "mask", while
mask starts at bit 0 instead of shift

this is how the current code is being used at the moment:
  channel->mux.shift =3D meson_pwm_per_channel_data[i].clk_sel_shift;
  channel->mux.mask =3D MISC_CLK_SEL_MASK;

so with MISC_CLK_SEL_MASK this would become:
  channel->mux.shift =3D meson_pwm_per_channel_data[i].clk_sel_shift;
  channel->mux.mask =3D MISC_CLK_SEL_MASK(i) >> channel->mux.shift;

or we could dynamically determine the "shift" using ffs or friends

my own brain parses the variant from the patch best
I'm happy to change it though if we can find something "better"


Martin
