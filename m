Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E44164200E
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Dec 2022 23:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiLDW2r (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 4 Dec 2022 17:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLDW2r (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 4 Dec 2022 17:28:47 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3AA12757;
        Sun,  4 Dec 2022 14:28:45 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 57ABF1C09F4; Sun,  4 Dec 2022 23:28:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1670192923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tb+QBPJo0qeYHJ8DCZunY3OVS7kTZ2CbN+bF9vSBHmo=;
        b=ec39C9C+3rTa41D3UNoAC8tUW4ruR37wNmvC6i0jR2Q0Ycm/FxKytfmEmYVOIwmzUiZIDz
        335h8/Uy852+C/1MUnFweQXtZXmBC58AyiL+QJqFLpMWQVnWtZ+50qvJT2abCCPvJj1/Wv
        874wLikS0ttriMDQyWw8z8cJns+23EQ=
Date:   Sun, 4 Dec 2022 23:28:42 +0100
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
Message-ID: <Y40fGiCXlyRhOvX8@duo.ucw.cz>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-5-u.kleine-koenig@pengutronix.de>
 <20221204210401.eij5vujwnekjtxch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="N3pGd5riUuvOQ5Z4"
Content-Disposition: inline
In-Reply-To: <20221204210401.eij5vujwnekjtxch@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--N3pGd5riUuvOQ5Z4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > .get_state() can return an error indication. Make use of it to propagate
> > failing hardware accesses.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

>=20
> It would be great to get an Ack from you for this patch and the led part
> of patch 1 to take it via the PWM tree.

Let me take a look at that tommorow. Sorry for the delay.

Best regards,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--N3pGd5riUuvOQ5Z4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY40fGgAKCRAw5/Bqldv6
8uYSAJ9q+Rh+wUpHaH6Gt4aM9yVKHpvEgACfRkkSTyW62li8GbdlpL2AopRtniM=
=cB78
-----END PGP SIGNATURE-----

--N3pGd5riUuvOQ5Z4--
