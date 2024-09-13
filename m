Return-Path: <linux-pwm+bounces-3230-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8211A977AE6
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 10:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033491F21789
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 08:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61D11D67BA;
	Fri, 13 Sep 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHG5KaJu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F01BDA95;
	Fri, 13 Sep 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215962; cv=none; b=RLftyMB0rpBR7HFSbpL8wc6BR0+XweoAyOHSykjEk/F1RIffz3dUG9Guc7O+ZP0+ZJvQS5ocwWWDHIl20UPmNMQ87PaKIJVxF5sRPraBjNcIlu4Plm8JGpzQIaijngzydBG6nEDVdAsjNwRpciqNgjuHF7IzraNOF3vMd5JX6aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215962; c=relaxed/simple;
	bh=7a7WJ2r0b6hRO6CMep05vOcO8PK2KvNTPoIJIsnqAjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5OnXzqAOySCC5XZoFw2fI4+lVwsWeHIWV9D+GoV0ptrBbE5z3wlM2KLKjqlRVIxweSq2nB7a/HvzruFtactdMXqUvymIsLHh5t9kox7MSYmB8QqAJiGHcdc0BXJp2tmeOjHNcweaR4uj5Cpq6gcZGInaeh3tjLL3qjrjHcd5FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHG5KaJu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c4c6cb29so618903f8f.3;
        Fri, 13 Sep 2024 01:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726215959; x=1726820759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1U3m6JcetIPiZdTK0Yjh2Sbb/vfGdhku0JpIn5i9K0=;
        b=JHG5KaJuYDmvoYJcqY7dhx/xXeJBMrK2ZLQzMfBxTNICb+Q6COofOOTH4C8Q0kzf4K
         OA0hEtwVzfCztIfs4Ra8tC+EhA4sDLOpjIDBLomVCepq/eaOf02lzV/HHxa+9UeSV/r2
         1RCopL/4yPlILIBFm69iWmeuOhBtQKMvPwOnoCFi9GCySGg5lBqZBM1sXizdN/wkmiIw
         rc0DKLV6LA5Wmzg/BOwMKf2ki45jYYV2/ELeMBGL8wpXDoeC78P3VD+hdO6XKnMcdhBz
         3k4W74PAlynB5RraFU4+cFcthNyTUpulq+M2wOKfB1hV3Xe+5ubLuXFmTDRbuItqVb20
         gljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726215959; x=1726820759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1U3m6JcetIPiZdTK0Yjh2Sbb/vfGdhku0JpIn5i9K0=;
        b=Tde9yGQpHJ2wXqdqGBudBAWxP2wt0YlLpHaTrwYwd9tS066yMLCUXdwiCFypfOHnod
         FlV8JlQGi3WeO6RWlnsL8jNIwPhFcaxnBqzEcZIvRWlgkZADS2y/07AO4ysr9zcVSMV0
         3oqksFJt2MDoqCrBOuen1aJr6tVJUWil89peyKgFBvc5kOYEiCu3Hk4qFQfQT219Kb3d
         cpozMqDeXeSrx45ug0/dqbCREOilcb4nCDVJ8SkEZlqo6EqVRvH4IMwTbve/mGZhgT3q
         AgTPNd6wNdrshCUrVVvIaBHb3KKr7ghVqDQNwqEaDIV28Qc2AzJ46AHim3vmVPCTim2z
         Xl3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOcIlO53hugvj+syU1NiTQyp4H2PD1nZ1sPDMRQ0Wzc8Jpolx6zLZf+hYwgZ2SD2si6LRPPFsOLQ5u@vger.kernel.org, AJvYcCWzkErda6eFfZmlLwvkujlVLHAon+BM3EjHNqHl1qBbhUC85rSE3a00SmVrKDT3gCEXIjBLIU534Cbq@vger.kernel.org
X-Gm-Message-State: AOJu0Yys21LKmXvt/jW0VPq3i+tLdMCWcOabQ2MjkWYC08XZunAkhc27
	+vrP1emiximPJ5WtGmtTnjihoBrJ0dh6CCYejTU3G5huaYHPCmRt55AaL5NCbEhajfHTfhcRCYi
	UuFwlV2oO2RJmIe+/tVmrULxqAsQ=
X-Google-Smtp-Source: AGHT+IEwVBE2KEcxHxmWBTHi12u4QfNYS1NaDUvGBrJYbk+9ILHQxGC0dT6D3EuYJE8DAuuQmPEfh3hUAIl1Qx1j1mU=
X-Received: by 2002:adf:ee47:0:b0:371:8e3c:5c with SMTP id ffacd0b85a97d-378d61d4d8dmr1733060f8f.7.1726215958909;
 Fri, 13 Sep 2024 01:25:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720516327.git.zhoubinbin@loongson.cn> <63a540e93147eff5e7c942133c462530689f707c.1720516327.git.zhoubinbin@loongson.cn>
 <awru62rcjkkb6n4sa2abmilzmu5ddxiv5s52tnkm2jcwi4isnt@djpzrj6asxok>
In-Reply-To: <awru62rcjkkb6n4sa2abmilzmu5ddxiv5s52tnkm2jcwi4isnt@djpzrj6asxok>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Fri, 13 Sep 2024 14:25:43 +0600
Message-ID: <CAMpQs4K+hx36TpYupByGaVcCh=jFsOKvD584QJQs=Z8Qt3p6EQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] pwm: Add Loongson PWM controller support
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe:

Thanks for your review.

On Tue, Sep 10, 2024 at 1:00=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Wed, Jul 10, 2024 at 10:04:07AM +0800, Binbin Zhou wrote:
> > diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> > new file mode 100644
> > index 000000000000..17ab2a2f48ad
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-loongson.c
> > @@ -0,0 +1,285 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Loongson PWM driver
> > + *
> > + * Author: Juxin Gao <gaojuxin@loongson.cn>
> > + * Further cleanup and restructuring by:
> > + *         Binbin Zhou <zhoubinbin@loongson.cn>
> > + *
> > + * Copyright (C) 2017-2024 Loongson Technology Corporation Limited.
> > + *
> > + * Limitations:
> > + * - The buffer register value should be written before the CTRL regis=
ter.
> > + * - When disabled the output is driven to 0 independent of the config=
ured
> > + *   polarity.
>
> An info about possible glitches and if a period is completed on
> reconfiguration or when the PWM is disabled would be great.
>
> Also if there is a publically available manual, please add a link here.

The descriptions related to our PWM controllers are in the CPU
manuals, e.g. for the Loongson-2K series CPUs. but unfortunately we
only have the Chinese manuals right now, so I don't have a link to
them here.
>
> > + */
> > +
> > [...]
> > +static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> > +                           const struct pwm_state *state)
> > +{
> > +     int ret;
> > +     u64 period, duty_cycle;
> > +     bool enabled =3D pwm->state.enabled;
> > +
> > +     if (enabled && !state->enabled) {
> > +             pwm_loongson_disable(chip, pwm);
> > +             return 0;
> > +     }
>
> You can also shortcut if !pwm->state.enabled. Something like:
>
>         if (!state->enabled) {
>                 if (enabled)
>                         pwm_loongson_disable(chip, pwm);
>                 return 0;
>         }
>
> > +     if (state->polarity !=3D pwm->state.polarity) {
> > +             ret =3D pwm_loongson_set_polarity(chip, pwm, state->polar=
ity);
> > +             if (ret)
> > +                     return ret;
> > +     }
>
> Together with the shortcut above this is buggy. Consider:
>
>         pwm_apply_might_sleep(mypwm, &(struct pwm_state){
>                         .period =3D A,
>                         .duty_cycle =3D B,
>                         .polarity =3D PWM_POLARITY_NORMAL,
>                         .enabled =3D true});
>         pwm_apply_might_sleep(mypwm, &(struct pwm_state){
>                         .period =3D A,
>                         .duty_cycle =3D B,
>                         .polarity =3D PWM_POLARITY_INVERSED,
>                         .enabled =3D false});
>         pwm_apply_might_sleep(mypwm, &(struct pwm_state){
>                         .period =3D A,
>                         .duty_cycle =3D B,
>                         .polarity =3D PWM_POLARITY_INVERSED,
>                         .enabled =3D true});
>
> After the 2nd call you left pwm_loongson_apply() early without writing
> the inversed polarity to the register space. In the 3rd call you have
> state->polarity =3D=3D pwm->state.polarity and so skip configuring the
> polarity again.
>
> I suggest to just do pwm_loongson_set_polarity() unconditionally if
> state->enabled =3D true.

I check code and try to do it like:

        if (!state->enabled) {
                if (enabled)
                        pwm_loongson_disable(chip, pwm);
                return 0;
        }

        ret =3D pwm_loongson_set_polarity(chip, pwm, state->polarity);
        if (ret)
                return ret;

Thanks.
Binbin
>
> > +     period =3D min(state->period, NANOHZ_PER_HZ);
> > +     duty_cycle =3D min(state->duty_cycle, NANOHZ_PER_HZ);
> > +
> > +     ret =3D pwm_loongson_config(chip, pwm, duty_cycle, period);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (!enabled && state->enabled)
> > +             ret =3D pwm_loongson_enable(chip, pwm);
> > +
> > +     return ret;
> > +}
>
> Best regards
> Uwe

