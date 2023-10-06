Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222967BC106
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 23:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjJFVQt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 17:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjJFVQs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 17:16:48 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE08BE
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 14:16:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qosBg-00058J-Bb; Fri, 06 Oct 2023 23:16:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qosBf-00Bc4b-KS; Fri, 06 Oct 2023 23:16:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qosBf-00AWMM-Au; Fri, 06 Oct 2023 23:16:43 +0200
Date:   Fri, 6 Oct 2023 23:16:43 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v1 071/101] pwm: ab8500: Store parent device in driver
 data
Message-ID: <20231006211643.bvn7yof46znyjij7@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-72-u.kleine-koenig@pengutronix.de>
 <ZR_WXxqhmRgtpA0n@orome.fritz.box>
 <20231006110951.wkmjvokvnenuypdh@pengutronix.de>
 <ZR_tcmBGOOQVNSz4@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mnhu63np2ta7cbrh"
Content-Disposition: inline
In-Reply-To: <ZR_tcmBGOOQVNSz4@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mnhu63np2ta7cbrh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Oct 06, 2023 at 01:20:18PM +0200, Thierry Reding wrote:
> On Fri, Oct 06, 2023 at 01:09:51PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, Oct 06, 2023 at 11:41:51AM +0200, Thierry Reding wrote:
> > > Also, you could then just make this a single large patch that renames
> > > dev to parent in one go rather than making this large set even larger
> > > with this kind of trivial changes.
> >=20
> > The idea here is (again) that I don't have to touch all drivers in the
> > commit that changes struct pwm_chip.
> >=20
> > In the end there is such a parent pointer (pwmchip.dev.parent). Would
> > you prefer a macro (say) pwmchip_parentdev that can be defined as
> >=20
> > 	#define pwmchip_parentdev(chip) (chip)->dev
> >=20
> > at the beginning and then be changed to
> >=20
> > 	#define pwmchip_parentdev(chip) (chip)->dev.parent
> >=20
> > in the right moment? That's the best idea I have here.
>=20
> No, that's not necessarily better. So I think either we live with the
> duplicated parent pointer (which is the same whether we keep it in the
> core structure or the driver-private structure), or we just change all
> the occurrences at once when the new parent is introduced. I personally
> much prefer a single big patch with a lot of small one-line fixups over
> 30 patches that exist purely for the purpose of making patch 31 smaller.

I find that a surprising attitude. We're quite different here, I'd even
ask a contributor who sends a such a change in a single patch to split
it. I'll rework this part of the series to the above described macro,
which opens the opportunity to squash it all into a single patch in the
end without those (admittedly ugly) added extra pointers in driver
private data.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mnhu63np2ta7cbrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUgeToACgkQj4D7WH0S
/k4Q3gf/QgwBl+c3FGnMz/Jb9w5dMlJy/u7eIQjo1ipXqTDEbC2ylI9lYR6gBvdK
EbUtk2RHniioSPbzHcUy/xR5X0OHwMNjtc+lYAXilKufasmOU6GQOeDavc/7z6NO
641HP8wpEaD7VdjXadKR9ucEjQkG07kdnO++mG5c3sfYJiXc5PWwoe7Vvxv6YhNW
M5A3s92iU+FTPUdJZry0R7d2zulB5GCg4TC+4TuLWjhoTB6f4UgoWaoiUo2pyMYn
9olWfIxZBy6yfuiwXU24Gb/XCjblbeQtPdvmwOo2dtm8VIQcq7A1wBMDxyQnCsq6
q5rQ5y11yxUW+CUAlKEiXQjgyGI/1Q==
=hlCc
-----END PGP SIGNATURE-----

--mnhu63np2ta7cbrh--
