Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F4DA7680
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2019 23:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfICVtI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Sep 2019 17:49:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37463 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICVtI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Sep 2019 17:49:08 -0400
Received: by mail-io1-f66.google.com with SMTP id r4so24281557iop.4
        for <linux-pwm@vger.kernel.org>; Tue, 03 Sep 2019 14:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pIo91Q36vun7aLtO9TkeIx08TIvyM7Sp/XL5FdL62Pw=;
        b=LwqvELJ1i2Q3DCg4D7DyATWzDxEvCOsUnieSldxwCDTtVgnP05O2ry04ib4XaqPbIu
         //KAgUTf3Q1zTWt50JrcYDrP5RnQRdhw/Si3UwwWjsaM/dFV3IwiyfMmHfzAhoP6Ipoo
         7QlVz4ne985Z+Jee/G692hohhiEcXBm7sr1AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pIo91Q36vun7aLtO9TkeIx08TIvyM7Sp/XL5FdL62Pw=;
        b=E8NC9PW7r4JcjbW9ZRnAPXCDVYQjEP/KfyOobGiwgzJecTcA1pPCdxBXuh2537VZDk
         0LVhN8Ubtj4BzyT1gui+BLzHEcDxTzya/xWjc17kKyK/0jHTOu/JBKGe33wbmjYWYadj
         UHQjiGGBUrkjl0zZXdR+kxvbARdKilorGh4+w4WuFIr3xjLOqYfKXVMBshhkQwX8I+J3
         FDRYmHL1WQD+OnjmgnvWBeYBsbd52LHfOeh/QZRMJKQpG+wHIl0VSgFeqrcIUbW0KLr6
         /ohArWvI6maJKqMohfUyKp7pe7bWbVUKtYQxDAvDeXewoP17hpgU3MMwj12yEWIDOTwu
         AIMg==
X-Gm-Message-State: APjAAAWu1RyRYRWImimMgTmRoscFW/Ais7y62XgUK41LmsCl1Eu5EbvS
        wnSYAGun43nR4nOtf1wqwi8VjyNWI5U=
X-Google-Smtp-Source: APXvYqz6A/n3kN04xXPhRpsHhlUUTTGVSrqjE+jT1KBVq8ae98rzduc+kMX+iYq/kF6fByUPnAP08w==
X-Received: by 2002:a05:6602:25d3:: with SMTP id d19mr767158iop.206.1567547346869;
        Tue, 03 Sep 2019 14:49:06 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id f7sm4261987ioc.31.2019.09.03.14.49.06
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 14:49:06 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id r4so24281463iop.4
        for <linux-pwm@vger.kernel.org>; Tue, 03 Sep 2019 14:49:06 -0700 (PDT)
X-Received: by 2002:a5e:8d14:: with SMTP id m20mr6935463ioj.52.1567547345570;
 Tue, 03 Sep 2019 14:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190824153707.13746-1-uwe@kleine-koenig.org> <20190824153707.13746-6-uwe@kleine-koenig.org>
 <CAD=FV=X8kVU_zr69aKe-+GkAQh-tDwVf8tFogKve3s5O5ndF-g@mail.gmail.com>
 <20190902142709.wxrjsfzorozgeiuh@pengutronix.de> <CAD=FV=XFTuixKL-VBv-QObiO=Jg43i6W0enprLgXQ0U8=9C49A@mail.gmail.com>
 <20190903184800.2fmmvwyzbwbsaf6y@pengutronix.de> <CAD=FV=XOyayzv6N9Ky8m2ffXe4UzUijzrL8JCMZC3K+MEzaRFw@mail.gmail.com>
 <20190903201550.gxcyed5svtq33ev2@pengutronix.de> <CAD=FV=WjRiaNLJQJ25OeNSpY455H-ev8g3iZN24UXQtk3uXhtA@mail.gmail.com>
 <20190903210740.qgyvxxmsdg5dzaby@pengutronix.de>
In-Reply-To: <20190903210740.qgyvxxmsdg5dzaby@pengutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 Sep 2019 14:48:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VDj8pCmkBd70buQNVmiv56OUEVWfRJALYgtZcESvPXdw@mail.gmail.com>
Message-ID: <CAD=FV=VDj8pCmkBd70buQNVmiv56OUEVWfRJALYgtZcESvPXdw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] pwm: fsl-ftm: Don't update the state for the
 caller of pwm_apply_state()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm <linux-pwm@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Tue, Sep 3, 2019 at 2:07 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Tue, Sep 03, 2019 at 01:50:27PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Sep 3, 2019 at 1:15 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Tue, Sep 03, 2019 at 12:35:25PM -0700, Doug Anderson wrote:
> > > > Hi,
> > > >
> > > > On Tue, Sep 3, 2019 at 11:48 AM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > On Tue, Sep 03, 2019 at 09:54:37AM -0700, Doug Anderson wrote:
> > > > > > On Mon, Sep 2, 2019 at 7:27 AM Uwe Kleine-K=C3=B6nig
> > > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > > On Fri, Aug 30, 2019 at 10:39:16AM -0700, Doug Anderson wrote=
:
> > > > > > > > On Sat, Aug 24, 2019 at 8:37 AM Uwe Kleine-K=C3=B6nig <uwe@=
kleine-koenig.org> wrote:
> > > > > > > > >
> > > > > > > > > The pwm-fsl-ftm driver is one of only three PWM drivers w=
hich updates
> > > > > > > > > the state for the caller of pwm_apply_state(). This might=
 have
> > > > > > > > > surprising results if the caller reuses the values expect=
ing them to
> > > > > > > > > still represent the same state.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg>
> > > > > > > > > ---
> > > > > > > > >  drivers/pwm/pwm-fsl-ftm.c | 4 ----
> > > > > > > > >  1 file changed, 4 deletions(-)
> > > > > > > >
> > > > > > > > Presumably this patch could break something since the pwm-f=
sl-ftm
> > > > > > > > driver doesn't appear to implement the get_state() function=
.  ...or
> > > > > > > > did I miss it?
> > > > > > >
> > > > > > > I don't expect breakage. We have more than 50 pwm drivers and=
 only three
> > > > > > > of them made use of adapting the passed state. So unless you =
do
> > > > > > > something special with the PWM (i.e. more than backlight, LED=
 or fan
> > > > > > > control) I don't think a consumer might care. But it might we=
ll be that
> > > > > > > I miss something so feel free to prove me wrong.
> > > > > >
> > > > > > I don't have this hardware so I can't prove you wrong.  ...but
> > > > > > presumably someone added the code to return the state on purpos=
e?
> > > > > >
> > > > > > Maybe you could implement get_state() for this driver in your s=
eries?
> > > > >
> > > > > Sure, I could. But I don't have hardware either and so I'm not in=
 a
> > > > > better position than anybody else on this list.
> > > > >
> > > > > I suggest to apply as is during the merge window, and let affecte=
d
> > > > > user report problems (or patches) if there really is an issue.
> > > > > Guessing what people might suffer from and trying to cure this wi=
th
> > > > > untested patches won't help I think.
> > > >
> > > > I suppose it's not up to me, but I would rather have a patch that
> > > > attempts to keep things working like they did before rather than on=
e
> > > > that is known to change behavior.  Even worse is that your patch
> > > > description doesn't mention this functionality change at all.
> > >
> > > I suggest to add
> > >
> > >         As the driver doesn't provide a .get_state() callback it is
> > >         expected that this changes behaviour slightly as pwm_get_stat=
e()
> > >         will yield the last set instead of the last implemented setti=
ng.
> > >
> > > to the commit log to fix this.
> > >
> > > > I will also note that not everyone does a deep test of all
> > > > functionality during every kernel merge window.  ...so your change =
in
> > > > functionality certain has a pretty high chance of remaining broken =
for
> > > > a while.
> > >
> > > I don't expect any real breakage. The changed behaviour only affects
> > > users of pwm_get_state() that is called after pwm_apply_state().
> > >
> > > > In addition if a PWM is used for something like a PWM
> > > > regulator then subtle changes can cause totally non-obvious breakag=
es,
> > > > maybe adjusting regulators by a very small percentage.
> > >
> > > So for drivers/regulator/pwm-regulator.c this affects the .get_voltag=
e()
> > > call only. Note that .set_voltage() does call pwm_get_state() but
> > > doesn't use the result. I don't see how my change would affect the
> > > configuration written to the PWM registers when the PWM regulator dri=
ver
> > > is its user. So if you want to convince me that the PWM regulator is =
one
> > > of the potentially affected consumers, you have to work a bit harder.
> > > :-)
> >
> > Prior to your patch, pwm_apply_state() would call the ->apply()
> > function, right?  That would modify the state.  Then pwm_apply_state()
> > would store the state (after it had been modified) into pwm->state.
> > All future calls to pwm_get_state() would return the modified state.
> >
> > ...this means that the call to pwm_get_state() in
> > pwm_regulator_get_voltage() would return the actual hardware state.
> >
> > After your patch series pwm_get_state() will not return the actual
> > hardware state for "pwm-fsl-ftm.c", it will return the state that was
> > programmed.
> >
> > While pwm_set_voltage() will not necessarily be affected, future calls
> > to pwm_regulator_get_voltage() could be affected.  Unless you are
> > asserting that 100% of the calls to pwm_get_voltage() cosmetic.
> >
> >
> > Please correct anything I got wrong there.
>
> I think this is all true. The key question here is then: Who calls the
> .get_voltage() callback and cares about the result? Yes, it changes a
> few files in sysfs but apart from that?

There are lots of drivers that call get_voltage() for things other
than sysfs, but without auditing each one I can't say if any of them
would change behavior in a way that would matter.

-Doug
