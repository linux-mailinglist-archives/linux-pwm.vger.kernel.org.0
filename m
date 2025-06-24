Return-Path: <linux-pwm+bounces-6497-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1166DAE5C9E
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 08:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF95C1B632A4
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 06:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DBA221DB3;
	Tue, 24 Jun 2025 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXKpxpmD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708BC26ACB;
	Tue, 24 Jun 2025 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750745352; cv=none; b=oyePkI+4ng6MNE/rPeJu9/Plr+dTSkMCs4zBd3h2mtcHZtgvLhSzZYoU+uQOOMoYPAm/5zWWs9wuDdsb/ZoXejUJVoOhtfSFe6W3SUEZyy5yeiMCy8HS+YAVsQlYXfnFShR60qj5YaBVIUGwgfbQP6CIcMtLRf19WCPEEnwkPOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750745352; c=relaxed/simple;
	bh=fW7Ckj8ahWnKsa5BdcKtdLsAQ3uxbj3Ysj/czUQcrMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mB4g+MHPq7GryjnPleV7aLgxHJoZ69feJxeC//O7fMFPyOINuN1r4LloXeAB9wYqcSWxqerKsiGo9K0hAHA8XIhDiHyc0+1DRan5k5Sc/HhDKliBAE9oyEE4n3CB331Z67RlFVPGPA6BtMp7EPkct+swe+Y/2SXxV5xjMOIZN/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXKpxpmD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad93ff9f714so9826466b.2;
        Mon, 23 Jun 2025 23:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750745349; x=1751350149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fW7Ckj8ahWnKsa5BdcKtdLsAQ3uxbj3Ysj/czUQcrMI=;
        b=EXKpxpmDmFdWHeJlhxQgqMsEx97yRO0c10s46apEvX37TUfW1SwNBUCbi0sBQfzW86
         4WDLUMAIvcWNg37bjMR+S74IRUb9nfdhU18OCr9xDTsme/DzQpyEtkRnGIpVm3nM4YpP
         8tCmsnxOlfvc4L9P8gBpxl45YhHMbdIazFQfEnscoPjB5LuFTZVKTQ9DwpJnw8wuvGod
         LPJRegUPhGwmQ2h9xZ9Nhj3cRUi/j9ktitw9QBBji70Bto4iWKrJS8d7Dr+obpv++7ZK
         a4NGccZiM8Eb3XfgFEqT+7dohwY8yOHmMRc10NB3vM8yayDHLcwwRNqcV/GDuVDyIt2w
         FAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750745349; x=1751350149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fW7Ckj8ahWnKsa5BdcKtdLsAQ3uxbj3Ysj/czUQcrMI=;
        b=wVkXJWqb9cvV4PXCamceigaVnevfFGdo7bZlLK8ahjzjLMreQlgDYyOLFaO46VXdgT
         2J2LP8CTtVv0j8wf9PeZ6omhRr96o9peZOsZIWq/6jQx76CR/mxUixrMlL33gpPanFsP
         BWY8MXR1D1l53JUJWqQhT16LYxjinmg2QGCrjjnuOA8e3peicqZREGgpI32S492GEes9
         jvyuXdRdgWk2TgXIHvVqYuVzTH7Sd6UYVnSCtmBa533k07gUpLSg70evhKXPut52/fZ9
         T72cwljY384uKClNYkDafecGUyivm8z3DWg740C5RtAzbpMTqTw1rXZxZWzBI2dD1ylD
         jUaA==
X-Forwarded-Encrypted: i=1; AJvYcCVp/IpyZWoixJVdfaibeFT+ECVmNrlplJjzPOP1I3k5s3hjvoRtxqLAGABGhnT9RX/KZmB/G+uNwcXH@vger.kernel.org, AJvYcCX6PD2IboO+KElUn2pleDBa3Qz+PdaRlNUWdTAEdxxwQh4jnQj+MtjKy+YY4BHAZuQK6L7q2NGs9PSOCdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp3jBJzwWO2hhHL43PszCLfZBygFqcBGWWb80TgoHVCjHvzKv8
	xymM4XuIUHk8n8RZEa/Mlo6H6/JR9e1JezvqlCfPOfE2L10DJvZZrO+nX+7y9ye2/jEAp9anQ90
	1Nn18sisDK+aZRMHjF6uKzc26tdhje6g=
X-Gm-Gg: ASbGncurdFywFYRdc73Kwnw5ZaHvZAMsvdOFa1Vq5ciR3ITqVpkv3+lPJfWvK8JXoTc
	0TPtcSXPv+SmIWyOrbDDMaviVZV7PD92KMwPwKoSAm6NJJcE+U1u2FZtTfd83xbF/7B9VkKD3wi
	S2o5T4XhhIlxIMbZv2qd4uRXwiJ6wBxXQ+WeJDsUruch+7Qw==
X-Google-Smtp-Source: AGHT+IFIgr0ofGUe9CoG/+hPdKQ1x6RXPoUtMHXI2Z6EQ/AleFVzF2M27mcDjxtQoJRPf0KEBzcZLAD1davZ4q/0hRg=
X-Received: by 2002:a17:906:c113:b0:ae0:66e8:9ddb with SMTP id
 a640c23a62f3a-ae066e8d717mr1210117566b.19.1750745348429; Mon, 23 Jun 2025
 23:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623211116.1395-1-ansuelsmth@gmail.com>
In-Reply-To: <20250623211116.1395-1-ansuelsmth@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 24 Jun 2025 09:08:32 +0300
X-Gm-Features: Ac12FXwFNvcqZKqUD5srAT7_XmAWpE_IZPZsBp_UYx_m4TP8w1QBK-94n1EW-T8
Message-ID: <CAHp75VcWW=RaHS9Yb8BcK2Jt7qtNOQzA3eDOZQ88RQG63981cQ@mail.gmail.com>
Subject: Re: [PATCH v15 1/2] math.h: provide rounddown_ull variant for
 rounddown MACRO
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Andy Shevchenko <andy@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 12:11=E2=80=AFAM Christian Marangi <ansuelsmth@gmai=
l.com> wrote:
>
> There is currently a problem with the usage of rounddown MACRO with

rounddown() with

> u64 dividends. This cause compilation error on specific arch where

causes

> 64bit division is done on 32bit system.

on the 32-bit


> To be more specific GCC try optimize the function and replace it with

to optimize

> __umoddi3 but this is actually not compiled in the kernel.

__umoddi3()

> Example:
> pwm-airoha.c:(.text+0x8f8): undefined reference to `__umoddi3'
>
> To better handle this, introduce a variant of rounddown MACRO,

rounddown(),

> rounddown_ull that can be used exactly for this scenario.

rounddown_ull()

> rounddown_ull new MACRO use the do_div MACRO that do the heavy work of

The rounddown_ull() is a new macro that uses do_div() to do the heavy work =
of

> handling internally all the magic for 64bit division on 32bit (and

for the 64-bit divisions on the 32-bit platforms (and

> indirectly fix the compilation error).

...

> - Add this patch

Why are math64 APIs not usable here?

--=20
With Best Regards,
Andy Shevchenko

