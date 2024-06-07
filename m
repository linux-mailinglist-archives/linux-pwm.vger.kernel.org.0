Return-Path: <linux-pwm+bounces-2369-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE478FFC50
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 08:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152771F235BA
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 06:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9B914F137;
	Fri,  7 Jun 2024 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiwKUFc+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E629CE1
	for <linux-pwm@vger.kernel.org>; Fri,  7 Jun 2024 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742208; cv=none; b=uzYeDOeq5LY9pVP1/MkuZETNpxv01u6GhQ2jFcscWjnB6FRcq9xpqvN7AFzs0GAdyKOP+DA0VN1GcaGr6/6xzs3kKPaNw6501GX1um6/wtO0+DbybhKmMtSYQepjcIktIbJKNNBEZqz+afqzy2Jny9aCrl35XpnsXF949aQHN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742208; c=relaxed/simple;
	bh=2FibxVVT9Lkc6+KLyyH4CUcM53GdiN2suhXZBgKl3oU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IKN0Cx2OsggFYzc6HhvKDPRj+44wFdNcHBY71lqeQB0iPTGxDmTRSjF1SDR842iPt8a2yU/aPZcvihm3WkSOY41BJtn2Clg/EdlYEb2L6b3VfDK4u36I+oa2zu6MT6hv5qIYoYgtKfyqmxId/e2u7UhFehosPoG6brUxrkC24SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiwKUFc+; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a68b0fbd0so2018902a12.1
        for <linux-pwm@vger.kernel.org>; Thu, 06 Jun 2024 23:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717742205; x=1718347005; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gJC1lYcVeKDKlx80+SsHySKwEMWdr+jQfJ8oEahhv5w=;
        b=RiwKUFc+CLD1GS9KqKPht+DPtdZtS+k0Ppjr/RXABtl/jOeZV3dF5PYdmZa7DhA8IW
         xp4Pay2IjKRLIaSnxKkWR/kcnjeq9v/wVArTWD1dK443sDu4B0siKrCkD5iN0cqX9bTx
         a97wSP0vX7Zrzx+zazuky1xxhVi37ST5i4fLSJ0IsemH6kqJEMQ9BJz5sN97r0aso6LH
         uyCSIadq4rkCHzDs41TVXZARW9vB31yrWayWwPgltfzWAibfQ8CW65mFKbMd1/STPuNM
         sa883icCg/Dkd4A5INkZ5w66fkyWF3j7jgm+l19jk3+z9yS0WSx8a11iTZzv8vC63n0y
         WBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717742205; x=1718347005;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJC1lYcVeKDKlx80+SsHySKwEMWdr+jQfJ8oEahhv5w=;
        b=jOxaC5f8P7uSpB2qT4xjLv5o6Xub/Xfciv3cfZ1fPyJaa8h5K3/pUSNtF3RUtZA9sE
         SM0P3Zqifu8RvaqTvzYKEZpTH2Mm9REmSfeGenD90yHu85LK6TDc9jPbgzzEsZRkPKd4
         zhfzSpEYY/B2S72A3hknuYCziWt1dH++fkgfDl3brHxnIN2ZFKbWpoiPuv1F0Ec+NxRn
         8qAXwQ8OyJhchLbL6IRP5+Zi3eM/QDkgP5VytWvm6n7P6SRV7YJ1Hw1oMDW8Z+66KKaS
         mzWxfxEwi0VKzs5DbwnHR6v/KBtcNt+i6SdFPUTv26Ytu3VMy0fyqmr+V2k0jbWFssiS
         B0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3+3g3tdLzsGYfuDTFc1Eql8+T1EqmJ+1J5gdkNIAz+hj+R13JuliqGAhcJvzUWWpwzsqqegensVsMX6voZocMJAXTc1odwNw9
X-Gm-Message-State: AOJu0YxtH6kLj3S9YwBHxx8e4bQriq+kdX3RnR0yLdKwklehe/i9HhXq
	UQszUuXT+1UQkY2yfbWhuIELtTPF77FujWXoi3d9za7BTqr0D7Bwecd4rtoXW/U=
X-Google-Smtp-Source: AGHT+IFoDb5RRVyqn2gwKthGjayD2letCqPqV/R3PT9vqzKN00RxY39bdB1wIhpYZDNydc8On1DNLQ==
X-Received: by 2002:a50:9f45:0:b0:57a:2158:bbf9 with SMTP id 4fb4d7f45d1cf-57c509a812emr820180a12.33.1717742205093;
        Thu, 06 Jun 2024 23:36:45 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae23a0d7sm2232694a12.95.2024.06.06.23.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 23:36:44 -0700 (PDT)
Message-ID: <3755faec8dc7048da880ef6b924ed2e5a224bfef.camel@gmail.com>
Subject: Re: [PATCH 2/2] pwm: axi-pwmgen: Make use of regmap_clear_bits()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@baylibre.com>, Trevor
 Gamblin <tgamblin@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, linux-pwm@vger.kernel.org
Date: Fri, 07 Jun 2024 08:40:32 +0200
In-Reply-To: <20240606164047.534741-6-u.kleine-koenig@baylibre.com>
References: <20240606164047.534741-4-u.kleine-koenig@baylibre.com>
	 <20240606164047.534741-6-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 18:40 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Instead of using regmap_update_bits() and passing val=3D0, better use
> regmap_clear_bits().
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/pwm/pwm-axi-pwmgen.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index 1bd4150e0158..aac4f395497b 100644
> --- a/drivers/pwm/pwm-axi-pwmgen.c
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -156,7 +156,7 @@ static int axi_pwmgen_setup(struct regmap *regmap, st=
ruct
> device *dev)
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Enable the core */
> -	ret =3D regmap_update_bits(regmap, AXI_PWMGEN_REG_CONFIG,
> AXI_PWMGEN_REG_CONFIG_RESET, 0);
> +	ret =3D regmap_clear_bits(regmap, AXI_PWMGEN_REG_CONFIG,
> AXI_PWMGEN_REG_CONFIG_RESET);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0


