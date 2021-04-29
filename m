Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F376536E881
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Apr 2021 12:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbhD2KSc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Apr 2021 06:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbhD2KSb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Apr 2021 06:18:31 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4CDC06138B;
        Thu, 29 Apr 2021 03:17:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d14so14060805edc.12;
        Thu, 29 Apr 2021 03:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ImTMkw4U5vtlYvJP6g+MoBmtSzH32s9jNzhywlLI9q8=;
        b=ZGRndCuRxRc7px6xkuB8MlKw2/zHecdpKlZIwJ0/jypH05+14aXbBR28GA/mpe4Um6
         vbk0a5/iPkuRZV7S2ZlOGEnz6647deSOsdzDXeU5sQkuwu0cf+LnYlIzEeMxSJbhcCyH
         dh3IFF5IOlV39fQ0bsHbHbN7vSrsE4h9NRwgQ7HdlXyFA45Pd1y+7es7dzYB6Rp2VFow
         DTEPDR/zcUK1WhZu6z8xNmIFfVky2xXA2ojiP4ResUUCo2FJ3th+ErEtI8fUo3Arw5ru
         vEe1XdT5EXrwf/f8ngk6ilQmON/D/Bl5UIMqzo6u0/SG78rhm7Z2nFEQ2EeNBW/HHyD2
         k3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ImTMkw4U5vtlYvJP6g+MoBmtSzH32s9jNzhywlLI9q8=;
        b=X8rHXzt+p3fYIj0eayiCSV0JU8LU38D/N/APGnd5IGyLgdaF2zF/k1eB0gz161wNth
         uMwSilQ7IbrB3asnFyueo+ZlL0Y1hwR5HE8paRzRn308R5Firra5OOjplfLwN34BW4xK
         KfpGJNbgqGPBCy0BNlizXmPpwn8+JeIFgCtWfaEUZbTrHUawLSFwvZ0/9TCRWvvkdkGe
         qyqQMtXAh5wt0JItESAG6xDMTckRHEa3+zpED24e7rncpv1dz4klYInZaDaN3sHjSWAq
         CuH+0ogeeqz4Iy5ByAZ0vYjH79VnLKaUlaJFe5kOlPtXC7D3T9B8obpnVZWK5G7TsAZ1
         Aniw==
X-Gm-Message-State: AOAM531eVZnFbJtR4wQenTPIAJc3ESBSABhXSmJlctvXPb23BGGEgkGC
        SMCiPFv0VLwnejiM0d036OU=
X-Google-Smtp-Source: ABdhPJwJdKyu6B3UXQoa7kFJqlmAR+7J2NX4I2qTcJh1EaMV9aQv0GG/kQAMbJIMUNo9NawMauOkaA==
X-Received: by 2002:a05:6402:2d6:: with SMTP id b22mr17274816edx.274.1619691462944;
        Thu, 29 Apr 2021 03:17:42 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id k12sm2006656edo.50.2021.04.29.03.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 03:17:41 -0700 (PDT)
Date:   Thu, 29 Apr 2021 12:18:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fenglin Wu <fenglinw@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, subbaram@codeaurora.org,
        collinsd@codeaurora.org, aghayal@codeaurora.org
Subject: Re: [PATCH 2/2] pwm: pwm-qcom: add driver for PWM modules in QCOM
 PMICs
Message-ID: <YIqH/eimua/gwDW8@orome.fritz.box>
References: <20210427102247.822-1-fenglinw@codeaurora.org>
 <20210427102247.822-3-fenglinw@codeaurora.org>
 <20210427170748.wglupc6zwrndalxs@pengutronix.de>
 <YImfkM/ll1nCmopq@orome.fritz.box>
 <20210429065213.inajpznvfxa2xsld@pengutronix.de>
 <20210429070653.GJ6446@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J6I+xEPlKn2g3FMY"
Content-Disposition: inline
In-Reply-To: <20210429070653.GJ6446@dell>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--J6I+xEPlKn2g3FMY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 29, 2021 at 08:06:53AM +0100, Lee Jones wrote:
> On Thu, 29 Apr 2021, Uwe Kleine-K=C3=B6nig wrote:
>=20
> > Hello,
> >=20
> > On Wed, Apr 28, 2021 at 07:46:56PM +0200, Thierry Reding wrote:
> > > On Tue, Apr 27, 2021 at 07:07:48PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > I would like to see the register definition to use a common prefix =
(like
> > > > QCOM_PWM_) and that the names of bit fields include the register na=
me.
> > > > So something like:
> > > >=20
> > > > 	#define QCOM_PWM_PWM_SIZE_CLK		0x41
> > > > 	#define QCOM_PWM_PWM_SIZE_CLK_FREQ_SEL 		GENMASK(1, 0)
> > > >=20
> > > > even if the names are quite long, its usage is less error prone. Ma=
ybe
> > > > it makes sense to drop the duplicated PWM (but only if all or no
> > > > register contains PWM in its name according to the reference manual=
).
> > > > Also maybe QCOM_PWM_PWMSIZECLK_FREQSEL might be a good choice. I le=
t you
> > > > judge about the details.
> > >=20
> > > Please stop requesting this. A common prefix is good for namespacing
> > > symbols, but these defines are used only within this file, so there's=
 no
> > > need to namespace them.
> >=20
> > I do consider it important. The goal of my review comments is to improve
> > the drivers according to what I consider sensible even if that might not
> > fit your metrics.=20
> >=20
> > Consistent name(space)ing is sensible because the names of static
> > functions are used in backtraces. It is sensible because tools like
> > ctags, etags and cscope work better when names are unique. It is
> > sensible because it's harder than necessary to spot the error in
> >=20
> > 	writel(PWM_EN_GLITCH_REMOVAL_MASK, base + REG_ENABLE_CONTROL);
> >=20
> > . It is sensible because the rule "Use namespacing for all symbols" is
> > easier than "Use namespacing for symbols that might conflict with
> > (present or future) names in the core or that might appear in user
> > visible messages like backtraces or KASAN reports". It's sensible
> > because then it's obvious when reading a code line that the symbol is
> > driver specific. It is useful to have a common prefix for driver
> > functions because that makes it easier to select them for tracing.
> >=20
> > > Forcing everyone to use a specific prefix is just going to add a bunch
> > > of characters but doesn't actually add any value.
> >=20
> > That's your opinion and I disagree. I do see a value and the "burden" of
> > these additional characters is quite worth its costs. In my bubble most
> > people also see this value. This includes the coworkers I talked to,
> > several other maintainers also insist on common prefixes[1] and it
> > matches what my software engineering professor taught me during my
> > studies. I also agree that longer names are more annoying than short
> > ones, but that doesn't outweigh the advantages in my eyes and a good
> > editor helps here.
>=20
> FWIW, I'm +1 for proper namespacing for the purposes of; tracing,
> logging and future proofing, even if it does add a few more chars.
> Less of a problem now the 80-char rule is waning.

I've mentioned this in other threads before, but in retrospect I suppose
I could've been more specific. For function names, even static ones,
yes, I agree a common prefix is better. But there's absolutely no reason
to enforce it for register definitions or local variables because the
symbols will never show up anywhere.

Thierry

--J6I+xEPlKn2g3FMY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCKh/0ACgkQ3SOs138+
s6Gd4Q//Tx9VahXAUfB9cMzMbyK+8akZj8xJgwRhL5iCR9XHAiacw67IXUcIUK4H
jSN1zuwjMFQc5K5qWZ1f8U/E7tsQOD/xxYJqDnsMtOxrCDO2/pitCGOcvQOSvKp2
fR9aQGI2Yj23uwOMZvgKF5dn0qrmDOIrrFvE2evZCncQIcHF8wf4i4VYBrebMlew
9pZmFAe+GTWvc/Pyto3g2oDw9cakRcTixuURAs7Es+HyvASMtUUgtT28AVkoMlNi
s/rF54/U4oJ6XBSbJMv+3FoXaLf6uhmp9ciH70piEW62eD9M9Ar50l+JfzokI04J
kC4jozCaxgvLLRmwiHcHMLlOC7joWJab9XhOxZX1nGemuoKWSKgnVJnHnKaxGwCh
bAh1jx4dDFwhpj+v/pCH3XHUcatpmfzPo9KTuIM+KmqecTGjYcKRDO0rwSmv4cLG
+98Sxpl5w6AlcpyZXXSc3F87K0qnpTjq+AA3lQ8g2dhjreCgxKrQcS4mOpfgi8k8
5NDoGv5wWI624GfUhos0fOqzoORNqHpKKvtrvEV/kA6PPa7LUJp954LDRcm+7hW2
g4QeV/BqjKyU8kM9MFGJMsKxiFetn6slzXgk3pUjAQxy3D9LEpmfL19El5wJcCrs
wvUKt1Kxbx/JD+oaHwggZmCvSbTja5mmg1xQP8wM0wNMzXxar5k=
=HT+U
-----END PGP SIGNATURE-----

--J6I+xEPlKn2g3FMY--
