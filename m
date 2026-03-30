Return-Path: <linux-pwm+bounces-8420-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J+3F+FqymnG8gUAu9opvQ
	(envelope-from <linux-pwm+bounces-8420-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 14:21:53 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA28335AF35
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 14:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6C74304FF8A
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 12:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F02277C9D;
	Mon, 30 Mar 2026 12:13:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A15B21ADB7
	for <linux-pwm@vger.kernel.org>; Mon, 30 Mar 2026 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872784; cv=none; b=qFw4DVg6776cX3wAovHSlTuaaPNUW/txf1NZbRqFaQP/ciKu96TiO8uGBcYi2aD2cSlxe1FzYyijUvWlxEx+VH83VS5+WCWaiGl1RNTAqp54RO6rFSeI0b7co+AVENWzfqgmkGOwnPlB2/ZmHtBtpGZWy/1gyMEc/8z+yO2C3Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872784; c=relaxed/simple;
	bh=gu2bg73xFS0jBgND2oeThYTBnkCQBKCEGzyuQqD4MTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4lFCgC6AVoWm/gf0barl2K/o20ahIam4vkiNWdHPeljWK0EXZKCLAGKd/Sew5Dxi5c4VnEXAVMEJ6J7nDxSo9bDRTItfjcnhHecj//C5yr5GKozsNtfrTx96rBip5r0sBzOoaTBGlekcmsDmAIjeLDw/zTCIGUpcRDAIG/HzPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56cd842b60bso3202108e0c.0
        for <linux-pwm@vger.kernel.org>; Mon, 30 Mar 2026 05:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774872782; x=1775477582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u2SCNNGrJmTLDn5Ig7RgkFDYfrdLEqp1DryMV/htQms=;
        b=fqO+oQ7xYkCcZlN3Nf+PgPezN8k1gTbCAJni0cWO945Pf6RxeAiIy0D2H5xr+VyAvi
         CMgs4WXs8okW8X20w/00X+YkwQ+Y3Gipx80G0IfcgBnCqyKDV/KT4BnNh8K836cUgIje
         OkJrwNlCToyeONWSaUzdKtjotFAU67RWIA6fyu4z5gkv1QkTC8T1RVm8JcE/21FL0lLv
         ZLnegZzL17XB9MNOZzahAAaf1NTLdtaLj4MYYR3UFlY8xiH0NH3uujqKypE1ifPvqxXm
         WEoBcVkonXaNPsz+kiqfliX1uEoAo7O6sOzNKq4tTZ3rxsftev/+3rNc86vH37saT9uW
         KX4w==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3qgMX/npCpgBp2Njx/kp9QldHHg6xuLzq25h7Itw53xBsmK4DIber/bko4kUmt0XvY6Gs4Lgzhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw137KmchvibvqKcTgLMz+5BZDxb6F26UrQw9nKTOLYx1mbnFjU
	TVb9E6hQvWrLm0alyrMU2IRRKwQJ4KmT9XQLGDmGdlAb4OwIF6A7j1kQqjXRjJ1x
X-Gm-Gg: ATEYQzzxpwow/LowkQV1XFdDikDMYS+7GZHm/sUtEoY7vezeCgd7hBN0Pvvbijdutrd
	4eEnFQNe4RlS0MBJjR1W3/E4uLRiSJEJCMxyJmwJQo5f2q0ce1YH8yi15XKP/SjLuSSDAxH6hqY
	e+fAlFwc+vrHIOGGMndi5N1cqEmvy/OrYhxVOMbUe2nngdFkpD/weZx2e/XnmhbNKy+9RMb/AWH
	IdZY/qOacFsSudYdxTwiht+ouO6xi8rRBKSpoYwlWjYWwbfgYG6b5BkuAiqoGix8RFiEed/8u4d
	42Y78nzEvBUdKyvlMaXyqpIqII6ufxuH2FUHL07Z/+M6N/QIRx7dTIQzmo+99ReaCUOP+JGBmB+
	WK6dntHlPgfGpZawB6DaK2JY26ifCxNv9tHvb4kpzpA3Ok2PERu+uvmJphmI6Db003Dm1whMo7E
	oDOVv/boaRXYjcHRh+0qOndT0lnuwy4SQzPU4AAeOzvzzw/1muXG7RFH/+ekhn
X-Received: by 2002:a05:6122:218e:b0:56b:95cf:e9ef with SMTP id 71dfb90a1353d-56d4a67bf38mr4983318e0c.16.1774872782202;
        Mon, 30 Mar 2026 05:13:02 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d589f9a1esm8133254e0c.12.2026.03.30.05.13.01
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 05:13:01 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94ac8cbf3feso2679420241.0
        for <linux-pwm@vger.kernel.org>; Mon, 30 Mar 2026 05:13:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAJGOErQMuM828+nvBD3NmWUjeSYtNOY1CdSVLyJ/AUVJJ1DcjQBY1Nc4IKNcxL1va5BTh9/CTvKI=@vger.kernel.org
X-Received: by 2002:a05:6102:8091:b0:605:3bf8:d7ed with SMTP id
 ada2fe7eead31-6053bf90f72mr1025174137.10.1774872781056; Mon, 30 Mar 2026
 05:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527171504.346696-2-u.kleine-koenig@baylibre.com>
 <a14be34c-de2a-4bea-9282-1fac7780b9a4@kernel.org> <crk42dsypmbyqk7avldghjq32vslmalfmmouwxzgtdci4agfhz@rkbmxj5z22fx>
 <20250606141324.GA1383279-robh@kernel.org> <erst43cabswj3cwnszssolgyoh4dsgrlnjjxhb7luk3qkqhyay@6zyoixljvwwg>
In-Reply-To: <erst43cabswj3cwnszssolgyoh4dsgrlnjjxhb7luk3qkqhyay@6zyoixljvwwg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Mar 2026 14:12:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXDZD6QAbKgny1utfYhagUEZ5pcgiDCTTfJKNVVZLOUYg@mail.gmail.com>
X-Gm-Features: AQROBzCz5K9CVhDhcMpmA7U1tBX0huemhEHllmKL7cyhyBhjBEZSpl6cn-J6aWU
Message-ID: <CAMuHMdXDZD6QAbKgny1utfYhagUEZ5pcgiDCTTfJKNVVZLOUYg@mail.gmail.com>
Subject: Re: New default binding for PWM devices? [Was: Re: [PATCH]
 dt-bindings: timer: xlnx,xps-timer: Make PWM in example usable]
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Sean Anderson <sean.anderson@seco.com>, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Chris Packham <Chris.Packham@alliedtelesis.co.nz>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8420-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-m68k.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:email,800f0000:email]
X-Rspamd-Queue-Id: AA28335AF35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe,

On Sat, 7 Jun 2025 at 09:23, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> On Fri, Jun 06, 2025 at 09:13:24AM -0500, Rob Herring wrote:
> >    reg:
> > >      maxItems: 1
> > >
> > > -  '#pwm-cells': true
> > > +  '#pwm-cells':
> > > +    const: 3
> > >
> > >    xlnx,count-width:
> > >      $ref: /schemas/types.yaml#/definitions/uint32
> > > @@ -82,7 +83,7 @@ examples:
> > >      };
> > >
> > >      timer@800f0000 {
> > > -        #pwm-cells =3D <0>;
> > > +        #pwm-cells =3D <3>;
> > >          clock-names =3D "s_axi_aclk";
> > >          clocks =3D <&zynqmp_clk 71>;
> > >          compatible =3D "xlnx,xps-timer-1.00.a";
> > >
> > > There is however one concern that I want to get resolved first to
> > > prevent churn:
> > >
> > > In principle I think it's bad that a phandle to a PWM must contain a
> > > period and flags specifying the polarity. For some use cases the peri=
od
> > > might not matter or is implicitly given or more than one period lengt=
h
> > > is relevant.
> >
> > Why can't the period be 0 and no flags set if they aren't needed?
>
> I don't say they cannot, and probably that's the most sane option if
> there is no fixed default period and flags and we're sticking to 3
> cells.

So zero should have been used for drivers/pwm/pwm-argon-fan-hat.c?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

