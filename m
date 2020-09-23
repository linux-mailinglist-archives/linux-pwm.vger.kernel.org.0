Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538222757B8
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 14:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIWMLJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 08:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgIWMLJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Sep 2020 08:11:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1772EC0613CE
        for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2020 05:11:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so20743877wrn.10
        for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2020 05:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p/ifN60ejlHPkMbS3o7O8TU01AjDpjR8/cONGBOM55I=;
        b=gDyA+itJ2phejG2kaLvMA4fSorYM8TBQixgsL4VwvYAP/mrGSClecciRcLud3z79eP
         O/i3CO9SFN7ubC2NtbmXvg5BkDclOYOroRuurJ6X8if97CL1dBVFgD3XQkCFWDPXp7HS
         IxgQU7l9d8J40+2uL0l3kPJ+c1HLtkYO1CPtXF+j/NSQroh0+rRIzjtvl6Oy1ralokIR
         +CrYcByA/3IXdLrkkSLdavloc0m9MqmWNqRRwLeqME8vbskUPYIYef7L4EjdfIsPc7rc
         vBejHDI6dSHuohw5xTbtb5duP9WXJ/Fr/UkB2iXc3Yd3BVhqg6apnSowZmgfAZ/IE519
         F65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p/ifN60ejlHPkMbS3o7O8TU01AjDpjR8/cONGBOM55I=;
        b=bOINnRK0kv8eNCLqeH6j7O20vxNlxF0DtEhY0FJbKMB+javPKWkpKZ4wFfj05zzVdI
         GeWqnAEq9idOKUvILeIsSi08W79aGOAYVhOYf9kSkzfhLAQYomSI23fSjtWoCpPeOZuT
         1W8KNF2wKFFG1o778c85+InVzc50OkhLTnFpVsj8hTbU1AlJV2CRJslV35Bl53x512tJ
         4YAWcNf1WpBUfHPmLq4FwxJFfANWZ9ovcoSLOMXB9m7KfMQQ4j0DiVRoeUS5nl731eM4
         igts+saZW/CtJNrVpY3l9CqCGmbB6dXC5DlS1FDuxwaKIluYso/J/QD71QZELo5c+Uk5
         5d8g==
X-Gm-Message-State: AOAM530M8l7E2Kdo3ALpHET+KQFuDy8bOxcHbbJ7M6rr00nFpq3KPZ5z
        +kGLl8C70n0hnDH4Gy/U3ck=
X-Google-Smtp-Source: ABdhPJw5UPDhsxrXlYTwo/penMQk76Kxy02bJ8+HIlditbbofGmf4RNFZodWFp0e1KesPXU+c6l7bA==
X-Received: by 2002:adf:f5c1:: with SMTP id k1mr512289wrp.271.1600863067830;
        Wed, 23 Sep 2020 05:11:07 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id c14sm31219367wrm.64.2020.09.23.05.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 05:11:06 -0700 (PDT)
Date:   Wed, 23 Sep 2020 14:11:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH] pwm: Allow store 64-bit duty cycle from sysfs interface
Message-ID: <20200923121104.GC1848911@ulmo>
References: <20200824145539.3160946-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <20200824145539.3160946-1-jarkko.nikula@linux.intel.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2020 at 05:55:39PM +0300, Jarkko Nikula wrote:
> PWM core was converted to u64 by the commit a9d887dc1c60 ("pwm: Convert
> period and duty cycle to u64") but did not change the duty_cycle_store()
> so it will error out if trying to pass a numeric string bigger than
> 2^32-1.
>=20
> Fix this by using u64 and kstrtou64() in duty_cycle_store().
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> I don't think this qualifies for a Fixes tag since original commit doesn't
> cause a regression while still might be good for v5.9 material.
> ---
>  drivers/pwm/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9rO1gACgkQ3SOs138+
s6E4Gg//YwQddTs8G3WkUppT8WtY02IxU6w0Syw3Ift6g7zHQSqazu/ZZW34Ls2n
2cGhCCV5p/SKbUO8dC9UlkQZZril1N4p8x9HTVvevFQ8mERSrNNonW7HiaE7DBB8
czK3so05oh/eekdhLGmUtVcu4gN9zNYwBOoUuiP1PKpaq306BAxP120nRh5+DhTT
QsjGj25TTclFxSAbcC4IgqFDxoN9hP+VUMfQeJywe+ZjiCW4gSZy8b0v1zSQwirZ
mJdDmTWOA4kooTpIJJ9GlLxE6+78gSVrH2/zYSb6WZVLYRMJTqEwZm/fqJhCq7Fs
gzUjiyMJLd5ZxljA7DQ2jmE9dv2yYxKT3O1qEXDnpnLhLS8QK0NnDu+LBxQc9RnR
r9wJ2zn05da2/ktjVMsAhUUXD8atH46NQk9tXAK19knv75aJsWUxCTjCgeG9GK2g
dslhQzReYMeMD7J/qGspfzVZ/UORS7cdSwVfUGtPdoetZT7Wn9cKYsEzDoepL2T3
SbAJj3KeaTckXz1VLByUlAx62K6kUh0fAm5F4/24IBqzcqv43fWlor01qgX6Ssye
POSbah64W983GHSfLs2VsW96187qvsDI38FupdXvHyrpzyAzj9/30o0y195zLBoe
CJt8N/eU00pYJ/kEBWj0ThqjzijUwBr8BYDabvvo5eiE/QFVOY4=
=G9Su
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
