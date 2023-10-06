Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500517BB7CB
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 14:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjJFMgs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 08:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjJFMgr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 08:36:47 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEF2CF
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 05:36:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qok4S-000372-MM; Fri, 06 Oct 2023 14:36:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qok4S-00BWJG-2I; Fri, 06 Oct 2023 14:36:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qok4R-00AEBx-PD; Fri, 06 Oct 2023 14:36:43 +0200
Date:   Fri, 6 Oct 2023 14:36:43 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v1 001/101] pwm: Provide devm_pwmchip_alloc() function
Message-ID: <20231006123643.hpotju7nixecmjkq@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-2-u.kleine-koenig@pengutronix.de>
 <ZR_SJW9vxOYoAC6N@orome.fritz.box>
 <20231006105626.xu5ztizlk44iyl3u@pengutronix.de>
 <ZR_qoncG_Dma-Lnq@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qdwz3mvbe6i6acqm"
Content-Disposition: inline
In-Reply-To: <ZR_qoncG_Dma-Lnq@orome.fritz.box>
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


--qdwz3mvbe6i6acqm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Oct 06, 2023 at 01:08:18PM +0200, Thierry Reding wrote:
> On Fri, Oct 06, 2023 at 12:56:26PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, Oct 06, 2023 at 11:23:49AM +0200, Thierry Reding wrote:
> > > On Tue, Aug 08, 2023 at 07:17:51PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > +struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigne=
d int npwm, size_t sizeof_priv)
> > > > +{
> > > > +	struct pwm_chip *chip;
> > > > +	size_t alloc_size;
> > > > +	unsigned int i;
> > > > +
> > > > +	alloc_size =3D sizeof(*chip) + sizeof_priv;
> > > > +
> > > > +	chip =3D devm_kzalloc(parent, alloc_size, GFP_KERNEL);
> > >=20
> > > Are you sure this works the way you want it to? If you allocate using
> > > device-managed functions, this memory will be released when the driver
> > > is unbound from the device, so we're basically back to square one,
> > > aren't we?
> >=20
> > After this patch the problem with broken lifetimes isn't fixed. Today
> > the way the pwm_chip is allocated is a problem in each driver. With this
> > function (that indeed suffers from the same problem) the issue can be
> > shifted from each individual driver to this function (patches #2 - #69).
> > Then the lifetime tracking can get fixed in a single place without
> > touching all drivers in one single commit (patches #70, #100 and #101).
> > With the whole series applied this devm_kzalloc is indeed gone -- this
> > can however only happen when all drivers use devm_pwmchip_alloc().
> >=20
> > If you have a better idea how to split such a conversion in managable
> > and reviewable patches, I'm all ears.
>=20
> Is there anything that would prevent us from merging the really
> interesting bits from patch 100 into this first patch?

The main part of patch #100 is that struct pwm_chip gets a member of
type struct device. Sure, we *could* do that (and replace all usages of
chip->dev by chip->dev.parent), but I see no benefit in that, because
you only can use the embedded dev once all drivers don't place it in
memory obtained by devm_kzalloc(). So it would only make patch #1 more
strange (because why would you use a struct device only to use the
parent pointer?).

So unless I miss something (which I think I don't) there is nothing that
can sensibly be moved in pwmchip_alloc() before all drivers are
converted.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qdwz3mvbe6i6acqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUf/1oACgkQj4D7WH0S
/k44jwf/RMqIFkHI2rW5gjf6ZWUMlBdNeTcDOZaBCPfBz+CjZHKiIASmo89WcuCj
ch23VBo61TXAkjbby9iWpzBg7Tlh95vRYrMxLbgy7kNotqr3yxoQ9gL4UmjICTes
cIdLYbJiT9xjWpyTSH/tpII9933XFsTopRRT6/fG8edDNvTZLrN83rRgJ5nd8aqQ
yMJYii2vEu1syDI9t6rhfSl3GSS93xjlf82wVhwhIzI4iHEMrwKZevJVQ9V3UG88
dyU+8+jm16RSqBpkd5lKpXTlo11Egbh8+HGomZ+hJ3JtZY9cYqaQIVtzIE8/P+wn
Owc4aCR+U9WYcuyDR6AJUbhblooXqA==
=0JO5
-----END PGP SIGNATURE-----

--qdwz3mvbe6i6acqm--
