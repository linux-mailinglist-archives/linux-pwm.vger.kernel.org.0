Return-Path: <linux-pwm+bounces-209-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5257FB538
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 10:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1854D1C2103E
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 09:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C855219BA5;
	Tue, 28 Nov 2023 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE6B1BB
	for <linux-pwm@vger.kernel.org>; Tue, 28 Nov 2023 01:07:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r7u45-0003gR-Iy; Tue, 28 Nov 2023 10:07:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r7u44-00C8fG-VE; Tue, 28 Nov 2023 10:07:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r7u44-00A46g-Lu; Tue, 28 Nov 2023 10:07:32 +0100
Date: Tue, 28 Nov 2023 10:07:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc()
 function
Message-ID: <20231128090732.54xm72pnnjmbsjqb@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-101-u.kleine-koenig@pengutronix.de>
 <CAMRc=MdSc3emU+AJpCni6is0qsmR9HcqysSL33gpAmb8JTnjVA@mail.gmail.com>
 <20231121161111.zphi7pn77ns7sgu2@pengutronix.de>
 <20231122090502.tcscaaaf7vuk6g7w@pengutronix.de>
 <CAMRc=MdBvcS8pvtt_mB9NWskJPQgB4t4jot5YZRE=_d+jVNnMQ@mail.gmail.com>
 <ZWCTtPVkTUQNLVoa@orome.fritz.box>
 <CAMRc=MeuJKJWOXJQZXQr5mc-NB4mh_jF0JW1LuTNEO9EhTYncQ@mail.gmail.com>
 <20231127105844.kpu5ori6o6umfynh@pengutronix.de>
 <CAMRc=Me=J0f4epqmeLasqMYfMjMz46jpfmBpxV2bHGcp5Ev47Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bt6nvbkkqijug5ra"
Content-Disposition: inline
In-Reply-To: <CAMRc=Me=J0f4epqmeLasqMYfMjMz46jpfmBpxV2bHGcp5Ev47Q@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--bt6nvbkkqijug5ra
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bart,

On Mon, Nov 27, 2023 at 09:22:48PM +0100, Bartosz Golaszewski wrote:
> On Mon, Nov 27, 2023 at 11:58=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Nov 24, 2023 at 10:16:40PM +0100, Bartosz Golaszewski wrote:
> > > I admit I've been quite busy but I do plan on going through Uwe's
> > > series next week and maybe running tests similar to what I have for
> > > GPIO on it.
> >
> > That's great. If you want to do that on my tree that already saw a few
> > improvements compared to what I sent out, get it at
> >
> >         https://git.pengutronix.de/git/ukl/linux pwm-lifetime-tracking
> >
> > . The improvements are only on the driver level, so unless you're using
> > one of the improved drivers, the difference wouldn't be that big I
> > guess. For (maybe) quicker feedback loops, you can find me on irc (e.g.
> > on libera's #linux-pwm) if that's a communication channel you like.
>=20
> I don't see anything obviously wrong with the approach.

Is this the result of "running tests similar to what I have for GPIO on
it" or did you only find the time for some high-level code inspection?

> I see the
> chip->operational field that is set to false on release. In my
> version, we just use a NULL-pointer to carry the same information.

Yup, sounds obvious. Your usage of "just" sounds as if your variant was
better. To give the alternative view where the suggested approach sounds
better would be:

You need a pointer and I "just" a bool that even has a name implying its
function. You need to dereference the pointer in several places as the
needed information is distributed over two structures while it's all
together in a single struct for the usual foo_alloc() + foo_register()
approach.

> Interestingly you DO have a pwm_device and pwm_chip structures. I'd
> say it would be more logical to have the pwm_device embed struct
> device.

A pwm_chip represents a piece of hardware that provides (possibly)
several PWM lines. A pwm_device is the abstraction for a single PWM
line. So that's two different concepts and I wonder why you find it
interesting that we have two different structures for it.

Today the pwm framework already has a struct device for the
pwm_chip that appears in /sys/class/pwm/pwmchipX. If a PWM line is
exported in sysfs, another struct containing a struct device is
allocated (struct pwm_export) to manage /sys/class/pwm/pwmchipX/pwmY/.

I think it's good to have a struct device in the gpio_chip. I'd be open
to put a struct device into pwm_device (unconditionally, not only when
it's exported), but that's a change that is out of scope for this
series. Also note that this would change the behaviour of
/sys/class/pwm/ which I'd like to prevent (at least today until the
character support is established, available for some time and known to
be in use).

> My approach is more about maintaining the logical scope and not
> changing the ownership of objects allocated in the driver. I also
> don't see a reason to expose the internals of the subsystem (struct
> device) to the provider drivers other than in callbacks where it is
> relevant. Subsystems should handle as much as possible and any data
> structures not relevant to what the driver does should be hidden from
> it.

Drivers see struct pwm_chip today and IMHO that's fine. I also feel
little incentive to hide something from the driver in .probe() and then
have to expose (more of) it in .apply() anyhow. Also I don't think the
series would benefit from putting yet more changes into it.

Struct pwm_chip currently contains the following members:

        struct device dev;
        struct cdev cdev;
        const struct pwm_ops *ops;
        struct module *owner;
        unsigned int id;
        unsigned int npwm;

        struct pwm_device * (*of_xlate)(struct pwm_chip *chip,
                                        const struct of_phandle_args *args);
        unsigned int of_pwm_n_cells;

        /* only used internally by the PWM framework */
        struct mutex lock;
        bool uses_pwmchip_alloc;
        bool operational;
        void *drvdata;
        struct pwm_device pwms[] __counted_by(npwm);

Some of them should be moved below the "only used internally" comment.
(i.e. dev, cdev, owner, id). For me this is "hidden" good enough then.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bt6nvbkkqijug5ra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVlrdMACgkQj4D7WH0S
/k6c5wf9E2tdhwxXGvVzBTwP5Wg4xq/VjRfjNRrS8a3XVPZLQpkBZvdjOweJ9URS
416ChSRdmw0rqB0FmvkSH6eGFEa4qE5dwB/JETObDLK6YEmrqdZkeC2DcDRciKIz
gZWNEqfeAWLBTfc0qpuRaAfRD7rOq4mUEzBz4jJqH09vhrFRWDlhoa8wtqc1AzgS
rcKqOVQjRZKGFacUJO7XOgiLkSB7V0c1/r7pVCt2pYuzHOFKV9lgKbKZHb/5GX2W
JO6PPKShv1Dk6dRsRVBlKRuuOQIqy5FbMLegciBhkU/waQG86p/e5aSAzFVf6nlx
jiE4PFAO9UHTqRsi1Z5Rb6LhfygIgQ==
=OsxS
-----END PGP SIGNATURE-----

--bt6nvbkkqijug5ra--

