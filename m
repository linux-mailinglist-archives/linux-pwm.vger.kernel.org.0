Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E51643826
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Dec 2022 23:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiLEWbJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Dec 2022 17:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiLEWbI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Dec 2022 17:31:08 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE6121A6;
        Mon,  5 Dec 2022 14:31:07 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 99A221C09F9; Mon,  5 Dec 2022 23:31:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1670279466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ctsIkhYu8v+3TDmLR0eJwXG/03lgp0BGhj8APIy4BKc=;
        b=MxCsBMEh84Q8LXw7sba++OyXuNDog7UEExiB2ior/fWXyloSc5OFjP1994MsCDLIBGdW1j
        LKJrr/gRosBbiCYTaNb7oqGwxW0RqYtUr30Fwhm2710Hkuw1kFqa3hQ4Da8u1HTHiWiifo
        NVky4BXTYCEhuzjj7C+yJS9barl+hag=
Date:   Mon, 5 Dec 2022 23:31:06 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 04/11] leds: qcom-lpg: Propagate errors in
 .get_state() to the caller
Message-ID: <Y45xKswRnao8P8Mf@duo.ucw.cz>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UMJAMAvHISBid0R5"
Content-Disposition: inline
In-Reply-To: <20221130152148.2769768-5-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--UMJAMAvHISBid0R5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> .get_state() can return an error indication. Make use of it to propagate
> failing hardware accesses.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Pavel Machek <pavel@ucw.cz>

Best regards,
							Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--UMJAMAvHISBid0R5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY45xKgAKCRAw5/Bqldv6
8pyEAJ9C/ruX2TuaSvO9zAh4FaFlfpSg7ACgm3hf0eXdHZoNXSyIG6/g3KHamJU=
=hdn0
-----END PGP SIGNATURE-----

--UMJAMAvHISBid0R5--
