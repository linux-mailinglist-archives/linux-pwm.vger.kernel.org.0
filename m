Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC9D2833E7
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Oct 2020 12:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgJEKR0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Oct 2020 06:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJEKR0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2020 06:17:26 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090D6C0613CE;
        Mon,  5 Oct 2020 03:17:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id u8so11108149ejg.1;
        Mon, 05 Oct 2020 03:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OlZ4Bs7gdC+/u+u591gGsyT23WUTmNER4sYQPnGpIq4=;
        b=UdsPVNQew6DI2Hd74ztXAyoAQrIzygEefTczOc3G469livl7USmsmQHQYObTtDw1Ql
         9ARDVbD/K07HJn0MsnckszZbt4oFnB75smaltLwsRrZAuqirDA+I3mAcm5G9nXz2BDFz
         MIip+wGHsQKwmkht0hzR+umaqJ0vRTeSHMFRj+HkrrCXf08I3nW8rpp+TauXJjsGGmMJ
         AK45//HG8kDIoo6bSPQEfM0zRwV8yO9sAiI071tBYnOYZEHAJGRXd/f1IY6dFG+iLdxB
         wnkQDG20HCzaZwESzL6SqXBg4kGn5oE9D/qTDU1Qj/30bK0klELhp6lfAliKy6FSWYxw
         3VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OlZ4Bs7gdC+/u+u591gGsyT23WUTmNER4sYQPnGpIq4=;
        b=rrrsmnZDJ58CoM0Q/E2L1Tiwy7uH3GGAgUkXHX6H7z0lDCtQ+GNv/b0ZiPkf46nazR
         HMDY++F87wjG9MFhM/55nmqOn5SjfN0pJ1+nGnbMvXRdDMKaMDBLnbqQGVAInnHAYiC6
         x9FMJUXPYQPkO5iqdauHpDVCfom1ggd6ryJXCA0GNo8Mnx22InJxwcImKaPY2JJxWX6j
         kugPTfOfbrOv7o7qY8uWJim6eUIdZbL0vX7nNd9DEwClzMKysc59xkcQwSWEmvg4/J2Y
         L24S/eT/Pm6v/swvsE+cAcoMmWGpwlm2gFY3ErI4xdU4qxrM86vUHpx4AnGNygDgAr7k
         r5Zg==
X-Gm-Message-State: AOAM532oh1IqoQs0xAWIxh3fPuVG5zM2bwlYXy+nVOI94HoZNRLK65h/
        DtlFtCcPtL3MT5nO+FTsoF8=
X-Google-Smtp-Source: ABdhPJyn6k76KDcQUIDgievBwTzljwXkfvQhXf1LnGr8iyEpaDeftS3E8Cd+knWhDCya99viDhdxQQ==
X-Received: by 2002:a17:906:7254:: with SMTP id n20mr326611ejk.382.1601893044588;
        Mon, 05 Oct 2020 03:17:24 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id y3sm1329219ejk.92.2020.10.05.03.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 03:17:23 -0700 (PDT)
Date:   Mon, 5 Oct 2020 12:17:21 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20201005101721.GL425362@ulmo>
References: <20200929121953.2817843-1-poeschel@lemonage.de>
 <20200930065726.fjcsm4pfh65medgl@pengutronix.de>
 <20200930092056.maz5biy2ugr6yc3p@lem-wkst-02.lemonage>
 <20200930094146.73s3qzvf5ekjeavc@pengutronix.de>
 <20201001090531.gubfwmznlto2ng6l@lem-wkst-02.lemonage>
 <20201001112449.GA2364834@kroah.com>
 <20201005093016.GD425362@ulmo>
 <20201005094530.GA154185@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bFUYW7mPOLJ+Jd2A"
Content-Disposition: inline
In-Reply-To: <20201005094530.GA154185@kroah.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bFUYW7mPOLJ+Jd2A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 11:45:30AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 05, 2020 at 11:30:16AM +0200, Thierry Reding wrote:
> > On Thu, Oct 01, 2020 at 01:24:49PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Oct 01, 2020 at 11:05:31AM +0200, Lars Poeschel wrote:
> > > > On Wed, Sep 30, 2020 at 11:41:46AM +0200, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > Hello,
> > > > >=20
> > > > > I added Greg Kroah-Hartman who I discussed this with via irc a bi=
t to
> > > > > Cc:.
> > > > >=20
> > > > > On Wed, Sep 30, 2020 at 11:20:56AM +0200, Lars Poeschel wrote:
> > > > > > thank you for your review!
> > > > > >=20
> > > > > > On Wed, Sep 30, 2020 at 08:57:26AM +0200, Uwe Kleine-K=C3=B6nig=
 wrote:
> > > > > > > On Tue, Sep 29, 2020 at 02:19:53PM +0200, poeschel@lemonage.d=
e wrote:
> > > > > > > > From: Lars Poeschel <poeschel@lemonage.de>
> > > > > > > >=20
> > > > > > > > This adds a class to exported pwm devices.
> > > > > > > > Exporting a pwm through sysfs did not yield udev events. The
> > > > > > >=20
> > > > > > > I wonder what is your use-case here. This for sure also has a=
 place to
> > > > > > > be mentioned in the commit log. I suspect there is a better w=
ay to
> > > > > > > accomplish you way.
> > > > > >=20
> > > > > > Use-case is to be able to use a pwm from a non-root userspace p=
rocess.
> > > > > > I use udev rules to adjust permissions.
> > > > >=20
> > > > > Hmm, how do you trigger the export? Without being aware of all the
> > > > > details in the sysfs code I would expect that the exported stuff =
is
> > > > > available instantly once the write used to export the PWM is comp=
leted.
> > > > > So changing the permissions can be done directly after triggering=
 the
> > > > > export in the same process.
> > > >=20
> > > > The export is triggered through the userspace process itself. Why c=
an it
> > > > do this ? Because there is another udev rule, that changes permissi=
ons
> > > > when a pwmchip appears.
> > > > Then I'd like to have the second udev rule, that changes permission=
s on
> > > > the freshly exported pwm. The userspace process can't do this.
> > > > You are right I could propably do everything from within udev: If a
> > > > pwmchip appears, export certain pwms and right away change their
> > > > permissions. It does not also not feel right. It'd require knowledge
> > > > from the userspace application to be mapped to udev.
> > >=20
> > > The way the kernel code is now, yes, you will not have any way to
> > > trigger it by userspace as the kernel is creating a "raw" struct devi=
ce
> > > that isn't assigned to anything.  That is what needs to be fixed here.
> > >=20
> > > > > Out of interest: What do you use the pwm for? Isn't there a suita=
ble
> > > > > kernel driver that can do the required stuff? Compared to the ker=
nel-API
> > > > > the sysfs interface isn't atomic. Is this an annoyance?
> > > >=20
> > > > Use-case is generating a voltage from the pwm. This voltage is used=
 to
> > > > signal different states and does not change very often. This is
> > > > absolutely not annoying that this is not atomic. We just change the=
 duty
> > > > cycle on the fly. Everything else is configured one time at startup.
> > > > I'd call what I need pwm-dac. I could not find a ready to use drive=
r.
> > > > Maybe I could misuse some kernel driver for this. Maybe I could use
> > > > pwm-led or pwm-brightness or pwm-fan. Propably pwm-regulator could =
work,
> > > > there is even a userspace facing part for this, but this is not
> > > > devicetree ready.
> > > > ...and the worst, please don't blame me: The application is java, so
> > > > ioctl is a problem.
> > >=20
> > > I thought java could do ioctls, otherwise how would it ever be able to
> > > talk to serial ports?
> > >=20
> > > Anyway, this needs to be fixed in the kernel...
> >=20
> > If atomicity was a problem, we could potentially add a mechanism to the
> > sysfs interface to enable that. I don't see a good way of doing that in
> > a single file, since that works against how sysfs is designed. But one
> > thing I could imagine is adding a file ("lock", or whatever you want to
> > call it) that you can use for atomic fencing:
> >=20
> > 	$ echo 1 > lock # locks the hardware state
> > 	$ echo 100 > period
> > 	$ echo 50 > duty_cycle
> > 	$ echo 0 > lock # flushes state to hardware
> >=20
> > But it sounds like that's not even a big issue.
>=20
> That is exactly what configfs was designed for :)

Interesting... for some reason I had never thought about configfs in
this context. But it does indeed sound like it could solve this problem
in a better way.

My memory is a bit sketchy, but I think for USB device controllers this
works by exposing each controller in configfs and then configuring
things like endpoints within the controller's directory. So I wonder if
instead of requesting PWMs via sysfs, we should rather expose them via
configfs items.

Something like:

	# mkdir /configfs/7000a000.pwm/0

could then be the equivalent of exporting PWM channel 0 of the given PWM
chip in sysfs, except that now you get a configfs directory with
attributes that you can use to inspect and reconfigure the PWM channel
and ultimately apply the changes atomically.

How does that work from a permissions point of view? How do we ensure
that people don't need root privileges to access these?

Thierry

--bFUYW7mPOLJ+Jd2A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl968q8ACgkQ3SOs138+
s6FjFQ//fgIU7KMkHJOFYJclMWcyXa8WyI91TAGfFO99v7BjkuJBCskVLrKYp1YY
41P8v47hWoSYBI4wXr+tRArhIGb3lwLU8x/SCffWvTUTZvaCOJozxNYtKHNjwtWT
p8rr1WjKVyYcqZy3IAu92F2AN9zL+fdB7PbKBB4rsZWG927xjvNoICiu47igsccr
59ZkVTjQXttlfqaEcmlwtW3TtrtAjvoSwBnxKW46a/2OfGQAPU0+b42vbGGnPxGR
b9UGyGV8+nw3WSANUhnBHgJBE29yfwt+1upgqklQvWKnU77l2CiwINC7R5zQcPAb
Hi8lPbtn0IFWWvCY+UU4RwRtF5tLykBP8wRwTxOccqpkn9uCNvFeMwIex9X/RQGD
n0DiqwzEZXpUizR3PpY8iYJyTgzt+8UaOoPAFrMqQ50b1k4z5jrsC+/TJom99NnV
XIhjK7ksRGONWZp/BJ5RK63vWZNRFYL66Vsu9AzXnO+CKwyhvuEewsKf86nX5aur
lw7rd5ZBR8zxa1wUlc114TB6zP30Nu1kwwIXYvuQEj9fT7KUe1jgWyoYkVC/2CR8
K0O1rGZxbGxo3CiwmCnB/OKWOgEcmsfi5Qd2qpbtcjRXipnOM3CXczOmBuhJvQlj
6m7kMYH6iSEHoLK4e/yXq/Rql7bOPP5FKd3JaxC3je0UeqLaRDs=
=gHDq
-----END PGP SIGNATURE-----

--bFUYW7mPOLJ+Jd2A--
