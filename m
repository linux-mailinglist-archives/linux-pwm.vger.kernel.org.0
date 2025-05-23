Return-Path: <linux-pwm+bounces-6100-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B992AC1F59
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 11:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6CA1C01C5C
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 09:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2019224AF7;
	Fri, 23 May 2025 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fxd9gY/8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE229224244;
	Fri, 23 May 2025 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747991364; cv=none; b=axpZRYHobf707nHQ28uEkx/ffHD0F0gXSJ05mZaSg9kbESAx13lqXd08Yh8iCCp0QZIS+v/yQEuE6MGqb8i+AbWawU8XhujHFC8F6qw2SdzQbzcAqIqJxypgiBJmhIg0EZLUk9jmkfI947EZ5H327nJcO2AVdWefYizR7Z0K9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747991364; c=relaxed/simple;
	bh=lW7WtQ2vlF2Wd82UclrK1JSl9S2LF9/UCtgR3hlKKjw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aUdNoEPHYNYRh0cM8hwxn1HZh9YzxUFgaobauuC2/fW/F34zn46mDt5Kb6FPV96ZnflHn080VWXbdwd18klWW/F5s0ghIr1SfuKkld6nwHiHcupmmwQLQFwa2W6Qfs5CpWm8QU3r/hjZbytGdGMKw1yvj8wfEDZxcE69G67lYLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fxd9gY/8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so98771445e9.3;
        Fri, 23 May 2025 02:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747991361; x=1748596161; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+AP8LZoG25l93LAAiXUjrH09qdNvVnby2FpvyeZp92o=;
        b=Fxd9gY/8X6UAY/66g6ho8St1+KFQG0NY3a6AuI2kfpRD/2nAtj60RSGjZ3fYBMQKL/
         W6zPJbE3/EtOvgRwbz17nLSQdorqllxYzgG6CRAwX/Xu7zg4LPjHP0KDs7csFOCd7/5H
         MHv5iOkI3aL5WgLQTBsOtZJLzBlPoGYrsK6aun5NNT/zORQ7adTdnVIKBvsHGYQWgAwT
         Rxj/7J+CIAsdFMq82LNaD1RPnF1PhW0IXs3ovdjNu9HLVTZlJSCRyf/gesKjqWL2FSSs
         63epKGNJpdMwjI7/kCXB8hCzMz5HJ7StriCVA/h4JbeOftwl1SU9WyfB76zc3EKaNvQU
         lslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747991361; x=1748596161;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+AP8LZoG25l93LAAiXUjrH09qdNvVnby2FpvyeZp92o=;
        b=fj2SZTFi802vf/dSKX3MEZ0TJIOHt2uRZkp+l/9MI6gHXYJ5wQTTHVUWEykM/PJZA7
         ODMHweNJbJ1dXcbo3Hsd4hygcFrLg9e0ANtACIWt78x9JG62tisoIcJevy153ZloHcm/
         LZ4zccH5pFG7NX9HYLVXXVlXNTjm8C6NBgzjbb5IMJ2hC6sjAsi7pnk+C6vL8ZV7tF7c
         HpIcgUJyyjNepHfE5KgYXscpTxpy4ZS74M2PnA0kADbLG2A5024JbKtF47l3km4vH61b
         QpxccJ5CRiIFtimw3gJil22ArJswSiiY2I/fzgJsbb3n/Lc94kp3YYn1jBsSW1T1MeOg
         DhuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNwmxV0fiCy2MCA/9ADLYLqpYngVEzDTr4LHburzi8blQQ7CH9txaSJilrMEqB3IuoEM4Gs6lC/JK2PpuT@vger.kernel.org, AJvYcCXq6bgiOUzQgPxGHkpWjXfbDElrEhAq2W75c7fRFNg1MEI5LbEaBB4atbrGG1yFU1Ftljwka+MKN7XD@vger.kernel.org
X-Gm-Message-State: AOJu0YwolIBWbcc2omTb0KCNPnexkmHG2RSaNwwBiGG0M+ixRw6Oa1Ep
	SjyeLGqKZKcuKjNzF951FnLhvvccyeUnZ13P2jqrjvkXupdtsUhzdXsVClQInL6/
X-Gm-Gg: ASbGncuFULAdygbtHks3X5l7pBg1V73o1FWxs20bX+UJMSXEow8BtHPliqT0eAMWMAP
	NFn+NHgO4rforjlzz2t6buNYHGY/K4pKbEPrW7nH36ks/4bhqK4XG3xJeUJ2Bj93IG05AybgvRj
	CRjILP+e+wUvof+oNm2ghczRQHGAatZ4Idl6a9vEY4tN+yle6EkXxC6kWeV2A5h5gAKAafLfQHc
	e/WyCog6jqe63G8BJhffCfp2k0MUOsSODJYQWQ677XgL5y9mmKf5GQsDVkhf0TrE/8z2joBxe0A
	LevqNkBAmx4jgXqY1IOARXkpJFfSyQbcZNmpFPRbfTMJDjZuWRUxHzQ=
X-Google-Smtp-Source: AGHT+IFlCbanJtgwwqNJsZ4IcpUy1GJzGJ+c40q3HPEhx/L+0W/eUlETwtP4KjCbM/5ysYMU9EAwAg==
X-Received: by 2002:a05:600c:890b:b0:442:ffaa:6681 with SMTP id 5b1f17b1804b1-442ffaa6b6fmr178704095e9.28.1747991360643;
        Fri, 23 May 2025 02:09:20 -0700 (PDT)
Received: from [100.73.1.233] ([185.128.9.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f381465fsm133670215e9.29.2025.05.23.02.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 02:09:20 -0700 (PDT)
Message-ID: <92107be5d4085f934c725d31177aae00b971984d.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] pwm: axi-pwmgen: fix missing separate external
 clock
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich	
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Trevor Gamblin <tgamblin@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 23 May 2025 10:09:22 +0100
In-Reply-To: <20250522-pwm-axi-pwmgen-add-external-clock-v2-3-086ea9e6ecf0@baylibre.com>
References: 
	<20250522-pwm-axi-pwmgen-add-external-clock-v2-0-086ea9e6ecf0@baylibre.com>
	 <20250522-pwm-axi-pwmgen-add-external-clock-v2-3-086ea9e6ecf0@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-22 at 09:49 -0500, David Lechner wrote:
> Add proper support for external clock to the AXI PWM generator driver.
>=20
> In most cases, the HDL for this IP block is compiled with the default
> ASYNC_CLK_EN=3D1. With this option, there is a separate external clock
> that drives the PWM output separate from the peripheral clock. So the
> driver should be enabling the "axi" clock to power the peripheral and
> the "ext" clock to drive the PWM output.
>=20
> When ASYNC_CLK_EN=3D0, the "axi" clock is also used to drive the PWM
> output and there is no "ext" clock.
>=20
> Previously, if there was a separate external clock, users had to specify
> only the external clock and (incorrectly) omit the AXI clock in order
> to get the correct operating frequency for the PWM output.
>=20
> The devicetree bindings are updated to fix this shortcoming and this
> patch changes the driver to match the new bindings. To preserve
> compatibility with any existing dtbs that specify only one clock, we
> don't require the clock name on the first clock.
>=20
> Fixes: 41814fe5c782 ("pwm: Add driver for AXI PWM generator")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/pwm/pwm-axi-pwmgen.c | 23 ++++++++++++++++++++---
> =C2=A01 file changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index
> 4337c8f5acf055fc87dc134f2a70b99b0cb5ede6..60dcd354237316bced2d951b7f0b116=
c8291
> bb0d 100644
> --- a/drivers/pwm/pwm-axi-pwmgen.c
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -257,7 +257,7 @@ static int axi_pwmgen_probe(struct platform_device *p=
dev)
> =C2=A0	struct regmap *regmap;
> =C2=A0	struct pwm_chip *chip;
> =C2=A0	struct axi_pwmgen_ddata *ddata;
> -	struct clk *clk;
> +	struct clk *axi_clk, *clk;
> =C2=A0	void __iomem *io_base;
> =C2=A0	int ret;
> =C2=A0
> @@ -280,9 +280,26 @@ static int axi_pwmgen_probe(struct platform_device *=
pdev)
> =C2=A0	ddata =3D pwmchip_get_drvdata(chip);
> =C2=A0	ddata->regmap =3D regmap;
> =C2=A0
> -	clk =3D devm_clk_get_enabled(dev, NULL);
> +	/*
> +	 * Using NULL here instead of "axi" for backwards compatibility.
> There
> +	 * are some dtbs that don't give clock-names and have the "ext" clock
> +	 * as the one and only clock (due to mistake in the original
> bindings).
> +	 */
> +	axi_clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(axi_clk))
> +		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to get
> axi clock\n");
> +
> +	clk =3D devm_clk_get_optional_enabled(dev, "ext");
> =C2=A0	if (IS_ERR(clk))
> -		return dev_err_probe(dev, PTR_ERR(clk), "failed to get
> clock\n");
> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get ext
> clock\n");
> +
> +	/*
> +	 * If there is no "ext" clock, it means the HDL was compiled with
> +	 * ASYNC_CLK_EN=3D0. In this case, the AXI clock is also used for the
> +	 * PWM output clock.
> +	 */
> +	if (!clk)
> +		clk =3D axi_clk;
> =C2=A0
> =C2=A0	ret =3D devm_clk_rate_exclusive_get(dev, clk);
> =C2=A0	if (ret)

