Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2021432DD
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 21:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgATUXw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jan 2020 15:23:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37547 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgATUXw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 15:23:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so673150wmf.2
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jan 2020 12:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=blx58tyFmiCrtaxtBGJTF+K8emMT7rzaqBzdPdD0IHA=;
        b=kKETGPb9a8DlQftZrFctM/yibr38FOjAxKb26LURw48i8wyW3k6Q8K8d9sGk1f+j8t
         wlgNPZVsUfr2CaT6wRWlGWiGem+f3ufX4vHn7o1J16tZhm6sh6eIj7H+6obAGKSknn+n
         9BPR8R4Mb/7C77ziatEJopduqYCa5j6OYMt/W77xpvNEw3mBxc8sWMVAiXii8MqFipZ/
         i0+SAe8adIQfnXUBrBEBj/UVZ2jEdyMTqcJGRvL8dxwU32qNmgkgzfLnJiFwqaUCcF7e
         crc+ChLm51lq4DconMfR/gcuWrSYMq5ZSWvr4P+4vkG/CfPth7mzyiqp3PDYeJ5nb7Aa
         8ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=blx58tyFmiCrtaxtBGJTF+K8emMT7rzaqBzdPdD0IHA=;
        b=BVST8kUaVhsF0mDLsYK1uTnH3i/oAhxoWsycH6WkDxXB7IZM/DbmemVKjiqboIrbj3
         aoYQGoKm1pi3uNisMNMNoB2RRGzAILMFPZ1pt10EglZ93cV1yObkkH66GexseoFiJlqU
         0kROEv/SLGTKOw0D6NCWDRVaOcAtAUPPLhvnL1kX/87vxHcTdrImNfyHJH9ZS7NsayFy
         xwAT5tAibd9B6HDb53UuEHzCiBW1c0s7iU//Lf7iGqIzrSOPLtgGrAcWJvbSz6d9F/xn
         c7NJyKF1EbfZix07HhXxVNs31b5CrSelRWJk9oWy/8P6NoEPyLRm+ktZMO/szlEWtxAH
         jt7Q==
X-Gm-Message-State: APjAAAVcbze1zboiLzwlPjzQ6E2fw0BLyihepgQhUONsBZ5QtFMh1586
        aqTt8Y4Xnisr4qXJKTUPyoCkCJsW7cJVoHj4HKE=
X-Google-Smtp-Source: APXvYqxI3loe/BCFc+6njX152p+ji4MiB3Z5fjQTYByG6qGID1haSRYFnfFo0Ex65yQvnCmSSQEg6Wc/E9vwvQvv9IQ=
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr578586wma.62.1579551829712;
 Mon, 20 Jan 2020 12:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20200120143206.710666-1-thierry.reding@gmail.com> <20200120200917.gvua5h2egoznwd4h@pengutronix.de>
In-Reply-To: <20200120200917.gvua5h2egoznwd4h@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 20 Jan 2020 21:23:38 +0100
Message-ID: <CAJiuCce6rs7QkxRhAjmoTrN1VBAYpZO5DHnEDzk+ynAea2JT2Q@mail.gmail.com>
Subject: Re: [PATCH] pwm: sun4i: Initialize variables before use
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux PWM List <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe, Thierry

On Mon, 20 Jan 2020 at 21:09, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Thierry,
>
> On Mon, Jan 20, 2020 at 03:32:06PM +0100, Thierry Reding wrote:
> > GCC can't always determine that the duty, period and prescaler values
> > are initialized when returning from sun4i_pwm_calculate(), so help out =
a
> > little by initializing them to 0.
>
> Is it worth mentioning the gcc version you're using?

This issue has been trig by kbuild test robot.
I planned to submit a patch for it as it's due to my modification but
forget to submit it...

Original report
[linux-next:master 6586/9861] drivers/pwm/pwm-sun4i.c:57:34: warning:
'prescaler' may be used uninitialized in this function

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
master
head:   de970dffa7d19eae1d703c3534825308ef8d5dec
commit: 9f28e95b5286fce63a3d0d90dc7ca43eca8dda58 [6586/9861] pwm:
sun4i: Add support to output source clock directly
config: microblaze-randconfig-a001-20200118 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross
-O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 9f28e95b5286fce63a3d0d90dc7ca43eca8dda58
        # save the attached .config to linux build tree
        GCC_VERSION=3D7.5.0 make.cross ARCH=3Dmicroblaze

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

Note: it may well be a FALSE warning. FWIW you are at least aware of it now=
.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

>
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 0decc7cde133..3e3efa6c768f 100644
>
> I don't find this object (0decc7cde133) in my tree or next. Which
> version is this?
>
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -234,9 +234,9 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> >  {
> >       struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);
> >       struct pwm_state cstate;
> > -     u32 ctrl, duty, period, val;
> > +     u32 ctrl, duty =3D 0, period =3D 0, val;
>
> +     u32 ctrl, uninitialized_var(duty), uninitialized_var(period), val;
>
> should fix the warnings, too, and additionally explicitly documents that
> it's just the compiler that doesn't see there is no problem.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
