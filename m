Return-Path: <linux-pwm+bounces-5140-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6301DA5E493
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 20:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7381883F68
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 19:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FBB255E3D;
	Wed, 12 Mar 2025 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0w6DVHcP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144770809;
	Wed, 12 Mar 2025 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808326; cv=none; b=MnOCbwy6vZHqoUF2VWgFD08XtkLk3ki8fpL2DsedvWCANEE/EHDPRN7D0lMUPE2r2Vk1nr4oycHJboJalExeBXbR0Vz2/MU99gMgh5VBgAwPYhh65e1yipGRGKOuKHrvxirYzzmOu6ReKdIy7RP3lZu0NLSBb2BW2yvQfDJ6bHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808326; c=relaxed/simple;
	bh=C9INF1sRuTRBiE4I1IZ7b5gSF2dewfFG5yTbHzD+y0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlBHLnt+JHt6974i8ao5usGZ8epiTk5zubewQzF858OKL+RLxIns6lLYAweTvIvaZe9VCvy9odPYbtSlrL8ew0jsHfBCJqH8bM+khIZJYSf/8dmESYjVV7Hbx71WIl49dx4ix8UPPZmNuRZX7ClJeY1ixTkQeDaj9YMSnF1vYdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0w6DVHcP; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9G2KX65Ab+9QthP7hU+dGSKLgGHDZbANHAkXoqK6ZJ8=; b=0w6DVHcP8Ff1NsM8gB7G2O7rSU
	nQacEOXrojn9wRema8yOaO0egRFn0zuygBNIDCIswibMncUt/Ng/CbZMssdRIr0SUNRuaCzpzM29q
	XeddB38hzG7sGIPAS8eRvmEe2nFPKCSKh+CZkRnxyCfEeyUnQGDdWBevdPv5EEQiJhvEIWMxqpWRN
	E4mna9N2wg8wb9UFCaFND4cWatp12Cb8WBQYbPile+C6rOoG+m3IbpoQ7FZBxXIe97x0zpGZhUNnk
	UrxT6va3aKF91llsyjHRTr6XNcOtEqmJH4spBOnz37Z2PfTSzzp38OZPb5XHW+9pUfJf7BRcCdlZj
	eXLPSZVg==;
Received: from p3ee2c254.dip0.t-ipconnect.de ([62.226.194.84] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tsRuS-0001ql-MV; Wed, 12 Mar 2025 20:38:32 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>, Jonas Karlman <jonas@kwiboo.se>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: Add pwm nodes for RK3528
Date: Wed, 12 Mar 2025 20:38:31 +0100
Message-ID: <7779050.EvYhyI6sBW@phil>
In-Reply-To: <b7d8d385-81ee-4947-ab8f-1da43843464b@kwiboo.se>
References:
 <a5ec9062-ca57-4748-8c0f-fb5b9c75fa28@kwiboo.se>
 <20250312143515.1225171-1-amadeus@jmu.edu.cn>
 <b7d8d385-81ee-4947-ab8f-1da43843464b@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 12. M=C3=A4rz 2025, 16:00:00 MEZ schrieb Jonas Karlman:
> Hi Chukun,
>=20
> On 2025-03-12 15:35, Chukun Pan wrote:
> > Hi,
> >=20
> >> The pinctrl-names should be changed to "default" and not "active",
> >> something you can fixup or do you want a patch?

so yes of course the pinctrl needs to be default - simply because
that's the only pinctrl state mainline supports.

But judging by the fact that you're discussing working vs. non-working
below, can you please check if we should drop the patch for 6.15 till
that is solved?

Thanks a lot
Heiko

> > Sorry I've been a bit busy this week and forgot to send the v2 patch.
> > In rk3528.dtsi, the uart and upcoming i2c nodes do not have pinctrl,
> > so I prefer to remove them.
> >=20
> >>> Unlike other SoCs, pinctrl-names need to be in "active" state,
> >>> I'm not sure about this, but otherwise the pwm-regulator will
> >>> not work properly.
> >=20
> > BTW, setting the pinctrl of pwm corresponding to pwm-regulator
> > to "default" will cause kernel boot suspended.
> > Sorry but do you know why?
>=20
> Not an issue I have seen, do you have any more logs or details? E.g.
> what board you use, full regulator node, do you have operating points
> defined etc.
>=20
> I have runtime tested a branch at [1], that use pinctrl-names =3D default,
> have vdd_arm and vdd_logic defined, also an opp table for cpu and gpu.
>=20
> For E20C there is a commit to enable the vdd_logic, however without gpu
> enabled and a mali-supply the pwm-regulator is initialized to
> max-microvolt by Linux. Have instead updated U-Boot to initialize the
> pwm-regulator's:
>=20
> ```
> &vdd_arm {
> 	regulator-init-microvolt =3D <953000>;
> };
>=20
> &vdd_logic {
> 	regulator-init-microvolt =3D <900000>;
> };
> ```
>=20
> [1] https://github.com/Kwiboo/linux-rockchip/commits/next-20250311-rk3528/
>=20
> Regards,
> Jonas
>=20
> >=20
> > e.g.
> > ```
> > vdd_arm: regulator-vdd-arm {
> > 	compatible =3D "pwm-regulator";
> > 	pwms =3D <&pwm1 0 5000 1>;
> > 	...
> > };
> >=20
> > &pwm1 {
> > 	pinctrl-0 =3D <&pwm1m0_pins>;
> > 	pinctrl-names =3D "default";
> > 	status =3D "okay";
> > };
> > ```
> >=20
> > Thanks,
> > Chukun
> >=20
> > --
> > 2.25.1
> >=20
>=20
>=20





