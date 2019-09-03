Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E59CA759A
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2019 22:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfICUum (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Sep 2019 16:50:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33944 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfICUum (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Sep 2019 16:50:42 -0400
Received: by mail-io1-f65.google.com with SMTP id s21so39274774ioa.1
        for <linux-pwm@vger.kernel.org>; Tue, 03 Sep 2019 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KmvXXydCgmlQBF0/mkeWmyFX4fyvPR9o8i2o8yVoygE=;
        b=GE47mFRfsIAOoo4eqMrZfzfpRXZdBCAQ2nc89rNtJgFoBxHHpA5/HTkKd/56pGu3np
         KtnUOweAWvGBjrEX+FoIh+1/ItXOXFcsxnMxyw0qSu8///UVithsiEyBT0vnk14tuTSs
         hjpoDT8VOB4Js9mQlfqV+fKqAgkQymwT98vUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KmvXXydCgmlQBF0/mkeWmyFX4fyvPR9o8i2o8yVoygE=;
        b=uH7lg0I0wUHOK39X1d+4VTw8waf7qFGCFtikGmTFUI7ClOfYDGAPt0iGjz0OXKZnOw
         vF7AfprCe4niOsDUh5g+yu5T4c+84c8U3O0G+NEQvBXyNTPiUARSojdkgAo4z7GOdUlP
         are3xKm8q35Vm3xiuoCoxENwqgx1P/3z5say1Wu/RzI5lUb9BFoI7pED2BWNMG3kJ9Sy
         MZnXZQzy+eNOqyvk6rGTO4+96XTKZrlVuTe0/1NN+guikzNU1/mPLsw2M/j5YObXeoQj
         B8BlD9dyISY/wbA+PJtdLQ6Q+J5rwjjqtkUBGeNRKDdZK1eIsSFisP1HtWIM+AK6DS2/
         1B9g==
X-Gm-Message-State: APjAAAUv18AONGY7iV2EqS3+j/JAKuW8pKxUcD/GZ2zbw8vcwRwgk+nU
        8x6AGjLaFyJ8wZ9m8iMdt9Ftmyz72Q0=
X-Google-Smtp-Source: APXvYqwQZi1jfgZqkJgY2uPbBUkwqYBk0/KR9ovrjonov35OPg5FzVDcLfWeGi5eh2ee0pHIiVBzVg==
X-Received: by 2002:a05:6638:155:: with SMTP id y21mr34861749jao.112.1567543840991;
        Tue, 03 Sep 2019 13:50:40 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id c10sm2391669iot.14.2019.09.03.13.50.39
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 13:50:40 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id d25so36661810iob.6
        for <linux-pwm@vger.kernel.org>; Tue, 03 Sep 2019 13:50:39 -0700 (PDT)
X-Received: by 2002:a6b:b213:: with SMTP id b19mr59199iof.58.1567543839375;
 Tue, 03 Sep 2019 13:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190824153707.13746-1-uwe@kleine-koenig.org> <20190824153707.13746-6-uwe@kleine-koenig.org>
 <CAD=FV=X8kVU_zr69aKe-+GkAQh-tDwVf8tFogKve3s5O5ndF-g@mail.gmail.com>
 <20190902142709.wxrjsfzorozgeiuh@pengutronix.de> <CAD=FV=XFTuixKL-VBv-QObiO=Jg43i6W0enprLgXQ0U8=9C49A@mail.gmail.com>
 <20190903184800.2fmmvwyzbwbsaf6y@pengutronix.de> <CAD=FV=XOyayzv6N9Ky8m2ffXe4UzUijzrL8JCMZC3K+MEzaRFw@mail.gmail.com>
 <20190903201550.gxcyed5svtq33ev2@pengutronix.de>
In-Reply-To: <20190903201550.gxcyed5svtq33ev2@pengutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 Sep 2019 13:50:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WjRiaNLJQJ25OeNSpY455H-ev8g3iZN24UXQtk3uXhtA@mail.gmail.com>
Message-ID: <CAD=FV=WjRiaNLJQJ25OeNSpY455H-ev8g3iZN24UXQtk3uXhtA@mail.gmail.com>
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

On Tue, Sep 3, 2019 at 1:15 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Tue, Sep 03, 2019 at 12:35:25PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Sep 3, 2019 at 11:48 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > Hello,
> > >
> > > On Tue, Sep 03, 2019 at 09:54:37AM -0700, Doug Anderson wrote:
> > > > On Mon, Sep 2, 2019 at 7:27 AM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > On Fri, Aug 30, 2019 at 10:39:16AM -0700, Doug Anderson wrote:
> > > > > > On Sat, Aug 24, 2019 at 8:37 AM Uwe Kleine-K=C3=B6nig <uwe@klei=
ne-koenig.org> wrote:
> > > > > > >
> > > > > > > The pwm-fsl-ftm driver is one of only three PWM drivers which=
 updates
> > > > > > > the state for the caller of pwm_apply_state(). This might hav=
e
> > > > > > > surprising results if the caller reuses the values expecting =
them to
> > > > > > > still represent the same state.
> > > > > > >
> > > > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> > > > > > > ---
> > > > > > >  drivers/pwm/pwm-fsl-ftm.c | 4 ----
> > > > > > >  1 file changed, 4 deletions(-)
> > > > > >
> > > > > > Presumably this patch could break something since the pwm-fsl-f=
tm
> > > > > > driver doesn't appear to implement the get_state() function.  .=
..or
> > > > > > did I miss it?
> > > > >
> > > > > I don't expect breakage. We have more than 50 pwm drivers and onl=
y three
> > > > > of them made use of adapting the passed state. So unless you do
> > > > > something special with the PWM (i.e. more than backlight, LED or =
fan
> > > > > control) I don't think a consumer might care. But it might well b=
e that
> > > > > I miss something so feel free to prove me wrong.
> > > >
> > > > I don't have this hardware so I can't prove you wrong.  ...but
> > > > presumably someone added the code to return the state on purpose?
> > > >
> > > > Maybe you could implement get_state() for this driver in your serie=
s?
> > >
> > > Sure, I could. But I don't have hardware either and so I'm not in a
> > > better position than anybody else on this list.
> > >
> > > I suggest to apply as is during the merge window, and let affected
> > > user report problems (or patches) if there really is an issue.
> > > Guessing what people might suffer from and trying to cure this with
> > > untested patches won't help I think.
> >
> > I suppose it's not up to me, but I would rather have a patch that
> > attempts to keep things working like they did before rather than one
> > that is known to change behavior.  Even worse is that your patch
> > description doesn't mention this functionality change at all.
>
> I suggest to add
>
>         As the driver doesn't provide a .get_state() callback it is
>         expected that this changes behaviour slightly as pwm_get_state()
>         will yield the last set instead of the last implemented setting.
>
> to the commit log to fix this.
>
> > I will also note that not everyone does a deep test of all
> > functionality during every kernel merge window.  ...so your change in
> > functionality certain has a pretty high chance of remaining broken for
> > a while.
>
> I don't expect any real breakage. The changed behaviour only affects
> users of pwm_get_state() that is called after pwm_apply_state().
>
> > In addition if a PWM is used for something like a PWM
> > regulator then subtle changes can cause totally non-obvious breakages,
> > maybe adjusting regulators by a very small percentage.
>
> So for drivers/regulator/pwm-regulator.c this affects the .get_voltage()
> call only. Note that .set_voltage() does call pwm_get_state() but
> doesn't use the result. I don't see how my change would affect the
> configuration written to the PWM registers when the PWM regulator driver
> is its user. So if you want to convince me that the PWM regulator is one
> of the potentially affected consumers, you have to work a bit harder.
> :-)

Prior to your patch, pwm_apply_state() would call the ->apply()
function, right?  That would modify the state.  Then pwm_apply_state()
would store the state (after it had been modified) into pwm->state.
All future calls to pwm_get_state() would return the modified state.

...this means that the call to pwm_get_state() in
pwm_regulator_get_voltage() would return the actual hardware state.

After your patch series pwm_get_state() will not return the actual
hardware state for "pwm-fsl-ftm.c", it will return the state that was
programmed.

While pwm_set_voltage() will not necessarily be affected, future calls
to pwm_regulator_get_voltage() could be affected.  Unless you are
asserting that 100% of the calls to pwm_get_voltage() cosmetic.


Please correct anything I got wrong there.

-Doug
