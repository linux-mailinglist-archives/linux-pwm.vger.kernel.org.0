Return-Path: <linux-pwm+bounces-291-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDE5804DEA
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 10:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DA21F20FEB
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099ED3E49E;
	Tue,  5 Dec 2023 09:31:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB50129
	for <linux-pwm@vger.kernel.org>; Tue,  5 Dec 2023 01:31:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rARmM-0001GD-Ds; Tue, 05 Dec 2023 10:31:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rARmL-00DiB8-Uj; Tue, 05 Dec 2023 10:31:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rARmL-00Ed3C-Lb; Tue, 05 Dec 2023 10:31:45 +0100
Date: Tue, 5 Dec 2023 10:31:45 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc()
 function
Message-ID: <20231205093145.l7p52xtw2ak756ra@pengutronix.de>
References: <CAMRc=MdBvcS8pvtt_mB9NWskJPQgB4t4jot5YZRE=_d+jVNnMQ@mail.gmail.com>
 <ZWCTtPVkTUQNLVoa@orome.fritz.box>
 <CAMRc=MeuJKJWOXJQZXQr5mc-NB4mh_jF0JW1LuTNEO9EhTYncQ@mail.gmail.com>
 <20231127105844.kpu5ori6o6umfynh@pengutronix.de>
 <CAMRc=Me=J0f4epqmeLasqMYfMjMz46jpfmBpxV2bHGcp5Ev47Q@mail.gmail.com>
 <20231128090732.54xm72pnnjmbsjqb@pengutronix.de>
 <CAMRc=McAYSpCY=E1Ze7xKuBom8xOzQ4+5f7vYm33ihVU90xM1w@mail.gmail.com>
 <20231202004316.mxhrfsgcitupc6cc@pengutronix.de>
 <CAMRc=Md9bRdk5ZaCVu5gmZ4r5JR7eVZDriap32FMrN05PyTENQ@mail.gmail.com>
 <CAMRc=MeiL7omJhe_gb_UiL_bbJGoujp3Js4=Fe=qXKHv8TjM-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7wf42ilwzebmm55z"
Content-Disposition: inline
In-Reply-To: <CAMRc=MeiL7omJhe_gb_UiL_bbJGoujp3Js4=Fe=qXKHv8TjM-Q@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--7wf42ilwzebmm55z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Dec 04, 2023 at 10:28:15PM +0100, Bartosz Golaszewski wrote:
> On Mon, Dec 4, 2023 at 9:27=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> >
> > On Sat, Dec 2, 2023 at 1:43=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Fri, Dec 01, 2023 at 11:14:32AM +0100, Bartosz Golaszewski wrote:
> > > > On Tue, Nov 28, 2023 at 10:07=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > >
> > > >
> > > > [snip]
> > > >
> > > > >
> > > > > > I see the
> > > > > > chip->operational field that is set to false on release. In my
> > > > > > version, we just use a NULL-pointer to carry the same informati=
on.
> > > > >
> > > > > Yup, sounds obvious. Your usage of "just" sounds as if your varia=
nt was
> > > > > better. To give the alternative view where the suggested approach=
 sounds
> > > > > better would be:
> > > > >
> > > > > You need a pointer and I "just" a bool that even has a name imply=
ing its
> > > > > function. You need to dereference the pointer in several places a=
s the
> > > > > needed information is distributed over two structures while it's =
all
> > > > > together in a single struct for the usual foo_alloc() + foo_regis=
ter()
> > > > > approach.
> > > > >
> > > >
> > > > There's another reason we do that. I'm no longer sure if I mentioned
> > > > it in my talk (I meant to anyway).
> > > >
> > > > In GPIO we have API functions that may be called from any context -
> > > > thus needing spinlocks for locking - but also driver callbacks that
> > > > may use mutexes internally or otherwise sleep. I don't know if this=
 is
> > > > the case for PWM too but in GPIO we may end up in a situation where=
 if
> > > > we used a spinlock to protect some kind of an "is_operational" fiel=
d,
> > > > we'd end up sleeping with a spinlock taken and if we used a mutex, =
we
> > > > couldn't use API function from atomic contexts.
> > > >
> > > > This is the reason behind locking being so broken in GPIO at the
> > > > moment and why I'm trying to fix it this release cycle.
> > > >
> > > > Splitting the implementation into two structures and protecting the
> > > > pointer to the provider structure with SRCU has the benefit of not
> > > > limiting us in what locks we use underneath.
> > > >
> > > > Every subsystem has its own issues and we need to find something
> > > > generic enough to cover them all (or most of them anyway). I don't
> > > > think having a single structure cuts it.
> > >
> > > I'm convinced it works. I introduced a wrapper pwmchip_lock() that for
> > > now uses a mutex and once we have fast pwm_chips it uses a mutex for
> > > sleeping pwm_chips and a spinlock for the fast ones.
> > >
> > > That's similar to how struct irq_chip::irq_bus_lock works. For sleepi=
ng
> > > chips that callback uses a mutex, for fast chips a spinlock.
> > >
> >
> > Fair enough. I'd love to see a benchmark of what's faster one day
> > though: two structures with dereferencing and SRCU or one structure
> > with mutex/spinlock.

I think until the day has come that we have a SRCU+two and
mutex/spinlock+one implementation for one framework it's moot to discuss
which one is the faster, so I suggest we stop here. (Note, you can
already do mutex/spinlock+two already now. That's what I do for the
non-pure PWM drivers in the next iteration. Preview at
https://lore.kernel.org/linux-pwm/20231124215208.616551-4-u.kleine-koenig@p=
engutronix.de/T/#u)
For me it's not so clear that SRCU is the winner. Also the winner might
vary depending on questions like:

 - How many PWM (or GPIO) lines does the chip in question expose?
 - Does the implementation of the callbacks need serialisation (because
   the bits for different lines are in common registers)?
 - Usage pattern (influencing the contention of the locks)

(But I adhere to my suggestion to stop now :-)

> Actually there is one thing that - while not technically wrong - makes
> the split solution better. In case of your abstracted lock, you find
> yourself in a very all-or-nothing locking situation, where all of the
> structure is locked or none is. With SRCU protecting just the pointer
> to implementation, we can easily factor that part out and leave
> whatever fine-grained locking is required to the subsystem.

The fine-grainedness of the locking scheme isn't fixed with my approach.

In fact you could just not use the offer to handle framework struct and
driver private data in a single memory chunk (and/or stop using the
knowledge that it is (or can be) a single chunk) and then the two
approaches are not fundamentally different and you can use the same
locking mechanisms.

The biggest difference between our approaches is that I handle
allocation of the framework struct and its registration in two steps in
the drivers while you do that in a single one.

My approach has the advantage that it allows to handle private data in
the same allocation and that the driver can fill in the framework struct
without the need for copying or pointer dereferencing if the framework
needs the driver provided information. Yours has the advantage that
drivers see less of the framework and so are better separated from the
core.

How you weight the different advantages is very subjective.

So if we rule out the subjective metrics we're left with: Both
approaches solve the technical challenge at hand (i.e. ensure unloading
a driver doesn't make the kernel crash if a character device is still
open) and my approach already exists for pwm.

> Additionally: the pointer to implementation has many readers but only
> one writer. I believe this to be the same for your "operational"
> field. I don't know the PWM code very well but I can only guess that
> the situation is similar, where subsystem data structures are read
> more often than they are modified and multiple readers could access
> the structure at the same time lowering latencies.

The lock serves to serialize access to .operational and ensures that the
driver doesn't go away until all callbacks have completed. Is this
serialized in your approach, too?
(If you don't, I wonder if you should. And if you do, I think this
better matches the use case spinlocks and mutexes are optimized for
compared to SRCU.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7wf42ilwzebmm55z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVu7gAACgkQj4D7WH0S
/k5zJQgAnWzLDdMpPqjJZZYADCxbMOOj40HSDGnaLM7Mc5SoKMI2hi1DmYNdievd
2SzA9V3TfOG0r8aA2bXVQcmGt5SF4JM7QVs/f+2yyqVdlZbhOwgbZQlnRCnHuVUj
MfGJM7a7sbLdE1gseP888NCBuCe8AerygfrGxrMgTEJMEEsvbTasQSsYAQ5VdESH
LY9fSRfihFjMLtHpfEnrl+UBcXhgbqeWR/1YlzbgBC6UXk24xwz1W0NeOtyf2v8c
+tgAPnTzqhYwmbIq25fP45Q8U+bWBExJNwtd8AuqjEGImLIPfbq6iuW/7OATHRfp
ij4EFLGEF9jgOJdow4dCxBX/vFgyeQ==
=xWE2
-----END PGP SIGNATURE-----

--7wf42ilwzebmm55z--

