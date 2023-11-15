Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3917EC161
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Nov 2023 12:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbjKOLmM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Nov 2023 06:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjKOLmL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Nov 2023 06:42:11 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1F3E9
        for <linux-pwm@vger.kernel.org>; Wed, 15 Nov 2023 03:42:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3EHW-00018r-Rb; Wed, 15 Nov 2023 12:42:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3EHW-009D7x-FG; Wed, 15 Nov 2023 12:42:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3EHW-001qtD-6A; Wed, 15 Nov 2023 12:42:06 +0100
Date:   Wed, 15 Nov 2023 12:42:06 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 000/109] pwm: Fix lifetime issues for pwm_chips
Message-ID: <20231115114206.be3ynv5ejtixerho@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="prlya2k3lnadumla"
Content-Disposition: inline
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--prlya2k3lnadumla
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Oct 12, 2023 at 06:28:28PM +0200, Uwe Kleine-K=F6nig wrote:
> this is v2 of my series to address the lifetime issues I reported to
> this list[1]. It's still unclear to me if this is a shortcoming of
> devlinks (only).

The oops is fixed in the meantime (with v6.7-rc1~77^2~3 =3D 2e84dc379200
("driver core: Release all resources during unbind before updating
device links")).

Still, for the character device support this series (or something
similar) is necessary. I'd like to see the patches

	pwm: Provide a macro to get the parent device of a given chip
	pwm: Provide devm_pwmchip_alloc() function

going in and then coordinate the necessary updates with the drivers that
live in other trees (either using an immutable branch or waiting for yet
another merge window). This also had the upside that new PWM drivers
(there are a few in the making on the list currently) could be adapted
separately because the "old" way isn't broken (yet).

IMHO the start of a new development cycle (i.e. now) is a good time to
push that forward. What do you think?

For the v1 series you wrote that you'd prefer a big patch modifying all
drivers at once. Did you try to squash my patches accordingly? If not,
would it help if I do that and send such a series out? What would you
have squashed then? All patches concerning pwmchip_parent() in one
patch? All patches concerning devm_pwmchip_alloc() in one patch? Do you
want pwmchip_parent() flushed out again? And also squashed?

> For PWM character devices such a clean up is needed for sure as a PWM
> driver being unloaded must not result in killing userspace processes
> (while removing consumer devices is the status quo).
>=20
> This series is available at
>=20
> 	https://git.pengutronix.de/git/ukl/linux pwm-lifetime-tracking

I wanted to update this branch with my status quo on top of v6.7-rc1 but
there are a few conflicts. Would be great to get some feedback on

	https://lore.kernel.org/linux-pwm/20231023174616.2282067-13-u.kleine-koeni=
g@pengutronix.de/T/#t
and
	https://lore.kernel.org/linux-pwm/20231114112009.340168-1-u.kleine-koenig@=
pengutronix.de/T/#t

and preferably get them into next first. (I have them applied in

	https://git.pengutronix.de/git/ukl/linux pwm-for-next

if you want to take a look.) Then I'd rebase on top of that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--prlya2k3lnadumla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVUro0ACgkQj4D7WH0S
/k7uJwf/QFk393Hkv0/ahgtsy/cjQvib+a2Kmb4QgjALVf9fRPbYAsthLBuv+aKa
mHeUxCznuaWO0ZAmmsjtMTYWsRAIUlw+wmG0mhoWFE7Mtv9oUHMFKXD6CIT9QL+b
GVS2Rdlb6Glpelf4kT96V6bALiay/XqbjW0xWdm22Ik1BJaZdaBUEwrKXARIJv5f
M26VQBUFm6Oqyrj5wyTipJOE1HXbONHd+U2zk/tJX3nwVEq87Xo+T6Gr9Nwk9YCx
57T+9zj/6cRU24OJADMp/GD9BaWX7ZUaZKnC6MiukM2UV1h9CIQqzIc2778VZBOk
mR/VjxvJDWHrYEiyPs4u0RshSFEvYg==
=yAnd
-----END PGP SIGNATURE-----

--prlya2k3lnadumla--
