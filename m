Return-Path: <linux-pwm+bounces-6247-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0308DACF21C
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Jun 2025 16:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC681886B35
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Jun 2025 14:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517BC156677;
	Thu,  5 Jun 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="OSILMwkw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F551527B4;
	Thu,  5 Jun 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749134155; cv=pass; b=HJEr62cWMRBnsEdvSQjdtBz8QbbBAZ83VyggiGm9z6KzirFdp+8Wt17C8X3E6Jz66AW0oWm7NRvOja89gXvtMahOg23/RWbZeXGK62JjyKugkORC/wl84OE8PkTpruyj8BsgasJblEH8Q1CZWSCIuTyeMAmNx0kAGtDDxGn9ga4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749134155; c=relaxed/simple;
	bh=zDfM6k/ZV7EA2G43A/d5L8tp0cexa6Lz3lwBsr8Shio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4rE0E2d7ixC8Me7R/T+dPxgavCBOTzorNL50pz+/XtcmKvUTufsiQZ3bVvpwari6RJq+F4iWmV6hQa/3nkszdRbYzg5n5EJ83CrcalaxSh0FNdoOvxyuprH3DjD2HHub5202ITftKuvimn+F06r9mcCU8+wZp9QGmrj/20xLYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=OSILMwkw; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749134114; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NKn+SpOWGZY0QJiLOqY4x5Ai/Yv0TIZeaJezXC5g0ZWILWNQmwGJFWpEwycIA2HzIN1mCmRJ3lrQ+hHCgl6pjkXRIxothuFj2Ag8wxZl4+Ty/ThCLtpKCUsR4cTkTfcd7NP1DlPYr95uR7DP313/2QpjpFOHEQwx04AgqXCylHc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749134114; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0uzu1/EqrenMvPymkgwGDWP8FLVCKuEu8+xxxlpKXEc=; 
	b=LmLYwrivhz2E1yJeeGrUCihMh7inHsS0qrHwn1M+edFm2h8MYO4b8dGKP2O91A2LYT6yhG/u4seV30tnNEs+I/hgrhTBC7fMw/qyFiP6jdjelXdpn8fHFHGjX+ys+2vHF6bm3aA2cHibTTvwRpciXC+p8Iw4QuSvPDEAif/ZDUk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749134114;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=0uzu1/EqrenMvPymkgwGDWP8FLVCKuEu8+xxxlpKXEc=;
	b=OSILMwkw/0Mp9nvmWRFPhHe7GWjcRXLUfogUADlprLqTFnfGNGmypMwGhjY1dvCe
	0EmTHbfvP8VDn5JKm/e502sL90mToWYUGwiectxirFIjH5j1AD2h6HDBGLPRN0WzvdN
	Jbh/ZHimXwKzwzBG6KNOXPJrui4kvu7M+EB3/NPA=
Received: by mx.zohomail.com with SMTPS id 1749134112355222.8330067732718;
	Thu, 5 Jun 2025 07:35:12 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 William Breathitt Gray <wbg@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, kernel@collabora.com,
 Jonas Karlman <jonas@kwiboo.se>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject:
 Re: [PATCH v2 1/7] dt-bindings: pinctrl: rockchip: increase max amount of
 device functions
Date: Thu, 05 Jun 2025 16:35:05 +0200
Message-ID: <5876990.GXAFRqVoOG@workhorse>
In-Reply-To:
 <CACRpkdZRjLFa3Bni=wMG1LBoWnW+Zenj2FVP=_2s+U_1eykt7Q@mail.gmail.com>
References:
 <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com>
 <20250602-rk3576-pwm-v2-1-a6434b0ce60c@collabora.com>
 <CACRpkdZRjLFa3Bni=wMG1LBoWnW+Zenj2FVP=_2s+U_1eykt7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, 5 June 2025 15:29:03 Central European Summer Time Linus Wallei=
j wrote:
> On Mon, Jun 2, 2025 at 6:20=E2=80=AFPM Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
>=20
> > With the introduction of the RK3576, the maximum device function ID used
> > increased to 14, as anyone can easily verify for themselves with:
> >
> >   rg -g '*-pinctrl.dtsi' '<\d+\s+RK_P..\s+(?<func>\d+)\s.*>;$' --trim \
> >   -NI -r '$func' arch/arm64/boot/dts/rockchip/ | sort -g | uniq
> >
> > Unfortunately, this wasn't caught by dt-validate as those pins are
> > omit-if-no-ref and we had no reference to them in any tree so far.
> >
> > Once again kick the can down the road by increasing the limit to 14.
> >
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Is this something I can just apply?
>=20
> Yours,
> Linus Walleij
>=20

Absolutely, there's no harm in it landing early, and is only tangentially
related to the rest of the series because it came up while I was pinmuxing
my PWM pins.

Kind regards,
Nicolas Frattaroli



