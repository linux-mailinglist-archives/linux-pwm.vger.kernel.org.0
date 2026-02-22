Return-Path: <linux-pwm+bounces-8145-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VDGIFPP2mmkoogMAu9opvQ
	(envelope-from <linux-pwm+bounces-8145-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Feb 2026 13:30:43 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F4616F098
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Feb 2026 13:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E37FD300C00E
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Feb 2026 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7891DDC1B;
	Sun, 22 Feb 2026 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmECsLqS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4152F1E487
	for <linux-pwm@vger.kernel.org>; Sun, 22 Feb 2026 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771763438; cv=none; b=A7saAtQD+97qbU5wtMWtKR3MXatHxJ5U5JeYAZcMr6JGzV+Q1cBn4cEtL9HTP/MsT2vs33OjnvEhCBUdh73PgbMvCORxSo88Lla+lFBrBLxypNU5yvar0Yhg5ZyQcZ1qTRFdkBIrKRWiaE/RCo5SB7fqB8It5cMEbJjA6JiHR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771763438; c=relaxed/simple;
	bh=tzxl38FPzMo6zN1VmPw1jU1ks9I5QTmsXkZQLi+PoK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKk7uT2Q0RO5BflDYqOb5gnu+6a1loDy+u8rLkuBCKaGk0Q3tgd3qBugJVsTQE19AjYP3MP2hgEjhDXFgVtDl8wnexmcxR8nMSRWc0CW1b4vM5rhpmOt5MaejCAM2jhrE0V8Tst3wHp9P3lQzXkdRsBcsJ/y4fqzF8viGad6nzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmECsLqS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4834826e555so33474635e9.2
        for <linux-pwm@vger.kernel.org>; Sun, 22 Feb 2026 04:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771763435; x=1772368235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSJS2GkYexnr2R3qwinnT+ROgZLneAGoFNuJa+6p93s=;
        b=jmECsLqScCwAwO3rzHo3OJ6pVYroXyu0lcpxmwrv28ctNvlCMroxtKVNM6pMUJ6gD1
         FUx+RC6+RZDACCs/0aAn/+/WjDuH/SySjkMk4JnUHNnSDZFTqctuRC++SnVw+pzO6iue
         76HcI8Esu7DBSY15lGNVel6Y8ifJ63Ir1cymtaHwZrI3ZRSvph02Pt5fD5zvKjT6t6Kx
         b6Cnvw8s+2tYxW7C51jEaWE0/1YzXyUpfo0neyD3fFygjPa+uxngmDupefk2cqWyOpWx
         zOqhCc3PlCFRGYamquAHJV/DvN4/i1ZCYzJYUPk476SxIPn2GaJzHDA8DmGRsSlGrqrJ
         UGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771763435; x=1772368235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oSJS2GkYexnr2R3qwinnT+ROgZLneAGoFNuJa+6p93s=;
        b=wUiuVPkSaVWfj02rz8i02xhEx/SGGeyKgNd3g8j6H2kfEqzOIEzertjJbGwZIypqvl
         ti8YhP6NFy/9kZDsETO8qgBCNm8D8eqowwnIVCEv/G/n5Aqgg2xDHaLyQtPmJVm0XBzW
         dQBQedAjtJgx16He7lp2vEXyxYIQpjwD92Ga3uLhXWdqNeEkTQqbLpJOWmubOS375nK6
         bHRVRM1aq7MDFoLctfWFvBxWNzVG/u8OlkEUYnlvOWYioTxTNxTvFucB1NQ6NBAPJgOp
         6ddjQuYb+bMHG1avrmqJrRcZWfUdkAmrm5Iqs9RXQGquaufOeceVxuURYU54TCDYxRrj
         +tXw==
X-Forwarded-Encrypted: i=1; AJvYcCWh3ektoWUGi9v5+4GrcDL4LOuYfA8HQCFiZmpg1X6/ijYlTsmI/N1N2HDpuOCnUmHRujacIntw6mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9TYzOtP84RHOgst8p09xBYu+6Sp0fQMqd+0XdfQ9ho6zQ5ODO
	kkmNA/ntgvBE2B11VcYBuuK+9pnSVPHICXAb/uSwAHxpLp7M6hgGkuwd
X-Gm-Gg: AZuq6aIiE4W8NgYfHDyfh16YLZEyBtc1RhXGEUgOl1lwvuaz1CLkcrO6LdyNK7DH0eW
	RU8OPtpTjiQ12kxRDcCb6GY3pNY/hhu0TgHgIQWAvJZqYNprcC/89b4NymGoP+kXWmF6kcrFCDk
	bjSmTmW0hM+b9tZRAuwDCSkPEac/gpRmT3rwg28kaK4EazFxxG35e1s/AZW7iaEgnrJ76YeoI82
	5hJa0+zqc/S2048+hrLK9QoJYsPUgn8I5x16mMbHlBLxaUFRoqJX/uaA/E1a/IQc4cx2y7WWB4T
	0eH72IqL1ysRJw0KCdpSJS3i4WYRgVndepewbep84rZzL3Qqe69E/4ParmL/E2nJAk4AIbxErzT
	xfPLiYstSJ2I2LeSusc2t81s+xoEwTKwZ78wvYLIUqhDWBblblid0M29IexgJbM+e+N43yK75i9
	wRKYN6uyUUupsXMqf7MPJCgM6Di8bcV6UMoin3kmYVN24KqseTVsjvo2LTgcXe8MrR0OTqTwI/l
	qCpUxv39HA88KkwbQ==
X-Received: by 2002:a05:600c:8183:b0:47d:3ffa:5f03 with SMTP id 5b1f17b1804b1-483a962e09fmr77433955e9.21.1771763435348;
        Sun, 22 Feb 2026 04:30:35 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-126-118.dynamic.telemach.net. [86.58.126.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3dd3391sm124921405e9.1.2026.02.22.04.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 04:30:34 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org, Aleksandr Shubin <privatesub2@gmail.com>
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel <p.zabel@pengutronix.de>,
 Lukas Schmid <lukas.schmid@netcube.li>, Cheo Fusi <fusibrandon13@gmail.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 3/3] riscv: dts: allwinner: d1: Add pwm node
Date: Sun, 22 Feb 2026 13:30:32 +0100
Message-ID: <2265500.irdbgypaU6@jernej-laptop>
In-Reply-To: <20260221183609.95403-4-privatesub2@gmail.com>
References:
 <20260221183609.95403-1-privatesub2@gmail.com>
 <20260221183609.95403-4-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8145-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,sholland.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,netcube.li,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_PROHIBIT(0.00)[0.30.136.104:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jernejskrabec@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2F4616F098
X-Rspamd-Action: no action

Dne sobota, 21. februar 2026 ob 19:35:53 Srednjeevropski standardni =C4=8Da=
s je Aleksandr Shubin napisal(a):
> D1 and T113s contain a pwm controller with 8 channels.
> This controller is supported by the sun8i-pwm driver.
>=20
> Add a device tree node for it.
>=20
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> ---
>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/ris=
cv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> index 63e252b44973..8e38a0d95f5a 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -193,6 +193,19 @@ uart3_pb_pins: uart3-pb-pins {
>  			};
>  		};
> =20
> +		pwm: pwm@2000c00 {
> +			compatible =3D "allwinner,sun20i-d1-pwm";
> +			reg =3D <0x02000c00 0x400>;
> +			clocks =3D <&ccu CLK_BUS_PWM>,
> +				 <&dcxo>,
> +				 <&ccu CLK_APB0>;
> +			clock-names =3D "bus", "hosc", "apb";
> +			resets =3D <&ccu RST_BUS_PWM>;
> +			status =3D "disabled";

Move status at the bottom.

> +			#pwm-cells =3D <0x3>;

Just use decimal format.

Best regards,
Jernej

> +			allwinner,npwms =3D <8>;
> +		};
> +
>  		ccu: clock-controller@2001000 {
>  			compatible =3D "allwinner,sun20i-d1-ccu";
>  			reg =3D <0x2001000 0x1000>;
>=20





