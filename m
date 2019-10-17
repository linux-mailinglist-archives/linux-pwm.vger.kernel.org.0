Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B962DADEB
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 15:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394278AbfJQNJv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 09:09:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38086 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfJQNJu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 09:09:50 -0400
Received: by mail-io1-f67.google.com with SMTP id u8so2897137iom.5;
        Thu, 17 Oct 2019 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O2sCm4ci20pr97mr1Ng7lBlOLxIqCQWlGEv5VaAWrpY=;
        b=B0thk5RVDI1Q+DC+eDk29v9uNkCKojLy2NkVnH8swRWAYpZLzVE/JZTv5vqa+OtrUC
         XpX9MXfK0cFVmdrb5iczyt0YLFMU2CUmnmF4ywZrs5dhNirBabE8aVCyWkHqXthW93ob
         CicLaMm9leBEX/+G5jRMMrBtJOaV0ZE8+KHIQBpQyCIbOiZZBBftITS3Rqlhzt+e7THf
         F3nZlVXulQfyB99Z8GrV0jHrDHWe3Tt9M9o5g3aRyrRovJYA3pcoRiYQNssgNYRVJj8N
         tJdFzjKRi4qqVFQW3hF8H0BI59zAGuaS9o1VXgkF/u6zaKZqISvx5p+MCks0H40NXChE
         XU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O2sCm4ci20pr97mr1Ng7lBlOLxIqCQWlGEv5VaAWrpY=;
        b=kZwLAU6wcH0rKpyEcR7d+0mbXBjEqfnnz9wPqIRiwc19bF3Ss6AAlyUeUIGgH7TDC6
         GUazRM3qHfuNXF5v3Q9SM0OByNZOV3EvMNLpacdyB27LQBBHxLJwM91RrdZeYzeuxZhr
         u+kgv5ROzN8ceWMELD0ve6nw94CjhBxEUQscYwcijeHqlXPGA3pQmuJELtHv3rXW8+xX
         JEE5zX3MbwI6RE+sP6+TBaLOa8lL8g9CQmldBlwSuO5KzMFltRSgfMmZ1auQ7J7jJq86
         MCgRZDRDiufHamBDPNlon9jIq6G2+DZic0VOF6yheB4otmv5+j4EP0fOijoXyHrecjX3
         Z6XQ==
X-Gm-Message-State: APjAAAURiGsns3NJzBF3tyJ68h1lrT5bVFvmPEGyjyBduheglsxKdKIV
        PSA0sFX0Pu7riB4Xwpk2SQEHU6fmH7GtG1B9i9w=
X-Google-Smtp-Source: APXvYqw6EkAfFeEOZcW1bX3msw64f5/fs9DOq64tYcN0/EmcF2KEfLpPbHDlUF+sYBRfIbSGBN6JO5z7AiG9qZPNLY0=
X-Received: by 2002:a02:7741:: with SMTP id g62mr3188118jac.3.1571317787672;
 Thu, 17 Oct 2019 06:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <20191017114727.fy5tg2kgi6mr2sei@holly.lan> <20191017121945.cmcvaffmbd7zydrm@pengutronix.de>
 <CAHCN7xKogdqoLmbbTatPdtLzqz+MKh-jgrHkkCh+YA-bwwOkDA@mail.gmail.com>
 <CAHCN7xJFDrsqzR2H2mNYhKB8iF7xYWb9kM+HdzukjDix461gsg@mail.gmail.com> <20191017130519.GC3768303@ulmo>
In-Reply-To: <20191017130519.GC3768303@ulmo>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 17 Oct 2019 08:09:36 -0500
Message-ID: <CAHCN7xJz9vOQneMSZQ6GSqLCROWOHNgdx6NF=Ut5J2S+_aLKzw@mail.gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pwm@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 17, 2019 at 8:05 AM Thierry Reding <thierry.reding@gmail.com> w=
rote:
>
> On Thu, Oct 17, 2019 at 07:40:47AM -0500, Adam Ford wrote:
> > On Thu, Oct 17, 2019 at 7:34 AM Adam Ford <aford173@gmail.com> wrote:
> > >
> > > On Thu, Oct 17, 2019 at 7:19 AM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > On Thu, Oct 17, 2019 at 12:47:27PM +0100, Daniel Thompson wrote:
> > > > > On Thu, Oct 17, 2019 at 10:10:59AM +0200, Uwe Kleine-K=C3=B6nig w=
rote:
> > > > > > A previous change in the pwm core (namely 01ccf903edd6 ("pwm: L=
et
> > > > > > pwm_get_state() return the last implemented state")) changed th=
e
> > > > > > semantic of pwm_get_state() and disclosed an (as it seems) comm=
on
> > > > > > problem in lowlevel PWM drivers. By not relying on the period a=
nd duty
> > > > > > cycle being retrievable from a disabled PWM this type of proble=
m is
> > > > > > worked around.
> > > > > >
> > > > > > Apart from this issue only calling the pwm_get_state/pwm_apply_=
state
> > > > > > combo once is also more effective.
> > > > >
> > > > > I'm only interested in the second paragraph here.
> > > > >
> > > > > There seems to be a reasonable consensus that the i.MX27 and cros=
-ec
> > > > > PWM drivers should be fixed for the benefit of other PWM clients.
> > > > > So we make this change because it makes the pwm-bl better... not =
to
> > > > > work around bugs ;-).
> > > >
> > > > That's fine, still I think it's fair to explain the motivation of
> > > > creating this patch.
> > > >
> > > > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/b=
acklight/pwm_bl.c
> > > > > > index 746eebc411df..ddebd62b3978 100644
> > > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > > > @@ -67,40 +62,27 @@ static void pwm_backlight_power_on(struct p=
wm_bl_data *pb)
> > > > > >
> > > > > >  static void pwm_backlight_power_off(struct pwm_bl_data *pb)
> > > > > >  {
> > > > > > -   struct pwm_state state;
> > > > > > -
> > > > > > -   pwm_get_state(pb->pwm, &state);
> > > > > > -   if (!pb->enabled)
> > > > > > -           return;
> > > > > > -
> > > > >
> > > > > Why remove the pb->enabled check? I thought that was there to ens=
ure we
> > > > > don't mess up the regular reference counts.
> > > >
> > > > I havn't looked yet, but I guess I have to respin. Expect a v2 late=
r
> > > > today.
> > >
> > > I would agree that a high-level fix is better than a series of low
> > > level driver fixes.  For what its worth, your V1 patch worked fine on
> > > my i.MX6Q.  I can test the V2 patch when its ready.
> >
> > I may have spoken too soon.  The patch fixes the display in that it
> > comes on when it previously did not, but changes to brightness do not
> > appear to do anything anymore.  I don't have an oscilloscope where I
> > am now, so I cannot verify whether or not the PWM duty cycle changes.
> >
> > To my eye, the following do not appear to change the brightness of the =
screen:
> >      echo 7 > /sys/devices/soc0/backlight-lvds/backlight/backlight-lvds=
/brightness
> >      echo 2 > /sys/devices/soc0/backlight-lvds/backlight/backlight-lvds=
/brightness
> >      echo 5 > /sys/devices/soc0/backlight-lvds/backlight/backlight-lvds=
/brightness
>
> Hi Adam,
>
> can you try the i.MX PWM patch that I posted earlier instead? I really
> think we need to fix this in the PWM drivers because they are broken.
> pwm-backlight is not. -rc3 is really not a time to work around breakage
> in consumers.

I did try your patch, but it did not appear to make any difference on my i.=
MX6Q.

>
> If my patch doesn't help, can you try reverting the offending patch? If
> we can't come up with a good fix for the drivers, reverting is the next
> best option.

I am able to get an image after reverting the offending patch.  I did
not try playing with brightness levels after reverting.


>
> Thierry
