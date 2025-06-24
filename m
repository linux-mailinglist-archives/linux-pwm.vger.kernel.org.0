Return-Path: <linux-pwm+bounces-6506-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF2AE5FBF
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 10:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C179A164B64
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 08:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B34F26AA83;
	Tue, 24 Jun 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ypx08xSX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FD71C84DF;
	Tue, 24 Jun 2025 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754690; cv=none; b=ueHe4c9Im6EYuCV0+KENPaJ5+I7bLwq/sEUlZH6T+ufAIoAU7zP6hDmQagdKfsMdDVQw2bUFjMswVDoSqrM97Ftc7lB5zixOQrtq9E7B3h0XyuauIXCobYXrq7UwjGEHNuVMDaGSyswpUBM63tR1OSVVpDhyUym9cRG40y3g4fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754690; c=relaxed/simple;
	bh=OPaz9QhS73ELVN4z+SRdOOMsV90T2e5KyJE8ujJwpqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6hymNt629Rxpjy19PrLvZdMT7jxo1dRKETL5vEXP5snm/TKQElyo9zqgjmeRE0Nqm1/gOpe5zzGyc6Yqylj2/tDOerdVnb672Ezx0vNyLl8IKQ92JEvBN24a2YpQyFmW7Pg1EqcHUjKBm5w7URNVHjP2GTLS5YUah18sBPXvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ypx08xSX; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso31255266b.0;
        Tue, 24 Jun 2025 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750754687; x=1751359487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPaz9QhS73ELVN4z+SRdOOMsV90T2e5KyJE8ujJwpqg=;
        b=Ypx08xSXXyUynp1/MTi1UUeIdOjPKRFv0104sbFpOUTUD71iprzQQMmpyietaaSm6A
         A1S9ZYnG2zWIcf4vnihJ+Ln2kzoBxRd08x5oPSnYs8PXIdCH51R2B+HPKkEWihQameFg
         tHcC409VVNPWvjI/4kdxl4CaxPnRgnHLXJew2zYST9yIGauWIT5hPck5KeZNfkUZf7w4
         fBuOTyEwBiS1WGH/Mi38Ql4tD7sj0BfDyyY6hyUNqcw+x1kMgXIBiFPapelFXHpTJQfD
         BIvpEOD6HJGW8jip63MlwKSbK54PeN4qp8zUS/Nh5Fzz5DCYPKVEPcM2haHZ59g8tp7+
         pNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750754687; x=1751359487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPaz9QhS73ELVN4z+SRdOOMsV90T2e5KyJE8ujJwpqg=;
        b=T4cR2dYp+3qASMZTuEIy/ZpOIA4r+sQHdKyc15GEfrdf6cWYm+7SZPC7vM1aL8WAMq
         aISs907r8N3Dvfs3gf0BRklY5pWYIgRE/cF+PGPD5xzDycbH0Z7iT6O1HL0FN306mEVr
         mtLbxJSM+o8+JqKFVxlDRlCY4uuxZhPBLOcdQR32ACq9mLSS98j8Nygn1Hr3CHafsTlL
         zrF+KI756pOPbI0GCwCaAvJWcgNPVysrbe3HTacV1UgeKz5O61cknc04MI6Mv85RCWdR
         wVdwnm7WzzgOPG1oCiZpPVCEWKn7ZuLj3r/iMeUkK0wKRa0nk2kdDPaG7sXu9Yfy6mo2
         nh+A==
X-Forwarded-Encrypted: i=1; AJvYcCVCLbxqlxGskaAZv9z1KiasiMZa8cSGzXbHHWiVnMHSkZw+tJ/n7m00aDs9wuJQqiW+LZiQP40DU92/iLA=@vger.kernel.org, AJvYcCWoQEtelWbaMqNA4gMGLC3MdRu5RhMEEljow0P9a8dAj1YpaT6Clhu0gCv2pDrxyn1Oht+VJNVsXcUl@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsBAWwB8cPdu0To3d7GPfxngOyvir/vKLEV5JqE2NEm2HD0dZ
	hdNXh3KqC1nFkgrkrheErZQvwe6rKENQbn3a21Ib0wu12Q8Qi3YU2/WyyVwzhYlK1CXLOitxWxw
	cvc16C/3PSOS9Q40IHTKKl2Hc7PxxGJE=
X-Gm-Gg: ASbGncvjfs5Bh+YbuWKSAuQwmpY4orz1uTRxaGAVzUXAO9Vt5Doehy5b8dSTALQo9xE
	1Z/jMxAESi0WQPA1qR8s5YyfQ9t/DvmpxqnObWSis5Xq+yFdiczuHrK+ve/6433i3GS0xbW4rjJ
	eK2JX8RcJyfSseXOU/b9zd5u2Jw9DLBR57tgqqb+ehPGL+RA==
X-Google-Smtp-Source: AGHT+IFrlIXoAz5t2e4uA+1DCy66dkxbnaZWGebAvSXS48RGi9KvCTKUBXW8RZ4GNYIBqDNMGNutgSQHVQWGgl5KgWI=
X-Received: by 2002:a17:907:3da3:b0:ae0:a245:2ff4 with SMTP id
 a640c23a62f3a-ae0a6fe05efmr287650866b.0.1750754687074; Tue, 24 Jun 2025
 01:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623211116.1395-1-ansuelsmth@gmail.com> <CAHp75VcWW=RaHS9Yb8BcK2Jt7qtNOQzA3eDOZQ88RQG63981cQ@mail.gmail.com>
 <685a5787.050a0220.20ff0f.fd7a@mx.google.com> <aFpkmjlc-14xxkn4@smile.fi.intel.com>
In-Reply-To: <aFpkmjlc-14xxkn4@smile.fi.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 24 Jun 2025 11:44:10 +0300
X-Gm-Features: Ac12FXxcBV8-uP_MMK3wBYDKM3NE8a4b9gO9vxhVWAEba-RMLjZd-YbKu2l_IDE
Message-ID: <CAHp75VdNm_3ASFytiY616KsbbhfKFOicCwwNATbFQA68ZgVbdA@mail.gmail.com>
Subject: Re: [PATCH v15 1/2] math.h: provide rounddown_ull variant for
 rounddown MACRO
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Andy Shevchenko <andy@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 11:41=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Tue, Jun 24, 2025 at 09:45:08AM +0200, Christian Marangi wrote:
> > On Tue, Jun 24, 2025 at 09:08:32AM +0300, Andy Shevchenko wrote:
> > > On Tue, Jun 24, 2025 at 12:11=E2=80=AFAM Christian Marangi <ansuelsmt=
h@gmail.com> wrote:

...

> > > rounddown_ull()
>
> Btw, I don't like name for this, it's better to be in math64 with the u64=
 or similar suffixes like it's used for div/mul variants.
>
> Also add a roundup to make the API symmetrical (yes, it's okay that it ha=
s no
> users, it's a macro and doesn't consume memory at run-time).

Ha, there is already roundup_u64() in math64!

--=20
With Best Regards,
Andy Shevchenko

