Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74804C2D83
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Feb 2022 14:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiBXNq0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Feb 2022 08:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiBXNqZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Feb 2022 08:46:25 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1793A26F4E6
        for <linux-pwm@vger.kernel.org>; Thu, 24 Feb 2022 05:45:56 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id d10so4407691eje.10
        for <linux-pwm@vger.kernel.org>; Thu, 24 Feb 2022 05:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nf4jftydTxxUWPyj5ZPTKXupK4bmHq+doesyB140ov4=;
        b=kWAt9UE82NOOMvSxUmz5dISWJx0Nv7+aRlbXM7qUhcvVwEM+t3VxmCWprraznLMsMD
         Yh2L5kzWHvit+83lhRJ4ZnChYOi0ktFKoL7UvtgaAdXuUnxDGagISfBCmg1D7guhZC8a
         Gmq4OKRqjyRrr30avfvc2/KSrzRui94KI0hqOqMoBYD44rxx/9eotRmjXU3QhMBRiPhY
         D4ASPtxbfd1PwCgJL4NUfzYPTlb+yR0jVjkKFZu2CYdKKHPgMpqz/naH5WXbEOz7FLeY
         iKIK3Vabw6fisxTR/1I9EWZmw36lmEizs9CejoL4MhcffnjslFLfsc4PK/N0FA3qE8lh
         u+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nf4jftydTxxUWPyj5ZPTKXupK4bmHq+doesyB140ov4=;
        b=aEQjHrPZn7uCcWaw3zd8GNz4OGwt2Xirpk65xU00fJTDEFf92Kv5LNA/pft1dYCKMW
         OAHswRTi2D2KeOl1C2bU44xOf8lOl0+pZgbaZFJcOLsYRSBWW2O+17kuOOFnubGgARqx
         GJK4bnWLj8ZeQH/r9kuXCBwwq/YJ0uGSBBpkpSrYf0X1ZVXSU58Khvl8ur+/34HZcOZX
         yyFNi0ahBpRpbkV2MdfpP/A+N2b/T/9j4PonMGW6sxmU2kkg9nIkqJV8SKgN7aBWt5CV
         mK3/O+VR9Gmp3qMBw3uZPOeK8WdixOAT9y+EWPTYgf3dXKEDwqxApHjjjK70CqksO5l8
         Z7+w==
X-Gm-Message-State: AOAM531pxnlldkVeiKVmwSzz7IfzfT+c2OCI8ggAbu1cirfpGHA2aSxc
        mt1FdAcyCxc9qiV50Cc/CdU=
X-Google-Smtp-Source: ABdhPJzS3/fFrfeKjuj8RFPtHyPPO3+6MOrEzO6jnB3fZ1wPj9nLfHqK4WPlpGfZ4WauBXiCdgno8g==
X-Received: by 2002:a17:906:a1a:b0:6cf:d2d9:410c with SMTP id w26-20020a1709060a1a00b006cfd2d9410cmr2385774ejf.713.1645710354625;
        Thu, 24 Feb 2022 05:45:54 -0800 (PST)
Received: from orome (p200300e41f0a6900000000000000043a.dip0.t-ipconnect.de. [2003:e4:1f0a:6900::43a])
        by smtp.gmail.com with ESMTPSA id v5sm1412622edb.15.2022.02.24.05.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:45:53 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:45:51 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 0/2] pwm: brcmstb: Some cleanups
Message-ID: <YheMD3F2ZRVEkVcp@orome>
References: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/dBBTTi4KGMpCJSA"
Content-Disposition: inline
In-Reply-To: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--/dBBTTi4KGMpCJSA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 09:23:52AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> here are a few cleanups for the brcmstb PWM driver. There are a few
> issues left with it, that I'm not addressing for now. Just mention it in
> case someone wants to work on this driver:
>=20
>  - There is no .get_state() callback
>    (That needs to be implemented by some with hardware and
>    documentation)
>=20
>  - There are a few places where an overflow can happen in
>    brcmstb_pwm_config() that are not handled
>=20
>  - The loop in brcmstb_pwm_config() to calculate cword is ineffective,
>    cword could be calculated ad hoc.
>=20
>  - I don't understand
>=20
>                 /*
>                  * We can be called with separate duty and period updates,
>                  * so do not reject dc =3D=3D 0 right away
>                  */
>                 if (pc =3D=3D PWM_PERIOD_MIN || (dc < PWM_ON_MIN && duty_=
ns))
>                         return -EINVAL;
>=20
>    The usual policy is "With the selected period, pick the biggest
>    possible duty_cycle that isn't bigger thatn the requested duty_cycle.
>    So should this case be handled using dc =3D 0 instead?
>    But as I don't understand the real issue here (is this about changing
>    period and duty at the same time?), I don't want to touch that.
>=20
>  - The driver uses SIMPLE_DEV_PM_OPS which is deprecated.
>=20
>  - The driver defines pr_fmt(fmt) but doesn't use it.
>=20
> Uwe Kleine-K=C3=B6nig (2):
>   pwm: brcmstb: Implement .apply() callback
>   pwm: brcmstb: Remove useless locking
>=20
>  drivers/pwm/pwm-brcmstb.c | 52 ++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 28 deletions(-)

Both patches applied, thanks.

Thierry

--/dBBTTi4KGMpCJSA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXjA8ACgkQ3SOs138+
s6FYUQ//S7t/EH5pM+8Bnv5N6c75PVMAwVIgQXj9mFAzhhuy0wfqqLOVGglTddTs
NC982k+vVShTW/tS3sjY0yepLKjWUN1m4Co4vyJ18tQ3ZaFy4DHbPtKMb3EAbqnU
OY/CkLJmkyWu1Ej+JoEIW9ROi3T3HeHMtEXK1wK/5KWhFYw1/LH5hCEzyLqqChtl
fPYyreOSpa+57NCHj7fNA4SlaGQXTGg9iYV+L6mU3TZDOOKL0WDaYvXb24AbZvre
yVO8im48Y1nGcxSrpr4DRoiOR3QM1Wh0kMqn4Geo7EmCh5CEBeJP5Bxc7QHz0D/P
U/gprboLj4Cl6sEORq6Ad0P043Aw7I2iCgh9Fnic5n2VrzJQtH8or07teGHkkT4e
vNxJq6jddzobNYTrK80m2Od6MdTvfK5ZaPcmuoz0dua5rhCzzTsLEkEnQBPQcvri
FTNgmis+0Fr6L6wQpsfc+3mBJ/EmDOSwt7nsWhzYKEctnMurmERkW8ySjzgqn1TT
NdV+UCfkmups+eOtmZkYmKCJzs2N+iJslWMTJhEEmyT65jWBzWqVnvaaesksWIiZ
G770tYzfqXBEF2yVAnCrEwDi6z8OrwhK30C/VE/Xkbi6OXHgo5/TBi4KqICxq3Em
u2iNds/JZv/iZH+CBAddsvxc2VtHqf14v5b5/gc2RDCMGXDgGJQ=
=eR6l
-----END PGP SIGNATURE-----

--/dBBTTi4KGMpCJSA--
