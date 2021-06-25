Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E4E3B4048
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 11:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhFYJZr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Jun 2021 05:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhFYJZq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Jun 2021 05:25:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6CBC061574
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jun 2021 02:23:26 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwi3O-0004zV-6b; Fri, 25 Jun 2021 11:23:14 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwi3K-00013q-3p; Fri, 25 Jun 2021 11:23:10 +0200
Date:   Fri, 25 Jun 2021 11:23:09 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     kernel test robot <lkp@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, kbuild-all@lists.01.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 1/3] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <20210625092309.b5lv4v4hth4prh5z@pengutronix.de>
References: <f97c32aa98c9cdd977fac22cd504ad97448949e9.1624348502.git.baruch@tkos.co.il>
 <202106222154.DXCnEs3v-lkp@intel.com>
 <87zgvh95g9.fsf@tarshish>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="int4ugq3un2gn2yx"
Content-Disposition: inline
In-Reply-To: <87zgvh95g9.fsf@tarshish>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--int4ugq3un2gn2yx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 22, 2021 at 08:25:58PM +0300, Baruch Siach wrote:
> Hi lkp,
>=20
> Thanks for the report.
>=20
> Adding m68k maintainer to Cc.
>=20
> On Tue, Jun 22 2021, kernel test robot wrote:
> > I love your patch! Yet something to improve:
> >
> > [auto build test ERROR on pwm/for-next]
> > [also build test ERROR on robh/for-next v5.13-rc7 next-20210621]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:    https://github.com/0day-ci/linux/commits/Baruch-Siach/pwm-drive=
r-for-qualcomm-ipq6018-pwm-block/20210622-155719
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/=
linux-pwm.git for-next
> > config: m68k-allmodconfig (attached as .config)
> > compiler: m68k-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/0day-ci/linux/commit/9fe01901cd004c6d48de5=
41eb67dd006243c9220
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Baruch-Siach/pwm-driver-for-qu=
alcomm-ipq6018-pwm-block/20210622-155719
> >         git checkout 9fe01901cd004c6d48de541eb67dd006243c9220
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cr=
oss ARCH=3Dm68k=20
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >
> >>> ERROR: modpost: "__divdi3" [drivers/pwm/pwm-ipq.ko] undefined!
> >>> ERROR: modpost: "__udivdi3" [drivers/pwm/pwm-ipq.ko] undefined!
>=20
> That is most likely related to the div64_u64() call. The sh arch also
> showed a similar issue on v2:
>=20
>   https://lore.kernel.org/linux-pwm/202105250028.jIIxG5w6-lkp@intel.com/
>=20
> What is the right fix here? Isn't div64_u64() universally available? I
> see quite a few calls under driver/pwm/. Should the driver depend on
> some per-arch Kconfig symbol?

There is in your driver:

       u64 period_ns, duty_ns;

       ...

       freq =3D NSEC_PER_SEC / period_ns;

which might be the problem. / doesn't work for u64 in the kernel.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--int4ugq3un2gn2yx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDVoHoACgkQwfwUeK3K
7Ak7Wwf+KhGGFk3RpBvzrIT+s+s1n7taeYb1xhbWwajIgrLnMksghUy2PP00O54R
dSFCd9sVBYIA9FJoOyvp2VcItP6EKoxg26iS6MaSQ0UctmXkZkgjawLAwM1ZYcbA
Kb5h56Z1sIJM+SaDjOepWynL6cCPO3aEyNaNly6vil7i1MVRRotsNsfpjQu70h4E
4UOadJB5mcjQ6cZir78VNY/cwoWdj6gYM8lNW10kmK297K/cWExcyBkoVy9tCSLo
xhzdWJXEQ6AbiX+nMNNt9wu4ohkoVMid18EzL5iWpClk0NvX+PQq3Dv0byYKZN4F
8/SVeY9gEquC8sKvgjA4RHPi69vQsg==
=CCui
-----END PGP SIGNATURE-----

--int4ugq3un2gn2yx--
