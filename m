Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C80B345A24
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Mar 2021 09:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhCWIyM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Mar 2021 04:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCWIxm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Mar 2021 04:53:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F4FC061574
        for <linux-pwm@vger.kernel.org>; Tue, 23 Mar 2021 01:53:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l4so25735067ejc.10
        for <linux-pwm@vger.kernel.org>; Tue, 23 Mar 2021 01:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TSWIaDu0EOnZXUysXyenekiT8xiS8nS1eGTsxMx/0Y4=;
        b=ux2OyJTHVBMKeHQb2VnQ+p028P0KhuI61QK/Y4+ylaN9DHcCGXl8+ewtTf8ZL2h1Tt
         Z3jDqaUykxSPiMYxE8GgO3RlL3DzVMdxDlB/cLp6rCk0a8ZIBZkLshFxCrlYAaydBkAU
         LKCgEMQ3UMqaEYWg0TX1g0UP1gxlyx3jUARIYX9M+mobLov9LnaQXo+fHKgy/BkUNbCX
         FohJo59NFme1azbbBFqDAq3TaKUikeHoAa+VcDhof3NZidYD3+9f4JCmgGE/DLa2suOv
         +9G4GmXxW5LhoDU2yp7CaejxlNGZ1Ja1joeq4eAoQLXECPjyMEF384d6VTAKCY7MvXas
         LlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TSWIaDu0EOnZXUysXyenekiT8xiS8nS1eGTsxMx/0Y4=;
        b=ZfTN5BNsQGXVgSws8PJTiq4kdCU2Q+hi0T0v+9HK3c5IcnQk51BFxaWrXoQ/KTJgQB
         bBnmCpVN867wc3s4B4X0iOwRm3Ijf7G6zA+m03eT1Fzok52pqE82tsTMSJcIB8j2AMx0
         LAib/O+HRaPz4sBUrp+8Kc2JdJ+227CjsjeP/KRvCkjl+hchCSUHPifgLF2Wei6m3Kwo
         TM4MKjvzW+747YXYz/SS70B7n33wltq2vhHoDKtpYxh/WUMLUWeoYFcIUtdt+dNqGRwG
         Ejx3+MPpUP6KIyuXiyYkHTLwVa+EMtML2WBcU2LEH2QC2d1WpecO01OpXtGj/V5Ca1LB
         JavQ==
X-Gm-Message-State: AOAM531EYr/9nIp7JASZY3ZPfqkdMDB8QN/zqo91X5CZcQBfDIQPjGhz
        GuEzFQB92iHzl0K84JC2Yw0=
X-Google-Smtp-Source: ABdhPJx15cISdYo3JjRn8StSpOpHXav5CtaVYhU+Y7O1XuyOM/qhU/MtO4+RuA1Bhaws79i2ZM5FIA==
X-Received: by 2002:a17:907:1693:: with SMTP id hc19mr3804860ejc.28.1616489619196;
        Tue, 23 Mar 2021 01:53:39 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id o6sm12552063edw.24.2021.03.23.01.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 01:53:35 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:53:55 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 00/14] pwm: Patches I consider ready for the next merge
 window
Message-ID: <YFmso17v2N270Dd+@orome.fritz.box>
References: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
 <YFia9Q4lLIlKdEmf@orome.fritz.box>
 <20210323071929.GD2916463@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="odlMKT3xQKvhsdLj"
Content-Disposition: inline
In-Reply-To: <20210323071929.GD2916463@dell>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--odlMKT3xQKvhsdLj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 23, 2021 at 07:19:29AM +0000, Lee Jones wrote:
> On Mon, 22 Mar 2021, Thierry Reding wrote:
>=20
> > On Fri, Mar 19, 2021 at 11:28:38AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello,
> > >=20
> > > this is the set of patches that are open on the list for some time.
> > > Lee suggested to resend them.
> > >=20
> > > @Thierry: I'm unsure what is the best way to nag. Is it really
> > > resending? Or does this just result mostly in overhead because the
> > > patches are still open in patchwork and it adds copies to your mailbo=
x?
> > > (Another downside is that taking the patches from this thread results=
 in
> > > recording a newer Author Date compared to picking up the originals.)
> >=20
> > I use patchwork extensively for tracking, so merely resending patches so
> > that they float to the top of my inbox isn't useful in itself. Patches
> > do, by the way, float to the top of my inbox when you just reply to them
> > (e.g. by pinging). Resending a particular series is fine because it's
> > then easy to mark the old version as "superseded". Sending a collection
> > of patch such as this is a bit more annoying because now the duplicates
> > are spread about a bit more in patchwork, so it's a bit more work to get
> > patchwork cleaned up. But it's not that bad, so no harm done.
> >=20
> > Usually when I look at patchwork I will look at the A/F/R/T column and
> > the more flags I see there, the more likely I will be to go and apply
> > it. Anything else I will go and look at myself and comment and/or apply
> > or sometimes wait for someone else to review.
> >=20
> > Perhaps a better way to nag me would be to delegate patches that you've
> > reviewed or think are ready to me, which would make them stand out more
> > among the others.
>=20
> It's not Uwe's fault, it's mine.
>=20
> Since some of Uwe's patches had been left unreviewed for several
> weeks, I asked him to collect up all of his dangling patches and
> submit this resend for *me* to review.

Like I said, it's not a big deal. And I'm also aware that this is misery
of my own making, so no worries.

> As someone who does not use Patchwork, I find this to be the simplest
> and cleanest method of patch collation.  Going by your almost
> immediate reply, I guess it had a nice desired side-effect. :)

Indeed, it achieved the desired effect, so can't argue about its
effectiveness. =3D)

Thierry

--odlMKT3xQKvhsdLj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBZrKAACgkQ3SOs138+
s6HqdRAAvgaY8lfS3D3AEOqW7yN0VtUNm9hVXwR04ncssVT2olO0LnxsJ9FWcUyW
yPvX2Uc3mc/0NQwW2vppFbUBt7hXw/PEr9vwMTaar3I4+Z/xAMJiaNFXcx3v/hPG
6YUho+sQ179QSdgQNdo2+RMY7m/ZfEew2xtpGPnn68RDRSDSLHraW8AkOAiZy4hU
YeNHRYkr5mzRMQUr33bqGBZDYtSpx3xQABxnhrJ5ONbKsx7B02KQQcYTE8XajKDF
BnQrITGEBJWtbLVaYedUGSIjjhsp2eFNRmctPJyRsZY39ikHayl5cxcat743ejHC
cLWHJcukkTW3Pxa1QyTlK2OSafG67tWQwWKjp+T8FmiJOCQN/Wc1DpuJyEn2idaK
LxHPnxAyJrMeEKXWGHCZpBV06PJ9eDkwi/GnC4VFxp21uT5lMfJGzhmM2ZGM/lyI
P10dTTSKfriWn+NHfH0GIcnHixCx2CkXBYJeup+bjLXwl5aCNkDmoyCDotkHoRiv
WACNcm7uUwp0pq/K8agNV1K7g0tbjoJFxekqR+lMUNFPdNCSCQmMthumvJQuwpeg
B0p68braLGLcY9nCXoBuEtwdaw3Sj7azhKG1pY5Y06rK0E74s7yfaRNROConF0NC
ry5Fl3me1CmzpfcGlKUe5Wi5lrRmclXHbeUt7RNjqjCx9VPFQpE=
=m7ZA
-----END PGP SIGNATURE-----

--odlMKT3xQKvhsdLj--
