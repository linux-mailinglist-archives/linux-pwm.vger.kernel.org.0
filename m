Return-Path: <linux-pwm+bounces-195-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E574B7F7D73
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 19:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FD91C2124E
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 18:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EA939FE7;
	Fri, 24 Nov 2023 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E506AA
	for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 10:23:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6apL-0001j3-6i; Fri, 24 Nov 2023 19:22:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6apI-00BKCT-Qx; Fri, 24 Nov 2023 19:22:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6apI-007bog-HJ; Fri, 24 Nov 2023 19:22:52 +0100
Date: Fri, 24 Nov 2023 19:22:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Kees Cook <keescook@chromium.org>, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Pavel Machek <pavel@ucw.cz>, kernel@pengutronix.de,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 102/108] leds: qcom-lpg: Make use of
 devm_pwmchip_alloc() function
Message-ID: <20231124182252.r7br2vgr5ralwoua@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-103-u.kleine-koenig@pengutronix.de>
 <20231122115621.GK173820@google.com>
 <ZV43NHr1QN79lsaJ@orome.fritz.box>
 <20231123104458.2pfaowqylmpnynhx@pengutronix.de>
 <ZWCWqcxbAtmNPY85@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7sw6zvgk7ix5erfx"
Content-Disposition: inline
In-Reply-To: <ZWCWqcxbAtmNPY85@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--7sw6zvgk7ix5erfx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Nov 24, 2023 at 01:27:21PM +0100, Thierry Reding wrote:
> On Thu, Nov 23, 2023 at 11:44:58AM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello Thierry,
> >=20
> > [adding Bartosz to Cc]
> >=20
> > On Wed, Nov 22, 2023 at 06:15:32PM +0100, Thierry Reding wrote:
> > > On Wed, Nov 22, 2023 at 11:56:21AM +0000, Lee Jones wrote:
> > > > On Tue, 21 Nov 2023, Uwe Kleine-K=F6nig wrote:
> > > > > +	*(struct lpg **)pwmchip_priv(chip) =3D lpg;
> > > >=20
> > > > This is vile!
> > >=20
> > > Indeed. This highlights one of the weaker parts of this whole design =
and
> > > I really don't like it. The whole chip_alloc() construct works fine if
> > > you have everything isolated nicely in a single driver and subsystem
> > > (like you usually have in network land), but for cases like this where
> > > things are spread throughout and a device is actually more than just a
> > > PWM controller, it looks like we now have to work around this design
> > > because it doesn't fit.
> >=20
> > With the patch I suggested in reply to Lee's mail this is IMHO much
> > nicer and with that squashed into the patch under discussion I'd not
> > call this a work around.
> >=20
> > Note that the thing you consider ugly here (I think) is that for
> > handling a combined "PWM + something else" device a separate allocation
> > is needed for stuff that embedded a struct pwm_chip before. With
> > Bartosz's approach you have that second allocation for all PWM devices
> > ---and so the downsides hurt all PWM implementations and not only those
> > combined devices.
> >=20
> > Also note that among the four external PWM drivers (i.e.
> >=20
> > 	drivers/staging/greybus/pwm.c
> > 	drivers/leds/rgb/leds-qcom-lpg.c
> > 	drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > 	drivers/gpio/gpio-mvebu.c
> >=20
> > ) only two suffer from this complication, because the other two use a
> > pwm specific private data structure already which seems natural to me.
>=20
> That's true for now, but new drivers get added all the time, so anything
> we do here should be as future proof as we can make it.

If drivers are added with a sane separation between their functionality,
my approach doesn't result in these complications. See
https://lore.kernel.org/dri-devel/20231123175425.496956-1-u.kleine-koenig@p=
engutronix.de
for how this could look. With that applied, the ti-sn65dsi86 driver can
be nicely adapted.

So yes, if you have an ugly driver, the pwm support cannot be prettier.
I can live with that. You could even sell this as an advantage.

> > > In fact, this reminds me about the "midlayer mistake" in many ways and
> > > combined with what Bartosz said, I'm not sure this is going to hold up
> > > very well the more special cases we get.
> >=20
> > Where do you see a midlayer and how would that be better with what
> > Bartosz suggests?
>=20
> I wasn't saying that this was a midlayer but rather that it reminds me
> of one and the restrictions that it comes with.
>=20
> Right now all of these drivers work just fine and we don't need any of
> these weird assignments due to the single allocation. They all neatly
> plug into whatever other drivers or subsystems do.

Do you see the advantages of my approach, too?

> > The relevant difference between my approach and Bartosz's is that I put
> > the driver specific private data in the same allocation as the struct
> > pwm_chip and thus reducing the number of allocations and pointer
> > traversals. This difference IMHO doesn't qualify my approach as a
> > midlayer without Bartosz's qualifying, too.
>=20
> The solution that Bartosz proposed in his talk has two big advantages:
> it can potentially be generalized to a number of subsystems, which means
> that eventually we may get an actual library that would allow this stuff
> to be unified across subsystems without everyone having to invent their
> own and fix the same bugs.

Can you please point out the relevant difference between Bartosz's and
my approach that makes his generalizable but not mine? Also I don't see
much in the pwm core that could still benefit from such a
generalisation.

> Secondly it also puts the lifetime management
> where it belongs: in the subsystem. Drivers don't really have to care
> about lifetime management of whatever they expose. When they are
> unloaded, they should only need to let the subsystem know that they're
> gone and then the subsystem can take appropriate action.

I understand your words, but I don't see that critic to apply to my
patch set. Handling consumers of unloaded drivers is completely in the
core. If you don't agree, can you please point your finger on any of the
drivers adapted here that I might understand what you mean?
(OK, we need a one-time conversion of all drivers to an abstraction that
allows the core to handle the lifetime management. That's something that
my approach has in common with Bartosz's.)

> There are other advantages as well, mostly derived from the above: the
> patch series to implement this can probably be something like 5 patches,
> so we don't actually need to touch every driver, because the drivers
> themselves are not the issue.

While I don't think that the number of patches to reach a goal is a good
objective to judge the result of a patch set: We won't go down to 5. We
would still need to adapt every driver as they all assign struct
pwm_chip::dev.

> It's how the subsystem will expose them
> via chardev (or already exposes them via sysfs) that's really the
> problem. The only place where it makes sense to fix this is in the
> subsystem. Drivers don't need to be concerned about this.

This is another critic I don't understand. I agree it would be a
relevant issue if it applied. But the chardev stuff is completely in the
core.

I invested much thought, time and effort into this series. I'm convinced
it is a good one improving the pwm framework. I aligned the
implementation ideas to what several other frameworks do---I'm aware of
counter, iio, net, rtc, siox and spi that all use this idiom. I grepped
a bit around and found some more using the _alloc pattern: amba, drm,
hid, infiniband, input, libata. I also found some that don't:=20

  - rpmsg: but that seems to rely on the lowlevel drivers to get the
    lifetime stuff right (look at mtk_rpmsg.c).=20
  - i2c/i3c: has lifetime issues (though I think they are all "properly"
    worked around)
  - gpio: See how both gpio_chip and gpio_device have base, ngpio, a
    parent pointer (gpio_device has it in .dev), an owner and a label.
    Do they all have the same semantic? Yes? -> that's bad. No? ->
    that's IMHO even worse.

And now I'm supposed to rework my patch set to a different abstraction
because of some vapour ware resource lib that probably involves some
data duplication (see gpio above) and more overhead in the source *and*
the binaries because we need more pointer dereferences?

Honestly? That's really frustrating.

Can I please invest some of the karma I earned by caring for the pwm
subsystem to align it to how other major subsystems work?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7sw6zvgk7ix5erfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVg6fsACgkQj4D7WH0S
/k5OZQf+Krm8OwWB5OuMa+II/7yAn7B4H0GOQE/BiX4zMszv+mNnsN7jgUt6kgll
kNliGp89gUwUcO7zsvT4csj3YBNWb5WcEdMrixI0O5/vKP1WyZn24LLJViLjIk94
KmEHeIkIXA5Bb4UU4XdPQK4AC12DSKYDY3ozhR9YzwsZokTLxy2gtBwVZC/jkvEG
szDa59kE654mCR5ROVt8v1y+3GbZpHEDU1irvbu/ObI43dqGROxibG/ejnz2pxzx
YjPjsTywjQoqeATF33lhm2nmiVzq28i8Hc4/toIuEPQJ3Gm0cnIlkOV69Xf+0qDq
rBLRtTv+grdySvnv3oHfcvK+L7nGQw==
=HH1A
-----END PGP SIGNATURE-----

--7sw6zvgk7ix5erfx--

