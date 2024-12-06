Return-Path: <linux-pwm+bounces-4262-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9E89E6281
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 01:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4594C1631F1
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 00:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A9246447;
	Fri,  6 Dec 2024 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd2zo51O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C72BB09;
	Fri,  6 Dec 2024 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446277; cv=none; b=SkC5h6/f3V8sy77pwssuWzVmuDo2d0oBzAFyuJls57hPfhSG2ZFIOjBcSBpDuVme+ma5tJlIHF/a2WEFLqL0dI8Jts0UYxpkQJpH4+mmZ0xNzGGc6NV6LY6J43NNp24TtuIZRqaeO0DL0x1zs2f0346RR/jCygDXs6kET4zIucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446277; c=relaxed/simple;
	bh=78rE7sFM5hMSVUktXfM1DYZzRFvqYEeXK7x5OI2RSGM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gIEwusqdH49wQS/ystN6FrPrCu3o/f16zzE7PLdnc9j8J63sarcIevuoe7JsCYBZVKJMz1YFmG0ED9g4jrhrHuGAis4hqETPlbziJlOd0zhn6Y9qGFsSniDESjQpFEyuRPTFJKBHoIARJY04C1ZGIYJD3IeGRoGCP90TEWTvo+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bd2zo51O; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d882619044so11687726d6.0;
        Thu, 05 Dec 2024 16:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733446274; x=1734051074; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78rE7sFM5hMSVUktXfM1DYZzRFvqYEeXK7x5OI2RSGM=;
        b=Bd2zo51O4YoA6ss4Xt/oj2FNumARB+wFtekUhZvPo+I/HSvgnAkDQfUmsFCD/27hOj
         ji07Sz93vqVOdaZWt/05E5jyd5hx3eagel1lKktjgGz9u67xkdKr14G3f1sepUa24Us8
         d+qOHYjjenw08TxmT2MkQkqjh99ew+AwqoQqm3NwHzAAfSogs2IJpO4xKenWvPxCYDAK
         2USVT3Qq/eZuGa5nesnajCp56jEo19Ncf7WrYL0/IbYH/7fO30/Tu23GCWE2E2f1y/5B
         huJgugZufn0PBoSt5e1Wvyw77gfs4BDUYmkRHBJ4WQn1SI9pD6WwY65K9PWPnzFsXTdK
         tdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733446274; x=1734051074;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78rE7sFM5hMSVUktXfM1DYZzRFvqYEeXK7x5OI2RSGM=;
        b=lvhMwtiTkm7Dt+BlSoKye0Q4T4gWrdODkm/ncJB9KgzVun6kAiWyCtsC1hcMf+VC7K
         NO54GVYxmG5dX91qAj4jyiHGUzk+MV6NkXPHgkqm1GY5uH3+qA10YFyCrovDBpsLyTC6
         CX3mOsrbRNa1t2rrxVHqKjLFxk7XoAQ+Q9BCvctatv4TVSuRsi0MxbAW+eo0+oqNnFpA
         TCuGATFDl5jXhNbLXR+XvspJmKkvzLjvVu32p5gFY1jdy16Irp76acqh9D019VeckD0C
         edVRb3LsgMjjXm2Kp6bbsGuTby80Q7N319oLlsgrTzY4dQtDO8+TB70exwVHeOP/XOl3
         SxxA==
X-Forwarded-Encrypted: i=1; AJvYcCXLAPvR+7k2zDmm9ffITnAL4rFwvtbkXxt/P3nNvp8i1Keu09/u5TE0Xvr/78HvwqA2B9BC6aMNvNFbEsU=@vger.kernel.org, AJvYcCXQhe95Za8kUYyDmdQI1U13n5O3P2hcnhQzwkOs8Nyg05RHYy285cNYHNox7alwAQTVhq681KidD7r3@vger.kernel.org
X-Gm-Message-State: AOJu0YxZfPq/ai2iJ1mfOeczZC7933W5AJ+5jNYPLYqizv4A8eYLF9go
	4oseVEc/vsxaRJjAsdJIVPxEKXljkUhktSXuqsDlVQnp8R2/ID+J
X-Gm-Gg: ASbGnctk59A5EJC+8NjMxbYkRwcF+3XyeCbAtDH4PNERn1XsVI+sKOpTyNI4j4rXPA7
	7QQcXxAdG/BrfTad7YaM4tDMdTbsoVpjDZSnNxIScxV8v3DyeIaETfMuxDvz/hD6nvH+qpxEKZw
	UxTYpZVWBF/vPqdZ3J8audyzmv7JlRZHKl7r9agcWH3w44TbXr3dphyPj1CjoeDEhEQyBnNQkuY
	8Q6DGcaC/XBq07bH27tdcGaV18hdNBTgK/q5FPvBa5XLCdB8qJdVbzEmlnID3DdjogNO0dtqWc=
X-Google-Smtp-Source: AGHT+IF/sk9ZB235pUfB0O6hz42Upg4C3T7QSAhoiMqwmiLWKznlOnX/VWzkLXPVN06gb5l37ZaJIQ==
X-Received: by 2002:a05:6214:ac2:b0:6d8:d240:9f26 with SMTP id 6a1803df08f44-6d8e713feb7mr22257846d6.16.1733446274340;
        Thu, 05 Dec 2024 16:51:14 -0800 (PST)
Received: from smtpclient.apple ([2601:803:8180:ace0:901f:f4c2:743b:7118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8dabfb438sm12583646d6.106.2024.12.05.16.51.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2024 16:51:13 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH] pwm: stm32-lp: Add check for clk_enable()
From: Mingwei Zheng <zmw12306@gmail.com>
In-Reply-To: <geyicxufezkbu7cdvnbgnr2qeuwrn5ubz5ent3spk5biuozxrs@gsqx2chgiiot>
Date: Thu, 5 Dec 2024 19:51:00 -0500
Cc: fabrice.gasnier@foss.st.com,
 coquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com,
 thierry.reding@gmail.com,
 lee@kernel.org,
 linux-pwm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Jiasheng Jiang <jiashengjiangcool@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5778D1D6-9C2B-4456-9765-213120076C62@gmail.com>
References: <20241205051746.2465490-1-zmw12306@gmail.com>
 <geyicxufezkbu7cdvnbgnr2qeuwrn5ubz5ent3spk5biuozxrs@gsqx2chgiiot>
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
X-Mailer: Apple Mail (2.3731.200.110.1.12)



> On Dec 5, 2024, at 3:34 AM, Uwe Kleine-K=C3=B6nig =
<ukleinek@kernel.org> wrote:
>=20
> On Thu, Dec 05, 2024 at 12:17:46AM -0500, Mingwei Zheng wrote:
>> Add check for the return value of clk_enable() to catch the potential
>> error.
>=20
> Is this something that you actually hit, or just a janitoral fix you
> noticed while browsing the code (or reading some checker output)?

We detected this through static analysis, instead of actually hit.

>=20
>> Fixes: e70a540b4e02 ("pwm: Add STM32 LPTimer PWM driver")
>> Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
>> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>> ---
>> drivers/pwm/pwm-stm32-lp.c | 8 ++++++--
>> 1 file changed, 6 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
>> index 989731256f50..4abef304417d 100644
>> --- a/drivers/pwm/pwm-stm32-lp.c
>> +++ b/drivers/pwm/pwm-stm32-lp.c
>> @@ -163,12 +163,16 @@ static int stm32_pwm_lp_get_state(struct =
pwm_chip *chip,
>> unsigned long rate =3D clk_get_rate(priv->clk);
>> u32 val, presc, prd;
>> u64 tmp;
>> + int ret;
>=20
> Please move this variable to the block where it's used. No need for =
such
> a big scope.
>=20
> Otherwise looks fine.
>=20
> Best regards
> Uwe

Thank you! We will submit a v2 patch for you to review!

Best,
Mingwei


