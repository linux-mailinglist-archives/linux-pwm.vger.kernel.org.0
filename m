Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B9FA73C3
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2019 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfICTfk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Sep 2019 15:35:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39054 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICTfk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Sep 2019 15:35:40 -0400
Received: by mail-io1-f66.google.com with SMTP id d25so36119475iob.6
        for <linux-pwm@vger.kernel.org>; Tue, 03 Sep 2019 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WgUyaMdNtgO/S0kgGEK24DoI5vv3i2iBQJ3s94A4xGU=;
        b=OVUIRexcBatEyF7nWSqNoNLjIxQTj4i1rhz80NJl30JLv90OoId6sauAoAFTg/5R4b
         6lz6S58hy73Tj8J1Ib3Cl97hNZoiD1QWeMUkyJOJmqivAv4XFaVwbMcIvVdDf9bKwpdN
         dyQbqtX7S4HqQgc6+50+dDSLMc4aRrjIPDgDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WgUyaMdNtgO/S0kgGEK24DoI5vv3i2iBQJ3s94A4xGU=;
        b=HfE2JeGN2Ol2UhNZihp5raldaxGLryBM8NfbuBFmhPnw9XAfnUOW3oNOsDVq2VhFOp
         PnYnnSEFO0/JNB4WU/oSSlIbD/9cdMOveYKo6eKXRFSbBxGevvYd5qb4T10k9aPICG9h
         TXnMNAfM4nANVwd3r7Iv60mO/ddpsj6JF9Qa4Sgdup4k4rUOKOlZ6hFOtgLOqqpKCgwy
         2oMvJyWxMozxw3zod4hO1N2m6vht16No4JOsMOVAOwhZsUUc0i/W66M7DgllwrCDtbUc
         +sSrfTCs/nnuvxVe43S68viL6q2RSsq4UXe6adwotmyPoolWyUGg5TNWEyrkZqVKUI8D
         tODQ==
X-Gm-Message-State: APjAAAXTRqAjMA70z4wOZLUKfT6PVDpZ3fTQ/kK3ggWKG8UfREy9yhQ2
        /VI4wkEBH8L+YgIp/1f6uzGzaKDob5w=
X-Google-Smtp-Source: APXvYqwkao2Lm27PZ+5PstsTy4INfxvq6X/hoLKPW3g0v8ghw50Nm/UkAX3dCm8Qo/4HpeFzkanrRQ==
X-Received: by 2002:a5d:8353:: with SMTP id q19mr4692965ior.59.1567539339053;
        Tue, 03 Sep 2019 12:35:39 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id r138sm27753259iod.59.2019.09.03.12.35.38
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 12:35:38 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id d25so36119309iob.6
        for <linux-pwm@vger.kernel.org>; Tue, 03 Sep 2019 12:35:38 -0700 (PDT)
X-Received: by 2002:a05:6638:681:: with SMTP id i1mr1213550jab.127.1567539338060;
 Tue, 03 Sep 2019 12:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190824153707.13746-1-uwe@kleine-koenig.org> <20190824153707.13746-6-uwe@kleine-koenig.org>
 <CAD=FV=X8kVU_zr69aKe-+GkAQh-tDwVf8tFogKve3s5O5ndF-g@mail.gmail.com>
 <20190902142709.wxrjsfzorozgeiuh@pengutronix.de> <CAD=FV=XFTuixKL-VBv-QObiO=Jg43i6W0enprLgXQ0U8=9C49A@mail.gmail.com>
 <20190903184800.2fmmvwyzbwbsaf6y@pengutronix.de>
In-Reply-To: <20190903184800.2fmmvwyzbwbsaf6y@pengutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 Sep 2019 12:35:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XOyayzv6N9Ky8m2ffXe4UzUijzrL8JCMZC3K+MEzaRFw@mail.gmail.com>
Message-ID: <CAD=FV=XOyayzv6N9Ky8m2ffXe4UzUijzrL8JCMZC3K+MEzaRFw@mail.gmail.com>
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

On Tue, Sep 3, 2019 at 11:48 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Tue, Sep 03, 2019 at 09:54:37AM -0700, Doug Anderson wrote:
> > On Mon, Sep 2, 2019 at 7:27 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Fri, Aug 30, 2019 at 10:39:16AM -0700, Doug Anderson wrote:
> > > > On Sat, Aug 24, 2019 at 8:37 AM Uwe Kleine-K=C3=B6nig <uwe@kleine-k=
oenig.org> wrote:
> > > > >
> > > > > The pwm-fsl-ftm driver is one of only three PWM drivers which upd=
ates
> > > > > the state for the caller of pwm_apply_state(). This might have
> > > > > surprising results if the caller reuses the values expecting them=
 to
> > > > > still represent the same state.
> > > > >
> > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> > > > > ---
> > > > >  drivers/pwm/pwm-fsl-ftm.c | 4 ----
> > > > >  1 file changed, 4 deletions(-)
> > > >
> > > > Presumably this patch could break something since the pwm-fsl-ftm
> > > > driver doesn't appear to implement the get_state() function.  ...or
> > > > did I miss it?
> > >
> > > I don't expect breakage. We have more than 50 pwm drivers and only th=
ree
> > > of them made use of adapting the passed state. So unless you do
> > > something special with the PWM (i.e. more than backlight, LED or fan
> > > control) I don't think a consumer might care. But it might well be th=
at
> > > I miss something so feel free to prove me wrong.
> >
> > I don't have this hardware so I can't prove you wrong.  ...but
> > presumably someone added the code to return the state on purpose?
> >
> > Maybe you could implement get_state() for this driver in your series?
>
> Sure, I could. But I don't have hardware either and so I'm not in a
> better position than anybody else on this list.
>
> I suggest to apply as is during the merge window, and let affected
> user report problems (or patches) if there really is an issue.
> Guessing what people might suffer from and trying to cure this with
> untested patches won't help I think.

I suppose it's not up to me, but I would rather have a patch that
attempts to keep things working like they did before rather than one
that is known to change behavior.  Even worse is that your patch
description doesn't mention this functionality change at all.

I will also note that not everyone does a deep test of all
functionality during every kernel merge window.  ...so your change in
functionality certain has a pretty high chance of remaining broken for
a while.  In addition if a PWM is used for something like a PWM
regulator then subtle changes can cause totally non-obvious breakages,
maybe adjusting regulators by a very small percentage.  If you
implement the getter it seems (to me) more likely you'll either get it
right or it will totally break things.  That's actually a much better
failure mode...


-Doug
