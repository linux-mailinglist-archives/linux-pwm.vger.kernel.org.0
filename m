Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3D0F565CC
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2019 11:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfFZJma (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jun 2019 05:42:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50767 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZJma (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jun 2019 05:42:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so1378496wmf.0
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jun 2019 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dJaS+JRhWAC0YQIQUjsJfUFh9g8TrQ8kxuOGWAXR1TU=;
        b=Kq/7fAOCaaLYOpTvBl53hXOEQIkm4b5rKulajRqyq4W5BY5WGQCMQ9yVmImJlb1HTI
         Jhh8DohmI9c0ipfaoxXD5DaeguhVaTgS3GC0SCccJPYUJUvsGtXxweNudEW4vtHz9kJh
         4rxnySz2YK6gsd1cc7DIE5Z6GP7DFH/1eBKu91rcpde5O1NgGbWfGIt/lXHcMVrgJarc
         W1d6+lQ4v76rIa/j6N+i55IYwdsYQUr24beJLw37UWvK9OI+gwp9UFKZ1tvKJ5fsZv/2
         DmMqteCTS/o9Byu++hd/fED6g5y3lDKw6tuGUddMJedI4IYPJGWfH8pnMNCJMuOsFEqX
         5orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dJaS+JRhWAC0YQIQUjsJfUFh9g8TrQ8kxuOGWAXR1TU=;
        b=i+M4Dxz6R1ou8yAJQviahQ310gQiD2dbTrUi1hxvUNyBEQ3y9ErIpy0i7xR3ETwrsk
         HeNY73Dgs5tcguEJNCO3RrEIaYLLFhhdZFbaJRpnKf3ayBmOsLrEoEuUprQoZWiKzZ1p
         DXDx5Sn/2cVTFAcV3yfEapC43skeVwG8JycL/IDVFnYSzYFD77f26KEJAejCyp6cF7yx
         vzpH77qIxQhQbuqFtd42KOslnGLX3fIfvMWDxViSntrfv7FbpAJ9oxPqMYVyCojn/JPN
         hHmywdbhn9qJjiraMtQVUqy1bW66La2ScymHrBxH/VcLWNqvY1S1rU92Uo+T4jfXyNOw
         vZ6Q==
X-Gm-Message-State: APjAAAVkvjwkZV9TcTKpzbcHbJocOZtML+peCeMeBpbxFHFI1DA3yu84
        Wzt+OxxDKAXIlYCgFMgMAec=
X-Google-Smtp-Source: APXvYqxLwMxFLKeaAKhuR7X+iP+jMn9binC/LGvs/x0mQNWnXF4Zx660VSzVeMtIJMYieTbxcLSAVQ==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr2188141wmb.130.1561542146777;
        Wed, 26 Jun 2019 02:42:26 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id r12sm19720005wrt.95.2019.06.26.02.42.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 02:42:25 -0700 (PDT)
Date:   Wed, 26 Jun 2019 11:42:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>,
        linux-pwm@vger.kernel.org, kbuild-all@01.org
Subject: Re: [pwm:for-next 36/37] drivers/pwm/pwm-fsl-ftm.c:324:3-9:
 preceding lock on line 305 (fwd)
Message-ID: <20190626094225.GA22424@ulmo>
References: <alpine.DEB.2.21.1906261042400.2523@hadrien>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906261042400.2523@hadrien>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2019 at 10:43:43AM +0200, Julia Lawall wrote:
> Hello,
>=20
> It seems like there may be missing unlocks on lines 324 and 328.

Indeed, the existing "return ret;" in the function seem to have been
overlooked when the lock was added.

I sent out a patch that should fix this.

Thanks for reporting!
Thierry

> ---------- Forwarded message ----------
> Date: Wed, 26 Jun 2019 12:23:38 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild@01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: [pwm:for-next 36/37] drivers/pwm/pwm-fsl-ftm.c:324:3-9: precedin=
g lock
>     on line 305
>=20
> CC: kbuild-all@01.org
> CC: linux-pwm@vger.kernel.org
> TO: Patrick Havelange <patrick.havelange@essensium.com>
> CC: Thierry Reding <thierry.reding@gmail.com>
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/li=
nux-pwm.git for-next
> head:   cb8338e4fe3a8278cee91f666d2155a0ce1dd82f
> commit: c9aad8a921c23054dc10e783829fe6ee86826101 [36/37] pwm: fsl-ftm: Mo=
re relaxed permissions for updating period
> :::::: branch date: 9 hours ago
> :::::: commit date: 9 hours ago
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
>=20
> >> drivers/pwm/pwm-fsl-ftm.c:324:3-9: preceding lock on line 305
>    drivers/pwm/pwm-fsl-ftm.c:328:3-9: preceding lock on line 305
>=20
> # https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pw=
m.git/commit/?id=3Dc9aad8a921c23054dc10e783829fe6ee86826101
> git remote add pwm https://git.kernel.org/pub/scm/linux/kernel/git/thierr=
y.reding/linux-pwm.git
> git remote update pwm
> git checkout c9aad8a921c23054dc10e783829fe6ee86826101
> vim +324 drivers/pwm/pwm-fsl-ftm.c
>=20
> b505183b Xiubo Li          2014-02-27  288
> c9aad8a9 Patrick Havelange 2019-06-12  289  static int fsl_pwm_apply(stru=
ct pwm_chip *chip, struct pwm_device *pwm,
> c9aad8a9 Patrick Havelange 2019-06-12  290  			 struct pwm_state *newstat=
e)
> b505183b Xiubo Li          2014-02-27  291  {
> b505183b Xiubo Li          2014-02-27  292  	struct fsl_pwm_chip *fpc =3D=
 to_fsl_chip(chip);
> c9aad8a9 Patrick Havelange 2019-06-12  293  	struct pwm_state *oldstate =
=3D &pwm->state;
> c9aad8a9 Patrick Havelange 2019-06-12  294  	int ret =3D 0;
> b505183b Xiubo Li          2014-02-27  295
> c9aad8a9 Patrick Havelange 2019-06-12  296  	/*
> c9aad8a9 Patrick Havelange 2019-06-12  297  	 * oldstate to newstate : ac=
tion
> c9aad8a9 Patrick Havelange 2019-06-12  298  	 *
> c9aad8a9 Patrick Havelange 2019-06-12  299  	 * disabled to disabled : ig=
nore
> c9aad8a9 Patrick Havelange 2019-06-12  300  	 * enabled to disabled : dis=
able
> c9aad8a9 Patrick Havelange 2019-06-12  301  	 * enabled to enabled : upda=
te settings
> c9aad8a9 Patrick Havelange 2019-06-12  302  	 * disabled to enabled : upd=
ate settings + enable
> c9aad8a9 Patrick Havelange 2019-06-12  303  	 */
> b505183b Xiubo Li          2014-02-27  304
> c9aad8a9 Patrick Havelange 2019-06-12 @305  	mutex_lock(&fpc->lock);
> b505183b Xiubo Li          2014-02-27  306
> c9aad8a9 Patrick Havelange 2019-06-12  307  	if (!newstate->enabled) {
> c9aad8a9 Patrick Havelange 2019-06-12  308  		if (oldstate->enabled) {
> c9aad8a9 Patrick Havelange 2019-06-12  309  			regmap_update_bits(fpc->re=
gmap, FTM_OUTMASK,
> c9aad8a9 Patrick Havelange 2019-06-12  310  					   BIT(pwm->hwpwm), BIT(=
pwm->hwpwm));
> c9aad8a9 Patrick Havelange 2019-06-12  311  			clk_disable_unprepare(fpc-=
>clk[FSL_PWM_CLK_CNTEN]);
> c9aad8a9 Patrick Havelange 2019-06-12  312  			clk_disable_unprepare(fpc-=
>clk[fpc->period.clk_select]);
> c9aad8a9 Patrick Havelange 2019-06-12  313  		}
> c9aad8a9 Patrick Havelange 2019-06-12  314  		goto end_mutex;
> b505183b Xiubo Li          2014-02-27  315  	}
> b505183b Xiubo Li          2014-02-27  316
> c9aad8a9 Patrick Havelange 2019-06-12  317  	ret =3D fsl_pwm_apply_config=
(fpc, pwm, newstate);
> c9aad8a9 Patrick Havelange 2019-06-12  318  	if (ret)
> c9aad8a9 Patrick Havelange 2019-06-12  319  		goto end_mutex;
> c9aad8a9 Patrick Havelange 2019-06-12  320  	/* check if need to enable */
> c9aad8a9 Patrick Havelange 2019-06-12  321  	if (!oldstate->enabled) {
> c9aad8a9 Patrick Havelange 2019-06-12  322  		ret =3D clk_prepare_enable(=
fpc->clk[fpc->period.clk_select]);
> b505183b Xiubo Li          2014-02-27  323  		if (ret)
> b505183b Xiubo Li          2014-02-27 @324  			return ret;
> b505183b Xiubo Li          2014-02-27  325  		ret =3D clk_prepare_enable(=
fpc->clk[FSL_PWM_CLK_CNTEN]);
> b505183b Xiubo Li          2014-02-27  326  		if (ret) {
> c9aad8a9 Patrick Havelange 2019-06-12  327  			clk_disable_unprepare(fpc-=
>clk[fpc->period.clk_select]);
> b505183b Xiubo Li          2014-02-27  328  			return ret;
> b505183b Xiubo Li          2014-02-27  329  		}
> c9aad8a9 Patrick Havelange 2019-06-12  330  		regmap_update_bits(fpc->reg=
map, FTM_OUTMASK, BIT(pwm->hwpwm),
> c9aad8a9 Patrick Havelange 2019-06-12  331  				   0);
> b505183b Xiubo Li          2014-02-27  332  	}
> b505183b Xiubo Li          2014-02-27  333
> c9aad8a9 Patrick Havelange 2019-06-12  334  end_mutex:
> b505183b Xiubo Li          2014-02-27  335  	mutex_unlock(&fpc->lock);
> b505183b Xiubo Li          2014-02-27  336  	return ret;
> b505183b Xiubo Li          2014-02-27  337  }
> b505183b Xiubo Li          2014-02-27  338
>=20
> :::::: The code at line 324 was first introduced by commit
> :::::: b505183b5117ce149c65ae62f8c00e889acafa69 pwm: Add Freescale FTM PW=
M driver support
>=20
> :::::: TO: Xiubo Li <Li.Xiubo@freescale.com>
> :::::: CC: Thierry Reding <thierry.reding@gmail.com>
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0TPfwACgkQ3SOs138+
s6HoLRAArC/5NkgXZfz4pJUMP1w8EuLSDHbkUrgM5N871mZXJzJ7LBAZMFCXGYEo
37/0a2AEUMHeSMxmALPukoFPRaPLHjrYKt3QlW84g68WWtWXx0pnVEraRznlHNXz
87JlpSQstL5zYfgqeHYPN4Kjltaz71+yWfNyCZ+jz9aWF9EazLe/GBEJ2/WNnJ26
PO4CNK44DOnP4OYyk6LrzPPGfe8KcONcbhmfvA9k7VHDgbvsdgqOoX9uhWx/QDco
/z7ugZyIlfZKjE5nbRkRblbvBaSf0WN0KFcBZQi5jvoe8fJN6XKT04pbEfshRfeJ
dlgnxSfPhcHKpsdQzuZLKfzmN6uGcDLGStozRcNPAqYInvcWZ+V+sZOMK0NM2XaM
cXVWGTkHHpJ9jpDHXGNd7Di/hwpF4lTJvFY1SY5IBQ4eVkC1J/qepRsGl/Ksj5UV
neUGe1Z6Cy1tM6yoCM3ZpR+vVLPdrdrwHGA3YEloCfL+/ypf/V3Gpyj7xDWabvkq
TqLrSSahaHTHbCyrzvjFh81ZTEST7SlzKSYrV2Xkek3B82SWa6oDFMIfabhymcBq
ZDlrW93qCf7O18GkOwAVSJWRStwvp85OaTLDp0aj3hAHejd9iBZOh8w/GXtka98c
3vgH6qgEgTVOrZZeMo2L0DQkiA3ZcdlSNXrJGfBg0R4VNl7J+6Y=
=wnbU
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
