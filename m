Return-Path: <linux-pwm+bounces-7623-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AD9C5C141
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 09:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0023B1358
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 08:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FE62FDC52;
	Fri, 14 Nov 2025 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY8XsgSq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17BC1E1A3D
	for <linux-pwm@vger.kernel.org>; Fri, 14 Nov 2025 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110178; cv=none; b=qWf86AomDANksM6Rq6B8613gW90oX/kFjDTmdTFfgdJPI28U+bwrXhdFayXg4c3y9yxFrph7GkmQVuyfsQ4EwhcctHgWzBX6BLl0ldt4H+/xPulJ5cYQtRguWby8rnOW2wuam/CfHpLls4KoDBEVHe5kgYE3+KVWRLQ+DyxVIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110178; c=relaxed/simple;
	bh=qhWrVdkJl/bh943Rpg/Moi+ra3osyEZ5mvlznsHPeR0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K8UCW8z3yes6iLkFnosOhc74CyywpFkN3aXgcx8Mo05wFHUhGexEhQkyupbxQr07cW+lf2yIEo8NTYc9prf5xlx+Oqzuk7L9hD/yCMOcrrPrk65rJrkDIFPUJQgJOnh0anKFtrpFxeME7V10XroCn+k49aobpBEBqvM5Yxex9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY8XsgSq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477632d45c9so12829775e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 14 Nov 2025 00:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763110175; x=1763714975; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YeYjS1oDyvjSvHSS5QjEowfSx3Ga9VJevXqRCYptZeQ=;
        b=hY8XsgSqBR0Rp6d2MBEckJb3Ero2aZNqSBZemerRgFB1SL6m2WxoxlfKsUKf/XE2nm
         2UTXi9AUxQQWbSOgVZdOuDKXyb418BCjpID2pgWp0w0ucDTIO0SaiUxoPKnlsSK6AOIY
         /0QM5/gwL9bKwcE+MxLIO4gp5fwmwLcJuqLmkipV8spTzNRvujSWh9jm2cIWpoUQtu+m
         zQM1InoHGjiCBtJE6nEnXYf4PZ6Cd0uDsXz3wtNGE6JWVxp79ycLtFekBMDJ/ql4AnCF
         +SFex5vbAeRaec4HbOZo/S2gbddCrQEfAqhbotubEFrsLyTyTOFtL5oRh5gNdm0GMilE
         xS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763110175; x=1763714975;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YeYjS1oDyvjSvHSS5QjEowfSx3Ga9VJevXqRCYptZeQ=;
        b=xNXyZ4VVetlGwyekJregUg8cdnB+KenMG5FuKrwMrzm1z8byM642mUiCg5I0lVLwnD
         MJsdafeg6t5ePGRC0uiFsoDOYpfsXg4VAVFzNVaZYMI1bsqKml9JMtdrBxTwqVGfqkIr
         CNwCqztttqnm3uem9h5vhqU5ag9/kFShvCCeBcy+Bs861RWKGX/WVjfbfB6qGHtiw8dF
         hZzuctRdis+ES0xHsx0hhNkxz6Ay4R5KsUSBoaK2GPhaSnEoyXK/rwdO3T33klgpz4KV
         AB8v4VA+FTLmxLmJTsrORVsD+2Bq+n38rZKLCHnJ27x0mpnQj2OiMoG3W55IRcfH0Kfv
         SRPA==
X-Forwarded-Encrypted: i=1; AJvYcCU61MdZ/cJ8FnqJ0OCvVuR257NEeGW7faMOlKkYTd04mfpXnT/SY9sF7nPPKsRWFSLTUbgdo7aQfT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC7Gz8+5qfKqL1HHbG0V5bFCh44F5i3NLKJFj4ZLJBtU4tFEgo
	SMXGFOLGKQ0DKQLJSEPAj5jX/p+fhXa0w+aE69ksForYLBTWdS8b0udVgDx/sQ==
X-Gm-Gg: ASbGncu67oKqouEPgvtPGecYNStuAX6L0Uh1sjUwt9tFtaqL2tg1DvIAZM3afHyFJRx
	pmdiMAfw6urN4KAlfxjZuyDl/1qGGoXgdlo9+62ozLe6OXDXvT7pnRmyGISb4Q3dYtbcvV0QCEH
	rKry3fclYRR8uDbSWI9rGzHuFmwa0pnqQv9Rytd6nCzcKwZesxg8JXKQDwnWdEPI86kdN1LXb2C
	vIixnNn+yJBwUqWr4AakfbNrXuPB6iaYnNWGhyzxYd8xJeBJyaRlxj69boVjOCH33p6NNPzZqqw
	3xEPCTVvVjfGewKiRmpeiueCis9MoVGjCdqMpxytUmY3LNr++SVffLKqGQr6mMlK0/wpbOo68/1
	4Z1fyNeY07f85To3gyrvmG1OrcDAfCJmuMUGiGTFBwFac0P8jnKIW1AQtKtI4C6qYAogl0F3TBJ
	fkAJcVl0ym
X-Google-Smtp-Source: AGHT+IEkod5fG6AAsH4ctHoDhGlcXc5CZv0N8Qu+3OArUyWUzrS5cYCQoO9x4HYN//zKqgCfS/g6sg==
X-Received: by 2002:a05:600c:c4a1:b0:475:dd7f:f6cd with SMTP id 5b1f17b1804b1-4778fe96c46mr20560365e9.35.1763110174886;
        Fri, 14 Nov 2025 00:49:34 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb454a6sm40623555e9.2.2025.11.14.00.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 00:49:34 -0800 (PST)
Message-ID: <149fcf8e5df47fd94f9596498e9bfd7171cc7c5c.camel@gmail.com>
Subject: Re: [PATCH] pwm: adp5585: correct mismatched pwm chip info
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: ziniu.wang_1@nxp.com, laurent.pinchart@ideasonboard.com, 
	ukleinek@kernel.org, nuno.sa@analog.com, lee@kernel.org
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Date: Fri, 14 Nov 2025 08:50:12 +0000
In-Reply-To: <20251114065308.2074893-1-ziniu.wang_1@nxp.com>
References: <20251114065308.2074893-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-14 at 14:53 +0800, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
>=20
> The register addresses of ADP5585 and ADP5589 are reversed.
>=20
> Fixes: 75024f97e82e ("pwm: adp5585: add support for adp5589")
>=20
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---

Ouch!

Thanks for the fix!

Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

>=20
> =C2=A0drivers/pwm/pwm-adp5585.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> index dc2860979e24..806f8d79b0d7 100644
> --- a/drivers/pwm/pwm-adp5585.c
> +++ b/drivers/pwm/pwm-adp5585.c
> @@ -190,13 +190,13 @@ static int adp5585_pwm_probe(struct platform_device=
 *pdev)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static const struct adp5585_pwm_chip adp5589_pwm_chip_info =3D {
> +static const struct adp5585_pwm_chip adp5585_pwm_chip_info =3D {
> =C2=A0	.pwm_cfg =3D ADP5585_PWM_CFG,
> =C2=A0	.pwm_offt_low =3D ADP5585_PWM_OFFT_LOW,
> =C2=A0	.pwm_ont_low =3D ADP5585_PWM_ONT_LOW,
> =C2=A0};
> =C2=A0
> -static const struct adp5585_pwm_chip adp5585_pwm_chip_info =3D {
> +static const struct adp5585_pwm_chip adp5589_pwm_chip_info =3D {
> =C2=A0	.pwm_cfg =3D ADP5589_PWM_CFG,
> =C2=A0	.pwm_offt_low =3D ADP5589_PWM_OFFT_LOW,
> =C2=A0	.pwm_ont_low =3D ADP5589_PWM_ONT_LOW,

