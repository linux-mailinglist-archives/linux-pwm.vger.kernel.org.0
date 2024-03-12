Return-Path: <linux-pwm+bounces-1746-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E36B878F80
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Mar 2024 09:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C08281E6C
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Mar 2024 08:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5D56997C;
	Tue, 12 Mar 2024 08:11:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196BA69957;
	Tue, 12 Mar 2024 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231119; cv=none; b=dyqkdUP40eJv0z4t4S+7H6VlZMxf3ZJbgZoMTqmABOl32cjfLbLToLrkAuPcE9y5JQghBuo76j23XQi9OakyeV3DdqNm9kCVT7EuB/aUIUc9CwONUal2m/H4PqySbBOBCoHQeDTZD9e14jA04FHTmzMCYydUPW6rweUzPVMMnRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231119; c=relaxed/simple;
	bh=sk8HixfVcumWZ1GehQ9D9l7TFRrPjkgjILc7gne2LgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUaD4FNjGGrsCMZ2tJQ5xQ7oguSZ4ik99HCdWMg4DNjw/h1t4HZYIT2YnE+2inHUriGp7v8fq2btQbi77Fe5Jvdqvzyzp5jpa2HdBlrNGU6+WmIuYetylluPB/MY4AEYTavn2Jvgryjm3HKh+syE+r+c8WCYFMCNwAu/yUCBvuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so4272694276.1;
        Tue, 12 Mar 2024 01:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710231115; x=1710835915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DGGAdPbj0T4Ioaeokq1bEI9IQ4pAfF26xaU3ZGRRTE=;
        b=oEvxF35Ro8FRDiVFsEnTBBp4GF4hcwi2jmkf7t9jiFclOQq40+d6MuVfL40IhW+FiB
         ylGbxDwVcbib5nvgY1MrMdFUifhpgUcDY8evIA07KMkYAzjnasvGqFSnJV4DymZfaYVD
         EvG4BHpV9TerdmN8jUqX1pflRAHw4CJoWqWakqqySmLFeffasz5fHFbTV6cLdhDSwg6H
         oNzrp2E7CXLS/0Yd8W1II2xD6XlR7tiYH64WtRv1WiORagqMHDrMuTP1hChxe7UYe21k
         7k8w3+ErSUcSJtNbyZB4ivP/DbX1DzGVhoRUHQbQYzaCRvQCTS7bCJ8NUJ5k9Gj8we4g
         D4Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUPTs08aypXy3kB1RQ7y5lq2h5TmNs372ZQOY7UWB1IR6vAJ14s62EtuVuoChRfnCmctFSXCo3cqxUv4i40XtFgQvhVWLgFeIK6X6Sj+jUnjAupT7eZMQMeWs+Pag3iG39lpPbqq/V/kM5wJEM=
X-Gm-Message-State: AOJu0YxRun9avYQvBko5p4kfnDsdVWtz2THBI90SSTBDxgMtJKD4FU1H
	Ws7JAoVX1XO5CXoACnPv/2I9YdX5rkDFsNk0AkN8w9X7n7Nr1iUYsCyZektyFFg=
X-Google-Smtp-Source: AGHT+IFNaH9CLp8v+95AfkpFLyvHa4x3m0DWvM7x2rPJysWPzHHTHOqZmhiyYHsZsqgwVW0G3+1aMQ==
X-Received: by 2002:a25:1587:0:b0:dc2:271a:3799 with SMTP id 129-20020a251587000000b00dc2271a3799mr7069864ybv.23.1710231115282;
        Tue, 12 Mar 2024 01:11:55 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id v3-20020a259103000000b00dc7496891f1sm1549406ybl.54.2024.03.12.01.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 01:11:54 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so5800728276.0;
        Tue, 12 Mar 2024 01:11:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYeiLRIila3hZCFXGTan4SUpJHzc3Xvb7p+vFUFamMwsS7eyTVabBVPNxxzhcFo3RBWosyN4MtFLIfBLR3cazZOpFzHtrEkiE/PafeZOwoDm1ALZRicsQE2laPdLSznmCh1A9iejFwqw+Dhu8=
X-Received: by 2002:a25:2007:0:b0:dcb:b072:82d8 with SMTP id
 g7-20020a252007000000b00dcbb07282d8mr7175633ybg.15.1710231113910; Tue, 12 Mar
 2024 01:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220194318.672443-1-biju.das.jz@bp.renesas.com>
 <20240220194318.672443-4-biju.das.jz@bp.renesas.com> <hy5crf2leuvewkn5omgrk2bmkndivwmhst4yrefnd3mepy4nzd@xw3rtkxdnb2g>
In-Reply-To: <hy5crf2leuvewkn5omgrk2bmkndivwmhst4yrefnd3mepy4nzd@xw3rtkxdnb2g>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Mar 2024 09:11:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV8SnMgawrMspemJNfsAHW-wSboXeEOgZ6F37QqrmiLSA@mail.gmail.com>
Message-ID: <CAMuHMdV8SnMgawrMspemJNfsAHW-wSboXeEOgZ6F37QqrmiLSA@mail.gmail.com>
Subject: Re: [PATCH v18 3/4] pwm: Add support for RZ/G2L GPT
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Tue, Mar 12, 2024 at 8:20=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Feb 20, 2024 at 07:43:17PM +0000, Biju Das wrote:
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > +static u64 calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt, =
u32 val, u8 prescale)
> > +{
> > +     u64 tmp, d;
> > +
> > +     /*
> > +      * Rate is in MHz and is always integer for peripheral clk
> > +      * 2^32 * 2^10 (prescalar) * 10^9 > 2^64
> > +      * 2^32 * 2^10 (prescalar) * 10^6 < 2^64
> > +      * Multiply val with prescalar first, if the result is less than
> > +      * 2^34, then multiply by 10^9. Otherwise divide nr and dr by 10^=
3
> > +      * so that it will never overflow.
> > +      */
> > +
> > +     tmp =3D (u64)val << (2 * prescale);
> > +     if (tmp <=3D (1ULL << 34)) {
>
> I would have written that as:
>
>         if (tmp >> 34 =3D=3D 0)
>
> (which implements tmp < (1ULL << 34), which doesn't matter much).
>
> > +             tmp *=3D NSEC_PER_SEC;
> > +             d =3D rzg2l_gpt->rate;
> > +     } else {
> > +             tmp *=3D div64_u64(NSEC_PER_SEC, KILO);
>
> I don't know if the compiler is clever enough to not calculate that
> every time?

Not on 32-bit when written that way.

> Also using div64_u64 is too heavy given that both values fit
> into an u32.

Indeed, so "NSEC_PER_SEC / KILO" should be fine.
I guess NSEC_PER_MSEC would be too obfuscating?

>
> > +             d =3D div64_u64(rzg2l_gpt->rate, KILO);
>
> At first I thought you could better use 1024 as the common divisor here
> as it could be implemented using a shift operation. But I understood
> with the comment above that we're not losing precision here as both
> NSEC_PER_SEC and rate are a multiple of 1000.
>
> Maybe s/Rate is in MHz and is always integer for peripheral clk/Rate is
> a multiple of 1000000, and so dividing by 1000 is an exact operation./ ?
>
> > +     }
> > +
> > +     return DIV64_U64_ROUND_UP(tmp, d);
> > +}

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

