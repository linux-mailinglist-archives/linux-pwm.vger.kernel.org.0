Return-Path: <linux-pwm+bounces-8701-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LiWK5ib72kbDQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8701-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 19:23:36 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B029477629
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 19:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E5CB302333F
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E17A3E51F5;
	Mon, 27 Apr 2026 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="S9zXn+IM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0270B3E51E2;
	Mon, 27 Apr 2026 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310319; cv=pass; b=JWwUMFWJ9qLEcrE3dS5So57XK1fxSMsfJUiJWADvL3pj3AgHjLKY0o0ogFsHy35vttJPfx6iuU2tZw6jAMezurJcj05Wt3FQFOSfxzP9a4HaKDaA5tjW63iHULvjxoQPrxZ30UIp85ZxjU7/RlkieBlxfjAi1IcfJte5eIheSws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310319; c=relaxed/simple;
	bh=PUkidtf7LPsxLUJ+sc//1BBNuOqo8ELruR3uwxGDkA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgjp3OWWzAC3Du+t3sV4feq9yENvbk1XS/t0rvX+gDr3wNVWIMuM9EMluyUTT4QEtnMVI1TNpTmS9PxIJNPK25TlLw4AxftXJHJd4fLSePEtfLaeIuC0XcyXTzphGq5FQMkD2FgCZQmQJ3CHSRLWaxsYOKvZ8tCVX4cPNIUmaPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=S9zXn+IM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1777310285; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AONUFnmPJe7rvq6jg1smn1vKZwWTHWd4KK8LCstwo44AakIrSuIl1utQztkCYpM4Pmry9S2obBYcCcEwLRXAhw3zgG7imvAaCi70TGaFCsuKT3cMl9oXk3E/79p0/rWjZlv/wT+H+LuIjS6FZ5c3TEWpp48OfEjvwXXPvGp1j8M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777310285; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bXedwRzoqLX366g/tnoKfZ2zMaP1ns3wcTqOK2AZMgM=; 
	b=AlgdzFqkJ4Ae/TERfCWF7bUOs0kLATfB16eI2xYjXb4nbbZ4/07F6l9tR9lAucEwMgzZapr+sb8uG+8nbVWgAENnUDue2NeW2KndQf0jecwO11oIAjS+oatzmNzEbTzLsZEVHrS1CZdUgzneHn6ZWUTz1k00jsa1sxjxD8BMMHI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777310285;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=bXedwRzoqLX366g/tnoKfZ2zMaP1ns3wcTqOK2AZMgM=;
	b=S9zXn+IMlR2eV1zhjsqpJDfCInyD8z/vR/LnDAPOBLES8RavaNCeVAJspPcZAJR7
	vmHMRFdcBieZLbP5ie4MH0/RRVgZkxwOslDidpY12/ngVVuR4w0ecEjDcAUuxN3nYpX
	DxYEKcKIuMZ02nFZxatgtmJuhJG2uPWIxf1oiyXM=
Received: by mx.zohomail.com with SMTPS id 1777310283788820.0404676270748;
	Mon, 27 Apr 2026 10:18:03 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>,
 Damon Ding <damon.ding@rock-chips.com>
Cc: kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 6/6] arm64: dts: rockchip: Add cooling fan to ROCK 4D
Date: Mon, 27 Apr 2026 19:17:57 +0200
Message-ID: <El5M8EbxT4a3ZzcG9vKdNA@collabora.com>
In-Reply-To: <35afc21f-74c9-4f52-bdf1-18a34fb58578@rock-chips.com>
References:
 <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
 <20260420-rk3576-pwm-v5-6-ae7cfbbe5427@collabora.com>
 <35afc21f-74c9-4f52-bdf1-18a34fb58578@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 2B029477629
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-8701-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.frattaroli@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.1:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email,collabora.com:dkim,collabora.com:mid]

Hello,

On Sunday, 26 April 2026 09:23:01 Central European Summer Time Damon Ding wrote:
> Hi Nicolas,
> 
> On 4/20/2026 9:52 PM, Nicolas Frattaroli wrote:
> > The ROCK 4D has a header to connect a small cooling fan. This fan is
> > driven by one of the SoC's PWM outputs driving a transistor, that in
> > turn controls the fan's power.
> > 
> > With the introduction of PWM support, add a description of this cooling
> > fan, as well as the additional trips and cooling-maps for it.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >   arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 50 +++++++++++++++++++++++++
> >   1 file changed, 50 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> > index 899a84b1fbf9..2d5ede010ad0 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> > @@ -45,6 +45,14 @@ rfkill {
> >   		shutdown-gpios = <&gpio2 RK_PD1 GPIO_ACTIVE_HIGH>;
> >   	};
> >   
> > +	fan: pwm-fan {
> > +		compatible = "pwm-fan";
> > +		cooling-levels = <0 180 205 230 255>;
> > +		fan-supply = <&vcc_5v0_sys>;
> > +		pwms = <&pwm2_8ch_5 0 60000 0>;
> > +		#cooling-cells = <2>;
> > +	};
> > +
> >   	leds: leds {
> >   		compatible = "gpio-leds";
> >   		pinctrl-names = "default";
> > @@ -711,6 +719,36 @@ rgmii_phy0: ethernet-phy@1 {
> >   	};
> >   };
> >   
> > +&package_thermal {
> > +	polling-delay = <100>;
> > +
> > +	trips {
> > +		package_fan0: package-fan0 {
> > +			temperature = <50000>;
> > +			hysteresis = <2000>;
> > +			type = "active";
> > +		};
> > +
> > +		package_fan1: package-fan1 {
> > +			temperature = <60000>;
> > +			hysteresis = <2000>;
> > +			type = "active";
> > +		};
> > +	};
> > +
> > +	cooling-maps {
> > +		map1 {
> > +			trip = <&package_fan0>;
> > +			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> > +		};
> > +
> > +		map2 {
> > +			trip = <&package_fan1>;
> > +			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> > +		};
> > +	};
> > +};
> > +
> >   &pcie0 {
> >   	pinctrl-names = "default";
> >   	pinctrl-0 = <&pcie_reset>;
> > @@ -720,6 +758,13 @@ &pcie0 {
> >   };
> >   
> >   &pinctrl {
> > +	fan {
> > +		fan_pwm: fan-pwm {
> > +			rockchip,pins =
> > +				<4 RK_PC5 14 &pcfg_pull_down_drv_level_5>;
> > +		};
> > +	};
> > +
> >   	hym8563 {
> >   		hym8563_int: hym8563-int {
> >   			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
> > @@ -770,6 +815,11 @@ wifi_en_h: wifi-en-h {
> >   	};
> >   };
> >   
> > +&pwm2_8ch_5 {
> > +	pinctrl-0 = <&fan_pwm>;
> 
> May I ask why the pinctrl does not directly use &pwm2m1_ch5?
> 
> Is it because the default pin configuration cannot meet the requirements 
> of the fan?

Yes, I'm adding a strong pull down. The PWM pin controls a transistor,
and if it floats when not in use the fan can start spinning when no
PWM signal is present. If I recall correctly (it's been a while since
I wrote this DT patch) it could be left spinning when the board was
shut down with a `poweroff` command.

> 
> > +	status = "okay";
> > +};
> > +
> >   &sai6 {
> >   	status = "okay";
> >   };
> > 
> 
> Best regards,
> Damon
> 
> 

Kind regards,
Nicolas Frattaroli



