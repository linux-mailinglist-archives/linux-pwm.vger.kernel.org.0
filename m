Return-Path: <linux-pwm+bounces-8440-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKQeFrp0y2k3HwYAu9opvQ
	(envelope-from <linux-pwm+bounces-8440-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 09:16:10 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E16364EE5
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 09:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A173A3019CB0
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 07:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2361396B68;
	Tue, 31 Mar 2026 07:16:07 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A2B391E41
	for <linux-pwm@vger.kernel.org>; Tue, 31 Mar 2026 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941367; cv=none; b=jhaPRx6wdKu6OV9eWbDAyfLcouwnzHaV7rO8j4UNeNdSvSMw3FS9jrCJ7XUl51eq5NdyTWgGckuLgEAST95FTLkx/FaE25e0VJOLILtAcEjcYbi5g2aPGsATR+Sqb3C516qyqBOLGYx7UMxceGdy3RM1cLroky+8KSHJGylNp3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941367; c=relaxed/simple;
	bh=q5OHA3ZdesVxiReV2n5KKI02Ui/pzuS+2M91K/dmVh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b91E4U028A29oue4lJGDt+bJ2TfoK2r/QnWxd/pPm2Fy6lphYYEdFfAFCEcqKgQOF1r39iC8/+FkCuoEk+Cssxo6ei+of00I2TflB6zf3Qii4EFNgy5TifqN/SKIUNbQMuhW5KRFL6QiZhoHcQOJbUdkohqzShHJdsZtDoeFZ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso5858391e0c.3
        for <linux-pwm@vger.kernel.org>; Tue, 31 Mar 2026 00:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774941365; x=1775546165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GybSjq2nLK8ss9TDbgAYO/BHTfGcuQ5m8BL/6DmiVDM=;
        b=b87qroPpByhgIXLkYyWMYwWd5Ex+UDI8giulIksoMkdOmiRr5zqRd1Hk7CcW50G/Uc
         MpUd7BH1UKOf64kCwT30uMB9nqvs0MBiHOZpeKkGe/whDBDDOr1Y9zD8fMGusMFuYmqc
         c3szl+x435x04iLL2mr0P3Wj9vuYW97T7WM4wc5THB09fEpqja2nzHsDNnzjWu/eX98s
         LJZZmvejW3Tp2dkK9mQ6FAU79diOAvUbqXQjk1o1VCYEHQCqaRcQZILn6hg5ovUeqQWp
         QmN1FzhViipAD8Jcqb2uy1Hs+LWu0NWh4gSdtTc+JdqodzAtIXqRYcCIlLltGCvs71HR
         27sA==
X-Forwarded-Encrypted: i=1; AJvYcCUuImL8vEyyQKiRqEZOMakFIxL6fGWN+D0wqyXBLhVhFfWOnLb9FEwUkiswu498TUMRxlNiGT+bKS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB4gq9Aw/bQ/Ypd45DhdnnAiZ5nY36z0bj5kHDqC0XYg0Nk7wA
	2m2A4FWQWljV2sBUtdB7IGwibHfF9e3Mo2Wwuph99v0vZPAhYJFoSZWh0BroEp/1
X-Gm-Gg: ATEYQzxEFlwU+0JAECO/HQKCZmWMMj10mHFotDtBFY3yXvxvYX81w1hMi6uXYnRoZlC
	3CM8rv0UqqGAeZyyUW+ZCYmFq0cOGw2IDmUM0wrebj7fp/6XRUeeSOu21eWtdnuZ9gty2x5Fv+C
	FXQjAQDWh//9/A2bCBstW8kCvWn0zbyw39Cg7NWN6IHx5OOkb3GJXi4s+zt/IyAI0va0dlgmD9L
	e+c8MSin7mtNvRvvpFFSN4vKe6tgGhxKqEzFhzVZdaT7/+eiAE+ThANUv3MPzPip2SKwqsRQpi/
	3T6Z/xEbRcz637XzuERvV8dvY2s8P87LDmeIOCFYXmpGsr8oaue3u+rXmFGTWs/9q+PJi6D61vY
	hC8EnB6z43OsY2F9tCSSkBL2zg6JmoHU8BLNm9xWfUrE1U86FzTfA7RzgM3ITFdrY5dLbTqtRwJ
	N9wLqaDtYifrx0blpOHoW2Kbt6EnWeoZ56JGhFlMlltuSXN+5sJixgPXeKz7p5yu1bz97iWdk=
X-Received: by 2002:a05:6122:1d0b:b0:56c:d862:37dd with SMTP id 71dfb90a1353d-56d4a68af0fmr6754053e0c.14.1774941364454;
        Tue, 31 Mar 2026 00:16:04 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58893d37sm12094785e0c.3.2026.03.31.00.16.02
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 00:16:02 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-953a8eed138so1506304241.3
        for <linux-pwm@vger.kernel.org>; Tue, 31 Mar 2026 00:16:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRf0dkX21lneKB6gQWLPKfybZmNOK7cojahRpRFOV6jcy900XLa7dUwxrz+f1O2bGSNDz5nRSH5Ko=@vger.kernel.org
X-Received: by 2002:a05:6102:32c9:b0:600:a2:138c with SMTP id
 ada2fe7eead31-604f9207584mr5893673137.23.1774941362400; Tue, 31 Mar 2026
 00:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527171504.346696-2-u.kleine-koenig@baylibre.com>
 <a14be34c-de2a-4bea-9282-1fac7780b9a4@kernel.org> <crk42dsypmbyqk7avldghjq32vslmalfmmouwxzgtdci4agfhz@rkbmxj5z22fx>
 <20250606141324.GA1383279-robh@kernel.org> <erst43cabswj3cwnszssolgyoh4dsgrlnjjxhb7luk3qkqhyay@6zyoixljvwwg>
 <CAMuHMdXDZD6QAbKgny1utfYhagUEZ5pcgiDCTTfJKNVVZLOUYg@mail.gmail.com> <actvzQTb-a7O7sbP@monoceros>
In-Reply-To: <actvzQTb-a7O7sbP@monoceros>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 31 Mar 2026 09:15:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWMuveJb0ntTA_VvgQ5UCSE2A3WtdcZyKus9hmHnmy-rA@mail.gmail.com>
X-Gm-Features: AQROBzC5O7y3QvMpcokNbpWXfoeDXMF1WE-YznyR1FbIsYafuG2hHGsIakeoqfI
Message-ID: <CAMuHMdWMuveJb0ntTA_VvgQ5UCSE2A3WtdcZyKus9hmHnmy-rA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8440-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[linux-pwm,dt,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,mail.gmail.com:mid,800f0000:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0E16364EE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe,

On Tue, 31 Mar 2026 at 09:03, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> On Mon, Mar 30, 2026 at 02:12:47PM +0200, Geert Uytterhoeven wrote:
> > On Sat, 7 Jun 2025 at 09:23, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@baylibre.com> wrote:
> > > On Fri, Jun 06, 2025 at 09:13:24AM -0500, Rob Herring wrote:
> > > >    reg:
> > > > >      maxItems: 1
> > > > >
> > > > > -  '#pwm-cells': true
> > > > > +  '#pwm-cells':
> > > > > +    const: 3
> > > > >
> > > > >    xlnx,count-width:
> > > > >      $ref: /schemas/types.yaml#/definitions/uint32
> > > > > @@ -82,7 +83,7 @@ examples:
> > > > >      };
> > > > >
> > > > >      timer@800f0000 {
> > > > > -        #pwm-cells =3D <0>;
> > > > > +        #pwm-cells =3D <3>;
> > > > >          clock-names =3D "s_axi_aclk";
> > > > >          clocks =3D <&zynqmp_clk 71>;
> > > > >          compatible =3D "xlnx,xps-timer-1.00.a";
> > > > >
> > > > > There is however one concern that I want to get resolved first to
> > > > > prevent churn:
> > > > >
> > > > > In principle I think it's bad that a phandle to a PWM must contai=
n a
> > > > > period and flags specifying the polarity. For some use cases the =
period
> > > > > might not matter or is implicitly given or more than one period l=
ength
> > > > > is relevant.
> > > >
> > > > Why can't the period be 0 and no flags set if they aren't needed?
> > >
> > > I don't say they cannot, and probably that's the most sane option if
> > > there is no fixed default period and flags and we're sticking to 3
> > > cells.
> >
> > So zero should have been used for drivers/pwm/pwm-argon-fan-hat.c?
>
> Do you mean #pwm-cells =3D <0>? Or period =3D flags =3D 0?

#pwm-cells =3D <0>

> If the phandle wouldn't contain period and flags and so it would only be
> used to identify the PWM to use and say nothing about how it is used,
> then using #pwm-cells =3D <0> for PWM chips that only have a single PWM
> would work fine.

Exactly what pwm-argon-fan-hat needs!

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

