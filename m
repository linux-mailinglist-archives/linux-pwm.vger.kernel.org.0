Return-Path: <linux-pwm+bounces-8444-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id K8jzGyl7y2lPIQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8444-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 09:43:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D682C365658
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 09:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DB9130312E5
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 07:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F8A3C8715;
	Tue, 31 Mar 2026 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi+c8SJx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012123BE16E;
	Tue, 31 Mar 2026 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942564; cv=none; b=AvzUFfpDoCbhg4EGUfZW0El/6ifzDoioHfo7EWPr8EVwm89ZHMzev2um5Ja6s2YOGJEcZUuJBVz/0ZTIrhAhU4f202egCMQCIzQf1YbAYq/L6lKskyniwVXvUacc8662DH6kA1isgUAUU1wYNNvxGfL70Lu7xcnxhAOOVEVDtUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942564; c=relaxed/simple;
	bh=6k307i8VwvH6rWKWKxaJdayRee/mTSIw9CfTlwbA7DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtdEGDPgD+xQ179kjTTs0jpQ0jGsDieuVF6cOUIHSEY5x6b3ISe2lw5vgwB77AoM5a7zZBkAR7+VRTeOV5/X1fjr/1PaFH443KeJUQj3p7Fl8K5deYgzfN+FwethYSd/zl1VnHqvfevtRm0NstpD/piGUugELRzIu41FUJanc6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yi+c8SJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0115FC19423;
	Tue, 31 Mar 2026 07:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774942563;
	bh=6k307i8VwvH6rWKWKxaJdayRee/mTSIw9CfTlwbA7DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yi+c8SJxLD6zktj4xmcJnTeBTrS5Z3m6a2peMCn+4MPnOnLw12SHVRvJGaBZHItzv
	 aBXL841caAnJDe94vvGKySmTaWpsbFwyVY396ytCJVJ9MegI1c8olv4PcFHH8M0vEB
	 MviKDAMo4RqrulRuUG8lPUnEuJiPli51E5UeIH5X6tP6Og7y9UOOdlkZVP5i5iIedE
	 MrbxCbeSvq7RCANmHDp0Ojpo/Qj8S5n06edP6QaVB2RXfmzxaoJj3fd4Dgt9Aka0KM
	 ULpLTRRD7WazSGRBcoZpGIHOjg6s+fnfwMQv9qQaYmjjTaFYE007K6kjTlwhEMrb0a
	 xETFvf+7uOTvg==
Date: Tue, 31 Mar 2026 09:36:00 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH v4 6/7] pwm: tegra: Add support for Tegra264
Message-ID: <act4lQhiy2x3Qzx9@orome>
References: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
 <20260331-t264-pwm-v4-6-c041659677cf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dpacxmcdjmza7u6p"
Content-Disposition: inline
In-Reply-To: <20260331-t264-pwm-v4-6-c041659677cf@nvidia.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8444-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,nvidia.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierry.reding@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,pengutronix.de:email]
X-Rspamd-Queue-Id: D682C365658
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--dpacxmcdjmza7u6p
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 6/7] pwm: tegra: Add support for Tegra264
MIME-Version: 1.0

On Tue, Mar 31, 2026 at 11:12:18AM +0900, Mikko Perttunen wrote:
> Tegra264 changes the register layout to accommodate wider fields
> for duty and scale, and adds configurable depth which will be
> supported in a later patch.
>=20
> Add SoC data and update top comment to describe register layout
> in more detail.
>=20
> Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
> Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/pwm/pwm-tegra.c | 75 ++++++++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 61 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index d7968521fbfd..c9d30724e339 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -7,22 +7,60 @@
>   * Copyright (c) 2010-2020, NVIDIA Corporation.
>   * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer <s.hauer@pengutronix=
=2Ede>
>   *
> - * Overview of Tegra Pulse Width Modulator Register:
> - * 1. 13-bit: Frequency division (SCALE)
> - * 2. 8-bit : Pulse division (DUTY)
> - * 3. 1-bit : Enable bit
> + * Overview of Tegra Pulse Width Modulator Register
> + * CSR_0 of Tegra20, Tegra186, and Tegra194:
> + * +-------+-------+----------------------------------------------------=
-------+
> + * | Bit   | Field | Description                                        =
       |
> + * +-------+-------+----------------------------------------------------=
-------+
> + * | 31    | ENB   | Enable Pulse width modulator.                      =
       |
> + * |       |       | 0 =3D DISABLE, 1 =3D ENABLE.                       =
           |
> + * +-------+-------+----------------------------------------------------=
-------+
> + * | 30:16 | PWM_0 | Pulse width that needs to be programmed.           =
       |
> + * |       |       | 0 =3D Always low.                                  =
         |
> + * |       |       | 1 =3D 1 / 256 pulse high.                          =
         |
> + * |       |       | 2 =3D 2 / 256 pulse high.                          =
         |
> + * |       |       | N =3D N / 256 pulse high.                          =
         |
> + * |       |       | Only 8 bits are usable [23:16].                    =
       |
> + * |       |       | Bit[24] can be programmed to 1 to achieve 100% duty=
       |
> + * |       |       | cycle. In this case the other bits [23:16] are set =
to     |
> + * |       |       | don=E2=80=99t care.                                =
               |
> + * +-------+-------+----------------------------------------------------=
-------+
> + * | 12:0  | PFM_0 | Frequency divider that needs to be programmed, also=
 known |
> + * |       |       | as SCALE. Division by (1 + PFM_0).                 =
       |
> + * +-------+-------+----------------------------------------------------=
-------+
>   *
> - * The PWM clock frequency is divided by 256 before subdividing it based
> - * on the programmable frequency division value to generate the required
> - * frequency for PWM output. The maximum output frequency that can be
> - * achieved is (max rate of source clock) / 256.
> - * e.g. if source clock rate is 408 MHz, maximum output frequency can be:
> - * 408 MHz/256 =3D 1.6 MHz.
> - * This 1.6 MHz frequency can further be divided using SCALE value in PW=
M.
> + * CSR_0 of Tegra264:
> + * +-------+-------+----------------------------------------------------=
-------+
> + * | Bit   | Field | Description                                        =
       |
> + * +-------+-------+----------------------------------------------------=
-------+
> + * | 31:16 | PWM_0 | Pulse width that needs to be programmed.           =
       |
> + * |       |       | 0 =3D Always low.                                  =
         |
> + * |       |       | 1 =3D 1 / (1 + CSR_1.DEPTH) pulse high.            =
         |
> + * |       |       | 2 =3D 2 / (1 + CSR_1.DEPTH) pulse high.            =
         |
> + * |       |       | N =3D N / (1 + CSR_1.DEPTH) pulse high.            =
         |
> + * +-------+-------+----------------------------------------------------=
-------+
> + * | 15:0  | PFM_0 | Frequency divider that needs to be programmed, also=
 known |
> + * |       |       | as SCALE. Division by (1 + PFM_0).                 =
       |
> + * +-------+-------+----------------------------------------------------=
-------+
> + *
> + * CSR_1 of Tegra264:
> + * +-------+-------+----------------------------------------------------=
-------+
> + * | Bit   | Field | Description                                        =
       |
> + * +-------+-------+----------------------------------------------------=
-------+
> + * | 31    | ENB   | Enable Pulse width modulator.                      =
       |
> + * |       |       | 0 =3D DISABLE, 1 =3D ENABLE.                       =
           |
> + * +-------+-------+----------------------------------------------------=
-------+
> + * | 30:15 | DEPTH | Depth for pulse width modulator. This controls the =
pulse  |
> + * |       |       | time generated. Division by (1 + CSR_1.DEPTH).     =
       |
> + * +-------+-------+----------------------------------------------------=
-------+
>   *
> - * PWM pulse width: 8 bits are usable [23:16] for varying pulse width.
> - * To achieve 100% duty cycle, program Bit [24] of this register to
> - * 1=E2=80=99b1. In which case the other bits [23:16] are set to don't c=
are.
> + * The PWM clock frequency is divided by DEPTH =3D (1 + CSR_1.DEPTH) bef=
ore subdividing it
> + * based on the programmable frequency division value to generate the re=
quired frequency
> + * for PWM output. DEPTH is fixed to 256 before Tegra264. The maximum ou=
tput frequency
> + * that can be achieved is (max rate of source clock) / DEPTH.
> + * e.g. if source clock rate is 408 MHz, and DEPTH =3D 256, maximum outp=
ut frequency can be:
> + * 408 MHz / 256 ~=3D 1.6 MHz.
> + * This 1.6 MHz frequency can further be divided using SCALE value in PW=
M.

This paragraph exceeds the 80 character limit. Technically checkpatch
now has a limit of 100 characters, so it probably doesn't warn about
this, but I've seen some people say that we should still stay within
the 80 character limit if easily doable (which would be the case here).

I don't care much either way, so it's ultimately up to Uwe. Other than
that looks good:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--dpacxmcdjmza7u6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnLeWAACgkQ3SOs138+
s6GjJA/+M+9NdXIvktftT2CnoEXnIyK76tg2SbfWn5drbr95ifHnxvyVHEc88TR/
fdfyDRkKLJQaE2hobLa4D5mzW2btjeeuK669JMfe4U/26zus/3LIptRZeBEyGGi0
3tWv2Uk1a8Z8bBYPb1GKfdanEU8L1e/jyJtfbl6ytljbB5eneZjy4MnFVz/+cl5y
jvoUZwsmR0oILI/5XUrnaxXYZ2nvIzuyaNRNKG9BYN7ucHoWUdZeSORrc7ZIbPjr
5+diPFxoArSt5SazK504t5ZdPZ1oZDiMYvVFUATjcnbvsTLEbxQ9gVavR14hM62O
cHoiDp49+r5UO27XT7yWuS/W/FIv1mOUkaTGBEXKAnNqd/WEJFwmWWAocOJBr/15
XZeTYeDNOIrGa2/7CRF63L/XIvfG4s6yVVunTQnsvqPliA49Y+H5FT3eDJYoE/Oy
/fyJdpdm6f8V44cITwyP0b73UCNbT9E41e+h80sFDIjdjeuLYNgSB4P1OnvVvnZ6
+YPJp5AUT0BZr5CapFOd+Njp+7DTSUGxqaN/R7eqV1jMBMIqhenjglufYemRidw1
QgOI9neDK0SydRKoncEH9TozZTdJkGWUfNwM7DC4LOor00MJ2eAl46ma+zcCc4dC
1zS/M8+TQaKt0jQu2aeC/lPjWzpr/t30PySe+HkJpTizSbYgxX8=
=t8bQ
-----END PGP SIGNATURE-----

--dpacxmcdjmza7u6p--

