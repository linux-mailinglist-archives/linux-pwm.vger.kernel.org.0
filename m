Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B973697EC
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Apr 2021 19:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243237AbhDWRF0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Apr 2021 13:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243264AbhDWRFZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Apr 2021 13:05:25 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB04CC06175F;
        Fri, 23 Apr 2021 10:04:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g17so57531646edm.6;
        Fri, 23 Apr 2021 10:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yp0Fcm4ftjxsSpx+OMWSILWZbaBJSa4V9KKvmMfNtFk=;
        b=t4w9Merg1efC3mkVl8fmW75MKFTzIUHGYMFsFQI9yr6SD+0AHgRhFxzU1JgdgR/2ZB
         1kuGO+ZRGcNY7wrdTmpwaFai1FAMSQi5Mn6xmr20fMfUDxmsB4DITAWkHyIJp2WAYUNs
         FhOqslTv2JcT4pKfXpTF56AGIqReqMaUavVZR56ixQoZpQaUCbmJaDRcnZ5zg9s7QIfa
         PpboitbSfwBfEwzIiRMtJYriFBSzmPipqm5iw1jR3TZBHhoY9cSeJeoAsFOqJDT+y1D+
         9TCnI3xLX6BoLR4TXJrI2cibi7/lwi23dSdHZ3WEmdx+XZ+zONZrDXWgiE/bYYLKjbp0
         0HAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yp0Fcm4ftjxsSpx+OMWSILWZbaBJSa4V9KKvmMfNtFk=;
        b=Efx++3peN7vxRJrFGajX+gFwDu6UaIr6Ljkz70hddskAglQvBAcKeZYYelQ1zJOMz5
         jCCYvz7Dns38bV2a9EdiPuAZIuWMMGYVTix35GHj6ZGFuYCq3BZj2GMWRZwtssUdUfg0
         GVreOA3UOuhVNg2MyTf/m9uPx/4AahfWPxoKXIahBskeciZ3N1P+QlFrL5p+nXOKNXRU
         Ji0Bno0gAdCeZ8J25HN+XhcGcf9DcvjBmavhBpQYbFcIKC8ZiWq+auQIBEKZUDsB3QdW
         4dVeqsKL1mhg61Jre6By2F2Yo0tG46W7pyp1hIf6tMEKeD5lFyeI3rx+/5cZon+yZP48
         6WKg==
X-Gm-Message-State: AOAM530j4D8jPkls/Hg2miy/qvDTL1RHN48MvoLeJrjZrAGJZXfZsc4E
        GiE9fUSXjpDQP2C5fH5YW+g=
X-Google-Smtp-Source: ABdhPJyzyWxSdAyEIFimlcXfMU2ky29TPHyE2cUPGI/3diEAZcyN7IZZI+wAMpHiJgeHhB24Fj2H7A==
X-Received: by 2002:a05:6402:5111:: with SMTP id m17mr5867151edd.175.1619197487628;
        Fri, 23 Apr 2021 10:04:47 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id e11sm4470851ejn.100.2021.04.23.10.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 10:04:46 -0700 (PDT)
Date:   Fri, 23 Apr 2021 19:05:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
Message-ID: <YIL+Xwjbk1EE04Sm@orome.fritz.box>
References: <20210419000007.1944301-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OOXUOpActKFR3W/b"
Content-Disposition: inline
In-Reply-To: <20210419000007.1944301-1-nobuhiro1.iwamatsu@toshiba.co.jp>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--OOXUOpActKFR3W/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 19, 2021 at 09:00:05AM +0900, Nobuhiro Iwamatsu wrote:
> Hi,
>=20
> This series is the PWM driver for Toshiba's ARM SoC, Visconti[0].
> This provides DT binding documentation and device driver.
>=20
> [0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/imag=
e-recognition-processors-visconti.html
>=20
> Updates:
>=20
>   dt-bindings: pwm: Add bindings for Toshiba Visconti PWM Controller
>     v5 -> v6:
>       - No update.
>     v4 -> v5:
>       - No update.
>     v3 -> v4:
>       - No update.
>     v2 -> v3:
>       - Change compatible to toshiba,visconti-pwm
>       - Change filename to toshiba,visconti-pwm.yaml.
>       - Add Reviewed-by tag from Rob.
>     v1 -> v2:
>       - Change SPDX-License-Identifier to GPL-2.0-only OR BSD-2-Clause.
>       - Set compatible toshiba,pwm-visconti only.
>       - Drop unnecessary comments.
>=20
>   pwm: visconti: Add Toshiba Visconti SoC PWM support
>     v5 -> v6:
>      - Update year in copyright.
>      - Update limitations.
>      - Fix coding style, used braces for both branches.
>     v4 -> v5:
>       - Droped checking PIPGM_PCSR from visconti_pwm_get_state.
>       - Changed from to_visconti_chip to visconti_pwm_from_chip.
>       - Removed pwmchip_remove return value management.
>       - Add limitations of this device.
>       - Add 'state->enabled =3D true' to visconti_pwm_get_state().
>     v3 -> v4:
>       - Sorted alphabetically include files.
>       - Changed container_of to using static inline functions.
>       - Dropped unnecessary dev_dbg().
>       - Drop Initialization of chip.base.
>       - Drop commnet "period too small".
>       - Rebased for-next.=20
>     v2 -> v3:
>       - Change compatible to toshiba,visconti-pwm.
>       - Fix MODULE_ALIAS to platform:pwm-visconti, again.
>       - Align continuation line to the opening parenthesis.
>       - Rewrite the contents of visconti_pwm_apply() based on the content=
s suggested by Uwe.
>     v1 -> v2:
>       - Change SPDX-License-Identifier to GPL-2.0-only.
>       - Add prefix for the register defines.
>       - Drop struct device from struct visconti_pwm_chip.
>       - Use '>>' instead of '/'.
>       - Drop error message by devm_platform_ioremap_resource().
>       - Use dev_err_probe instead of dev_err.
>       - Change dev_info to dev_dbg.
>       - Remove some empty lines.
>       - Fix MODULE_ALIAS to platform:pwm-visconti.
>       - Add .get_state() function.
>       - Use the author name and email address to MODULE_AUTHOR.
>       - Add more comment to function of the hardware.
>       - Support .get_status() function.
>       - Use NSEC_PER_USEC instead of 1000.
>       - Alphabetically sorted for Makefile and Kconfig.
>       - Added check for set value in visconti_pwm_apply().
>=20
> Nobuhiro Iwamatsu (2):
>   dt-bindings: pwm: Add bindings for Toshiba Visconti PWM Controller
>   pwm: visconti: Add Toshiba Visconti SoC PWM support
>=20
>  .../bindings/pwm/toshiba,pwm-visconti.yaml    |  43 ++++
>  drivers/pwm/Kconfig                           |   9 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-visconti.c                    | 189 ++++++++++++++++++
>  4 files changed, 242 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/toshiba,pwm-vis=
conti.yaml
>  create mode 100644 drivers/pwm/pwm-visconti.c

Both patches applied, thanks.

checkpatch did complain when I applied:

> WARNING: please write a paragraph that describes the config symbol fully
> #9: FILE: drivers/pwm/Kconfig:604:
> +config PWM_VISCONTI

That seems a bit excessive. The paragraph is perhaps not a poster child
for Kconfig, but there are others that aren't better, so I think that's
fine.

> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #32:=20
> new file mode 100644

Fine, too.

> WARNING: 'loosing' may be misspelled - perhaps 'losing'?
> #112: FILE: drivers/pwm/pwm-visconti.c:76:
>  +	 * NSEC_PER_SEC / CLKFREQ =3D 1000 without loosing precision.
>   	                                         ^^^^^^^

I've fixed that up while applying.

> WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code ra=
ther than BUG() or BUG_ON()
> #127: FILE: drivers/pwm/pwm-visconti.c:91:
> +		BUG_ON(pwmc0 > 3);

I think that one is legit. I've turned that into:

	if (WARN_ON(pwmc0 > 3))
		return -EINVAL;

so that requests for too big period will be rejected rather than crash
the system. Next time, please run checkpatch before submitting and
eliminate at least the big warnings.

Thierry

--OOXUOpActKFR3W/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCC/lwACgkQ3SOs138+
s6GyZg//fJSJJDdj59dL5ufPtYkDzLvfPUP/5WuRD3JMyxANw11LWExaErgZmtC4
JDAsEWBPV0MwNKECyTpYiCJpKWOjer9lIw4oVCqbMeSjZBaRN7RJJb83j68v2tU0
ksaN8tGyOLz3UZnJRh3ExXQ3iAwYJcZDRFCjJTypc7Ve2kUdiK3FEv5uPfNpSK8a
o6DmGe2Lv78F/rn3VZzZtgA2kYsGu8UGW3LM0DygZ1zb/W60x0SlKWAEPfhpUVKV
+KKMMDlVcfp/G1/V3Iw8X0L1C/psC3QtwM8VFOQuml4EkCxGKF7BUbqxMWgQo/uh
5ugx5C48cZ4U2aDnfyc1M0Hy7bF3uuSck8PV8bEY6BSci5Wol3z2U27JsZpMKA24
8HmzBBVlc1l0an2Cd2nAf8osc3r+UKltAzHIBwi46gs43Pt0zc60b/mfu6CJA9V0
jlGXM5JTWtNxpEhshKvNtk8gpMVieeVC9o4Rh/U8PpZbEZThmBAisn7ygZWFyW7s
yff9YcV1EI4p5kUVgcBMR/04OBshPDfBz/hpoyzT4t9I6KT6DlSWjB8h94QX71zD
z+SsL/5YprPAl0QqdzZUvDO+pu8PBVidu12222hnICrgK6u1WcU/My44GgXul22o
kArqNPZWJvW6GEm5DofV8zvo4mfEfXns2mhOgGE9d4FuhNtumic=
=YER4
-----END PGP SIGNATURE-----

--OOXUOpActKFR3W/b--
