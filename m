Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A51F7BB5B9
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 12:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjJFK4c (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 06:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjJFK4a (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 06:56:30 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3760283
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 03:56:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoiVP-0005kf-6U; Fri, 06 Oct 2023 12:56:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoiVO-00BUgB-Gx; Fri, 06 Oct 2023 12:56:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoiVO-00A9rH-7l; Fri, 06 Oct 2023 12:56:26 +0200
Date:   Fri, 6 Oct 2023 12:56:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v1 001/101] pwm: Provide devm_pwmchip_alloc() function
Message-ID: <20231006105626.xu5ztizlk44iyl3u@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-2-u.kleine-koenig@pengutronix.de>
 <ZR_SJW9vxOYoAC6N@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yh4cs5sssyalgclu"
Content-Disposition: inline
In-Reply-To: <ZR_SJW9vxOYoAC6N@orome.fritz.box>
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


--yh4cs5sssyalgclu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Oct 06, 2023 at 11:23:49AM +0200, Thierry Reding wrote:
> On Tue, Aug 08, 2023 at 07:17:51PM +0200, Uwe Kleine-K=F6nig wrote:
> > +struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned in=
t npwm, size_t sizeof_priv)
> > +{
> > +	struct pwm_chip *chip;
> > +	size_t alloc_size;
> > +	unsigned int i;
> > +
> > +	alloc_size =3D sizeof(*chip) + sizeof_priv;
> > +
> > +	chip =3D devm_kzalloc(parent, alloc_size, GFP_KERNEL);
>=20
> Are you sure this works the way you want it to? If you allocate using
> device-managed functions, this memory will be released when the driver
> is unbound from the device, so we're basically back to square one,
> aren't we?

After this patch the problem with broken lifetimes isn't fixed. Today
the way the pwm_chip is allocated is a problem in each driver. With this
function (that indeed suffers from the same problem) the issue can be
shifted from each individual driver to this function (patches #2 - #69).
Then the lifetime tracking can get fixed in a single place without
touching all drivers in one single commit (patches #70, #100 and #101).
With the whole series applied this devm_kzalloc is indeed gone -- this
can however only happen when all drivers use devm_pwmchip_alloc().

If you have a better idea how to split such a conversion in managable
and reviewable patches, I'm all ears.

> > +	if (!chip)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	chip->dev =3D parent;
> > +	chip->npwm =3D npwm;
> > +
> > +	return chip;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
> > +
> >  /**
> >   * __pwmchip_add() - register a new PWM chip
> >   * @chip: the PWM chip to add
> > @@ -208,8 +233,6 @@ static bool pwm_ops_check(const struct pwm_chip *ch=
ip)
> >   */
> >  int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
> >  {
> > -	struct pwm_device *pwm;
> > -	unsigned int i;
>=20
> Am I missing something? You seem to be using this variable in the for
> loop below, so how can you remove it?

Yeah, that series might not be bisectable. This will be fixed in the
next iteration.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yh4cs5sssyalgclu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUf59kACgkQj4D7WH0S
/k79KQf8DNVh3by2mZx9KJzQTyAXdQ3BSqc3rmFFaWmSbUVXlA/ns+RtYa3CKiyB
DlkkmROsd1VwoMsEUBTAHKmENtiJKwJP7zj2HinUt5t+WZ75ZWgEuA0nTJZ1El2t
I+6te3xVRobsAOfZhZdbknDEvugyo6frugtSZ+rYJeabjmozR64E0/+tAu68g0gk
icAyc2V6ti+Dig5T2LiV2KRgJ3Fe51gE3FZcwr7xqzjNVkC2748lC/NhoBBy10Tt
aFVgk9+JG5ndJ4RWk/cPhWuKVXi7QeVgifkwb5nTyx3PdrPXp5eAKuwL4id58+47
T34RT32NSXLmX0mVZ9tYvk2Kq32P+w==
=nN9A
-----END PGP SIGNATURE-----

--yh4cs5sssyalgclu--
