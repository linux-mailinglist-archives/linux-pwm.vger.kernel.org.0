Return-Path: <linux-pwm+bounces-1553-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F3485B58A
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 09:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179231C225E2
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6742E3E8;
	Tue, 20 Feb 2024 08:39:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F36B5D46C
	for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418374; cv=none; b=S+kARG5ykpHj3K/ks2KWjrlhdTKQIpkPrao2Gm3pZ2vQjRe1OZzmSCpv9bqm6sFgXH9j1F2rGvQ4ZtSdr6tSSixUVJaqTh+WfAHBcfaX6ZwACVbOcAMa6SN5MhNPQxxr4hPJNhna+Y2ib/Drofjt5FhoGScZus+0ZLN9mDuE/VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418374; c=relaxed/simple;
	bh=WCIgc8FmZR2G8VtM8HPhX6ovI0R5QT9omQjCWGJo+1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggjIvlZmOxBFqGG4L4AG6psYYt4XVKBRrpriwx/78HTZ7aMH0U/Y+0HcFGXKwG3o/LlJYKqh6Kic9mDT2bfsNDBJDBrfkHpuPstSzVQVdhXwFc8KqSGF6UE545p9kX3a8R6INMabBHhr9FftBOcCbtl0JCqXgiKp98KKsEfWtf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcLeg-00082X-Iy; Tue, 20 Feb 2024 09:39:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcLef-001oAI-4n; Tue, 20 Feb 2024 09:39:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcLef-008LlF-08;
	Tue, 20 Feb 2024 09:39:09 +0100
Date: Tue, 20 Feb 2024 09:39:08 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lee Jones <lee@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Boris Brezillon <bbrezillon@kernel.org>
Cc: Dharma.B@microchip.com, krzysztof.kozlowski@linaro.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, 
	linux-pwm@vger.kernel.org, Hari.PrasathGE@microchip.com, Manikandan.M@microchip.com, 
	Conor.Dooley@microchip.com
Subject: Re: (subset) [linux][PATCH v6 3/3] dt-bindings: mfd: atmel,hlcdc:
 Convert to DT schema format
Message-ID: <qywehfpajronx457jzaxpynjnae6wpl5uvswetr6nrtmmcm5wl@7rl5jfqsofzn>
References: <20240202001733.91455-1-dharma.b@microchip.com>
 <20240202001733.91455-4-dharma.b@microchip.com>
 <170738899221.920003.15342446791449663430.b4-ty@kernel.org>
 <cedecdb7-fe4a-42ea-9a11-faa82f84b57d@linaro.org>
 <ffd43756-b24e-4f19-be33-0e33047ad70c@microchip.com>
 <20240220082026.GG10170@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qejo3o7k6h2mp3hz"
Content-Disposition: inline
In-Reply-To: <20240220082026.GG10170@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--qejo3o7k6h2mp3hz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Feb 20, 2024 at 08:20:26AM +0000, Lee Jones wrote:
> On Tue, 20 Feb 2024, Dharma.B@microchip.com wrote:
> > On 12/02/24 3:53 pm, Krzysztof Kozlowski wrote:
> > > On 08/02/2024 11:43, Lee Jones wrote:
> > >> On Fri, 02 Feb 2024 05:47:33 +0530, Dharma Balasubiramani wrote:
> > >>> Convert the atmel,hlcdc binding to DT schema format.
> > >>>
> > >>> Align clocks and clock-names properties to clearly indicate that th=
e LCD
> > >>> controller expects lvds_pll_clk when interfaced with the lvds displ=
ay. This
> > >>> alignment with the specific hardware requirements ensures accurate =
device tree
> > >>> configuration for systems utilizing the HLCDC IP.
> > >>>
> > >>> [...]
> > >>
> > >> Applied, thanks!
> > >>
> > >> [3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
> > >>        commit: cb946db1335b599ece363d33966bf653ed0fa58a
> > >>
> > >=20
> > > Next is still failing.
>
> If this continues to be an issue, I can just remove the commit.

The missing part in next is that patch 1 isn't included. So the options
are:

 a) Someone (dri or dt folks?) merges patch 1
    This fixes the state in next, though some commits stay around that
    fail dt_binding_check

 b) Someone (mfd or dt?) merges all 3 patches in one go and the two
    patches already applied are dropped.
    This makes dt_binding_check happy for all revs.

For me a) is good enough, but I guess the dri people are not aware there
is something to do for them?! Would be nice if Sam or Boris commented.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qejo3o7k6h2mp3hz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXUZSwACgkQj4D7WH0S
/k7RwggAn5k8z+bYxn2HgADIEc6MbdHU9mSeQkIedBDJ7eKUR9WZ1pe+Srnu1tVr
WrbdWq3sSF9lnSbmq+jH/W6Rp2m1T/8d17EqgmBblQM31IHwt/aJO6y0Ey3qrE91
tF3NOvg4sDPwl0E+WSKOSl0fk9Qk0zhL161D6FREDGwt2KAZ5MKIxYvIobYDLHmb
sqKfYhfHR7r3FfhvtPTkWrTdhasrsrxNY1Jkff8UuznodekV+O6j5UaQyLCZRzRS
+kw+V/q9YQW1PdpNX8GuUYeArlXwco8mSS3iVm7KbAJDg20lGumcEJGr9u8WRB3d
pduGmFRvTTV/J2sLRDjAX4oijX45fA==
=2XIV
-----END PGP SIGNATURE-----

--qejo3o7k6h2mp3hz--

