Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4077749BA21
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jan 2022 18:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587712AbiAYRTR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jan 2022 12:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454469AbiAYRPm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jan 2022 12:15:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB57AC0613EF
        for <linux-pwm@vger.kernel.org>; Tue, 25 Jan 2022 09:15:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nCPPd-0006Ij-5l; Tue, 25 Jan 2022 18:15:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nCPPc-00CNnp-CP; Tue, 25 Jan 2022 18:15:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nCPPb-001LbV-2z; Tue, 25 Jan 2022 18:15:19 +0100
Date:   Tue, 25 Jan 2022 18:15:11 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 1/3] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <20220125171511.zoyuiflb6utlkng5@pengutronix.de>
References: <ab2a4c345844f66aa22a847e522b2f4ee0786d8b.1639499239.git.baruch@tkos.co.il>
 <20220119172439.be4xpaqgwzdy26oh@pengutronix.de>
 <87tuds7y09.fsf@tarshish>
 <20220125161204.hx5foivny6iupjke@pengutronix.de>
 <87pmof93wf.fsf@tarshish>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rtkyyvtpld77pqog"
Content-Disposition: inline
In-Reply-To: <87pmof93wf.fsf@tarshish>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rtkyyvtpld77pqog
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Baruch,

On Tue, Jan 25, 2022 at 06:22:45PM +0200, Baruch Siach wrote:
> On Tue, Jan 25 2022, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jan 25, 2022 at 03:03:08PM +0200, Baruch Siach wrote:
> >> On Wed, Jan 19 2022, Uwe Kleine-K=F6nig wrote:
> >> > The task here is to calculate the biggest pwm_div for a given pre_div
> >> > such that
> >> >
> >> >
> >> > 	(pre_div + 1) * (pwm_div + 1) * NSEC_PER_SEC
> >> > 	-------------------------------------------- <=3D period_ns
> >> > 	                   rate
> >> >
> >> > right?
> >> >
> >> > This is equivalent to:
> >> >
> >> > 	                  period_ns * rate
> >> > 	pre_div <=3D ---------------------------- - 1
> >> > 	           (pre_div + 1) * NSEC_PER_SEC
> >> >
> >> > As pre_div is integer, rounding down should be fine?!
> >>=20
> >> I can't follow. With round down (as in v8) the result is always:
> >>=20
> >>   NSEC_PER_SEC * (pre_div + 1) * (pwm_div + 1) <=3D period_rate
> >
> > Yes, that's the condition that a valid configuration should fulfill
> > because then the configured period is never bigger than the requested
> > period.
> > =20
> >> As a result, 'diff' calculation below will always produce diff <=3D 0.=
 When
> >> there is no diff =3D=3D 0 result (bingo) we get IPQ_PWM_MAX_DIV in bot=
h best_
> >> values at the end of the loop.
> >
> > Looking again, your check is wrong. I think you need:
> >
> > 	diff =3D period_rate - NSEC_PER_SEC * (pre_div + 1) * (pwm_div + 1)
> >
> > . Given the calculations for pre_div and pwm_div this should never be
> > negative and you should pick values that minimize diff.
>=20
> So, if I understand correctly, you suggest to leave round up as in v10,
> and invert the diff calculation. Is that correct?

If you agree that this results in the intended setting and keeps dmesg
clean even with PWM_DEBUG enabled: yes.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rtkyyvtpld77pqog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHwMBwACgkQwfwUeK3K
7AmFxQf/YRtXmhd4P49NhBwlmxPnQXNVAn7fvF9d8RieTsIcquAtT3GrH8pdgAup
wTEBkPe3VzmKXIS70T78v0R92ZXHivZWBYrsjLcJyIFpUlEmvOiI0/9T1ij2c8Z5
cQNa0J9YMgj/c+j1QrN+gjvfwB2Z88CtdcgU/6I5fPBMh+QDz3GPj/KhYOXCiler
gEUjCsV9XfisjFmWAcwNMcReyywvTgE2yseHQM6NmbfISa+7n3FJcpxLpFFKtDvB
Y4LE5Xu8q/E3NQXfo/Uhs9lZiTAwV9MX+buVFDDOYSsYp0D7ULusW7VLzf2Gq5jL
PMNNDVYKKkcT/A52EZZ4+oGG76INeA==
=x5TU
-----END PGP SIGNATURE-----

--rtkyyvtpld77pqog--
