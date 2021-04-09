Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3391359E88
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 14:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhDIMYW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 08:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDIMYW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 08:24:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D07DC061760;
        Fri,  9 Apr 2021 05:24:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w23so6324229edx.7;
        Fri, 09 Apr 2021 05:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dDmmuOMnrTstdQHLcak7JJ08nQ33vOnMIv2U8P95spE=;
        b=iMm27RJjZpAnS1VjwjNFdEdlorvTwevDfiANV6EBz84mi1L9Ympa/MEL45nLob0r5U
         SLw1cAa/mcaLCCudi3m3kCtphAU3NuZl4DDSlo8xCMY0kd2Tm5Mnm5U5B1+bHkypbJH4
         irU80VH9KgyZjv7FuzP/IDfFmr2rzgBFamd6lx+OwThKIHxFxPjbg5C0EUiQlxewiVw/
         MKxUQ+OFKpMqSA1eUDXqdBRSUd6nRn5oC2wna7hCne4xo9Rs+Ryl7oCqYYpyDBPc7Kil
         maDL0YpDmSJVrObWzO89A7t8EqPB5Y7PTxNnguM6+/TV0+BdmT5YSOKdcTY2v6MBq01d
         +YGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dDmmuOMnrTstdQHLcak7JJ08nQ33vOnMIv2U8P95spE=;
        b=FyaEuEm86Y1+0Q+6zihGWlYK3qeYT1+03m8Sb2TiQG1nQrv+oyGsNnocDieTBtvUNt
         yn1qsVtwTVd+86TcC4v34BpzZc37HS9cAU2zh4/3om1UcZDFbfeyVki9yAMlVB0Fjib4
         5Ys43v+Ejr+0Z2R35Z58Jy68yManOoVpzn54GU8Svp1WT50DcPE9ezSPUkehW0gh+g0I
         YL+edgf/kH7wYjOU18mbHJ01MqQne/WKPUBG4mt4S0LmLKHgJ79tfBGWEc0CcAP0kR9I
         n1/JxFZfOblJ9zdWK+nPgLoCrOKEH3k6H6asNEp6OTPG1GVJ8NsmLxpe2kelk6uE33oh
         aCLA==
X-Gm-Message-State: AOAM5308+9EFPJ0UWkDsS6kO50eFVHS1w5Dyp9gTHt7X8AgLm6lgO2oL
        vBja+J2Z3E1s/dhDds+9UDs=
X-Google-Smtp-Source: ABdhPJw1UQ8t+I94zh+tUqUsDHSoeO2DCGHzyhF75nSRTJ1hIv1N/Mwn2ysHBEgVkMwveeTttbR0/g==
X-Received: by 2002:a05:6402:1a2b:: with SMTP id be11mr8900562edb.304.1617971048229;
        Fri, 09 Apr 2021 05:24:08 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id p22sm1159691eju.85.2021.04.09.05.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:24:07 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:24:43 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [v3,PATCH 3/3] pwm: mtk_disp: implement .get_state()
Message-ID: <YHBHizYI7oyULZx9@orome.fritz.box>
References: <1617703062-4251-1-git-send-email-rex-bc.chen@mediatek.com>
 <1617703062-4251-4-git-send-email-rex-bc.chen@mediatek.com>
 <20210406102756.4kncasxe4um3q6wi@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IeOqv4HFT+wQMYyn"
Content-Disposition: inline
In-Reply-To: <20210406102756.4kncasxe4um3q6wi@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--IeOqv4HFT+wQMYyn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 12:27:56PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Apr 06, 2021 at 05:57:42PM +0800, Rex-BC Chen wrote:
> > implement get_state function for pwm-mtk-disp
> >=20
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
>=20
> Ideally you S-o-b line is the last one to show the order in which this
> patch went from one person to another.
>=20
> > ---
> >  drivers/pwm/pwm-mtk-disp.c | 46 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> > index 502228adf718..166e0a8ca703 100644
> > --- a/drivers/pwm/pwm-mtk-disp.c
> > +++ b/drivers/pwm/pwm-mtk-disp.c
> > @@ -179,8 +179,54 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chi=
p, struct pwm_device *pwm,
> >  	return mtk_disp_pwm_enable(chip, state);
> >  }
> > =20
> > +static void mtk_disp_pwm_get_state(struct pwm_chip *chip,
> > +				   struct pwm_device *pwm,
> > +				   struct pwm_state *state)
> > +{
> > +	struct mtk_disp_pwm *mdp =3D to_mtk_disp_pwm(chip);
> > +	u32 clk_div, period, high_width, con0, con1;
> > +	u64 rate;
> > +	int err;
> > +
> > +	err =3D clk_prepare_enable(mdp->clk_main);
> > +	if (err < 0) {
> > +		dev_err(chip->dev, "Can't enable mdp->clk_main: %d\n", err);
> > +		return;
> > +	}
> > +	err =3D clk_prepare_enable(mdp->clk_mm);
> > +	if (err < 0) {
> > +		dev_err(chip->dev, "Can't enable mdp->clk_mm: %d\n", err);
> > +		clk_disable_unprepare(mdp->clk_main);
>=20
> As before: %pe please

According to the documentation %pe only works on pointers for which
IS_ERR() is true, so I'm not sure it can be used with plain integer
error codes.

Looks like there's a bunch of drivers that will do %pe and then use
ERR_PTR(err) to make this work, but to be honest, that seems like
jumping through hoops.

But I don't feel strongly either way, so choose whichever you want.

Thierry

--IeOqv4HFT+wQMYyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwR4gACgkQ3SOs138+
s6H28RAAjleBEqp+dx8paKdyG8VdIU9HykF82fycv6g3VrCecRf53SQtxA7boouL
ZwXKfG14xpSZe6RGEhlG3s4CLwzQQVnoVn/pp2hIGwJHB58lXYKZ7RlUUvhKxov9
J341uNYUPUkBheLIkgbF44ohGIRH8YV107LdI2KpYLZP7Q0cyX7B6tat5VTxH7R9
l2TGrEjpzpXjwx1k1zhTnIubJNwTqYGAnat2WpGDTWsBrL3Bm1u9i7kkYEfrYuvp
LUGiQuZTbIlFY5xU8A+7+4oNVwkEI4k+yQeltm5dS4TNH1JPeA8iX87B8WIaOQ30
tO8rufvyeU+mfkwmZw7gxU6uQoBNip9K9hksXP6ufxz9mQk/7EDYDvltQeFWLQE1
P0Iop2JaL7WVWRwVYoG/K4tlkwDV88LgVxSNq7I/VoXe8b+yOXsaYCxcOKfWdEDz
FjgYDq8i2FiA/twxnAopPtFWZhyctrTokPU7JRv9wNCkFG+7V4kjbtQNcE/STGic
bsuPg1MN0iev2oDsXEolXhLorZNkREpfOjTc15jUmunEWjf/V6/m1aEKaodhjptq
bGNcXEWogDc9ZwJbi59KR8GDhClYLfdBRfGTBLazdX5iZ/63pOk2nCHF353EEldm
jN3Ca0o0VnHUcc9HzMdZEaPMvGgh3SZs3/rcivNtIZSyModYZf0=
=NX8J
-----END PGP SIGNATURE-----

--IeOqv4HFT+wQMYyn--
