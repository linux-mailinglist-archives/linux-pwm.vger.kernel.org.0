Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA757A5D76
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Sep 2023 11:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjISJLH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Sep 2023 05:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjISJLF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Sep 2023 05:11:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8037FDA
        for <linux-pwm@vger.kernel.org>; Tue, 19 Sep 2023 02:11:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2486EC433C8;
        Tue, 19 Sep 2023 09:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695114660;
        bh=zvujWliJ8zUzjyqJbubpZ0nfFaMwxADyZ2s46QyB91A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tL0LYYtrHCxlHr0kdSmBwAZ5ccuqlIIMo9A2sLPX+e3Rue8RH8n2CEKQHw5UdQaHt
         xoLSnFPSOouh2L+f72kaywfP6kacIhyJ67V7nb3L6jwotRhd9WFOa5scntLyFNR0mS
         opvJMk6DaH/KIdPrik+9A9CvpEZ/h7CW/AUFT8d0GTQ9m0SHaRX4f09NZ+qv6Eio7Z
         u8PNALya6XP8KLffYvrHgIPeucpu0GonHm9yQgbLnkDiR8kHtz8DNLNcjIIVrK1BS/
         RKy8PO+7ohtIStd7hGM4UWDfNFCPh/jRjrlg5C/MLKB6gguOpf3ZSAs0PVcqsZaa8X
         yYIrAupbw13lg==
Date:   Tue, 19 Sep 2023 10:10:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1] pwm: microchip-core: convert SOC_MICROCHIP_POLARFIRE
 to ARCH_MICROCHIP_POLARFIRE
Message-ID: <20230919-2a868286ba7bda597a3102ff@fedora>
References: <20230918-finisher-eliminate-b9cacc9d86eb@wendy>
 <20230918130322.2wyxfcvnf74wsj54@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AD6VpnQii4E2Pmyk"
Content-Disposition: inline
In-Reply-To: <20230918130322.2wyxfcvnf74wsj54@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--AD6VpnQii4E2Pmyk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 03:03:22PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Conor,
>=20
> On Mon, Sep 18, 2023 at 11:23:27AM +0100, Conor Dooley wrote:
> > As part of converting RISC-V SOC_FOO symbols to ARCH_FOO to match the
> > use of such symbols on other architectures, convert the Microchip FPGA
> > PWM driver to use the new symbol.
> >=20
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > CC: Thierry Reding <thierry.reding@gmail.com>
> > CC: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > CC: linux-pwm@vger.kernel.org
> > ---
> >  drivers/pwm/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 8ebcddf91f7b..502d041d4a11 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -407,7 +407,7 @@ config PWM_MEDIATEK
> > =20
> >  config PWM_MICROCHIP_CORE
> >  	tristate "Microchip corePWM PWM support"
> > -	depends on SOC_MICROCHIP_POLARFIRE || COMPILE_TEST
> > +	depends on ARCH_MICROCHIP_POLARFIRE || COMPILE_TEST
> >  	depends on HAS_IOMEM && OF
> >  	help
> >  	  PWM driver for Microchip FPGA soft IP core.
>=20
> that seems to be in line with commit 444c3dbdabd4 ("RISC-V: introduce
> ARCH_FOO kconfig aliases for SOC_FOO symbols")

Ah, now that you mention it, it would probably be a good idea for me to
point out that commit in future submissions. Thanks!

--AD6VpnQii4E2Pmyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQllnQAKCRB4tDGHoIJi
0oNWAPoCjUvN43pG3bHKGWRVHgrM7A8tzJ1IcItGsTzHA1iSEAEAnsTtW+a9L0c0
fkuO0gXRmOLM28YuhSHIZOdCCpopkwI=
=adum
-----END PGP SIGNATURE-----

--AD6VpnQii4E2Pmyk--
