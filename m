Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814B328333A
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Oct 2020 11:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgJEJaV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Oct 2020 05:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgJEJaV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2020 05:30:21 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C6CC0613CE;
        Mon,  5 Oct 2020 02:30:20 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b12so8499409edz.11;
        Mon, 05 Oct 2020 02:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ePZkaljwe6pYtW+StSXkgUMc7x0Nnw0FBYjjoTVvbrs=;
        b=ZogVZqI0lOvZkQfVc4+275vuy4WtjN891+TWais4csUNd3KBxZu4Wt6YF0nNtiICCe
         ZNoeIMhZ1Egq4KiKO107ee47HyqepdcZoNi2KXL/i7qZpFuj1JqPvMN2l3VqPh7tDT2q
         vrxgEF+OmBH4lCnwZ549eDWTmne2Xn1KsYCBoJj2BiRsRkOKGTx+uVp0LDcCK0EMU+mK
         D7EuqMtGex910dXss17cgFlBX7R/w89nHGx3vLT+ti8soMOadED7CsrKZtkqKzGfCjcU
         ERlZbneUfXp8yT6gzs/c/w5htutG0p0tU7O3ZS/Ml1gzu/BuHkZ7DKFiQxORS1K53rjE
         GlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ePZkaljwe6pYtW+StSXkgUMc7x0Nnw0FBYjjoTVvbrs=;
        b=mr5iGMQ9w87JD2Zh7Yh57C5VR03+W1vUrQ95P0Yypzmv9biNsa+NWmKVgzLw5a0KhN
         bbDK2TXkgPfnKg5h4BYf6X/remCVKU2zrz/f2oZQutbK3YNobfofbFLJmPp0fAAEaH1F
         7cK4K9cICRrJbiIO0yq87l0IgnTLTNFPcNTejmcB9q0RcA/65AMmuiyVA8LvLkWyGoN0
         7EXlSlvrPH8E5BUSU9VHTj1lWNVVTJ2pORbfiQMo8kfds3oJdNaXo8UXkaL5MzJXeArH
         mwO0sHrMDpiFQh0FCfTaCRTeoiV2ho7M/D2sxSlU9sW3eJjR/piTy8RiIc6rL5kgc5+a
         AiHA==
X-Gm-Message-State: AOAM531ybXClDkBTS8n09p5rukdPiDcpXgJ4FaeS9rRhyYgl9F4cfgwA
        efJBmKfICOo/PdwhjW7nQME=
X-Google-Smtp-Source: ABdhPJz2i+YrMbd1UKBch4+iSIOa3IOCRkMWx1costLrg/X1bXQYMVaFDWpCve04LneyiioSUDt/2Q==
X-Received: by 2002:a50:b745:: with SMTP id g63mr5685774ede.181.1601890219192;
        Mon, 05 Oct 2020 02:30:19 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id n25sm2729579ejd.114.2020.10.05.02.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 02:30:17 -0700 (PDT)
Date:   Mon, 5 Oct 2020 11:30:16 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20201005093016.GD425362@ulmo>
References: <20200929121953.2817843-1-poeschel@lemonage.de>
 <20200930065726.fjcsm4pfh65medgl@pengutronix.de>
 <20200930092056.maz5biy2ugr6yc3p@lem-wkst-02.lemonage>
 <20200930094146.73s3qzvf5ekjeavc@pengutronix.de>
 <20201001090531.gubfwmznlto2ng6l@lem-wkst-02.lemonage>
 <20201001112449.GA2364834@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <20201001112449.GA2364834@kroah.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2020 at 01:24:49PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 01, 2020 at 11:05:31AM +0200, Lars Poeschel wrote:
> > On Wed, Sep 30, 2020 at 11:41:46AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello,
> > >=20
> > > I added Greg Kroah-Hartman who I discussed this with via irc a bit to
> > > Cc:.
> > >=20
> > > On Wed, Sep 30, 2020 at 11:20:56AM +0200, Lars Poeschel wrote:
> > > > thank you for your review!
> > > >=20
> > > > On Wed, Sep 30, 2020 at 08:57:26AM +0200, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > On Tue, Sep 29, 2020 at 02:19:53PM +0200, poeschel@lemonage.de wr=
ote:
> > > > > > From: Lars Poeschel <poeschel@lemonage.de>
> > > > > >=20
> > > > > > This adds a class to exported pwm devices.
> > > > > > Exporting a pwm through sysfs did not yield udev events. The
> > > > >=20
> > > > > I wonder what is your use-case here. This for sure also has a pla=
ce to
> > > > > be mentioned in the commit log. I suspect there is a better way to
> > > > > accomplish you way.
> > > >=20
> > > > Use-case is to be able to use a pwm from a non-root userspace proce=
ss.
> > > > I use udev rules to adjust permissions.
> > >=20
> > > Hmm, how do you trigger the export? Without being aware of all the
> > > details in the sysfs code I would expect that the exported stuff is
> > > available instantly once the write used to export the PWM is complete=
d.
> > > So changing the permissions can be done directly after triggering the
> > > export in the same process.
> >=20
> > The export is triggered through the userspace process itself. Why can it
> > do this ? Because there is another udev rule, that changes permissions
> > when a pwmchip appears.
> > Then I'd like to have the second udev rule, that changes permissions on
> > the freshly exported pwm. The userspace process can't do this.
> > You are right I could propably do everything from within udev: If a
> > pwmchip appears, export certain pwms and right away change their
> > permissions. It does not also not feel right. It'd require knowledge
> > from the userspace application to be mapped to udev.
>=20
> The way the kernel code is now, yes, you will not have any way to
> trigger it by userspace as the kernel is creating a "raw" struct device
> that isn't assigned to anything.  That is what needs to be fixed here.
>=20
> > > Out of interest: What do you use the pwm for? Isn't there a suitable
> > > kernel driver that can do the required stuff? Compared to the kernel-=
API
> > > the sysfs interface isn't atomic. Is this an annoyance?
> >=20
> > Use-case is generating a voltage from the pwm. This voltage is used to
> > signal different states and does not change very often. This is
> > absolutely not annoying that this is not atomic. We just change the duty
> > cycle on the fly. Everything else is configured one time at startup.
> > I'd call what I need pwm-dac. I could not find a ready to use driver.
> > Maybe I could misuse some kernel driver for this. Maybe I could use
> > pwm-led or pwm-brightness or pwm-fan. Propably pwm-regulator could work,
> > there is even a userspace facing part for this, but this is not
> > devicetree ready.
> > ...and the worst, please don't blame me: The application is java, so
> > ioctl is a problem.
>=20
> I thought java could do ioctls, otherwise how would it ever be able to
> talk to serial ports?
>=20
> Anyway, this needs to be fixed in the kernel...

If atomicity was a problem, we could potentially add a mechanism to the
sysfs interface to enable that. I don't see a good way of doing that in
a single file, since that works against how sysfs is designed. But one
thing I could imagine is adding a file ("lock", or whatever you want to
call it) that you can use for atomic fencing:

	$ echo 1 > lock # locks the hardware state
	$ echo 100 > period
	$ echo 50 > duty_cycle
	$ echo 0 > lock # flushes state to hardware

But it sounds like that's not even a big issue.

However, given the use-case description, it sounds to me like
pwm-regulator would be a better candidate to solve this, because it's
purpose is literally to generate a voltage using a PWM. There is a
device tree binding for pwm-regulator, so this should work there as
well.

Lars, what exactly are the problems that you're running into when trying
to use pwm-regulator with device tree?

Thierry

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9656UACgkQ3SOs138+
s6HD5xAAvnyVRSm0tP6ShHAqbfvbGKSqbPUTqlWsUE+wjnExEvJX4PSDgcs421EZ
wUN9RpVomYodDxziajQul9gfgLM850jPwVHu5kZq+Jf5+zC3dPblZ5jJKhv6K2XW
36DniEVx7D571P1cqmuGKXPu+NRt3sXOrASZAQRheKGwVYp1S6i5VZIqTwRNsN9b
0jb3uP9e86DipQ8vhd7QXreXMMYJfeqo0MJoGZ3sJoVFUd8ZVv1v3hBJyVgrmuew
33tAnCejJm2Vgkpp4UO/mXunx3a302e5XIICBJCSRxayVZ+bh3wJ2Tnrwp3nc/KP
D6FKteu4eEJ6KT6b5Q6kryamUSffGiUXdpdy3uDoNj8zmKvBubQ9PjVn2XKDdD/A
8yb6iMS0+nYbNfae5pmDmCLyzvtpu58BdF7j0ABy/G472V5YtQNntmOyDsgrzFOP
ySQjhjf/k+ICoLpedv6vTxf1kSV2Pzt5eXCId8gjO9aGmT2PdhC0+Lmu/JhhHOSZ
fpnybB0Sc3Tg8iEE2nZThZyKhWhXKfUxDlF/BPQWCPGHn0d9Gsh6moS/5ER665Cl
mxmBFjlWZIc1PCWQEYADOCZb0btYXj4bGQKozp+IH7Iay/kbdMtPv39lrzXsgLr/
3weuk1GzUjLJdhlMM+XV6VvfckzdXDruxc7iV4wNhEggH7z+Kmg=
=mIRH
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
