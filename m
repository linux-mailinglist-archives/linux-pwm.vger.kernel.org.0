Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE812834A5
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Oct 2020 13:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgJELIY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Oct 2020 07:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJELIY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2020 07:08:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917D7C0613CE;
        Mon,  5 Oct 2020 04:08:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h24so4713413ejg.9;
        Mon, 05 Oct 2020 04:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FZnH0gtambJRJ5Gy4z4Dh52PL6dm4E2p/R1Klp5kTwY=;
        b=ZvIKgvNBKNLul4XDS4CGQE3XGtkixGHab39jqzuTHfNfiV7ljvi3WDisCn+NaQRecK
         FaHU+7MN8J9Z0KAZmsTBYyrth98rQpZe9QecC75rZkXjAcwBQYwCDIdtFgTo9AyiIaIk
         w83CwnRjQb/sH4XKTGKD1rHY3GylPHi8zSvthI+JCoimT4/zNJeyuC2Azxymh7drIfvv
         9TccLTMuehpVHsWubL3DyQDt2gGLw8eooFxszjsq5CzkLbJcm59sSldQoWn3n7uz3bwC
         NR0Y9IJ/YzlU51wLMi/GDGHDj25cwRZhQgmWwknxRmxz9Bt3UjDBEOoByFPHNUtvt8YB
         xkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FZnH0gtambJRJ5Gy4z4Dh52PL6dm4E2p/R1Klp5kTwY=;
        b=LYQOOiyerFqMtbstelKsXYLX6qpbN9hJNSIXBaxKix+S427vqNDXetVNTHt/Dym0Ip
         CTjz0srmJrn/B6EPu1xfZXATJ0BhSTkrGek7mGscdVOI4RbW2ZvOSkixwZze0TMXcLUo
         APAoaMdq6coARuF0Lvrg3fH2LGArybgpFPEo7vWYmAkcuovgJAdbHPJbGBT06wlJJS8O
         YxNLdI9gxBx5d1l9GIEdXmLNwrly1/8I3p8RgNru2O+lODyEV5IHsonQARPvBkVg59ws
         YQ3UZpaW6UTJPAKqLQ1ztgdgbjeVMwT8nfU8dOVbavJ/ZvHjHE7EY6DGnpW42fNFH4yR
         508w==
X-Gm-Message-State: AOAM530iS6Ea/B77LVApKB2zwIEUIW1OXh8yKFWOYWFpRMP9ZVWa/A4g
        0dB/hAC9xduqCyIL/jZhUew=
X-Google-Smtp-Source: ABdhPJxLyI0e7K5U3LTAdpwo/4FZjk7EhBdRHifi+9FqGD0tAHbYzQ8Z9OV6JgGtl2lVkiTwx9JpPw==
X-Received: by 2002:a17:906:dc9:: with SMTP id p9mr9849710eji.403.1601896102200;
        Mon, 05 Oct 2020 04:08:22 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id k18sm7894278ejk.42.2020.10.05.04.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 04:08:21 -0700 (PDT)
Date:   Mon, 5 Oct 2020 13:08:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20201005110819.GP425362@ulmo>
References: <20200929121953.2817843-1-poeschel@lemonage.de>
 <20200930065726.fjcsm4pfh65medgl@pengutronix.de>
 <20200930092056.maz5biy2ugr6yc3p@lem-wkst-02.lemonage>
 <20200930094146.73s3qzvf5ekjeavc@pengutronix.de>
 <20201001090531.gubfwmznlto2ng6l@lem-wkst-02.lemonage>
 <20201001112449.GA2364834@kroah.com>
 <20201005093016.GD425362@ulmo>
 <20201005094530.GA154185@kroah.com>
 <20201005101721.GL425362@ulmo>
 <20201005104023.GB245520@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JPKYlvo4+BwO1+FT"
Content-Disposition: inline
In-Reply-To: <20201005104023.GB245520@kroah.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--JPKYlvo4+BwO1+FT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 12:40:23PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 05, 2020 at 12:17:21PM +0200, Thierry Reding wrote:
> > On Mon, Oct 05, 2020 at 11:45:30AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Oct 05, 2020 at 11:30:16AM +0200, Thierry Reding wrote:
> > > > On Thu, Oct 01, 2020 at 01:24:49PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Thu, Oct 01, 2020 at 11:05:31AM +0200, Lars Poeschel wrote:
> > > > > > On Wed, Sep 30, 2020 at 11:41:46AM +0200, Uwe Kleine-K=C3=B6nig=
 wrote:
> > > > > > > Hello,
> > > > > > >=20
> > > > > > > I added Greg Kroah-Hartman who I discussed this with via irc =
a bit to
> > > > > > > Cc:.
> > > > > > >=20
> > > > > > > On Wed, Sep 30, 2020 at 11:20:56AM +0200, Lars Poeschel wrote:
> > > > > > > > thank you for your review!
> > > > > > > >=20
> > > > > > > > On Wed, Sep 30, 2020 at 08:57:26AM +0200, Uwe Kleine-K=C3=
=B6nig wrote:
> > > > > > > > > On Tue, Sep 29, 2020 at 02:19:53PM +0200, poeschel@lemona=
ge.de wrote:
> > > > > > > > > > From: Lars Poeschel <poeschel@lemonage.de>
> > > > > > > > > >=20
> > > > > > > > > > This adds a class to exported pwm devices.
> > > > > > > > > > Exporting a pwm through sysfs did not yield udev events=
=2E The
> > > > > > > > >=20
> > > > > > > > > I wonder what is your use-case here. This for sure also h=
as a place to
> > > > > > > > > be mentioned in the commit log. I suspect there is a bett=
er way to
> > > > > > > > > accomplish you way.
> > > > > > > >=20
> > > > > > > > Use-case is to be able to use a pwm from a non-root userspa=
ce process.
> > > > > > > > I use udev rules to adjust permissions.
> > > > > > >=20
> > > > > > > Hmm, how do you trigger the export? Without being aware of al=
l the
> > > > > > > details in the sysfs code I would expect that the exported st=
uff is
> > > > > > > available instantly once the write used to export the PWM is =
completed.
> > > > > > > So changing the permissions can be done directly after trigge=
ring the
> > > > > > > export in the same process.
> > > > > >=20
> > > > > > The export is triggered through the userspace process itself. W=
hy can it
> > > > > > do this ? Because there is another udev rule, that changes perm=
issions
> > > > > > when a pwmchip appears.
> > > > > > Then I'd like to have the second udev rule, that changes permis=
sions on
> > > > > > the freshly exported pwm. The userspace process can't do this.
> > > > > > You are right I could propably do everything from within udev: =
If a
> > > > > > pwmchip appears, export certain pwms and right away change their
> > > > > > permissions. It does not also not feel right. It'd require know=
ledge
> > > > > > from the userspace application to be mapped to udev.
> > > > >=20
> > > > > The way the kernel code is now, yes, you will not have any way to
> > > > > trigger it by userspace as the kernel is creating a "raw" struct =
device
> > > > > that isn't assigned to anything.  That is what needs to be fixed =
here.
> > > > >=20
> > > > > > > Out of interest: What do you use the pwm for? Isn't there a s=
uitable
> > > > > > > kernel driver that can do the required stuff? Compared to the=
 kernel-API
> > > > > > > the sysfs interface isn't atomic. Is this an annoyance?
> > > > > >=20
> > > > > > Use-case is generating a voltage from the pwm. This voltage is =
used to
> > > > > > signal different states and does not change very often. This is
> > > > > > absolutely not annoying that this is not atomic. We just change=
 the duty
> > > > > > cycle on the fly. Everything else is configured one time at sta=
rtup.
> > > > > > I'd call what I need pwm-dac. I could not find a ready to use d=
river.
> > > > > > Maybe I could misuse some kernel driver for this. Maybe I could=
 use
> > > > > > pwm-led or pwm-brightness or pwm-fan. Propably pwm-regulator co=
uld work,
> > > > > > there is even a userspace facing part for this, but this is not
> > > > > > devicetree ready.
> > > > > > ...and the worst, please don't blame me: The application is jav=
a, so
> > > > > > ioctl is a problem.
> > > > >=20
> > > > > I thought java could do ioctls, otherwise how would it ever be ab=
le to
> > > > > talk to serial ports?
> > > > >=20
> > > > > Anyway, this needs to be fixed in the kernel...
> > > >=20
> > > > If atomicity was a problem, we could potentially add a mechanism to=
 the
> > > > sysfs interface to enable that. I don't see a good way of doing tha=
t in
> > > > a single file, since that works against how sysfs is designed. But =
one
> > > > thing I could imagine is adding a file ("lock", or whatever you wan=
t to
> > > > call it) that you can use for atomic fencing:
> > > >=20
> > > > 	$ echo 1 > lock # locks the hardware state
> > > > 	$ echo 100 > period
> > > > 	$ echo 50 > duty_cycle
> > > > 	$ echo 0 > lock # flushes state to hardware
> > > >=20
> > > > But it sounds like that's not even a big issue.
> > >=20
> > > That is exactly what configfs was designed for :)
> >=20
> > Interesting... for some reason I had never thought about configfs in
> > this context. But it does indeed sound like it could solve this problem
> > in a better way.
> >=20
> > My memory is a bit sketchy, but I think for USB device controllers this
> > works by exposing each controller in configfs and then configuring
> > things like endpoints within the controller's directory. So I wonder if
> > instead of requesting PWMs via sysfs, we should rather expose them via
> > configfs items.
> >=20
> > Something like:
> >=20
> > 	# mkdir /configfs/7000a000.pwm/0
> >=20
> > could then be the equivalent of exporting PWM channel 0 of the given PWM
> > chip in sysfs, except that now you get a configfs directory with
> > attributes that you can use to inspect and reconfigure the PWM channel
> > and ultimately apply the changes atomically.
> >=20
> > How does that work from a permissions point of view? How do we ensure
> > that people don't need root privileges to access these?
>=20
> To change things in configfs, yes, I'm pretty sure you need root access.
> But to read things, sysfs is fine.  I don't really know what you are
> wanting to do here, both create a device and change the options over
> time?

Yes, I'm wondering if we should replace the write usages in sysfs with a
better configfs implementation. We obviously can't remove the existing
sysfs ABI, but for anything that's meant to be atomic we could point
people at the configfs interface.

If configfs would also solve the permissions problem that Lars and
others have been trying to solve that would be two birds with one stone.

On the other hand, I'm wondering how much use there is in pursuing this
because as I mentioned earlier there are better alternatives (such as
pwm-regulator) that cater better to these specific use-cases and already
deal with atomicity. pwm-regulator should also show up as a separate
device in sysfs and allow permissions to be set using udev.

Thierry

--JPKYlvo4+BwO1+FT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl96/qAACgkQ3SOs138+
s6EHlxAAnw47bakhJ7pzr0YY//RcORi2PCEra8IOTptsOPLTx7y2qSTwTE27SJaa
Z+dTiXDZyn/TgThFeisDR+bXFpGN/msYGeYVL9cyLMNVMdfHhPlNGy8jRgwq9gNM
4tWJmPQ0L9d+NsEEm1KNErvDwjIKcZYBZnVsqvNUQ4bHqCz5P6FMsnA05xT81mgL
tCDK7DqEE0hUjgWGLfe5le08aruPjjR9WSIbc43+aI33zD5jiXgbnXuxdlsX+22x
jr4IiSos4Vjwzi+es1/BFmP1Se/frtBd923H+ov/QF50tDNJpIawYSjZmX0PgTBa
09+NxOVUqxl3nghsTW2+LaNxsEtuv9IyT6LVfYDum6VVaEDlgzd/jIQ9x158OfLB
79uWZSV0In1MqFpS1vlbh6A+k2wmwN8MWCFFmdoXMbFul4y79SCwu+a9LomQFin3
Q16vo1oA+ejcnUiF1orp5jjtbUg7pJopaL9obIeVGzX4wAy6QUwxuRmhbZPZKYfG
qaz8RJuetJMEu55G+xTdbuCIT6UZ34xYMv2EjfThzVOZzkbaWesgZHi3wpfuoR2B
6FtnLwoPba0WD71948vYlrEMWN021CFgSBms78p26wkyMhV2uS2SyYu18wb9xTwx
64Cp1aaZlrBOACSzVlvupJNx8xZziW/ryuqTgLBpaSoGgY3MmU8=
=IfWI
-----END PGP SIGNATURE-----

--JPKYlvo4+BwO1+FT--
