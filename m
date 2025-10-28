Return-Path: <linux-pwm+bounces-7503-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8924C13A52
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 09:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C28555642C1
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344A82DD5F3;
	Tue, 28 Oct 2025 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmHhx90L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052432DBF75;
	Tue, 28 Oct 2025 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641421; cv=none; b=kHad4uiNxrLPrsH/0DXa0wrfQ0mhSrxb1+jK4+2yjyU7ItK3fxib5fnhg0262qGGLucfRA4tr5aRm5kxybuaoyCtixBv5lTEmNLm1NjIkLob5QqnRU56+Hdolo6aPxzsaIOpSBrHP0I6OWbhacxXDsPcGPJvrP+bLN5O92W+cTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641421; c=relaxed/simple;
	bh=KDXhTRVe2x23tPuaEkQmJ+KZed5CS4Y7/Sq0vsM+Krs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTzKzwjBK/t3+qR+tRJjH/+Lv66mZtlSzhHqHy1PWJHc56DAEzNv2pou/B1Pi+tRNg6Upz0fMyE6zRez0r41dZW+D2bWztIUGqXa5xnxvtZTAM7dX1sKjCIeOY9rhHpY81N2aqaxelD9wXzb7BbgAyvdJrmFhh8UepNnUEwzr9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmHhx90L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEECFC4CEE7;
	Tue, 28 Oct 2025 08:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641420;
	bh=KDXhTRVe2x23tPuaEkQmJ+KZed5CS4Y7/Sq0vsM+Krs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qmHhx90LAeqKDo9OJhautzZdQwPxugsU/j5NRn1XafNc5m5Y1xk8DSY5IKucSYkm2
	 6qDYFj8WKohnoZu3c9y2BRE3K8rqeW4eM1GWmpfy+us8eHq6wrWV9RoMB1fkhBo74a
	 HagmcY1PvDNb3NGu0+25ssCRdCGrue2GwJ2n1+yZx/VbImaxnE3d3SDrswub9Adcpl
	 hP07sZSlIlDscognFZ9tY5TdngpT31at74u3hfGl721sTxle7R8f0wk2JD51pKuFCR
	 mAw+IXEqbYJ33NxTmlxqYXPYYBlVFHXCvfhbgoaR2Y/GAkboX3f5o95a05XJkaSFdK
	 p8BvoQe2AvQ7g==
Date: Tue, 28 Oct 2025 08:50:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee@kernel.org>,
	William Breathitt Gray <wbg@kernel.org>, kernel@collabora.com,
	Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
	linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: pwm: Add a new binding for
 rockchip,rk3576-pwm
Message-ID: <20251028-favored-dynamite-fa626b96ecba@spud>
References: <20251027-rk3576-pwm-v3-0-654a5cb1e3f8@collabora.com>
 <20251027-rk3576-pwm-v3-1-654a5cb1e3f8@collabora.com>
 <ff9631f5-8fff-4be8-8b6f-807c29943ef6@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O1U2C28gYoD3m1pn"
Content-Disposition: inline
In-Reply-To: <ff9631f5-8fff-4be8-8b6f-807c29943ef6@rock-chips.com>


--O1U2C28gYoD3m1pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 11:06:15AM +0800, Damon Ding wrote:
> On 10/28/2025 1:11 AM, Nicolas Frattaroli wrote:
=20
> The RK3506 and RV1126B platforms that are about to be upstream also use t=
his
> PWM IP. Would it be better to name the yaml file "pwm-rockchip-v4.yaml"?

No. Files should be named to match a compatibles.

> Then subsequent platforms only need to expand the compatible property.

That's all subsequent platforms need to do anyway!

--O1U2C28gYoD3m1pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQCDxgAKCRB4tDGHoIJi
0oP/AQCtGkPkLjIuhG6acisp6J+BGBKZt/zk42Iegz+EmIq1xQEAvpU0wnBrYIGQ
DQ8NJI1UvPDWp+Rn13RW0wjmDY/oaAg=
=NwWc
-----END PGP SIGNATURE-----

--O1U2C28gYoD3m1pn--

