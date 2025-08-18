Return-Path: <linux-pwm+bounces-7089-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C685B29E26
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 11:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC42D1893CFA
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 09:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B90A278156;
	Mon, 18 Aug 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XO6pwTJc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC7A307AEA;
	Mon, 18 Aug 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509931; cv=none; b=hIQky0aB3fLJK2utEYcH5M/zhL+rTqOwowCJcte6WToygaX+Rk9asWH42NKLYUooIn7w/UPoZZc/rX3VnQ5dD5aU1cuVBfxjVrEEy4ovMFGxpMckL44bktXvCOXrj7uzwFiaj0acG7yKZEATzgMbJojw5MK00/xm8z6FITx16MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509931; c=relaxed/simple;
	bh=NdEYA7o1VzPQoYIPoKPNZkexWdwuehcnlbt0D0zOaP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pN9uh9OkZXTKiHENxLhypwVyhdKansBgA4ePg363UHFYbGrsuFOTW7J+63kHmdHf52DCR+AFtORD7cOGV773OVP0DOQWChBMfgyS0RaaVJ/qM6dPhFYXlheGVAuMJlDAm3tTwY+8dPO5Nta/UhYC7R2YVCBifHmttciQa/zEZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XO6pwTJc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so513701466b.3;
        Mon, 18 Aug 2025 02:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755509928; x=1756114728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdEYA7o1VzPQoYIPoKPNZkexWdwuehcnlbt0D0zOaP4=;
        b=XO6pwTJc32/5shS5aWrAsJ+Zou8ND1hHK4v03Sr2xpaxOitwWT5KcJTyd0JxjB+21x
         iDuXDV50r8LAJZHrkO/zL/nbkyWiLI4tv1yeb0ob7i8IeFDaKaCsDxMmJJ5VkNt6RRjW
         eLFfRfA0L5my+4QSqtDDuQtj3WNaELxl2hIGSm4N2bLBrEjqpPOIbWBDwEaE9KWMVGGS
         eLx5upcLGO6q3WoOKZDKFp0sGwYzO3wz6D70eq8XO9S9iWauPHW3Fd1lKQ+A5c8AAShV
         /rcAIgi0jG4iXH+aepI2nF9lm82aNvKCKRKpbSHPOsYFthSK4KdYZdJSS0UP9YP+Qu+E
         5trA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509928; x=1756114728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdEYA7o1VzPQoYIPoKPNZkexWdwuehcnlbt0D0zOaP4=;
        b=RCRBtBtfsLta267QG5bujErfPiVz6Hux1o2eEOmEix/d3c97WA8Khog9zgm6ZLXXvu
         13rdOW8boZVKVQP3y6ZujBJnGBekDAFpgCZKQNEhX+dny6f2g1NUmZXdaoWQRKVoucRy
         cMB3gAHmnvhenax2YWUBk/Qk030uKmfoe+QWs0iZN9V1TjlaLVPaPoASwsunqFN6xcLi
         xU4T2FbNGVMzXehzFrjo06G8w43iW7Tp5smCEhRStlu/qo5m5sT28cr7855kHjsODhFC
         qdh3LWOrKjskKCGw+L5vaJOIzr/q9CTQxoM1oBX99wdl5lR6R2tMJGOxDzEUhAg2KRT2
         2L/g==
X-Forwarded-Encrypted: i=1; AJvYcCUwWZHaZmG5uzApCOF3GlhASD3xWtXAH68GakarlKVEFyMbZZw4NLhsMN4UqZ7nn58p67tHrRXvHcIxry8=@vger.kernel.org, AJvYcCV70NoGiCsDhZ2/vqPIlyZCtZqu90lDd5yKkoAvJ/YdXoxObuBEpt3fjaBp9vdUEnzrcJmRIfHeZ/wl@vger.kernel.org
X-Gm-Message-State: AOJu0YwJY9sxQ6zrLrvPgLLyqh8UGxPSof0lSkLu9fQl8Gn5+D3kLAs6
	u42547z0/xjTnxjP+cSw1Tn+ApGxKTvQia0rNhlhWArYKoGSqGawUwZ3FYhUjtuJRLW1drCBDL0
	78SivMxn4dixuXAi7MBJVG2v+UIK/8oA=
X-Gm-Gg: ASbGncvo0D2yTPjgwbzopnivOnZuZeNftrPp9nFN0tIcKSRrovTlYh3vUzwn8ATZb5z
	evmxwofKIJd/IcA/t9S0VBA9eWioSWpnHX/XwExM7gyR112/b1PsoQlWD/HdWRpADg++FgHTBST
	X2yfifPsxYGG1TxxQsyheYwFc1wLVEWzYFT5mf/GCJ0Ddy6awqtqPlf09t5WXxUMr1hePt4ei2r
	UMVtkwWUk5iV/Hs+w==
X-Google-Smtp-Source: AGHT+IE05VSrIMyvebGx0unCj4GEX/dqppJmwwCUmpmbrew8a29RQ3aQtfuq56iATh9CZLY2/vFkW+lSc+G0qBDC+B8=
X-Received: by 2002:a17:906:c107:b0:ae2:9291:9226 with SMTP id
 a640c23a62f3a-afceaea7031mr791267166b.59.1755509927350; Mon, 18 Aug 2025
 02:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816104904.4779-2-xry111@xry111.site> <n5kdswq7oduruqiruyup4rcdwrs76tlinz26swotzeqklterey@off5cbv5i4e5>
In-Reply-To: <n5kdswq7oduruqiruyup4rcdwrs76tlinz26swotzeqklterey@off5cbv5i4e5>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Mon, 18 Aug 2025 17:38:34 +0800
X-Gm-Features: Ac12FXzZ4KQDTgw3dey84zGRTpNWmm8rMIDLoaxRtbeHhBij0UBaLMWuq9ycu7o
Message-ID: <CAMpQs4LqEWSoMUZpcbyknuEvf48FMMgra+Jffk0AXvTiZYjANg@mail.gmail.com>
Subject: Re: [PATCH] pwm: loongson: Fix LOONGSON_PWM_FREQ_DEFAULT
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, linux-pwm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xi:

Thanks for your patch.

On Sun, Aug 17, 2025 at 6:59=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> Hello,
>
> [adding Juxin Gao to Cc:]
>
> On Sat, Aug 16, 2025 at 06:49:05PM +0800, Xi Ruoyao wrote:
> > Per the 7A1000 and 7A2000 user manual, the clock frequency of their
> > PWM controllers is 50 MHz, not 50 kHz.
> >
> > Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")

I have confirmed once again that this was indeed my mistake. Thank you agai=
n!

Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>
>
> A quick glimpse into
> https://loongson.github.io/LoongArch-Documentation/Loongson-7A1000-userma=
nual-EN.pdf
> confirms this, so I tend to apply it. I'll wait a bit to give the people
> involved in 2b62c89448dd a chance to comment.
>
> Best regards
> Uwe

--=20
Thanks.
Binbin

