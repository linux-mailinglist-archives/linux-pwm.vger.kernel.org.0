Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C48143C3A5
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Oct 2021 09:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbhJ0HTs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 Oct 2021 03:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240390AbhJ0HTs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 Oct 2021 03:19:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D9CC061570
        for <linux-pwm@vger.kernel.org>; Wed, 27 Oct 2021 00:17:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mfdBM-0003Xo-4W; Wed, 27 Oct 2021 09:17:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mfcE4-0007VZ-MS; Wed, 27 Oct 2021 08:15:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mfcE4-0005Rs-LC; Wed, 27 Oct 2021 08:15:52 +0200
Date:   Wed, 27 Oct 2021 08:15:52 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>, sean@mess.org,
        mchehab@kernel.org, thierry.reding@gmail.com, lee.jones@linaro.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211027061552.bb4fczniqp6b7amh@pengutronix.de>
References: <YXU2i0FtAGDRCMSu@fedora>
 <202110271450.Z8JPybLg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rmb5bhrqbowkq2gg"
Content-Disposition: inline
In-Reply-To: <202110271450.Z8JPybLg-lkp@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rmb5bhrqbowkq2gg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 27, 2021 at 02:07:19PM +0800, kernel test robot wrote:
> Hi "Ma=EDra,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on media-tree/master]
> [also build test ERROR on v5.15-rc7 next-20211026]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>=20
> url:    https://github.com/0day-ci/linux/commits/Ma-ra-Canal/media-rc-pwm=
-ir-tx-Switch-to-atomic-PWM-API/20211024-183502
> base:   git://linuxtv.org/media_tree.git master
> config: riscv-randconfig-r004-20211027 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5db7=
568a6a1fcb408eb8988abdaff2a225a8eb72)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/abea850df0b6436083fcaa0=
97ad3029a27aa62bb
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Ma-ra-Canal/media-rc-pwm-ir-tx-S=
witch-to-atomic-PWM-API/20211024-183502
>         git checkout abea850df0b6436083fcaa097ad3029a27aa62bb
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 ARCH=3Driscv=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>=20
> >> ERROR: modpost: "__udivdi3" [drivers/media/rc/pwm-ir-tx.ko] undefined!

This comes from the line:

	state.duty_cycle =3D DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * state.period, =
100);

where DIV_ROUND_CLOSEST expands to a normal division but state.period is
a u64. So this should use DIV64_U64_ROUND_CLOSEST I guess.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rmb5bhrqbowkq2gg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF47pUACgkQwfwUeK3K
7AlPOggAkyeIIAGunaqgkFp7xpgGw+6WztW81Jl+0mXPhZOotqss8CMVgqYCAECm
QHDO7jphXkZH6LMx4rA5s62tqXBxTSJww8OzTazW5HT4KmfsPjIs3flhhn6k1zfz
HWIbJXVDun8I0ccJawNMlipcK1dT82uYoJYOqoNmuBYnh20EvUG5L2LXBU97ALbm
zSEAQzfn51R+cXL9D0Yo3try0rnvnQOQhOfWytvyhWyBTZmnS24GVk6BK5GZvbje
I1a1AbqFb8nQ/OlZenQGXsc8BRGJfFf7Z3rEp9c4ZBP5lAIVghPiMg9GLZMYDdA5
rok3UA6Chb6Vxn8Mh/KWofrY09vIlw==
=LGgu
-----END PGP SIGNATURE-----

--rmb5bhrqbowkq2gg--
