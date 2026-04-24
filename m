Return-Path: <linux-pwm+bounces-8689-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIZvLwNK62mWKgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8689-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 12:46:27 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3BD45D544
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 12:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FD4D3002B46
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31772882BE;
	Fri, 24 Apr 2026 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFpfhwgD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75672D3EF2;
	Fri, 24 Apr 2026 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027562; cv=none; b=YuFeFxY4VY1KcvdRA6b87h6FKycLo76jhPNLFORWuhpPj66eCkSE4XLLQLnEAVitUZOaJR/cGx55zQHeyGSZeRL31DMwG7FQca8FL+jN3gP3+qyxBYA7zAeoIZN0xMPnrSE0KuBQTpWd3BepU6xQ0LCebp4ljlK/pvWLgJ5aOKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027562; c=relaxed/simple;
	bh=wdjDn556jbNQ7WzXeovxIVH/s2CXei4diJaRwgeH7JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVQbuar2yOmrJ2CwI/MwvFaNDtmD1nY9t/8rHWBtm+nE0uGynhsnNOior20KbvEOa6IWIMtLc2QbP2x4pf0kvGUXJlHuYd/xV323RxjxL6DgtGDj+Xscz5qI9ysJ2JDg6me+yRu3tBaVF75qgfx0egAcm+XiVAPwPi+SE3l1dTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFpfhwgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BF6C19425;
	Fri, 24 Apr 2026 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027562;
	bh=wdjDn556jbNQ7WzXeovxIVH/s2CXei4diJaRwgeH7JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFpfhwgDLwVhkonHJohzjlaMdgRTAV05QdGH90A4J3liKHg1pMfsHoIlIA8JYM4/u
	 KM5X9kK4PESEn1AMXMrr8e9TfO+Eqf2c63LsY/dR73mWFVuxOHH4iKTmcQDoAKhwsX
	 tvmDyC5AHyIJKb5kXi+LQLP4+Il4P/bOZBTeEQ1jDstDfgUavlZsFqlc7p0f6qSzBj
	 HkUUNMXXU/bQdRDaPPuPsIYhFRWA7ILKrMG5DaKJxtCV9JXU0WCUudSaQDq1w4zdPc
	 otMC2pBvlhRjkLcOf/hmdVvfOC/9xE/n7OORCFHJGdo790iqZFZdByPUlCp7dqDlvP
	 2EaQbZO3rfysA==
Date: Fri, 24 Apr 2026 12:46:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Sangyun Kim <sangyun.kim@snu.ac.kr>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: atmel-tcb: Cache clock rates and mark chip as
 atomic
Message-ID: <aetJZzTHd4RBcytw@monoceros>
References: <20260415093433.2359955-1-sangyun.kim@snu.ac.kr>
 <20260419080838.3192357-1-sangyun.kim@snu.ac.kr>
 <aedfEzeRH5tH0-Fb@monoceros>
 <20260422044940.tse3ek7jlv3x2dbt@nunu>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xeni4cw4nw33ej5e"
Content-Disposition: inline
In-Reply-To: <20260422044940.tse3ek7jlv3x2dbt@nunu>
X-Rspamd-Queue-Id: BC3BD45D544
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8689-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]


--xeni4cw4nw33ej5e
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: atmel-tcb: Cache clock rates and mark chip as
 atomic
MIME-Version: 1.0

Hello Sangyun,

On Wed, Apr 22, 2026 at 01:49:40PM +0900, Sangyun Kim wrote:
> > On Sun, Apr 19, 2026 at 05:08:38PM +0900, Sangyun Kim wrote:
> > > @@ -438,16 +441,33 @@ static int atmel_tcb_pwm_probe(struct platform_=
device *pdev)
> > >  	if (err)
> > >  		goto err_gclk;
> > >=20
> > > +	err =3D clk_rate_exclusive_get(tcbpwmc->clk);
> > > +	if (err)
> > > +		goto err_disable_clk;
> > > +
> > > +	err =3D clk_rate_exclusive_get(tcbpwmc->slow_clk);
> > > +	if (err)
> > > +		goto err_clk_unlock;
> > > +
> > > +	tcbpwmc->rate =3D clk_get_rate(tcbpwmc->clk);
> > > +	tcbpwmc->slow_rate =3D clk_get_rate(tcbpwmc->slow_clk);
> > > +
> >=20
> > Only one concern left: clk_get_rate() should only be called on enabled
> > clocks. I don't know the architecture details and how expensive it is to
> > have .clk enabled (or if it's enabled anyhow).
> >=20
> > If you're ok, I'd squash the following diff into your patch:
>=20
> That makes sense. clk_get_rate() should indeed only be used on enabled
> clocks, and your change is the simplest way to ensure correctness while
> respecting the clk API constraints. I=E2=80=99m happy with squashing your=
 diff
> into my patch.

Just for the record: I did that, the result is already in Linus' tree
at https://git.kernel.org/linus/68637b68afcc3cb4d56aca14a3a1d1b47b879369
and will be part of v7.1-rc1.

Best regards
Uwe

--xeni4cw4nw33ej5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnrSeQACgkQj4D7WH0S
/k7Z9Af/SgtokfuDRo/0L8At8pZsQlZ3YT0qGgOFnJfR41bAVy9or6XPJUqkqIwn
11iDGuNU8konxGfKY0lXxoBjRTFHIRED+IRHWuxuxGU1w4qgWYG24/6MvjI+BH+D
EraEB/abCs+/orMz96YRsEpp8LfrHO2Bie+GsqU10mOFn889NGDfkiAMQNy0zBsm
fI/rV9cP4lQthcSquYYk2ytoMexP+hiPa4TfWAuOgw5u3zXd0fZlI6Bb1Bgo7YLJ
c4kXKrDyv5ATCO80N9TuTSXKFl7apewuCIocorPcktQ6hdXWyQobSMEtCshRN+vJ
MxYt/zoTs74WqXGUnpu6aa202u+9Yw==
=oCpN
-----END PGP SIGNATURE-----

--xeni4cw4nw33ej5e--

