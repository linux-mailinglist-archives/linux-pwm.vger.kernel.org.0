Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CB475FAC5
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jul 2023 17:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjGXP2c (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jul 2023 11:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjGXP2b (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jul 2023 11:28:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E74AE61
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jul 2023 08:28:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-992ace062f3so791832066b.2
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jul 2023 08:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690212506; x=1690817306;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBI/C+r5xG0KUP+bmv2oESdZYX2/jU3snuqVWjlvwF0=;
        b=ASVvf8bLl84hcfrtcIemCME+d+y8FVXth0MKzPW2qdyn+96LVYaG+fweIhS68Se14M
         y152tj3MymKN/JE1w+x4XTTnxFTDK9G6MH79Ke8jVCX3gt8a+TNZHuc7MxHOn5Ck0euW
         megq5+n8V/r94Pa25uxtbPBYnaHR1wNkQy8UyO4ZawHS6BmyBW1eZt43OCggpfVsZPRl
         2f1UE4tzl1aRcNCVKd4ckqiGMeHASG1NeUYEViJeRh/Em3pYFy3IJWSGptdT+CdEk0I9
         8g3GqPD+51rlrt2RJ0ryn03tboUtqXSxTB3vT2PNlPeDvSbdBRQvqeh5829dvmaD9TAg
         y93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690212506; x=1690817306;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBI/C+r5xG0KUP+bmv2oESdZYX2/jU3snuqVWjlvwF0=;
        b=Y79f8QW5k+z4VI7RRuOtRyjbrtTGmF8da9Nr7gPq7zo+ejgAAC8QAlxs17XZ5LPI0J
         Fntjiq/HVIt5tfg93pg77QlU/s18tc9v/sPUMrikD94mQQTJw/ZGdMMXFgvxvftRhMhQ
         lUoJelELmPfvmscmkTLCA6rVSgJuIYijTziRMTA5ZSixijxuSoHyuUwTpH27+gqAtUQQ
         X5stVx4Nws6+088gY+Cw7I3rvIek1HUxSfD4ROnXmGEO7/s1fHJaObMHhfDsG+LWu4i+
         Zj037XpIhMG1kA0jhzzcRiI34SpxKDhQbH8gr2eAcN7mVBmLUsPAwz5Xd3xDQBdMAECH
         2QUQ==
X-Gm-Message-State: ABy/qLaWXopA9HHL4byT31tSc6nRiFJ0WWMlyu3RwWlRMbZintQ+MsSK
        3SFTs+C/K6hUHTluCLgjSr4XnCFEOYY=
X-Google-Smtp-Source: APBJJlFJlWkhCVzs/37qjQssDLDt+8LfQHWA6Sfd724yPX8NKsW8qDjVuySvycDm1r3v42sltsV9qw==
X-Received: by 2002:a17:906:5d:b0:977:eed1:453c with SMTP id 29-20020a170906005d00b00977eed1453cmr9397270ejg.73.1690212506106;
        Mon, 24 Jul 2023 08:28:26 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bn5-20020a170906c0c500b0098f33157e7dsm6870365ejb.82.2023.07.24.08.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 08:28:25 -0700 (PDT)
Date:   Mon, 24 Jul 2023 17:28:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Explicitly include correct DT includes
Message-ID: <ZL6Yl-DFsiPIuuY7@orome>
References: <20230714174852.4062251-1-robh@kernel.org>
 <20230717074352.dz3ex7fwi77loayc@pengutronix.de>
 <20230724072442.yb4fa3vkw34nojwn@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M+7rjKCDL8Tv18IK"
Content-Disposition: inline
In-Reply-To: <20230724072442.yb4fa3vkw34nojwn@pengutronix.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--M+7rjKCDL8Tv18IK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 09:24:42AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Mon, Jul 17, 2023 at 09:43:52AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Acked-by: Uwe Kleine-K=C3=B6ng <u.kleine-koenig@pengutronix.de>
>=20
> I mistyped my name and this made it into your for-next branch. It would
> be great if you fixed it, e.g. using:
>=20
> 	FILTER_BRANCH_SQUELCH_WARNING=3D1 git filter-branch -f --msg-filter 'sed=
 "s/ng <u.kl/nig <u.kl/"' linus/master..

Done.

Thierry

--M+7rjKCDL8Tv18IK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS+mJUACgkQ3SOs138+
s6HhAhAAoB2OKwJqi5JUo8A46k6FHthtrN4rwe0NxXMASX2MR2wEnEjUrnWs4bIq
j6yi1pHzXGMnZkUma6OCfJ25lAQM7sKdiq11gJb0UigkdCdxidnrPFH4ZKERww5B
CtRVnBuhz3O6iug0rx8yRZtPVn2AnBbV0DDIWqhUyJ2tP01k/iLYdYq/lOF8N8xz
rPQSdkyh7ekjcyPQDN5H889H4z2zU0IJCIYHupcDFEn5qy8QiCzPYTxK5I/+BFrK
OdKe845jI6Hg8mmMjiWIBI4Pz19B/JQyQeBdaZGnuds76TntF4or+5MF1QjSy2Z/
jiADWodVZjWBE6rS0hrPgXhnUHYJUJ2gdsoL1fsbMMzFLW0m/PMNQtDX64c27ukr
aferGSKj1FMlAArhrnt8KdIXftHZVa6iCrnG/X+cytnvt7iKjYn+BHgB/+MuE5gK
V66Oa79A6UyeQidabihSMWeg87YckfLKoqhKXRsTTRSHy2pX44k9URAK0gRn6awL
NprGt654hyKbzqsUjHRMlir/tvL9LzVmHiPrd7FbLcOoXGUQKOhgm7ilkGwxyvgk
6qReKYtsbDxqt+q9SvfN5ITwf0ca+R2F+QPEKwK5kSDEbszL9xud0qd4ZoRghvQX
s/3MLF4xLoOIrCJ0y6qPk3kLRT+Dpq2y3mA+tlnoKykBBuc0Nlk=
=L9sn
-----END PGP SIGNATURE-----

--M+7rjKCDL8Tv18IK--
