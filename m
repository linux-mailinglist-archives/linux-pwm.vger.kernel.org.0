Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB5C7C581C
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Oct 2023 17:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjJKPbT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Oct 2023 11:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjJKPbS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Oct 2023 11:31:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D95492
        for <linux-pwm@vger.kernel.org>; Wed, 11 Oct 2023 08:31:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqbB5-0000Ai-2U; Wed, 11 Oct 2023 17:31:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqbB2-000wCs-MG; Wed, 11 Oct 2023 17:31:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqbB2-00EEPU-D3; Wed, 11 Oct 2023 17:31:12 +0200
Date:   Wed, 11 Oct 2023 17:31:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-pwm@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/11] pwm: brcmstb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM
 functions
Message-ID: <20231011153112.44vfwedz4qxlunsa@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
 <20231010075112.755178-5-u.kleine-koenig@pengutronix.de>
 <20231011122152.00007595@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oomp5est4h5u2yfc"
Content-Disposition: inline
In-Reply-To: <20231011122152.00007595@Huawei.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--oomp5est4h5u2yfc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 12:21:52PM +0100, Jonathan Cameron wrote:
> On Tue, 10 Oct 2023 09:51:05 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have =
to
> > care about when the functions are actually used, so the corresponding
> > #ifdef can be dropped.
> >=20
> > Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
> > isn't enabled.
>=20
> The additional change to potentially return an error when not doing so be=
fore
> wants to be called out in the description.

Indeed, good catch. Something like:

	pwm: brcmstb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM

	This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
	care about when the functions are actually used, so the corresponding
	#ifdef can be dropped.

	Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
	isn't enabled.

	While touching brcmstb_pwm_suspend() also propagate the return
	value of clk_enable() to the caller of .suspend().

	Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I fixed that in my tree, so if and when v2 happens, this comment will be
addressed.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oomp5est4h5u2yfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUmv78ACgkQj4D7WH0S
/k747Qf7B2r+4picEtUod+rGL8ED2e9mT6afaAR8hcBjh/SHl6jOV+8J+J/JMg1p
H5IJipXBkQYt5fpeTlSPk8jjQ75hOF1O5vqJjsXV3yggS4WoqhQSXZCLKkZkETO+
Ud7Nu3/omrcbwa/D5n3PXL3/KNdw/3vr/ZgOGy0/zoo/C39HO//pALOpymel2ncN
sii2KQCHHZmm5mlv4qA1hmp20/J+Jgbj7WzRDQw6myz6em+aX2mhXbrSo9DaUkzS
ZoGAkfowQQ8i8+MdHH8nGIHV5NebDNrNnX1ixi97Ey/CsU08Cl1ICWnKZKSc6+wA
i2RciHVckxVZxBxy0Ltw6NsWdU35pg==
=fooK
-----END PGP SIGNATURE-----

--oomp5est4h5u2yfc--
