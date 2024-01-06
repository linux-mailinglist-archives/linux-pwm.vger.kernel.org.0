Return-Path: <linux-pwm+bounces-688-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CFE826266
	for <lists+linux-pwm@lfdr.de>; Sun,  7 Jan 2024 00:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9273A282EF2
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jan 2024 23:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DCA1078A;
	Sat,  6 Jan 2024 23:26:13 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5910101EF
	for <linux-pwm@vger.kernel.org>; Sat,  6 Jan 2024 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rMG32-0005S0-BJ; Sun, 07 Jan 2024 00:25:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rMG31-000uBk-3e; Sun, 07 Jan 2024 00:25:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rMG31-0045QT-05;
	Sun, 07 Jan 2024 00:25:47 +0100
Date: Sun, 7 Jan 2024 00:25:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Johan Jonker <jbx6244@yandex.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	kernel@pengutronix.de, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: rockchip: Allow "interrupts" prooperty
Message-ID: <cvvifoctmgdsgqfadqbhgywfw2ff57fz33w26hghf5kyo5j5sw@mj75xtvczr2h>
References: <20240106142654.1262758-2-u.kleine-koenig@pengutronix.de>
 <7dea73a6-d733-4cd2-b2d5-02f09e2a6dd9@linaro.org>
 <94ad0f59-4095-40ee-963d-4ac379fc8852@yandex.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k6n65kljntfxlgu3"
Content-Disposition: inline
In-Reply-To: <94ad0f59-4095-40ee-963d-4ac379fc8852@yandex.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--k6n65kljntfxlgu3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Jan 06, 2024 at 10:25:10PM +0100, Johan Jonker wrote:
> On 1/6/24 18:10, Krzysztof Kozlowski wrote:
> > On 06/01/2024 15:26, Uwe Kleine-K=F6nig wrote:
> >> This fixes the dtbs_check error
> >>
> >> 	arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb: pwm@10280030: 'interr=
upts' does not match any of the regexes: 'pinctrl-[0-9]+'
> >> 	from schema $id: http://devicetree.org/schemas/pwm/pwm-rockchip.yaml#
> >>
> >> in several device trees.
> >>
> >> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> NAK
>=20
> There's a reason why this isn't implemented before:
>=20
> [RFC PATCH v1 1/2] dt-bindings: pwm: rockchip: add interrupts property <h=
ttps://lore.kernel.org/linux-rockchip/ed3df2c8-ffb5-1723-0ed7-3a2721972852@=
gmail.com/#r>
>=20
> https://lore.kernel.org/linux-rockchip/ed3df2c8-ffb5-1723-0ed7-3a27219728=
52@gmail.com/
>=20
> [PATCH 1/1] dt-bindings: pwm: rockchip: Add description for rk3588 <https=
://lore.kernel.org/linux-rockchip/20220901135523.52151-1-sebastian.reichel@=
collabora.com/#r>
>=20
> https://lore.kernel.org/linux-rockchip/66b5b616-ae9f-a1aa-e2b5-450f570cfc=
dd@gmail.com/
>=20
> [PATCH v1 03/11] dt-bindings: pwm: rockchip: add rockchip,rk3128-pwm <htt=
ps://lore.kernel.org/linux-rockchip/f5dd0ee4-d97e-d878-ffde-c06e9b233e38@gm=
ail.com/>
>=20
> https://lore.kernel.org/linux-rockchip/946d8ac2-6ff2-093a-ad3c-aa755e00d1=
dd@arm.com/
>=20
>=20
> On how to correctly model the DT with common interrupts , PWM and one sho=
t as a sort of MFD etc there's no consensus yet.
>=20
> Leaf it as it is till someone made a working driver demo, so that the cod=
er is free to model a DT solution that fits to him/her.

Having the warnings until this happens is bad though. If describing the
irqs in the schema is considered wrong, we should remove the interrupts
properties from the device tree sources.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--k6n65kljntfxlgu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWZ4W0ACgkQj4D7WH0S
/k7tKAgAtAf2QMmreY13aVdggwzkDRejn5LlPtH9i75yOhD82+fHrQlGV1FAH6/j
MGO96OT4P/wZfxxjQjWT4bQsp657BXs8decOHx099HpWSwF9n5ZDiHSHd7ExmbyL
pg73mDSpDtcemlmI75H2VPF1OvTk/rPl6F2b3FlDgewcTqir5ojqk6ov3yCoOasl
WIJ2vwkwkvGqqQc6npmqZIYanWBJlMvK3Mbmeg/RkWQgo2XHowhSNnfx82I80Dky
VWYme/woR3T0MDbOBG6eCs2wxILhaePXRVokg/qiSDuLSC7W4Bn1O6sfe9zYxGnz
/Pwr+6Hl/fYCYPGM8Iq7UlFNRf/HYw==
=pwCa
-----END PGP SIGNATURE-----

--k6n65kljntfxlgu3--

