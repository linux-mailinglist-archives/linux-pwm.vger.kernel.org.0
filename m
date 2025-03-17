Return-Path: <linux-pwm+bounces-5204-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E82A64A97
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 11:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B44A1883589
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9642236FD;
	Mon, 17 Mar 2025 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P43g9F1h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4F19F40A;
	Mon, 17 Mar 2025 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208119; cv=none; b=ZsihMNV0nj1x4q1Revi0PZSFGJ6ZEKEpeQjnq7WyvaDumabUz8melBE/ZWLYRT+BSVsVGjPfIoZS7XurGBAopKc7t7JBMdegFyRyoGTPyEhQYY4DKyHnTtKiZBLFYEI6d3n5Sm9Dmb0cEWiTJ58PYpImkV5zVTNZKlof1IdOCN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208119; c=relaxed/simple;
	bh=S+bZrXRRNuLrRLZQZmTxgx9Qoh5vMQnkLn0jPOAmkiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ea3z1V6WrCYd967Z7ZYD6W/3d3Is4v66zDIhIj7OCDRYip6PCOKJ+7Z5/wDaajDV87YFtlnOlOme7zGFQ4VN/2xtaI/M5zKLE8y1k7zC/rtcbwpb0HUKzV1k8IE6cF3QojVO2+uBpeMxxSUdgtZZqdKGzNvbFBTdNq3yWxTReIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P43g9F1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8B3C4CEE3;
	Mon, 17 Mar 2025 10:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742208118;
	bh=S+bZrXRRNuLrRLZQZmTxgx9Qoh5vMQnkLn0jPOAmkiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P43g9F1hhHqEa4tOz/U0oniq0b1kcSvTV3H/SdC3tsl9GwtDNMA2d9+q4Ct1mw5PC
	 iieDGr5wMMUOxCNVvfFxHaL/q7hhCnO0JW8bELKkQkYkIimLelgEVpz7XRzGMGqLYD
	 m4+aKNkpFS7bEniSNqjYifP0q2D3+J2YBTxvhBjK9xfhIoKDTrXkJZ2nNPYkvnfJ0J
	 bPuiGH0RCveLmpNSA5z1lL+cB1Oyzx2btW+qPXbeW/eNIHx9yxvGKbl7epNgnXDuEv
	 tORcIBR5c3oNZ5664Ga8KShH9AxslzKbRKim+FiM1Z0tvb4PtWDv7PIMTtxFdb72KD
	 dD5JKl9xkB9wg==
Date: Mon, 17 Mar 2025 11:41:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH 05/18] dt-bindings: mfd: adp5585: document adp5589 I/O
 expander
Message-ID: <20250317-noisy-handsome-worm-b5c3f0@krzk-bin>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
 <20250313-dev-adp5589-fw-v1-5-20e80d4bd4ea@analog.com>
 <20250314-outstanding-futuristic-cat-5d8240@krzk-bin>
 <c59477b2a94cbd10bc530809fbcdc0f2d1b79d07.camel@gmail.com>
 <f1ccbdc1-3f47-46a8-bcc2-ca6135882392@kernel.org>
 <ae74d31e8b3874da91ec5c2c9a20274358073266.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ae74d31e8b3874da91ec5c2c9a20274358073266.camel@gmail.com>

On Mon, Mar 17, 2025 at 09:30:37AM +0000, Nuno S=C3=A1 wrote:
> Now, I have:
>=20
> - if:
>       properties:
>         compatible:
>           contains:
>             const: adi,adp5585-01
>     then:
>       properties:
>         gpio-reserved-ranges: false
>     else:
>       if:
>         properties:
>           compatible:
>             contains:
>               enum:
>                 - adi,adp5585-00
>                 - adi,adp5585-02
>                 - adi,adp5585-03
>                 - adi,adp5585-04
>       then:
>         properties:
>           gpio-reserved-ranges:
>             maxItems: 1
>             items:
>               items:
>                 - const: 5
>                 - const: 1

Yes, you are right. The diff context confused me, so I thought these are
different.

It's fine.

Best regards,
Krzysztof


