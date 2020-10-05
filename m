Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F23283538
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Oct 2020 13:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgJEL6Y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Oct 2020 07:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJEL6Y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2020 07:58:24 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B044C0613CE;
        Mon,  5 Oct 2020 04:58:23 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dt13so2103301ejb.12;
        Mon, 05 Oct 2020 04:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H1cExRq0GT28OvS2Gv/BLO76werh/85yfLc6nnX6aOo=;
        b=LV0hYVCts/8oX8Akq8XVnIZVxjP2dbTB/1BpJ/higkpxNriCqBVdBE+u5VAhBrqMBy
         g0obWw4RdIlQ5To9Q0hVAuVkZJLW2luyKnIejVeqlquB14GJWFM0JWE9Iqy++Q+lZmAI
         w8MMe1TjOQxxTUthE6fztum2YS7LhiODKV/hqyP0UYLmUTCB3tRwiXxAT+tBVFcD8OJ4
         Z3NokWDwZpX1tKzdQs0J4ZExUzd8zhwTmSiOWPNR6GQmgdBsk6lTPnaWmXdbXqvyqEvN
         6sZv4fqxM3nonVzrtwy8fa9zDZC1i69XaYtAbN6ABtz93+OH2gXT30EfsUJ43sO5b78H
         r5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H1cExRq0GT28OvS2Gv/BLO76werh/85yfLc6nnX6aOo=;
        b=PC/ZdnqPMLT4HAximADF+1AAPrOauNDV8+oM7mKbnLhV7teQremG7H/8dLAYyQ0+9L
         j6asJLPoj3fc/oZc5RA2+FjxR2A87Qq/fGwLn2snCrP1qvqhUoJ1tfJElz9pQdb+NDBp
         D2HKxhoEtLnWWUaGr+XVM5RZpwxhqbqHAwpTbIW3k+TzwNi8dW2D1DMjn8rTNghDieYH
         6ECDd/ELiMGUnZ3iPtwXp+UK5ooXu7RCg+W58/ALDAVNXvs9jPPt62tCPTE8Tq/k/rGx
         R+OKroTJZ3bQHEe0xKTKdc2HCDmObNTs3vC+TkOTuKfwytpQBd+TK7F8jmMdaRohvBDl
         npgg==
X-Gm-Message-State: AOAM532LEfmTSPmm8nWo2FYdjbh2cK4azf2Ze8qzsL8r7DUhoeQw/3vg
        zBJZHzca0Zypg5zADMc4YlI=
X-Google-Smtp-Source: ABdhPJw3RZ870Qw4qNVYNiK+d9Z8PaiuQ99UpHGC2IPAa3uoIQOI5ETzR6FQT228mmFz4LBLXpxG0g==
X-Received: by 2002:a17:907:7292:: with SMTP id dt18mr2316602ejc.265.1601899102218;
        Mon, 05 Oct 2020 04:58:22 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id y3sm1495052ejk.92.2020.10.05.04.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 04:58:20 -0700 (PDT)
Date:   Mon, 5 Oct 2020 13:58:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20201005115819.GU425362@ulmo>
References: <20200930092056.maz5biy2ugr6yc3p@lem-wkst-02.lemonage>
 <20200930094146.73s3qzvf5ekjeavc@pengutronix.de>
 <20201001090531.gubfwmznlto2ng6l@lem-wkst-02.lemonage>
 <20201001112449.GA2364834@kroah.com>
 <20201005093016.GD425362@ulmo>
 <20201005094530.GA154185@kroah.com>
 <20201005101721.GL425362@ulmo>
 <20201005104023.GB245520@kroah.com>
 <20201005110819.GP425362@ulmo>
 <20201005111738.GA367715@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Sosn/fv6aiTyEgxl"
Content-Disposition: inline
In-Reply-To: <20201005111738.GA367715@kroah.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Sosn/fv6aiTyEgxl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 01:17:38PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 05, 2020 at 01:08:19PM +0200, Thierry Reding wrote:
> > On Mon, Oct 05, 2020 at 12:40:23PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Oct 05, 2020 at 12:17:21PM +0200, Thierry Reding wrote:
> > > > On Mon, Oct 05, 2020 at 11:45:30AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Mon, Oct 05, 2020 at 11:30:16AM +0200, Thierry Reding wrote:
> > > > > > On Thu, Oct 01, 2020 at 01:24:49PM +0200, Greg Kroah-Hartman wr=
ote:
> > > > > > > On Thu, Oct 01, 2020 at 11:05:31AM +0200, Lars Poeschel wrote:
> > > > > > > > On Wed, Sep 30, 2020 at 11:41:46AM +0200, Uwe Kleine-K=C3=
=B6nig wrote:
> > > > > > > > > Hello,
> > > > > > > > >=20
> > > > > > > > > I added Greg Kroah-Hartman who I discussed this with via =
irc a bit to
> > > > > > > > > Cc:.
> > > > > > > > >=20
> > > > > > > > > On Wed, Sep 30, 2020 at 11:20:56AM +0200, Lars Poeschel w=
rote:
> > > > > > > > > > thank you for your review!
> > > > > > > > > >=20
> > > > > > > > > > On Wed, Sep 30, 2020 at 08:57:26AM +0200, Uwe Kleine-K=
=C3=B6nig wrote:
> > > > > > > > > > > On Tue, Sep 29, 2020 at 02:19:53PM +0200, poeschel@le=
monage.de wrote:
> > > > > > > > > > > > From: Lars Poeschel <poeschel@lemonage.de>
> > > > > > > > > > > >=20
> > > > > > > > > > > > This adds a class to exported pwm devices.
> > > > > > > > > > > > Exporting a pwm through sysfs did not yield udev ev=
ents. The
> > > > > > > > > > >=20
> > > > > > > > > > > I wonder what is your use-case here. This for sure al=
so has a place to
> > > > > > > > > > > be mentioned in the commit log. I suspect there is a =
better way to
> > > > > > > > > > > accomplish you way.
> > > > > > > > > >=20
> > > > > > > > > > Use-case is to be able to use a pwm from a non-root use=
rspace process.
> > > > > > > > > > I use udev rules to adjust permissions.
> > > > > > > > >=20
> > > > > > > > > Hmm, how do you trigger the export? Without being aware o=
f all the
> > > > > > > > > details in the sysfs code I would expect that the exporte=
d stuff is
> > > > > > > > > available instantly once the write used to export the PWM=
 is completed.
> > > > > > > > > So changing the permissions can be done directly after tr=
iggering the
> > > > > > > > > export in the same process.
> > > > > > > >=20
> > > > > > > > The export is triggered through the userspace process itsel=
f. Why can it
> > > > > > > > do this ? Because there is another udev rule, that changes =
permissions
> > > > > > > > when a pwmchip appears.
> > > > > > > > Then I'd like to have the second udev rule, that changes pe=
rmissions on
> > > > > > > > the freshly exported pwm. The userspace process can't do th=
is.
> > > > > > > > You are right I could propably do everything from within ud=
ev: If a
> > > > > > > > pwmchip appears, export certain pwms and right away change =
their
> > > > > > > > permissions. It does not also not feel right. It'd require =
knowledge
> > > > > > > > from the userspace application to be mapped to udev.
> > > > > > >=20
> > > > > > > The way the kernel code is now, yes, you will not have any wa=
y to
> > > > > > > trigger it by userspace as the kernel is creating a "raw" str=
uct device
> > > > > > > that isn't assigned to anything.  That is what needs to be fi=
xed here.
> > > > > > >=20
> > > > > > > > > Out of interest: What do you use the pwm for? Isn't there=
 a suitable
> > > > > > > > > kernel driver that can do the required stuff? Compared to=
 the kernel-API
> > > > > > > > > the sysfs interface isn't atomic. Is this an annoyance?
> > > > > > > >=20
> > > > > > > > Use-case is generating a voltage from the pwm. This voltage=
 is used to
> > > > > > > > signal different states and does not change very often. Thi=
s is
> > > > > > > > absolutely not annoying that this is not atomic. We just ch=
ange the duty
> > > > > > > > cycle on the fly. Everything else is configured one time at=
 startup.
> > > > > > > > I'd call what I need pwm-dac. I could not find a ready to u=
se driver.
> > > > > > > > Maybe I could misuse some kernel driver for this. Maybe I c=
ould use
> > > > > > > > pwm-led or pwm-brightness or pwm-fan. Propably pwm-regulato=
r could work,
> > > > > > > > there is even a userspace facing part for this, but this is=
 not
> > > > > > > > devicetree ready.
> > > > > > > > ...and the worst, please don't blame me: The application is=
 java, so
> > > > > > > > ioctl is a problem.
> > > > > > >=20
> > > > > > > I thought java could do ioctls, otherwise how would it ever b=
e able to
> > > > > > > talk to serial ports?
> > > > > > >=20
> > > > > > > Anyway, this needs to be fixed in the kernel...
> > > > > >=20
> > > > > > If atomicity was a problem, we could potentially add a mechanis=
m to the
> > > > > > sysfs interface to enable that. I don't see a good way of doing=
 that in
> > > > > > a single file, since that works against how sysfs is designed. =
But one
> > > > > > thing I could imagine is adding a file ("lock", or whatever you=
 want to
> > > > > > call it) that you can use for atomic fencing:
> > > > > >=20
> > > > > > 	$ echo 1 > lock # locks the hardware state
> > > > > > 	$ echo 100 > period
> > > > > > 	$ echo 50 > duty_cycle
> > > > > > 	$ echo 0 > lock # flushes state to hardware
> > > > > >=20
> > > > > > But it sounds like that's not even a big issue.
> > > > >=20
> > > > > That is exactly what configfs was designed for :)
> > > >=20
> > > > Interesting... for some reason I had never thought about configfs in
> > > > this context. But it does indeed sound like it could solve this pro=
blem
> > > > in a better way.
> > > >=20
> > > > My memory is a bit sketchy, but I think for USB device controllers =
this
> > > > works by exposing each controller in configfs and then configuring
> > > > things like endpoints within the controller's directory. So I wonde=
r if
> > > > instead of requesting PWMs via sysfs, we should rather expose them =
via
> > > > configfs items.
> > > >=20
> > > > Something like:
> > > >=20
> > > > 	# mkdir /configfs/7000a000.pwm/0
> > > >=20
> > > > could then be the equivalent of exporting PWM channel 0 of the give=
n PWM
> > > > chip in sysfs, except that now you get a configfs directory with
> > > > attributes that you can use to inspect and reconfigure the PWM chan=
nel
> > > > and ultimately apply the changes atomically.
> > > >=20
> > > > How does that work from a permissions point of view? How do we ensu=
re
> > > > that people don't need root privileges to access these?
> > >=20
> > > To change things in configfs, yes, I'm pretty sure you need root acce=
ss.
> > > But to read things, sysfs is fine.  I don't really know what you are
> > > wanting to do here, both create a device and change the options over
> > > time?
> >=20
> > Yes, I'm wondering if we should replace the write usages in sysfs with a
> > better configfs implementation. We obviously can't remove the existing
> > sysfs ABI, but for anything that's meant to be atomic we could point
> > people at the configfs interface.
>=20
> How about fixing the sysfs interface so that it's usable, like the
> proposed patch does?  What you all have now is not working.
>=20
> When the revised version is sent, not this version...

I'm not sure which patch you're referring to. I don't see anything in my
inbox. I'll go check the spam, perhaps it's landed there.

Thierry

--Sosn/fv6aiTyEgxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl97ClgACgkQ3SOs138+
s6EVOw//e+9/kMEwvDWaPh3Qfa6OxoLzYvGDS2JVYHs2o0QL9m7k6HdfDmfBmldu
2WnXJatvEBuK8gnKe661/deK2CEkoGaDUs7KeUNRKShAKVLV5bUclt6+rwLOUAtr
hr7oq4KoSy44XBm9UcQ4LhCVo6ZBBfovjSwsvl0DiHjkQ9y0HPXTePMvDeVbJACj
oFKbd1/QC38RKRiF53y/kFZA5MXLu9/rryR1JT55bT1Jf/V2YvxIrPv31F/91oz4
dOoB5L9fgYAw90LKGLHprBlOlwIPmOukAQadFKYwEQrdRBaVhvrmQ60Y5APq+Lwd
TxuzBMxqVs6jDxMYM89IMxW1wrDFgbiORTUdwJsLQ6Fi4unLlwbyV8OlbzKbFEvT
Xn8k2zWdrnEfqsxfDyrf5AOBI9MrebhsPZIogI/VDnuKjvYfIYbnQF94tpq/vlt+
OjmkSjptlNuOceRJ/lAQwgALqrU9ZuDOwI+I2mViX6jLbZpDxDDmLKNtBEWQt59J
fcmKnxS43qI2qPPh7E6/qAvhgQlsDxR2hDB7raYFS+ixvuR1Ca/1XO4GcoMfNe36
nnHFmECZsqTG6c4G7SPl7q2C87zQIvq8ozyKn2D3JCDjNR5d4K3V23ELcmNQcFYP
6Du9oABTB3IAZjyde6c8JOtiRD0+/aLh2Zy92QtUCPIXFmhnT1c=
=kfam
-----END PGP SIGNATURE-----

--Sosn/fv6aiTyEgxl--
