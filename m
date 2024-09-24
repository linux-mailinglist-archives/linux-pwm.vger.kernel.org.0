Return-Path: <linux-pwm+bounces-3350-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3073983D91
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2024 09:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BC42810DB
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2024 07:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20BF12C7FB;
	Tue, 24 Sep 2024 07:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpOrVQtX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2852F870;
	Tue, 24 Sep 2024 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161658; cv=none; b=ptsG+7RKyiyLniDnR200BoTmnE8t65LLJuwbGpoZhoHNmdcuM2HOPvK9gN4hVe/IPrBFqBw5B9VKSKdWAYm+o3ud8rrOmvbSZKn28j6u6YcOkr6YkOHvf4sO5KuSWJitWUUOq1CwgPRS5u0LZ3xFz0qW+XwbGS5Z7D7AM41uSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161658; c=relaxed/simple;
	bh=LusOixPIEihzkNGxEaRVYOgMp9CGVjC235iqe783FsE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jVKGfjyxVFT0Prh3utzGA0u7wYryb3/VLNkcfZUUNINGF+LS9hXHM95EuKpMAvUzJeQ+F6eaF70u8+tOxD2kUCnzqhN9R9zKl6ED083qfOKnKTY2W9G1y4yEVH+pz3W1PIj7NQYjLqXgobA/ni8tODSYRFtJdCQ52HLlgW07ANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpOrVQtX; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c2561e8041so7130316a12.2;
        Tue, 24 Sep 2024 00:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727161655; x=1727766455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H/SZ96mhvfmweQ60Q5E5P959Yd7EdsII+tg5+PPqOoc=;
        b=QpOrVQtXhSbFp+1meub22NiP19v0Q4uuw2szQEahrXr7YRb0adtb+5zTYSQYyQjZsw
         mCSpOha5dQo3jFaSBJizOvbjlxyWVNWk3WsRcJ32T+zDTW/otWMYWwWslmNUgRk5GU9k
         cImrqC8HDPz4dBZqJvIJ1sFu44Va2jhCKLEkCS3kO7EM2a1U6DKYRi9gQytRmRy9aSh9
         6a/uHYrnKxaiG8D3Gpx2W/vIpspZOnBXA4J7u0fLhIaAOdQPSaOvZ9Y/ltGdRC+ifZos
         FunyChnZ0FJhyIHzs8sOCyoBp32UVUDzS/4vNncOrio/0deBjg5HgVI4y/lhxWItFW91
         VIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727161655; x=1727766455;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H/SZ96mhvfmweQ60Q5E5P959Yd7EdsII+tg5+PPqOoc=;
        b=p5BK3HhjJKXYX007NdRsU5XX0xdbgsM2cf772CIttPF5I1rT73rEVEBFiFIV0q6otN
         6xZ3CJV3q/gTINSBKL/qlbfHVSoL83BMCDvvrkjRTldTVcd2D6Vx2F9onDh3Y8tWBcuS
         moZaXOyhdYrVLeTuH9mIeR7QXhYXVN/wMvU44UAgkqA9pcV/Chi9/Cl5o2prrMvPcT+I
         /5cs6xVNp9CwvXPe0viUBGfRjE+6IVzzCdAq5obezvBngvtcDwq5GzzhG2eHbyC+vr2Y
         C4v7GhSMm+SzuTfwEzrYaeSMvyMCQyOUn3o2hoQ8jD7PlDsxPLJysLLTj+3pXalmX5IF
         lgAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6m2ZmkTgsMqEYnPxSVd4m0wcbEBEILSiMS862ubKAXTMDVmaMODQ/e46psXOrGuyh1brs+cFwuT5yeIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCM3TT7/z9mibUQM96xztpDwvf7to4IbeWp7leRopRS9FUpBXH
	Aiyx7GRK8O1PkjreTAiF0nwzg09bkQtmH1fceX3eTun4BB5x9wa+m45a7adbKsc=
X-Google-Smtp-Source: AGHT+IHkcliqxp/sd2zZNzMnqY3l8lSVD0gNPkKmkMmRPrXsT9dZ19UQkUHvQZWVKFFf5YCAfRwm2Q==
X-Received: by 2002:a05:6402:5110:b0:5c2:6090:4047 with SMTP id 4fb4d7f45d1cf-5c464a3aaa9mr10803025a12.8.1727161654949;
        Tue, 24 Sep 2024 00:07:34 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf48c357sm456825a12.11.2024.09.24.00.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 00:07:34 -0700 (PDT)
Message-ID: <2bf20010512ce94c117cb0e58313e72c7772d3c5.camel@gmail.com>
Subject: Re: [PATCH] pwm: axi-pwmgen: Create a dedicated function for
 getting driver data from a chip
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 24 Sep 2024 09:07:34 +0200
In-Reply-To: <20240923125418.16558-2-u.kleine-koenig@baylibre.com>
References: <20240923125418.16558-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-23 at 14:54 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Compared to direct calls to pwmchip_get_drvdata() a dedicated function
> has two upsides: A better name and the right type. So the code becomes
> easier to read and the new function is harder to use wrongly.
>=20
> Another side effect (which is the secret motivation for this patch, but
> shhh) is that the driver becomes a bit easier to backport to kernel
> versions that don't have devm_pwmchip_alloc() yet.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/pwm/pwm-axi-pwmgen.c | 9 +++++++--
> =C2=A01 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index b5477659ba18..e5162f3e511e 100644
> --- a/drivers/pwm/pwm-axi-pwmgen.c
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -53,10 +53,15 @@ static const struct regmap_config axi_pwmgen_regmap_c=
onfig =3D {
> =C2=A0	.max_register =3D 0xFC,
> =C2=A0};
> =C2=A0
> +static struct axi_pwmgen_ddata axi_pwmgen_ddata_from_chip(struct pwm_chi=
p *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> =C2=A0static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> =C2=A0			=C2=A0=C2=A0=C2=A0 const struct pwm_state *state)
> =C2=A0{
> -	struct axi_pwmgen_ddata *ddata =3D pwmchip_get_drvdata(chip);
> +	struct axi_pwmgen_ddata *ddata =3D axi_pwmgen_ddata_from_chip(chip);
> =C2=A0	unsigned int ch =3D pwm->hwpwm;
> =C2=A0	struct regmap *regmap =3D ddata->regmap;
> =C2=A0	u64 period_cnt, duty_cnt;
> @@ -100,7 +105,7 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, st=
ruct
> pwm_device *pwm,
> =C2=A0static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> =C2=A0				struct pwm_state *state)
> =C2=A0{
> -	struct axi_pwmgen_ddata *ddata =3D pwmchip_get_drvdata(chip);
> +	struct axi_pwmgen_ddata *ddata =3D axi_pwmgen_ddata_from_chip(chip);
> =C2=A0	struct regmap *regmap =3D ddata->regmap;
> =C2=A0	unsigned int ch =3D pwm->hwpwm;
> =C2=A0	u32 cnt;
>=20
> base-commit: 62f92d634458a1e308bb699986b9147a6d670457


