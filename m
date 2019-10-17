Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B892DAC74
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 14:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfJQMlB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 08:41:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34058 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfJQMlA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 08:41:00 -0400
Received: by mail-io1-f67.google.com with SMTP id q1so2815837ion.1;
        Thu, 17 Oct 2019 05:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=abxGIv0wZaO7m6Qh5FMNqXHQVKtoBH/088XCvw7BAp8=;
        b=lUdvVWlGBKFjzWFAqABNh/v0XvTmqFXOK0jBZGRUdcAzZeFF6vX0GGnRi70QIBsFur
         KozYFGgEzO+vGkD+EOzB3f2srFJ0w+KcfR1ZvxuqcnLYcpnfVa0vUcjM4HXdDvccVFrd
         NIyZrCT6gB7074/+KslJ9jzAJm2muR+zKobF/t/FS8V65zMgXQfXAba4ULyPf64443Mv
         TpojpnZahziD15HfRm6S/88tHHzwT382faqkW6HEaY1I5l9FL8d1OvhWB/0JmU/hMtcd
         AsD1r1HN1eAd83KG6UHwquwwSvWPAiiSKyBACWP5BYFqbiun48JjtkMda2XFp27zzNGV
         YlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=abxGIv0wZaO7m6Qh5FMNqXHQVKtoBH/088XCvw7BAp8=;
        b=YQRLZD8MxaiaSridftIHCRaCwunHSriIVd1sO+Mij+4QxwV/e+xh85c9OA5Dm4OzZP
         ElfI7TOYVZVSigBmdh7bteJvOlBhDNkoxftyA0h9Tmp2DEJtHxH74OBqzsSsg4lXgRkl
         eePhRB3M9/wyEFszXOCtWiFIm5kdsI6xpJCVavdjERJ7YH3qGIKg6X9DSVkkJ7jbW+r5
         HD89nSFAzaFD98znYduacn1pbbW+k57fXVH7y/oYXUqCLjKFlrMrA9azpcXx2/PlJbhp
         lhO3+uminc+3+ryQsnofB8QsY8iN6OUvzytyIPG6TpTAdQiDcxc6vq4M4NAOWMJ/2gOD
         GlWA==
X-Gm-Message-State: APjAAAWqq/5kP0gLxGx/wHxnMmOjP9i5y9YdKWAtPmOTXpPPse6s+8vA
        Jxlh0JHKi2Vc4vSyAlro4NQZQMSgXKQngzOtkB0=
X-Google-Smtp-Source: APXvYqwreiYtJbMerdyArqVDMTi1F2M9/b+Gagz4LCqyolhflr4yM8kZe6WOTJBzuf94hKK+D4FFaA/g0w8egKibxIA=
X-Received: by 2002:a5d:83c1:: with SMTP id u1mr2840326ior.78.1571316058583;
 Thu, 17 Oct 2019 05:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <20191017114727.fy5tg2kgi6mr2sei@holly.lan> <20191017121945.cmcvaffmbd7zydrm@pengutronix.de>
 <CAHCN7xKogdqoLmbbTatPdtLzqz+MKh-jgrHkkCh+YA-bwwOkDA@mail.gmail.com>
In-Reply-To: <CAHCN7xKogdqoLmbbTatPdtLzqz+MKh-jgrHkkCh+YA-bwwOkDA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 17 Oct 2019 07:40:47 -0500
Message-ID: <CAHCN7xJFDrsqzR2H2mNYhKB8iF7xYWb9kM+HdzukjDix461gsg@mail.gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 17, 2019 at 7:34 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Thu, Oct 17, 2019 at 7:19 AM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Thu, Oct 17, 2019 at 12:47:27PM +0100, Daniel Thompson wrote:
> > > On Thu, Oct 17, 2019 at 10:10:59AM +0200, Uwe Kleine-K=C3=B6nig wrote=
:
> > > > A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> > > > pwm_get_state() return the last implemented state")) changed the
> > > > semantic of pwm_get_state() and disclosed an (as it seems) common
> > > > problem in lowlevel PWM drivers. By not relying on the period and d=
uty
> > > > cycle being retrievable from a disabled PWM this type of problem is
> > > > worked around.
> > > >
> > > > Apart from this issue only calling the pwm_get_state/pwm_apply_stat=
e
> > > > combo once is also more effective.
> > >
> > > I'm only interested in the second paragraph here.
> > >
> > > There seems to be a reasonable consensus that the i.MX27 and cros-ec
> > > PWM drivers should be fixed for the benefit of other PWM clients.
> > > So we make this change because it makes the pwm-bl better... not to
> > > work around bugs ;-).
> >
> > That's fine, still I think it's fair to explain the motivation of
> > creating this patch.
> >
> > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backl=
ight/pwm_bl.c
> > > > index 746eebc411df..ddebd62b3978 100644
> > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > @@ -67,40 +62,27 @@ static void pwm_backlight_power_on(struct pwm_b=
l_data *pb)
> > > >
> > > >  static void pwm_backlight_power_off(struct pwm_bl_data *pb)
> > > >  {
> > > > -   struct pwm_state state;
> > > > -
> > > > -   pwm_get_state(pb->pwm, &state);
> > > > -   if (!pb->enabled)
> > > > -           return;
> > > > -
> > >
> > > Why remove the pb->enabled check? I thought that was there to ensure =
we
> > > don't mess up the regular reference counts.
> >
> > I havn't looked yet, but I guess I have to respin. Expect a v2 later
> > today.
>
> I would agree that a high-level fix is better than a series of low
> level driver fixes.  For what its worth, your V1 patch worked fine on
> my i.MX6Q.  I can test the V2 patch when its ready.

I may have spoken too soon.  The patch fixes the display in that it
comes on when it previously did not, but changes to brightness do not
appear to do anything anymore.  I don't have an oscilloscope where I
am now, so I cannot verify whether or not the PWM duty cycle changes.

To my eye, the following do not appear to change the brightness of the scre=
en:
     echo 7 > /sys/devices/soc0/backlight-lvds/backlight/backlight-lvds/bri=
ghtness
     echo 2 > /sys/devices/soc0/backlight-lvds/backlight/backlight-lvds/bri=
ghtness
     echo 5 > /sys/devices/soc0/backlight-lvds/backlight/backlight-lvds/bri=
ghtness


adam
>
> adam
> >
> > Best regards
> > Uwe
> >
> > --
> > Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
> > Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
