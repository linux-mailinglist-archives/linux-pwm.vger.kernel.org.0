Return-Path: <linux-pwm+bounces-7951-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0DAD3BA0C
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 22:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 904853000B79
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 21:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF0223B604;
	Mon, 19 Jan 2026 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slWirdLd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EFD2236EB;
	Mon, 19 Jan 2026 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768858409; cv=none; b=AjCiyCYeBHcQQrYS3ayOkXEBd0QlDefzoiGQRTQiSuKknhSN20JrjTYPE2g5qaHNsoIx3kqsKh9x7Gas3OqCB7JGHj+jm3iLk7OBGFlhFePZKf2dEa4Wk4fO6ZexabVLGe8rZMxfohClNStauXCzrAH0b0s4DJynqkomaW7ao6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768858409; c=relaxed/simple;
	bh=mEAQP/BhvUL9VConLfRhesq3COwjbVyjj6UAPVPKxcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9bXuptLXLdkiebUdG7vV4rYSeuMu55To7rFjjBC25cJLiC1l40rNVxwE+CoYBtc/E4LtYVmw2ehAF04VitY08k5qgBPCqmEc3+eyHMdWfu/2SyR6ppfDFHlUsmYuEsQlsXXPlufXJK5gSobWxZqOr2444DM6PGqYWbElu1yOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slWirdLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A73C116C6;
	Mon, 19 Jan 2026 21:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768858408;
	bh=mEAQP/BhvUL9VConLfRhesq3COwjbVyjj6UAPVPKxcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=slWirdLdpTfqNnMDZOkwimDfaAWBSMXsoAnSRZ56UwwA0TeYsTRKpxLY0pp7cu6as
	 jNcSmYTGsXbwWm4pBbSt+09O/cbBsLZsbGB8t+nEjEAuiLclovvl0SOk7LSF+q3hcS
	 f1Mdoanoe6dVwd+lcOTBtv+PFNit5pILCmOD8LHmgEbz6g16FD6CVW6OW9w72Pf6m8
	 +wrzUr7BYXRRSKrODgKeKEYGKyieewK1JMxGjuh5c2FeQhtIL/IH1C2wKn2njG8Bpx
	 g7OAxgHMHYYzmUtCwrPbQIMp5QQVic8pkvHz5fVJZgpZLpPbScP5vyChGf2qE3D8Jp
	 LQKGX2idbS1hQ==
Date: Mon, 19 Jan 2026 22:33:25 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Gokul Praveen <g-praveen@ti.com>, 
	"Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>, j-keerthy@ti.com, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, n-francis@ti.com
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
Message-ID: <xkhyvqemt7ox6s3kcwjx2qktwlrvdo2dbn2azlk6tdimjvclky@g3btsovrn5am>
References: <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
 <20260107194802.3917-1-rafael.v.volkmer@gmail.com>
 <60da27d5-5d85-4fbe-9b18-b7e74f9ab893@ti.com>
 <hjiyxkzimydqjrtte6r5kemfthwdmhtkysplsptm3npgwqiv4b@d6vlu2fhks37>
 <575bfd8e-9246-4acf-ba76-8d5a84689643@ti.com>
 <xdj2ceubkss3ingkxdvc64zqrcd3wzz2uxa6wqwgvilu2ykukc@hbn6tt2gnxj5>
 <741ec8db-7804-4f31-969b-10724ec06823@ti.com>
 <hvz5lw4xvujmdruoi2h2wk4dvanyg7y5xp5tp2rs4dygmza3s3@idcjbz6wbxh4>
 <29dc86d5-080c-4af2-8e19-99a137c55f2f@ti.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m7gvxx7im3ru63tn"
Content-Disposition: inline
In-Reply-To: <29dc86d5-080c-4af2-8e19-99a137c55f2f@ti.com>


--m7gvxx7im3ru63tn
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
MIME-Version: 1.0

On Mon, Jan 19, 2026 at 08:30:08PM +0530, Kumar, Udit wrote:
> Hi Uwe/Gokul,
>=20
> On 1/12/2026 12:52 PM, Uwe Kleine-K=F6nig wrote:
> > Hello Gokul,
> >=20
> > On Mon, Jan 12, 2026 at 11:21:50AM +0530, Gokul Praveen wrote:
> > > On 10/01/26 04:23, Uwe Kleine-K=F6nig wrote:
> > > > As I cannot reproduce the issue, can you please check if adding
> > > >=20
> > > > 	pm_runtime_get_sync(pwmchip_parent(chip));
> > > >=20
> > > > to the probe function makes the problem disappear? Also please boot=
 with
> > > >=20
> > > > 	trace_event=3Dpwm
> > > >=20
> > > > on the command line and provide the content of
> > > > /sys/kernel/debug/tracing/trace after reproducing the problem.
> > > sure Uwe, I will try this from my side.
> > >=20
> > > In the meantime, will you able to test the same on TI J784S4 EVM as t=
he
> > > issue was reproduced on this board.
> > I don't have such hardware, sorry. The boards with TI SoC on my desk are
> > only a Beaglebone Black and a BeaglePlay. (And I didn't setup the
> > BeaglePlay yet, it was already quite a hassle to make the boneblack work
> > with a recent kernel. In the end it looks trivial, but
> > https://salsa.debian.org/kernel-team/linux/-/merge_requests/1777 plus
> > unreliable netbooting in the bootloader took me several hours to sort
> > out.)
>=20
> I am able to see this issue on J7200 hardware ,
>=20
> LTM, it may work on certain devices, depending upon how LPSC (Local power
> state controller) and PSC (power state controller))
>=20
> are managed.
>=20
> In original code , while putting sync at
>=20
> https://elixir.bootlin.com/linux/v6.18.6/source/drivers/pwm/pwm-tiehrpwm.=
c#L293
>=20
>=20
> will leads to calling genpd driver [0], which may put PWM IP in powered d=
own
> state, leading to loosing contents.
>=20
> So, we need retain pm count (genpd on in fact) between config and enable
> call.
>=20
> Therefore this patch LGTM

I doesn't look good to me, it's way to complicated. Unless I still
misunderstand something, I think

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 7a86cb090f76..4942689105f3 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -378,6 +378,8 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
 	int err;
 	bool enabled =3D pwm->state.enabled;
=20
+	guard(pm_runtime_active)(pwmchip_parent(chip));
+
 	if (state->polarity !=3D pwm->state.polarity) {
 		if (enabled) {
 			ehrpwm_pwm_disable(chip, pwm);

is enough to fix the issue. (We need something like
https://lore.kernel.org/linux-pwm/20251123233349.2122-1-rafael.v.volkmer@gm=
ail.com/
to make this really robust.)

Best regards
Uwe

--m7gvxx7im3ru63tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmluoyMACgkQj4D7WH0S
/k7S1Af9HgRQ6/4rqZwBRWsiZ0MMm1TrPyaTcFAeRovLRxhqkripDyVsbBJacyjc
asgmYUWTTzcmQ7kRcNbEw0cFTOhmhYorMil1x3wxZXVhqOrQ6ksqcG59pIOPoKUH
fPwX91+ZAXqf+n8R2hg6tAPFhWKwbHhsdkQpWOIQHQLODzefvs6v0n8zP0NWTbVW
tbK6BrK1VF7+kpb2xZB1GSmjDkfjWOZymLlrT07HD6n5d9U4kF1P1P2h1I/9sfCm
dUI39M4qlaXLTZFF6IzaUTVMJO6Psq4Fbzapm36aLuxsqzExgQGdX4DLkD4OhaOH
vCJtO38Ql43En2otrkZMdaGMELSp8A==
=V5E+
-----END PGP SIGNATURE-----

--m7gvxx7im3ru63tn--

