Return-Path: <linux-pwm+bounces-8131-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPL4Ks40mGn/CgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8131-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 11:17:50 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2495E166BFC
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 11:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D32BF3031B2C
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 10:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4725333C1B6;
	Fri, 20 Feb 2026 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuHW5xgN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D1233C18B
	for <linux-pwm@vger.kernel.org>; Fri, 20 Feb 2026 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582667; cv=none; b=mdznzt0K7nEMPldMworQilKBg0SnebNR31H2GMNON+UPt1QPNWc2fyliLGQ/3799oKfVY9r9jxJ8jRegDeSjCfabODMg6YW7uVyT0Y6JK3VrC8dpJbF08zW3NILQyqK2AZoyBEXBP27HJzYhS1oCVOUDvQix7Xj9SQcbdwE+9/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582667; c=relaxed/simple;
	bh=8JPAPEZguacmifSWCnnDXUVYRogc7fx9Jf3HfyYCE3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XLfGltrU25IwUSTDg6toxqa2QSXkRXld4sqRBebkk/KWnBSAmk3R/m6fX2Z297ZfO2+Y/HoCqBPrdNwLgNFWchrKgARo3/elCyKwErGd9v3IdHdFub8kcukdDNZFBD7Bz60tpB+thmNJ6BnvPPz3doJhmYn1665PBOZVtwWXa5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuHW5xgN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43770c94dfaso1982280f8f.2
        for <linux-pwm@vger.kernel.org>; Fri, 20 Feb 2026 02:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771582664; x=1772187464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=foa7kGkA11ij00nt3xJx3lBVlw2GastjEXv+CSxW2yk=;
        b=iuHW5xgNXlMkYa5na6xVFsFvMgX/y+z0qv99LuwzI8lHpFPtsx5OcI9a87+oqUuNwj
         Mk+SGUZGdTiCrs2xadCfd1d6xPxMu7AOhyF6n6WqZvo47+3T/VfTx5ZY54d+kwT88m0M
         hfRd5J4dEYL6EILboAPm5wPpLo7c80Q5sU/hVoZdGcQMVHTkNpg9MvqHZby8X3Dn7xyN
         UESxVZ8Aue+81XHBsJYdA7aqR0/4Zg1wIQuCKXVqQdcJEenBnGv7ClPxWAgXiiNPaMhf
         l3zb9byU00RccX1i3rPoM/Anlce6rTCNnJr9Ss8qk7WItarMWm8vTOhT6XLmLKOhRDLy
         G9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771582664; x=1772187464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=foa7kGkA11ij00nt3xJx3lBVlw2GastjEXv+CSxW2yk=;
        b=Gqngxvhu+1/PWDJcUAwvm/1NdSFOqJqwKheChR2PTZzLK7NYODLLYb86H1ZwNbj7bm
         d7Av6XJ5LNoQAFMmkdlrtN0rBulfnK4lWSHvuAORGn4zN2qXmlRpF8DfszLBKIfxRgQX
         wTVEBUIZIOm/Zt8YI30HR7bfUgdEcDUmXPlTl8ku0LWRtP3R5IKUBDJYD2D5fWVNGh7x
         AEEt9Ad3hOvyKKss18mmHD+VN182I9HLssZAqN5xAkEP3V9tu6UCqNbPQMgHWlrJ0qGd
         /MAkWfY8q6KWGhME4UTbJPubfHoxGPkWTFTpwPCrYc0rLTcylJ/8fGtvuchLu4MFpRMC
         UMIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1z8MSRdHm8kOPhzC6IZwjf5ceXXMsT+kUuF7Rn0ZmBcmsjvclRdpmz1PAtlSxW7dsRz/ECKmVWHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQlCDmfHeGp5E3fE4zynRTjbwMDWY0kv4UZK78XumHCrWlQdv
	RqdygGXECY6YPrUdkgxmq+C1h5bvF+ElyhEiHPBt7VOGLJ94OklKQ4FW
X-Gm-Gg: AZuq6aJS1CYCFydoVL7h6Yx1OvCzgtmG2lqz5J4uVivOZSX1UFc8xr6wO1pwxbbgcRX
	8V2uSLq4L7uFqPHZuiuQQqXrwZmpKPHzhVYNBFY4MzoOBbESTz8I4LqzBmq4HlNqBalrr8DvVLg
	B9D9IM+99wHXm8of9poLTy9n+T0NBE/aJaJAAMrGqGruRcG13oeOw8tHVY6s4KpQUofNXy9+G6D
	6yYJTQbq+nrcBNO5kFKKF5qdZKhyPu8tT0qv2gfc8bdL+qN9FbCc7JnzaNT6Tt7Ux05s9LkNqnb
	1hGXdrnn0dCCBKbMVfXVHCm1pIVJ6Ufy3mfrfsTDJg62AQKSU1X9OZ0Pizjz3hH9FfcfC+mJ7Iy
	lQHvwbERwUV4jpIlskEUicvPd4u7e+vtwcRHeWdWnaEmjd9GA6NfHiFt45smuVtwk+hCwwJhFxu
	Jvc/2dd7WABZV/eUay+F7bF7DOTHgNXHo=
X-Received: by 2002:a05:6000:2911:b0:437:71b2:6f34 with SMTP id ffacd0b85a97d-43958df112cmr13666718f8f.1.1771582663829;
        Fri, 20 Feb 2026 02:17:43 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abe3b3sm62452448f8f.18.2026.02.20.02.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 02:17:43 -0800 (PST)
Message-ID: <9951c2fc9bbca27e0a5e7d953a31a0f802bac38f.camel@gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add entry for AD5706R DAC driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron	 <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Fri, 20 Feb 2026 10:18:26 +0000
In-Reply-To: <20260220-dev_ad5706r-v1-3-7253bbd74889@analog.com>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
	 <20260220-dev_ad5706r-v1-3-7253bbd74889@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8131-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2495E166BFC
X-Rspamd-Action: no action

On Fri, 2026-02-20 at 16:02 +0800, Alexis Czezar Torreno wrote:
> Add maintainer entry for the Analog Devices AD5706R DAC driver
> and device tree binding.
>=20
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> ---

Hi Alexis,

Fairly sure checkpatch will complain in other patches as files are being ad=
ded. Need to
speak with Jorge as I just saw this was not triggered in internal CI.

- Nuno S=C3=A1

> =C2=A0MAINTAINERS | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1251965d70bdfa990c66966cd77f7ab52ae3385f..3d7bd98b4d1b55836e40687a9=
a3ac9f4935a8acb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1496,6 +1496,14 @@ W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
> =C2=A0F:	drivers/iio/adc/ad4851.c
> =C2=A0
> +ANALOG DEVICES INC AD5706R DRIVER
> +M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
> +F:	drivers/iio/dac/ad5706r.c
> +
> =C2=A0ANALOG DEVICES INC AD7091R DRIVER
> =C2=A0M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> =C2=A0L:	linux-iio@vger.kernel.org

