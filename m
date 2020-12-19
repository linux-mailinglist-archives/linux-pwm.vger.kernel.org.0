Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672DD2DEC8A
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Dec 2020 01:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgLSA6X (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Dec 2020 19:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgLSA6X (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Dec 2020 19:58:23 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C9FC0617B0;
        Fri, 18 Dec 2020 16:57:42 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c5so4546151wrp.6;
        Fri, 18 Dec 2020 16:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Td55Oeit3N9imCisD2GbUqp3NAMaC5VmhvHn2GBbmd8=;
        b=VS4LntTIrB7TYNvSUqjeRYHBpnD5DXazoY9w3tacwo083sLLAVpv1CMP3+Mrs73LoG
         ZEQ0cJjMX6WyKZyJ2Eefi+umAVEpwDoSWtsSsPXA6HtBYzXlgP9CoXBN6gVkULm0TRzJ
         NoAckKMFRjJvBgz9OHV1QrVpTkexoDqs2p5h48Oefrh8KcUxZZs2f/nZO1TLcIRxcFBA
         OnJpLhFibE1fA11/g7MC6kqzAOErl2vGwbqaZDHAu6r9Src6ObnLVuU60dRUHP+6+W96
         jYizioVWV77T0Z+e+SnRMbRpbTIZJBfooDq5t7lRy9k8VsfrbkPZrt4HbsB0i9ByhlLC
         mt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Td55Oeit3N9imCisD2GbUqp3NAMaC5VmhvHn2GBbmd8=;
        b=lcg9j5EHAbZM7uA1J1BU+j+4uWMTFpPJ7sYxBaHmtEu08Z+l+AdN6fDO85+qTZYf0w
         oq229TAthFoKcfTpGT5peJHfikg4pDSpT6RZl5jDN7SR6C/tM1p6V9bnUWmlSg2x8Bl/
         HsQ4VWRjuOevqakd6dAAR8aNFLCxHCllkAU1HGgGpyvuSltS7AJGbjNbcKS7betL3syk
         xIxnBlGzNAilS5SMGs9TUoiqwIb2Cwv6KIUttuaHEl605+JgbgynAy2KxEWwFFvK822K
         TCKu/vVjNLrHPjNL74ETi6CcLvy1bDxfdiGDpYEN29yPybT9FLuTcubngKRMYs2BzkW+
         rQQg==
X-Gm-Message-State: AOAM533PDwYEqUF2GFClazFMqEtkkaMa+8bJ8S311KQR4Vjhg7vTjT61
        qp9hNfh8WjeSo10fZLeo/io=
X-Google-Smtp-Source: ABdhPJyNIdfhgIk/joQM/aoEInCJTIPtkAOyu55ox6fJcLiZPh+GtCWzs6y28ZxIrDJV8C6CHyrZeg==
X-Received: by 2002:adf:a1d5:: with SMTP id v21mr7065554wrv.24.1608339461625;
        Fri, 18 Dec 2020 16:57:41 -0800 (PST)
Received: from localhost (pd9e5183e.dip0.t-ipconnect.de. [217.229.24.62])
        by smtp.gmail.com with ESMTPSA id z2sm13637018wml.23.2020.12.18.16.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 16:57:40 -0800 (PST)
Date:   Sat, 19 Dec 2020 01:57:39 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] pwm: Changes for v5.11-rc1
Message-ID: <X91QA5bXgPXCiS8U@ulmo>
References: <20201218160401.2478999-1-thierry.reding@gmail.com>
 <CAHk-=wgfVj3n5qftaLwk3ZiMiKooO-vzk_XHbcRKPCpBWbtq7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UuKmZbsSpvb8Shtk"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgfVj3n5qftaLwk3ZiMiKooO-vzk_XHbcRKPCpBWbtq7w@mail.gmail.com>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--UuKmZbsSpvb8Shtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 18, 2020 at 12:35:09PM -0800, Linus Torvalds wrote:
> On Fri, Dec 18, 2020 at 8:04 AM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > This is a fairly big release cycle from the PWM framework's point of
> > view.
>=20
> Why does all of this have commit dates from the last day?
>=20
> It clearly cannot have been in linux-next in this form, at least.
>=20
> I pulled and then unpulled. Don't send me stuff that hasn't been in
> next without a _lot_ of explanations for why, most certainly not the
> week before Christmas.

I didn't realize that this would show up as all new commits. The reason
why this happens is because the first commit in the tree is a fix for an
issue for which Uwe had sent an alternative patch to you directly for
inclusion in v5.10.

After going over the patches again as I was preparing the pull request,
I realized that the commit message was no longer accurate, so I changed
the commit message of the first commit, which then caused all of the
subsequent patches (i.e. all of them) to be rewritten.

The only change that hasn't been in linux-next for at least a week is a
bugfix I merged two days ago. The rest should be identical except for
the commit message on that first commit.

For reference, here's a diff on my for-next branch that the pull request
is based on, compared to what it was like a week ago:

	$ git diff for-next@{8days}..pwm/for-5.11-rc1
	diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
	index cc1eb0818648..ce5c4fc8da6f 100644
	--- a/drivers/pwm/pwm-sun4i.c
	+++ b/drivers/pwm/pwm-sun4i.c
	@@ -294,12 +294,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
	=20
		ctrl |=3D BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
	=20
	-       if (state->enabled) {
	+       if (state->enabled)
			ctrl |=3D BIT_CH(PWM_EN, pwm->hwpwm);
	-       } else {
	-               ctrl &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
	-               ctrl &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
	-       }
	=20
		sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
	=20

And that corresponds to the topmost patch.

I hope this clarifies things, and sorry for not mentioning this in the
pull request.

Thierry

--UuKmZbsSpvb8Shtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/dUAMACgkQ3SOs138+
s6HJVA//eFJ4uSIFAPO7Bw0dLCDxoZORAAMg/p+L/R7impss3wcHWwoeSMbnZjjT
2ILjl7ROTjacWx/AAp6NIgVNqS//NBsjBvE8LbArGh3NrXnmyptSNr+qa8h2Z2LH
s2qM3iri5QhlviCXpowbFG9kLParbASD3Swmfmw7tD0ObtX+ooa67Im8gP7Gj/w/
V/kLdFLVsaKHAOUcvVGVLTGMRkzPQZ8C+HCl37nHos3p7bHRwGfXXeaaCgjqpX+G
szgf9skGUwCSAKFpfdWrzuOS8uxXs2jk2ofMjy8UhhH+GAHt3XkXZ/ikV7ax+wmP
rlnOQfproPcBL1d56C7KqU6GBcHd1kWAzoy8oOWE2H5QhEqZa0V6agcQCLVfVzn2
WFgRJwXCcIrHGBFIdxzzG91xJrIynJ+rBcxnu1lGFya2bVGTyuPV6FrhboK2CGvB
ASQ90s2Kraz3vf3BaZ0GpKPUvIp7gvY6YErCq9IRYMOBJnueKeuWaM/9nnKfllZj
m0x/unAo5+UKjxeAv09Hm6UqNMwd75FU1ZjY2DcYLyDjokkBCYzcUMEr3CROZvHf
xYALLsJGL9YHqaKHy7sz9WyMMLKF1Y0uOppCf6aihMgyu4FxsBU1c1C6En1lDeAM
2S7Mhow28rJ859TU/IEaRdgqjTFvjDmcu+Bna7yAOhvrvQ/Kl+M=
=TJmD
-----END PGP SIGNATURE-----

--UuKmZbsSpvb8Shtk--
