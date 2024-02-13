Return-Path: <linux-pwm+bounces-1303-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4CA8538ED
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Feb 2024 18:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D354F1C21659
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Feb 2024 17:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E39604C4;
	Tue, 13 Feb 2024 17:49:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F53A60266
	for <linux-pwm@vger.kernel.org>; Tue, 13 Feb 2024 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846543; cv=none; b=VBPZfQbB/lc8DW8OP1EwZiJd87+GchFtQnjlfpznLLz/KRs/0mF7u0bGRTiQjkcuZ2ogpcxFxVaFAuLtLIntw9rnDxWC8ip3jTa5xmBetvv8xwF6dlhYhuu9AeIrcRu0M/vsU9f1vL8D6wxVUerSZ/JsQSxzNG4niJMiqsD6MFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846543; c=relaxed/simple;
	bh=QWIuBAJ3e+TCWmBbhbpgT4PWb2RX18XR04uHZ6yIclw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4nmFakCLDBKEcDelbdviVv3RMeZ1GIw2XiNmoCJcQbMvh6lTthy6eXs2Hk7Gm4PXBcKwgAimXU0xWPDVV4FjGC08SEwtqL3s0kQz0TmglVeA4lJysJPf9yUJQLNDzrJ5eNEuNgyAUVBcGQDxOxoJGLw563U8P/wQOYNZwLxTGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZwtm-0007eB-T1; Tue, 13 Feb 2024 18:48:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZwtk-000Wtk-TI; Tue, 13 Feb 2024 18:48:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZwtk-0046pb-2d;
	Tue, 13 Feb 2024 18:48:48 +0100
Date: Tue, 13 Feb 2024 18:48:48 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek,mt2712: add compatible
 for MT7988
Message-ID: <onnokyq7ciza7i7jzc74cun2khpst5iocuccks2cm433ux3za3@dou4oacrvuxj>
References: <20240213164633.25447-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jhwaxkndpklwhxal"
Content-Disposition: inline
In-Reply-To: <20240213164633.25447-1-zajec5@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--jhwaxkndpklwhxal
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rafa=C5=82,

On Tue, Feb 13, 2024 at 05:46:32PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> MT7988 has on-SoC controller that can control up to 8 PWMs.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

please make sure that the email address used for sending the patch
matches the Signed-off-by line.

(It depends on the pickyness of the relevant maintainer if that is a
stopper or not.)

Assuming this patch will go in via a mediatek tree:

Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jhwaxkndpklwhxal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXLq38ACgkQj4D7WH0S
/k5Yxgf+MGDk4UWSSThMXzK6DjwTQdURT3za9jTq2ls/OQIHoQfyaw902waKPjVr
mPIVGTESq0AvIpQNcZQQH8WUjNfI7at0cWPaTA/iZD07h9nMOEztTp4wP3rYwBp5
yicKjx5McHb1nR5poDAXFudd+7v/gOgXBLPxABfx4FiOLWqnNuDJF2xwmge8mKHp
NKlYSZk+kiCbBwsZk3LBwLqKv45TnPI2yuayws+r1jYLnmXMyRUkVQqCpX2/CUGq
wESqm70l9ty5FmyiE86YbJkgx+b5o9Z/nJt223FluL3Ftnxfc0sABjdCI9IxmFCg
sWhDm4LJVkrMbtBmn8VK5huxt/BXmw==
=o3gj
-----END PGP SIGNATURE-----

--jhwaxkndpklwhxal--

